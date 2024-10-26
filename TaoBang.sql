CREATE DATABASE QuanLy_RapChieuPhim;
GO
USE QuanLy_RapChieuPhim;
GO

--------------------------------- TABLE ----------------------------------------------
--- Bảng thể loại phim (Genres)
--------------------------------------------------------------------------------------
CREATE TABLE genres
(
    id int IDENTITY(1,1),
    name nvarchar(100) NOT NULL UNIQUE,
    CONSTRAINT pk_genre PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng đạo diễn (Directors)
--------------------------------------------------------------------------------------
CREATE TABLE directors
(
    id int IDENTITY(1,1),
    name nvarchar(100) NOT NULL,
    CONSTRAINT pk_directors PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng diễn viên (Actors)
--------------------------------------------------------------------------------------
CREATE TABLE actors
(
    id int IDENTITY(1,1),
    name nvarchar(100),
    CONSTRAINT pk_actors PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng phim (Movies)
--------------------------------------------------------------------------------------
CREATE TABLE movies
(
    id int IDENTITY(1,1),
    name nvarchar(100) UNIQUE,
    duration time,
    star float CHECK (star < 10 AND star > 0 ),
    old int CHECK (old < 30 AND old > 0 ),
    type nvarchar(20) CHECK (type IN(N'ĐANG CHIẾU',N'SẮP CHIẾU')) DEFAULT N'SẮP CHIẾU',
    image nvarchar(300),
    thumbnail nvarchar(300),
    trailer nvarchar(300),
    id_director int,
    description nvarchar(500),
    release_date date,
    CONSTRAINT pk_movies PRIMARY KEY (id),
    CONSTRAINT fk_movie_directors FOREIGN KEY (id_director) REFERENCES directors(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng thể loại phim và phim (Genres-Movies)
--------------------------------------------------------------------------------------
CREATE TABLE genres_movies
(
    id_genre int,
    id_movie int,
    CONSTRAINT pk_genres_movies PRIMARY KEY (id_genre, id_movie),
    CONSTRAINT fk_genres_movies_genres FOREIGN KEY (id_genre) REFERENCES genres(id),
    CONSTRAINT fk_genres_movies_movies FOREIGN KEY (id_movie) REFERENCES movies(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng diễn viên và phim (Actors-Movies)
--------------------------------------------------------------------------------------
CREATE TABLE actors_movies
(
    id_actor int,
    id_movie int,
    CONSTRAINT pk_actors_movies PRIMARY KEY (id_actor, id_movie),
    CONSTRAINT fk_actors_movies_actors FOREIGN KEY (id_actor) REFERENCES actors(id),
    CONSTRAINT fk_actors_movies_movies FOREIGN KEY (id_movie) REFERENCES movies(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng rạp chiếu phim (Cinemas)
--------------------------------------------------------------------------------------
CREATE TABLE cinemas
(
    id int IDENTITY(1,1),
    name nvarchar(100) UNIQUE,
    city nvarchar(30),
    address nvarchar(100) UNIQUE,
    amount_rooms int,
    CONSTRAINT pk_cinemas PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng phòng chiếu phim trong rạp (Screen Rooms)
--------------------------------------------------------------------------------------
CREATE TABLE screen_rooms
(
    id int IDENTITY(1,1),
    id_cinema int,
    name nvarchar(100),
    amount_seats int,
    CONSTRAINT pk_screen_rooms PRIMARY KEY (id),
    CONSTRAINT fk_screen_rooms FOREIGN KEY (id_cinema) REFERENCES cinemas(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng lịch chiếu phim (Show Times)
--------------------------------------------------------------------------------------
CREATE TABLE show_times
(
    id int IDENTITY(1,1),
    id_movie int,
    id_screen_room int,
    time_start datetime,
    time_end datetime,
    CONSTRAINT pk_show_times PRIMARY KEY (id),
    CONSTRAINT fk_show_times_movies FOREIGN KEY (id_movie) REFERENCES movies(id),
    CONSTRAINT fk_show_times_screen_rooms FOREIGN KEY (id_screen_room) REFERENCES screen_rooms(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng ghế ngồi (Seats)
--------------------------------------------------------------------------------------
CREATE TABLE seats
(
    id int IDENTITY(1,1),
    number_of_column int,
    number_of_row char(1),
    genre_seats nvarchar(30),
	price DECIMAL(10, 2),
    CONSTRAINT pk_seats PRIMARY KEY (id),
	CONSTRAINT chk_genre_seats CHECK (genre_seats IN (N'Ghế đôi', N'VIP', N'Thường'))
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng ghế ngồi theo suất chiếu (Screen Rooms Seats)
--------------------------------------------------------------------------------------
CREATE TABLE screen_rooms_seats
(
    id_showtime int,
    id_seat int,
	reservedBy INT NULL,
    status nvarchar(30) CHECK (status IN(N'ĐANG TRỐNG',N'ĐÃ ĐẶT',N'ĐANG GIỮ')) DEFAULT N'ĐANG TRỐNG',
    CONSTRAINT pk_screen_rooms_seats PRIMARY KEY (id_showtime, id_seat),
    CONSTRAINT fk_screen_rooms_seats_showtime FOREIGN KEY (id_showtime) REFERENCES show_times(id),
    CONSTRAINT fk_screen_rooms_seats_seats FOREIGN KEY (id_seat) REFERENCES seats(id),
	CONSTRAINT fk_screen_rooms_seats_customers FOREIGN KEY (reservedBy) REFERENCES customers(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng vé xem phim (Tickets)
--------------------------------------------------------------------------------------
CREATE TABLE tickets
(
    id int IDENTITY(1,1),
    id_show_time int,
    id_seat int,
    CONSTRAINT pk_tickets PRIMARY KEY (id),
    CONSTRAINT fk_tickets_show_times FOREIGN KEY (id_show_time) REFERENCES show_times(id),
    CONSTRAINT fk_tickets_seats FOREIGN KEY (id_seat) REFERENCES seats(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng khách hàng (Customers)
--------------------------------------------------------------------------------------
CREATE TABLE customers
(
    id int IDENTITY(1,1),
    name nvarchar(50),
    email nvarchar(50) UNIQUE,
    phone char(10),
    rank nvarchar(20) CHECK (rank IN (N'CẤP ĐỒNG', N'CẤP BẠC', N'CẤP VÀNG', N'CẤP BẠCH KIM', N'CẤP KIM CƯƠNG')) DEFAULT N'CẤP ĐỒNG',
    CONSTRAINT pk_customers PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng nhân viên (Staffs)
--------------------------------------------------------------------------------------
CREATE TABLE staffs
(
    id int IDENTITY(1,1),
    name nvarchar(50),
    office nvarchar(50),
    email nvarchar(50) UNIQUE,
    phone char(10) UNIQUE CHECK (LEN(phone) = 10),
    CONSTRAINT pk_staff PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng giao dịch mua vé, đồ ăn, thức uống (Transactions)
--------------------------------------------------------------------------------------
CREATE TABLE transactions
(
    id int IDENTITY(1,1),
    id_customer int,
    id_ticket int,
    id_staff int NULL,
    total_amount DECIMAL(10, 2) CHECK (total_amount >= 0),
    time_transaction datetime,
    type_transaction nvarchar(10) CHECK (type_transaction IN ('ONLINE', 'OFFLINE')),
    CONSTRAINT pk_transactions PRIMARY KEY (id),
    CONSTRAINT fk_transactions_customers FOREIGN KEY (id_customer) REFERENCES customers(id),
    CONSTRAINT fk_transactions_tickets FOREIGN KEY (id_ticket) REFERENCES tickets(id),
    CONSTRAINT fk_transactions_staff FOREIGN KEY (id_staff) REFERENCES staffs(id),
    CONSTRAINT chk_staff_offline CHECK (
        (type_transaction = 'OFFLINE' AND id_staff IS NOT NULL) OR
        (type_transaction = 'ONLINE' AND id_staff IS NULL)
    )
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng sự cố, vấn đề phát sinh (Problems)
--------------------------------------------------------------------------------------
CREATE TABLE problems
(
    id int IDENTITY(1,1),
    id_staff int NOT NULL,
    status nvarchar(30) CHECK (status IN(N'CHỜ TIẾP NHẬN',N'ĐÃ XỬ LÝ',N'ĐÃ HUỶ',N'ĐANG XỬ LÝ')) DEFAULT N'CHỜ TIẾP NHẬN',
    name nvarchar(100) NOT NULL,
    description nvarchar(300),
    date_start datetime NOT NULL,
    date_end datetime,
    expense money,
    CONSTRAINT pk_problems PRIMARY KEY (id),
    CONSTRAINT fk_problems_staff FOREIGN KEY (id_staff) REFERENCES staffs(id),
    CONSTRAINT chk_problem_dates CHECK (date_end IS NULL OR date_end > date_start)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng đồ ăn thức uống (Foods-Drinks)
--------------------------------------------------------------------------------------
CREATE TABLE foods_drinks
(
    id int IDENTITY(1,1),
    name nvarchar(100),
	image_url NVARCHAR(255),
	stock_quantity INT CHECK (stock_quantity >= 0),
    price DECIMAL(10, 2) CHECK (price >= 0),
    category nvarchar(20) CHECK (category IN (N'Đồ ăn', N'Thức uống')),
    CONSTRAINT pk_foods_drinks PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng kết nối đồ ăn thức uống với giao dịch (Transactions-Foods-Drinks)
--------------------------------------------------------------------------------------
CREATE TABLE transactions_foods_drinks
(
    id_transaction int,
    id_food_drink int,
    quantity int,
    CONSTRAINT pk_transactions_foods_drinks PRIMARY KEY (id_transaction, id_food_drink),
    CONSTRAINT fk_transactions_foods_drinks_transactions FOREIGN KEY (id_transaction) REFERENCES transactions(id) ON DELETE CASCADE,
    CONSTRAINT fk_transactions_foods_drinks_foods_drinks FOREIGN KEY (id_food_drink) REFERENCES foods_drinks(id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng vouchers (Vouchers)
--------------------------------------------------------------------------------------
CREATE TABLE vouchers
(
    id int IDENTITY(1,1),
    code nvarchar(20) NOT NULL,
    name nvarchar(100),
	discount_percentage DECIMAL(5, 2) CHECK (discount_percentage >= 0 AND discount_percentage <= 100),
    rank nvarchar(20) CHECK (rank IN (N'CẤP ĐỒNG', N'CẤP BẠC', N'CẤP VÀNG', N'CẤP BẠCH KIM', N'CẤP KIM CƯƠNG')),
    date_start date,
    date_end date,
    CONSTRAINT pk_vouchers PRIMARY KEY (id)
);

--------------------------------- TABLE ----------------------------------------------
--- Bảng sử dụng voucher (Voucher Uses)
--------------------------------------------------------------------------------------
CREATE TABLE voucher_uses
(
    id int IDENTITY(1,1),
    id_customer int,
    id_voucher int,
    date_used datetime,
    CONSTRAINT pk_voucher_uses PRIMARY KEY (id),
    CONSTRAINT fk_voucher_uses_customer FOREIGN KEY (id_customer) REFERENCES customers(id),
    CONSTRAINT fk_voucher_uses_voucher FOREIGN KEY (id_voucher) REFERENCES vouchers(id),
    CONSTRAINT uc_customer_voucher UNIQUE (id_customer, id_voucher)
);
