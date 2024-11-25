USE QuanLy_RapChieuPhim;
GO

--------------------------------- FUNCTION ----------------------------------------------
--- Lấy danh sách phim đang chiếu
--- Hàm này trả về danh sách các phim có trạng thái "ĐANG CHIẾU"
-----------------------------------------------------------------------------------------
CREATE FUNCTION GetAvailableMovies()
RETURNS TABLE
AS
RETURN
(
    SELECT id, name, type
    FROM movies
    WHERE type = N'ĐANG CHIẾU'
);
GO

--------------------------------- FUNCTION ----------------------------------------------
--- Lấy danh sách rạp theo phim
--- Hàm này trả về danh sách rạp chiếu phim (cinemas) theo ID phim truyền vào
-----------------------------------------------------------------------------------------
CREATE FUNCTION GetCinemasByMovie(@movieId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT c.id, c.name, c.city
    FROM cinemas c
    JOIN screen_rooms sr ON sr.id_cinema = c.id
    JOIN show_times st ON st.id_screen_room = sr.id
    WHERE st.id_movie = @movieId
);
GO

--------------------------------- FUNCTION ----------------------------------------------
--- Lấy danh sách ngày theo phim và rạp
--- Hàm này trả về danh sách các ngày chiếu theo phim và rạp, lọc các ngày từ hiện tại trở đi
-----------------------------------------------------------------------------------------
CREATE FUNCTION GetAvailableDates(@movieId INT, @cinemaId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT CAST(st.time_start AS DATE) AS show_date
    FROM show_times st
    JOIN screen_rooms sr ON sr.id = st.id_screen_room
    WHERE st.id_movie = @movieId
      AND sr.id_cinema = @cinemaId
      AND CAST(st.time_start AS DATE) >= CAST(GETDATE() AS DATE) -- Lọc các ngày >= ngày hiện tại
);
GO

--------------------------------- FUNCTION ----------------------------------------------
--- Lấy danh sách suất chiếu theo phim, rạp và ngày
--- Hàm này trả về danh sách suất chiếu trong một ngày cụ thể tại một rạp cho một phim
-----------------------------------------------------------------------------------------
CREATE FUNCTION GetAvailableShowtimes(@movieId INT, @cinemaId INT, @showDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT st.id, st.time_start, st.time_end
    FROM show_times st
    JOIN screen_rooms sr ON sr.id = st.id_screen_room
    WHERE st.id_movie = @movieId
      AND sr.id_cinema = @cinemaId
      AND CAST(st.time_start AS DATE) = @showDate
);
GO

--------------------------------- FUNCTION ----------------------------------------------
--- Lấy thông tin giao dịch theo ID khách hàng
--- Hàm này trả về danh sách thông tin giao dịch, bao gồm vé và thức ăn, cho một khách hàng cụ thể
--- Chỉ lấy các giao dịch mà thời gian giao dịch là NULL (chưa thanh toán)
-----------------------------------------------------------------------------------------
CREATE FUNCTION GetTransactionDetailsByCustomerId
(
    @CustomerId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT 
        t.id AS TransactionId,
        tic.id AS TicketId,
        c.name AS CustomerName,
        s.id AS ShowTimeId,
        seats.id AS SeatId,
		seats.price AS SeatPrice,
		seats.genre_seats AS GenreSeat,
        tfd.quantity AS FoodDrinkQuantity,
        fd.name AS FoodDrinkName,
		fd.price AS FoodDrinkPrice,
        t.time_transaction AS TimeTransaction
    FROM transactions t
    LEFT JOIN tickets tic ON tic.id = t.id_ticket
    LEFT JOIN customers c ON c.id = t.id_customer
    LEFT JOIN show_times s ON s.id = tic.id_show_time
    LEFT JOIN seats ON seats.id = tic.id_seat
    LEFT JOIN transactions_foods_drinks tfd ON tfd.id_transaction = t.id
    LEFT JOIN foods_drinks fd ON fd.id = tfd.id_food_drink
    WHERE t.id_customer = @CustomerId AND t.time_transaction IS NULL
);
GO

-- Hàm tính tổng doanh thu theo từng tháng trong 5 tháng gần nhất
CREATE FUNCTION GetMonthlyRevenue()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        MONTH(time_transaction) AS month, -- Lấy tháng từ thời gian giao dịch
        SUM(total_amount) AS total_amount -- Tổng doanh thu của các giao dịch trong tháng
    FROM 
        transactions
    WHERE 
        time_transaction >= DATEADD(MONTH, -5, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)) -- Lọc các giao dịch trong vòng 5 tháng gần nhất
    GROUP BY 
        MONTH(time_transaction) -- Nhóm theo tháng
);

GO

