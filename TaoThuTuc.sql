USE QuanLy_RapChieuPhim;
GO

--------------------------------- PROCEDURE ----------------------------------------------
--- Lấy lịch chiếu phim (Get Movie Showtimes)
--- Tham số:
--- @movieId     : ID của phim
--- @cityName    : (Tùy chọn) Tên thành phố
--- @cinemaName  : (Tùy chọn) Tên rạp
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetMovieShowtimes
    @movieId INT,
    @cityName NVARCHAR(100) = NULL,
    @cinemaName NVARCHAR(100) = NULL
AS
BEGIN
    SELECT 
        m.name AS movie_name,                      -- Tên phim
        c.name AS cinema_name,                     -- Tên rạp chiếu
        c.city AS city_name,                       -- Tên thành phố
        sr.name AS screen_room_name,               -- Tên phòng chiếu
        FORMAT(st.time_start, 'dd/MM/yyyy') AS show_time_date, -- Ngày chiếu
        FORMAT(st.time_start, 'HH:mm') AS show_time_start,     -- Giờ bắt đầu
        FORMAT(st.time_end, 'HH:mm') AS show_time_end          -- Giờ kết thúc
    FROM 
        show_times st
        JOIN movies m ON st.id_movie = m.id
        JOIN screen_rooms sr ON st.id_screen_room = sr.id
        JOIN cinemas c ON sr.id_cinema = c.id
    WHERE 
        m.id = @movieId
        AND (@cinemaName IS NULL OR c.name = @cinemaName)   -- Kiểm tra nếu có tên rạp
        AND (@cityName IS NULL OR c.city = @cityName)       -- Kiểm tra nếu có tên thành phố
    ORDER BY 
        st.time_start;                                      -- Sắp xếp theo thời gian chiếu
END;

GO

--------------------------------- PROCEDURE ----------------------------------------------
--- Lấy danh sách phim theo loại (Get Movies By Type)
--- Mô tả:
--- Lấy 3 phim "ĐANG CHIẾU" và 3 phim "SẮP CHIẾU" dựa trên ngày phát hành.
-----------------------------------------------------------------------------------------
CREATE PROCEDURE GetMoviesByType
AS
BEGIN
    -- CTE để lấy phim "ĐANG CHIẾU"
    WITH CurrentMovies AS (
        SELECT TOP 3 *                                -- Lấy 3 phim
        FROM movies
        WHERE type = N'ĐANG CHIẾU'                    -- Điều kiện lấy phim đang chiếu
        ORDER BY release_date DESC                    -- Sắp xếp theo ngày phát hành giảm dần
    ),
    -- CTE để lấy phim "SẮP CHIẾU"
    UpcomingMovies AS (
        SELECT TOP 3 *                                -- Lấy 3 phim
        FROM movies
        WHERE type = N'SẮP CHIẾU'                     -- Điều kiện lấy phim sắp chiếu
        ORDER BY release_date ASC                     -- Sắp xếp theo ngày phát hành tăng dần
    )

    -- Kết hợp kết quả từ hai CTE
    SELECT * FROM CurrentMovies
    UNION ALL
    SELECT * FROM UpcomingMovies;
END;

--------------------------------- PROCEDURE ----------------------------------------------
--- HoldSeatAndCreateTicket (Giữ ghế và tạo vé)
--- Mô tả:
--- 1. Kiểm tra xem ghế có khả dụng hay không (phải có trạng thái "ĐANG TRỐNG").
--- 2. Nếu khả dụng, cập nhật trạng thái ghế thành "ĐANG GIỮ" và thêm thông tin khách hàng giữ ghế.
--- 3. Tạo một vé mới cho ghế đã giữ trong bảng "tickets".
--- 4. Sử dụng giao dịch để đảm bảo các thao tác đều thành công hoặc bị hoàn tác nếu có lỗi xảy ra.
-----------------------------------------------------------------------------------------
CREATE PROCEDURE HoldSeatAndCreateTicket
    @ShowtimeId INT,                                 -- Tham số đại diện cho ID của suất chiếu (id_showtime).
    @SeatId INT,                                     -- Tham số đại diện cho ID của ghế (id_seat).
    @CustomerId INT                                  -- Tham số đại diện cho ID của khách hàng (reservedBy).
