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

SELECT * FROM GetTransactionDetailsByCustomerId(22);