-- Hàm tính doanh thu tháng hiện tại và tháng trước để so sánh tăng trưởng
CREATE FUNCTION GetCurrentMonthRevenueGrowth()
RETURNS TABLE
AS
RETURN
(
    WITH LastTwoMonths AS (
        -- Tạo danh sách hai tháng gần nhất: tháng hiện tại và tháng trước
        SELECT MONTH(GETDATE()) AS month, YEAR(GETDATE()) AS year
        UNION ALL
        SELECT MONTH(DATEADD(MONTH, -1, GETDATE())) AS month, YEAR(DATEADD(MONTH, -1, GETDATE())) AS year
    )
    SELECT 
        ltm.month, -- Tháng
        ltm.year,  -- Năm
        ISNULL(SUM(t.total_amount), 0) AS total_revenue -- Tổng doanh thu (nếu không có giao dịch thì trả về 0)
    FROM 
        LastTwoMonths AS ltm
    LEFT JOIN 
        transactions AS t
    ON 
        MONTH(t.time_transaction) = ltm.month AND YEAR(t.time_transaction) = ltm.year -- Ghép với bảng transactions theo tháng và năm
    GROUP BY 
        ltm.month, ltm.year -- Nhóm theo tháng và năm
);

GO

-- Hàm tính doanh thu của ngày hiện tại và ngày hôm qua
CREATE FUNCTION GetCurrentAndPreviousDayRevenue()
RETURNS TABLE
AS
RETURN
(
    WITH Days AS (
        -- Tạo danh sách gồm ngày hôm nay và ngày hôm qua
        SELECT CAST(GETDATE() AS DATE) AS transaction_date
        UNION ALL
        SELECT CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
    )
    SELECT 
        DAY(d.transaction_date) AS day, -- Ngày
        MONTH(d.transaction_date) AS month, -- Tháng
        YEAR(d.transaction_date) AS year, -- Năm
        ISNULL(SUM(t.total_amount), 0) AS total_revenue -- Tổng doanh thu (nếu không có thì trả về 0)
    FROM 
        Days d
    LEFT JOIN 
        transactions t ON CAST(t.time_transaction AS DATE) = d.transaction_date -- Ghép với bảng transactions theo ngày
    GROUP BY 
        d.transaction_date -- Nhóm theo ngày giao dịch
);

GO

-- Hàm trả về top 5 khách hàng chi tiêu nhiều nhất
CREATE FUNCTION GetTop5Customers()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5
        c.id AS customer_id, -- ID khách hàng
        c.email AS customer_email, -- Email khách hàng
        c.rank AS customer_rank, -- Hạng của khách hàng
        c.name AS customer_name, -- Tên khách hàng
        SUM(t.total_amount) AS total_spent -- Tổng số tiền đã chi tiêu
    FROM 
        customers c
    JOIN 
        transactions t ON c.id = t.id_customer -- Ghép với bảng transactions theo ID khách hàng
    GROUP BY 
        c.id, c.name, c.email, c.rank -- Nhóm theo thông tin khách hàng
    ORDER BY 
        total_spent DESC -- Sắp xếp giảm dần theo số tiền đã chi tiêu
);

GO

-- Hàm tính số lượng vé bán ra trong ngày hôm nay và hôm qua
CREATE FUNCTION GetCurrentAndPreviousDayTicketsSold()
RETURNS TABLE
AS
RETURN
(
    WITH Days AS (
        -- Tạo danh sách gồm ngày hôm nay và ngày hôm qua
        SELECT CAST(GETDATE() AS DATE) AS transaction_date
        UNION ALL
        SELECT CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
    )
    SELECT 
        DAY(d.transaction_date) AS day, -- Ngày
        MONTH(d.transaction_date) AS month, -- Tháng
        YEAR(d.transaction_date) AS year, -- Năm
        ISNULL(COUNT(t.id), 0) AS total_tickets_sold -- Số vé bán ra (nếu không có thì trả về 0)
    FROM 
        Days d
    LEFT JOIN 
        transactions t ON CAST(t.time_transaction AS DATE) = d.transaction_date -- Ghép với bảng transactions theo ngày
    GROUP BY 
        d.transaction_date -- Nhóm theo ngày giao dịch
);

GO

-- Hàm tính số lượng đồ ăn và đồ uống bán ra trong ngày hôm nay và hôm qua
CREATE FUNCTION GetCurrentAndPreviousDayFoodDrinkSales()
RETURNS TABLE
AS
RETURN
(
    WITH Days AS (
        -- Tạo danh sách gồm ngày hôm nay và ngày hôm qua
        SELECT CAST(GETDATE() AS DATE) AS transaction_date
        UNION ALL
        SELECT CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
    )
    SELECT 
        DAY(d.transaction_date) AS day, -- Ngày
        MONTH(d.transaction_date) AS month, -- Tháng
        YEAR(d.transaction_date) AS year, -- Năm
        ISNULL(SUM(tfd.quantity), 0) AS total_food_drink_sold -- Số lượng đồ ăn/uống bán ra (nếu không có thì trả về 0)
    FROM 
        Days d
    LEFT JOIN 
        transactions t ON CAST(t.time_transaction AS DATE) = d.transaction_date -- Ghép với bảng transactions theo ngày
    LEFT JOIN 
        transactions_foods_drinks tfd ON t.id = tfd.id_transaction -- Ghép với bảng transactions_foods_drinks để lấy số lượng bán
    GROUP BY 
        d.transaction_date -- Nhóm theo ngày giao dịch
);