AS
BEGIN
    -- Bắt đầu một giao dịch để đảm bảo tính toàn vẹn của dữ liệu.
    BEGIN TRANSACTION;

    -- Kiểm tra xem ghế có đang ở trạng thái "ĐANG TRỐNG" hay không.
    DECLARE @SeatStatus NVARCHAR(50);                -- Khai báo biến để lưu trữ trạng thái của ghế.
    SELECT @SeatStatus = status
    FROM screen_rooms_seats
    WHERE id_showtime = @ShowtimeId                  -- Lọc theo ID của suất chiếu.
      AND id_seat = @SeatId;                         -- Lọc theo ID của ghế.

    -- Nếu trạng thái của ghế không phải là "ĐANG TRỐNG", rollback và thông báo lỗi.
    IF @SeatStatus != N'ĐANG TRỐNG'                  
    BEGIN
        ROLLBACK TRANSACTION;                        -- Hoàn tác giao dịch nếu ghế không khả dụng.
        RAISERROR(N'Ghế không khả dụng.', 16, 1);     -- Phát sinh lỗi với thông báo "Ghế không khả dụng."
        RETURN;                                      -- Kết thúc thủ tục nếu có lỗi.
    END

    -- Nếu ghế khả dụng, cập nhật trạng thái ghế thành "ĐANG GIỮ" và thêm thông tin khách hàng giữ ghế.
    UPDATE screen_rooms_seats
    SET status = N'ĐANG GIỮ',                        -- Cập nhật trạng thái của ghế thành "ĐANG GIỮ".
        reservedBy = @CustomerId                    -- Cập nhật ID của khách hàng giữ ghế.
    WHERE id_showtime = @ShowtimeId
      AND id_seat = @SeatId;                         -- Áp dụng cho ghế và suất chiếu cụ thể.

    -- Chèn một vé mới vào bảng "tickets" cho ghế đã giữ.
    INSERT INTO tickets (id_seat, id_show_time)
    VALUES (@SeatId, @ShowtimeId);                   -- Thêm bản ghi vào bảng "tickets" với ID ghế và suất chiếu.

    -- Xác nhận giao dịch sau khi tất cả thao tác đã thành công.
    COMMIT TRANSACTION;
END

--------------------------------- PROCEDURE ----------------------------------------------
--- UnholdSeatAndDeleteTicket (Bỏ giữ ghế và xoá vé)
--- Mô tả:
--- 1. Kiểm tra xem ghế có đang được giữ bởi khách hàng hay không.
--- 2. Nếu có, cập nhật trạng thái ghế thành "ĐANG TRỐNG" và xoá thông tin người giữ ghế.
--- 3. Xoá vé tương ứng với ghế đã bỏ giữ từ bảng "tickets".
--- 4. Sử dụng giao dịch để đảm bảo các thao tác đều thành công hoặc bị hoàn tác nếu có lỗi xảy ra.
-----------------------------------------------------------------------------------------
CREATE PROCEDURE UnholdSeatAndDeleteTicket
    @ShowtimeId INT,                                 -- Tham số đại diện cho ID của suất chiếu (id_showtime).
    @SeatId INT,                                     -- Tham số đại diện cho ID của ghế (id_seat).
    @CustomerId INT                                  -- Tham số đại diện cho ID của khách hàng (reservedBy).
