USE QuanLy_RapChieuPhim;
GO

--------------------------------- TRIGGER ----------------------------------------------
--- TRIGGER: trg_Customers_DefaultRank
--- Mô tả: Tự động thay thế giá trị NULL ở cột rank bằng 'CẤP ĐỒNG' khi thêm khách hàng mới vào bảng customers.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_Customers_DefaultRank
ON customers
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO customers (name, email, phone, rank)
    SELECT 
        name, 
        email, 
        phone, 
        ISNULL(rank, N'CẤP ĐỒNG')
    FROM inserted;
END;



--- TRIGGER: trg_AfterInsertShowtime
--- Mô tả: Tự động thêm tất cả các ghế vào suất chiếu mới khi một suất chiếu mới được thêm.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_AfterInsertShowtime
ON show_times
AFTER INSERT
AS
BEGIN
    DECLARE @id_showtime INT;

    -- Lấy ID của suất chiếu vừa được thêm
    SELECT @id_showtime = id FROM inserted;

    -- Thêm tất cả các ghế vào suất chiếu mới với trạng thái "ĐANG TRỐNG"
    INSERT INTO screen_rooms_seats (id_showtime, id_seat, status)
    SELECT @id_showtime, s.id, N'ĐANG TRỐNG'
    FROM seats s;
END;
GO

--- TRIGGER: trg_CheckScreenRoomTimeConflict
--- Mô tả: Kiểm tra và ngăn chặn việc thêm suất chiếu trùng thời gian trong cùng một phòng chiếu.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_CheckScreenRoomTimeConflict
ON show_times
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @id_screen_room INT;
    DECLARE @time_start DATETIME;
    DECLARE @time_end DATETIME;

    -- Lấy thông tin suất chiếu từ bản ghi được chèn
    SELECT 
        @id_screen_room = i.id_screen_room, 
        @time_start = i.time_start, 
        @time_end = DATEADD(MINUTE, DATEDIFF(MINUTE, '00:00:00', CAST(m.duration AS TIME)) + 30, i.time_start)
    FROM inserted i
    JOIN movies m ON i.id_movie = m.id;

    -- Kiểm tra thời gian trùng lặp, bao gồm 30 phút dọn dẹp
    IF EXISTS (
        SELECT 1
        FROM show_times st
        WHERE st.id_screen_room = @id_screen_room
        AND (
            (@time_start BETWEEN st.time_start AND DATEADD(MINUTE, 30, st.time_end)) OR
            (@time_end BETWEEN st.time_start AND DATEADD(MINUTE, 30, st.time_end)) OR
            (st.time_start BETWEEN @time_start AND @time_end) OR
            (DATEADD(MINUTE, 30, st.time_end) BETWEEN @time_start AND @time_end)
        )
    )
    BEGIN
        -- Nếu có xung đột thời gian, trả về lỗi và hủy giao dịch
        RAISERROR('Thời gian chiếu đã bị trùng trong cùng phòng chiếu, vui lòng chọn thời gian khác.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Chèn bản ghi nếu không có xung đột
        INSERT INTO show_times (id_movie, id_screen_room, time_start, time_end)
        SELECT id_movie, id_screen_room, time_start, @time_end
        FROM inserted;
    END
END;
GO

--- TRIGGER: trg_UpdateTimeEnd
--- Mô tả: Tự động cập nhật `time_end` dựa trên thời lượng phim sau khi thêm suất chiếu.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateTimeEnd
ON show_times
AFTER INSERT
AS
BEGIN
    -- Cập nhật `time_end` dựa trên `time_start` và thời lượng phim
    UPDATE show_times
    SET time_end = DATEADD(MINUTE, DATEDIFF(MINUTE, '00:00:00', CAST(m.duration AS TIME)), i.time_start)
    FROM inserted i
    JOIN movies m ON i.id_movie = m.id
    WHERE show_times.id = i.id;
END;
GO

--- TRIGGER: trg_check_voucher_usage
--- Mô tả: Kiểm tra xem voucher có được sử dụng trong thời gian hợp lệ hay không.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_check_voucher_usage
ON voucher_uses
AFTER INSERT
AS
BEGIN
    DECLARE @id_voucher INT, @date_used DATETIME;

    -- Lấy ID voucher và ngày sử dụng từ bản ghi được chèn
    SELECT @id_voucher = id_voucher, @date_used = date_used FROM inserted;

    -- Kiểm tra nếu voucher không còn trong thời gian sử dụng hợp lệ
    IF NOT EXISTS (
        SELECT 1
        FROM vouchers
        WHERE id = @id_voucher
          AND @date_used BETWEEN date_start AND date_end
    )
    BEGIN
        -- Nếu voucher không hợp lệ, trả về lỗi và hủy giao dịch
        RAISERROR('Voucher cannot be used outside its valid date range.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--- TRIGGER: trg_DeleteShowTimesWithNullMovie
--- Mô tả: Xóa các suất chiếu có `id_movie` là NULL sau khi chèn hoặc cập nhật.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_DeleteShowTimesWithNullMovie
ON show_times
AFTER INSERT, UPDATE
AS
BEGIN
    -- Xóa các suất chiếu có `id_movie` là NULL
    DELETE FROM show_times
    WHERE id_movie IS NULL;
END;
GO

--- TRIGGER: trg_UpdateRoomCount
--- Mô tả: Cập nhật số lượng phòng chiếu trong bảng `cinemas` khi thêm, xóa hoặc sửa phòng chiếu.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateRoomCount
ON screen_rooms
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    -- Cập nhật khi thêm hoặc sửa phòng chiếu
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE cinemas
        SET amount_rooms = (
            SELECT COUNT(*)
            FROM screen_rooms
            WHERE id_cinema = i.id_cinema
        )
        FROM inserted i
        WHERE cinemas.id = i.id_cinema;
    END

    -- Cập nhật khi xóa phòng chiếu
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE cinemas
        SET amount_rooms = (
            SELECT COUNT(*)
            FROM screen_rooms
            WHERE id_cinema = d.id_cinema
        )
        FROM deleted d
        WHERE cinemas.id = d.id_cinema;
    END
END;
GO

--------------------------------- TRIGGER ----------------------------------------------
--- TRIGGER InsertTransactionOnTicketInsert
--- Mô tả:
--- 1. Khi một vé mới được thêm vào bảng "tickets", tự động thêm một giao dịch vào bảng "transactions".
--- 2. Lấy id_customer từ cột reservedBy trong bảng "screen_rooms_seats".
--- 3. Nếu bất kỳ dữ liệu nào khác không có sẽ đặt là NULL.
-----------------------------------------------------------------------------------------
CREATE TRIGGER InsertTransactionOnTicketInsert
ON tickets
AFTER INSERT
AS
BEGIN
    -- Bắt đầu một giao dịch để đảm bảo tính toàn vẹn của dữ liệu.
    BEGIN TRANSACTION;

    -- Chèn dữ liệu vào bảng "transactions" với giá trị từ bảng "tickets" và "screen_rooms_seats".
    INSERT INTO transactions (id_customer, id_ticket, total_amount, time_transaction, type_transaction)
    SELECT 
        sr.reservedBy AS id_customer,               -- Lấy id_customer từ cột reservedBy trong bảng screen_rooms_seats.
        i.id AS id_ticket,                          -- Sử dụng id của vé mới được thêm từ bảng tickets.
        s.price AS total_amount,                    -- Lấy giá ghế từ bảng seats.
        NULL AS time_transaction,                   -- Đặt time_transaction là NULL.
        NULL AS type_transaction                    -- Đặt type_transaction là NULL.
    FROM inserted i                                 -- "inserted" là bảng tạm chứa dữ liệu mới được thêm vào bảng tickets.
    JOIN screen_rooms_seats sr                     -- Kết nối với bảng screen_rooms_seats để lấy thông tin ghế.
        ON sr.id_showtime = i.id_show_time         -- Ghép nối theo suất chiếu (id_showtime trong screen_rooms_seats và id_show_time trong tickets).
        AND sr.id_seat = i.id_seat                 -- Ghép nối theo ghế (id_seat trong cả hai bảng).
    JOIN seats s                                   -- Kết nối với bảng seats để lấy giá ghế.
        ON s.id = sr.id_seat;                      -- Ghép nối theo id ghế.

    -- Xác nhận giao dịch để đảm bảo các thay đổi được lưu lại.
    COMMIT TRANSACTION;
END;

--------------------------------- TRIGGER ----------------------------------------------
--- Trigger: UpdateTotalAmountOnInsertFoodDrink
--- Mô tả:
--- 1. Cập nhật tổng số tiền (total_amount) trong bảng "transactions" 
---    mỗi khi có thay đổi trong bảng "transactions_foods_drinks".
--- 2. Xử lý cho các thao tác: INSERT, UPDATE và DELETE.
--- 3. Khi thêm hoặc cập nhật thực phẩm và đồ uống, tổng số tiền sẽ được tính toán
---    từ số lượng và giá của từng món ăn, đồ uống liên quan đến giao dịch.
--- 4. Khi xóa thực phẩm và đồ uống, tổng số tiền cũng sẽ được cập nhật tương ứng.
-----------------------------------------------------------------------------------------
CREATE TRIGGER UpdateTotalAmountOnInsertFoodDrink
ON transactions_foods_drinks
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    -- Bắt đầu một giao dịch để đảm bảo tính toàn vẹn của dữ liệu
    BEGIN TRANSACTION;

    -- Nếu có bản ghi mới được thêm hoặc cập nhật
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        -- Cập nhật total_amount trong bảng transactions
        UPDATE t
        SET total_amount = (
            -- Tính tổng tiền từ tickets (giá vé)
            ISNULL((
                SELECT seats.price
                FROM tickets
				join seats on seats.id = tickets.id_seat
                WHERE tickets.id = t.id_ticket
            ), 0)
            +
            -- Tính tổng tiền từ transactions_foods_drinks (đồ ăn, nước uống)
            ISNULL((
                SELECT SUM(fd.quantity * f.price)
                FROM transactions_foods_drinks fd
                JOIN foods_drinks f ON fd.id_food_drink = f.id
                WHERE fd.id_transaction = t.id
            ), 0)
        )
        FROM transactions t
        WHERE t.id IN (
            SELECT id_transaction FROM inserted
        );
    END

    -- Nếu có bản ghi bị xóa
    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        -- Cập nhật total_amount trong bảng transactions
        UPDATE t
        SET total_amount = (
            -- Tính tổng tiền từ tickets (giá vé)
            ISNULL((
                SELECT seats.price
                FROM tickets
				join seats on seats.id = tickets.id_seat
                WHERE tickets.id = t.id_ticket
            ), 0)
            +
            -- Tính tổng tiền từ transactions_foods_drinks (đồ ăn, nước uống)
            ISNULL((
                SELECT SUM(fd.quantity * f.price)
                FROM transactions_foods_drinks fd
                JOIN foods_drinks f ON fd.id_food_drink = f.id
                WHERE fd.id_transaction = t.id
            ), 0)
        )
        FROM transactions t
        WHERE t.id IN (
            SELECT id_transaction FROM deleted
        );
    END

    -- Xác nhận giao dịch
    COMMIT TRANSACTION;
END;


--------------------------------- TRIGGER ----------------------------------------------
--- Trigger: trg_UpdateSeatStatus
--- Mô tả:
--- 1. Cập nhật trạng thái ghế trong bảng "screen_rooms_seats" 
---    mỗi khi có thay đổi trong bảng "transactions".
--- 2. Xử lý khi có cập nhật trường "time_transaction" trong bảng "transactions".
--- 3. Khi "time_transaction" được cập nhật, tất cả các ghế tương ứng với 
---    giao dịch sẽ được đánh dấu là "Đã đặt".
--- 4. Trạng thái ghế sẽ được ghi nhận bởi id_customer của giao dịch tương ứng.
-----------------------------------------------------------------------------------------
CREATE TRIGGER trg_UpdateSeatStatus
ON transactions
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra xem time_transaction đã được cập nhật
    IF UPDATE(time_transaction)
    BEGIN
        -- Cập nhật trạng thái ghế tương ứng với các giao dịch đã được cập nhật
        UPDATE sr
        SET sr.status = N'ĐÃ ĐẶT', sr.reservedBy = t.id_customer
        FROM screen_rooms_seats sr
        INNER JOIN tickets tk ON sr.id_showtime = tk.id_show_time AND sr.id_seat = tk.id_seat
        INNER JOIN inserted i ON tk.id = i.id_ticket
        INNER JOIN transactions t ON t.id = i.id
        WHERE i.time_transaction IS NOT NULL;  -- Kiểm tra xem time_transaction đã được cập nhật
    END
END;