AS
BEGIN
    -- Bắt đầu một giao dịch để đảm bảo tính toàn vẹn của dữ liệu.
    BEGIN TRANSACTION;

    -- Kiểm tra xem ghế có đang được giữ bởi khách hàng này hay không.
    DECLARE @ReservedBy INT;                         -- Khai báo biến để lưu trữ ID khách hàng giữ ghế.
    SELECT @ReservedBy = reservedBy
    FROM screen_rooms_seats
    WHERE id_showtime = @ShowtimeId                  -- Lọc theo ID của suất chiếu.
      AND id_seat = @SeatId;                         -- Lọc theo ID của ghế.

    -- Nếu ghế không được giữ bởi khách hàng hoặc ghế không trong trạng thái giữ, rollback và thông báo lỗi.
    IF @ReservedBy != @CustomerId
    BEGIN
        ROLLBACK TRANSACTION;                        -- Hoàn tác giao dịch nếu ghế không được giữ bởi khách hàng.
        RAISERROR(N'Không có ghế nào được giữ bởi khách hàng này.', 16, 1);
        RETURN;
    END

    -- Nếu ghế đang được giữ bởi khách hàng, cập nhật trạng thái ghế thành "ĐANG TRỐNG" và xoá thông tin người giữ.
    UPDATE screen_rooms_seats
    SET status = N'ĐANG TRỐNG',                      -- Cập nhật trạng thái của ghế thành "ĐANG TRỐNG".
        reservedBy = NULL                           -- Xoá thông tin khách hàng giữ ghế.
    WHERE id_showtime = @ShowtimeId
      AND id_seat = @SeatId;                         -- Áp dụng cho ghế và suất chiếu cụ thể.

    -- Xoá vé tương ứng với ghế đã bỏ giữ từ bảng "tickets".
    DELETE FROM tickets
    WHERE id_seat = @SeatId
      AND id_show_time = @ShowtimeId;                -- Xoá vé dựa trên ID của ghế và suất chiếu.

    -- Xác nhận giao dịch sau khi tất cả thao tác đã thành công.
    COMMIT TRANSACTION;
END

--------------------------------- PROCEDURE ----------------------------------------------
--- PROCEDURE AddFoodDrinkTransaction
--- Mô tả:
--- 1. Thêm thông tin giao dịch thực phẩm và nước uống vào bảng "transactions_foods_drinks".
--- 2. Giảm số lượng tồn kho của sản phẩm trong bảng "foods_drinks".
-----------------------------------------------------------------------------------------
CREATE PROCEDURE AddFoodDrinkTransaction
    @TransactionId INT,
    @FoodDrinkId INT,
    @Quantity INT
AS
BEGIN
    -- Bắt đầu transaction
    BEGIN TRANSACTION;

    DECLARE @StockQuantity INT;

    -- Kiểm tra số lượng tồn kho hiện tại
    SELECT @StockQuantity = stock_quantity
    FROM foods_drinks
    WHERE id = @FoodDrinkId;

    IF @StockQuantity < @Quantity
    BEGIN
        -- Nếu số lượng yêu cầu lớn hơn số lượng tồn kho, hủy giao dịch
        ROLLBACK TRANSACTION;
        RAISERROR(N'Số lượng hàng không đủ cho sản phẩm ID: %d', 16, 1, @FoodDrinkId);
        RETURN;
    END

    -- Thêm vào bảng "transactions_foods_drinks"
    INSERT INTO transactions_foods_drinks (id_transaction, id_food_drink, quantity)
    VALUES (@TransactionId, @FoodDrinkId, @Quantity);

    -- Giảm số lượng tồn kho
    UPDATE foods_drinks
    SET stock_quantity = stock_quantity - @Quantity
    WHERE id = @FoodDrinkId;

    -- Hoàn tất transaction
    COMMIT TRANSACTION;
END;


CREATE PROCEDURE Get3Month
AS
BEGIN
	WITH DateRange AS (
		SELECT 
			CAST(DATEADD(DAY, number, DATEADD(MONTH, -2, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))) AS DATE) AS date
		FROM 
			master..spt_values
		WHERE 
			type = 'P' 
			AND DATEADD(DAY, number, DATEADD(MONTH, -2, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))) < DATEADD(MONTH, 1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
	)
	SELECT 
		d.date AS transaction_date,
		ISNULL(SUM(t.total_amount), 0) AS total_revenue
	FROM 
		DateRange d
	LEFT JOIN 
		transactions t ON d.date = CAST(t.time_transaction AS DATE)
	GROUP BY 
		d.date
	ORDER BY 
		d.date DESC;
END;
