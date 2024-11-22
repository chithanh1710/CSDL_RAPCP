--SELECT * FROM genres;
--SELECT * FROM directors;
--SELECT * FROM actors;
--SELECT * FROM movies;
--SELECT * FROM genres_movies;
--SELECT * FROM cinemas;
--SELECT * FROM screen_rooms;
--SELECT * FROM show_times;
--SELECT * FROM seats;
--SELECT * FROM screen_rooms_seats;
--SELECT * FROM tickets;
--SELECT * FROM customers;
--SELECT * FROM staffs;
--SELECT * FROM problems;
--SELECT * FROM transactions;
--SELECT * FROM foods_drinks;
--SELECT * FROM transactions_foods_drinks;
--SELECT * FROM vouchers;
--SELECT * FROM voucher_uses;

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng director
--------------------------------------------------------------------------------------
INSERT INTO directors(name) VALUES
(N'Taweewat Wantha'),
(N'Andy Serkis'),
(N'Scott Derrickson'),
(N'David Bruckner'),
(N'Ridley Scott'),
(N'Lý Minh Thắng'),
(N'Julius Onah'),
(N'Peter Sollett'),
(N'Barry Jenkins'),
(N'Jeff Fowler'),
(N'Nguyễn Thị Thắm'),
(N'Kenji Kamiyama'),
(N'J.C. Chandor'),
(N'Anthony Russo'),
(N'Parker Finn');

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng actor
--------------------------------------------------------------------------------------
INSERT INTO actors(name) VALUES
(N'Nadech Kugimiya'), (N'Denise Jelilcha Kapaun'), (N'Mim Rattawadee Wongthong'), -- Vùng Đất Bị Nguyền Rủa
(N'Paul Mescal'), (N'Denzel Washington'), (N'Pedro Pascal'), -- Võ Sĩ Giác Đấu II
(N'Hoài Linh'), (N'Đức Trí'), (N'Kiều Minh Tuấn'), -- Công Tử Bạc Liêu
(N'Chris Evans'), (N'Anthony Mackie'), (N'Scarlett Johansson'), -- Captain America
(N'Jason Momoa'), (N'Mark Wahlberg'), (N'Anne Hathaway'), -- Một Bộ Phim Minecraft
(N'Aaron Pierre'), (N'Kelvin Harrison Jr.'), (N'Beyoncé'), -- Mufasa: Vua Sư Tử
(N'Ben Schwartz'), (N'Idris Elba'), (N'Colleen O''Shaughnessey'), -- Nhím Sonic 3
(N'TBA1'), (N'TBA2'), (N'TBA3'), -- Bóng Đá Nữ Việt Nam
(N'Brian Cox'), (N'Miranda Otto'), (N'Luke Newberry'), -- Chúa Tể Của Những Chiếc Nhẫn
(N'Aaron Taylor-Johnson'), (N'Ariana DeBose'), (N'Russell Crowe'); -- Kraven - Thợ Săn Thủ Lĩnh
--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng director
--------------------------------------------------------------------------------------
INSERT INTO genres(name) VALUES
(N'Horror'),          -- Kinh dị
(N'Action'),          -- Hành động
(N'Drama'),           -- Chính kịch
(N'Comedy'),          -- Hài
(N'Adventure'),       -- Phiêu lưu
(N'Animation'),       -- Hoạt hình
(N'Fantasy'),         -- Huyền bí
(N'Documentary'),     -- Tài liệu
(N'Biography');       -- Tiểu sử


--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng cinemas
--------------------------------------------------------------------------------------
INSERT INTO cinemas(name, city, address) 
VALUES 
(N'Galaxy Nguyễn Du', N'TP.HCM', N'116 Nguyễn Du, Quận 1, TP.HCM'),
(N'Galaxy Kinh Dương Vương', N'TP.HCM', N'718 Kinh Dương Vương, Quận 6, TP.HCM'),
(N'Galaxy Mipec Long Biên', N'HÀ NỘI', N'Tầng 5, TTTM Mipec Long Biên, Số 2 Long Biên, Long Biên, Hà Nội'),
(N'Galaxy Tràng Thi', N'HÀ NỘI', N'10 Tràng Thi, Quận Hoàn Kiếm, Hà Nội');

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng screen_rooms
--------------------------------------------------------------------------------------
INSERT INTO screen_rooms(id_cinema, name) 
VALUES 
(1, N'1'),
(1, N'2'),
(2, N'1'),
(2, N'2'),
(3, N'1'),
(3, N'2'),
(4, N'1'),
(4, N'2');


--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng foods_drinks
--------------------------------------------------------------------------------------
INSERT INTO foods_drinks (name, price, category, stock_quantity, image_url)
VALUES 
(N'Bắp rang bơ', 50.00, N'Đồ ăn', 100, '/images/popcorn.jpg'),
(N'Hamburger', 75.00, N'Đồ ăn', 50, '/images/hamburger.jpg'),
(N'Hotdog', 60.00, N'Đồ ăn', 40, '/images/hotdog.jpg'),
(N'Coca Cola', 30.00, N'Thức uống', 200, '/images/cocacola.jpg'),
(N'Pepsi', 30.00, N'Thức uống', 180, '/images/pepsi.jpg'),
(N'7UP', 30.00, N'Thức uống', 170, '/images/7up.jpg'),
(N'Nước suối', 20.00, N'Thức uống', 300, '/images/water.jpg');

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng vouchers
--------------------------------------------------------------------------------------
INSERT INTO vouchers (code, name, rank, date_start, date_end, discount_percentage)
VALUES
(N'X4HD93JXPL8K2F7G5WQM', N'Giảm giá 10% cho thành viên Đồng', N'CẤP ĐỒNG', '2024-10-01', '2024-12-31', 10.00),
(N'ZK2HD9LG5P4WQ8FM6JXC', N'Giảm giá 15% cho thành viên Bạc', N'CẤP BẠC', '2024-10-01', '2024-12-31', 15.00),
(N'P8JH3F2QML9N4XZ7RDWG', N'Giảm giá 20% cho thành viên Vàng', N'CẤP VÀNG', '2024-10-01', '2024-12-31', 20.00),
(N'J9PLX2Z4QR8K7F6W3HCD', N'Giảm giá 25% cho thành viên Bạch Kim', N'CẤP BẠCH KIM', '2024-10-01', '2024-12-31', 25.00),
(N'Q5NK7HZ3X2G8PL4FM9JW', N'Giảm giá 30% cho thành viên Kim Cương', N'CẤP KIM CƯƠNG', '2024-10-01', '2024-12-31', 30.00),
(N'L3X9P2ZK4J7WF8GHQ6MD', N'Giảm giá 10% cho thành viên Đồng', N'CẤP ĐỒNG', '2024-10-01', '2024-12-31', 10.00),
(N'F8ZQ2P4LG5M6J7WXH9CD', N'Giảm giá 15% cho thành viên Bạc', N'CẤP BẠC', '2024-10-01', '2024-12-31', 15.00),
(N'G5XJ7P9K2L4F8WM3HQZD', N'Giảm giá 20% cho thành viên Vàng', N'CẤP VÀNG', '2024-10-01', '2024-12-31', 20.00),
(N'H3WZ7P9KF2J4LG6XM8QD', N'Giảm giá 25% cho thành viên Bạch Kim', N'CẤP BẠCH KIM', '2024-10-01', '2024-12-31', 25.00),
(N'M6X9Z3K2F5L7J8P4QGHD', N'Giảm giá 30% cho thành viên Kim Cương', N'CẤP KIM CƯƠNG', '2024-10-01', '2024-12-31', 30.00);

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng seats
--------------------------------------------------------------------------------------
INSERT INTO seats (number_of_column, number_of_row, genre_seats)
VALUES
(1, 'A', N'Thường'), (2, 'A', N'Thường'), (3, 'A', N'Thường'), (4, 'A', N'Thường'), (5, 'A', N'Thường'),
(6, 'A', N'Thường'), (7, 'A', N'Thường'), (8, 'A', N'Thường'), (9, 'A', N'Thường'), (10, 'A', N'Thường'),
(1, 'B', N'Thường'), (2, 'B', N'Thường'), (3, 'B', N'Thường'), (4, 'B', N'Thường'), (5, 'B', N'Thường'),
(6, 'B', N'Thường'), (7, 'B', N'Thường'), (8, 'B', N'Thường'), (9, 'B', N'Thường'), (10, 'B', N'Thường'),
(1, 'C', N'Thường'), (2, 'C', N'Thường'), (3, 'C', N'Thường'), (4, 'C', N'Thường'), (5, 'C', N'Thường'),
(6, 'C', N'Thường'), (7, 'C', N'Thường'), (8, 'C', N'Thường'), (9, 'C', N'Thường'), (10, 'C', N'Thường'),
(1, 'D', N'Thường'), (2, 'D', N'Thường'), (3, 'D', N'Thường'), (4, 'D', N'Thường'), (5, 'D', N'Thường'),
(6, 'D', N'Thường'), (7, 'D', N'Thường'), (8, 'D', N'Thường'), (9, 'D', N'Thường'), (10, 'D', N'Thường'),
(1, 'E', N'Thường'), (2, 'E', N'Thường'), (3, 'E', N'VIP'), (4, 'E', N'VIP'), (5, 'E', N'VIP'),
(6, 'E', N'VIP'), (7, 'E', N'VIP'), (8, 'E', N'VIP'), (9, 'E', N'Thường'), (10, 'E', N'Thường'),
(1, 'F', N'Thường'), (2, 'F', N'Thường'), (3, 'F', N'VIP'), (4, 'F', N'VIP'), (5, 'F', N'VIP'),
(6, 'F', N'VIP'), (7, 'F', N'VIP'), (8, 'F', N'VIP'), (9, 'F', N'Thường'), (10, 'F', N'Thường'),
(1, 'G', N'Thường'), (2, 'G', N'Thường'), (3, 'G', N'VIP'), (4, 'G', N'VIP'), (5, 'G', N'VIP'),
(6, 'G', N'VIP'), (7, 'G', N'VIP'), (8, 'G', N'VIP'), (9, 'G', N'Thường'), (10, 'G', N'Thường'),
(1, 'H', N'Thường'), (2, 'H', N'Thường'), (3, 'H', N'VIP'), (4, 'H', N'VIP'), (5, 'H', N'VIP'),
(6, 'H', N'VIP'), (7, 'H', N'VIP'), (8, 'H', N'VIP'), (9, 'H', N'Thường'), (10, 'H', N'Thường'),
(1, 'I', N'Ghế đôi'), (2, 'I', N'Ghế đôi'), (3, 'I', N'Ghế đôi'), (4, 'I', N'Ghế đôi'), (5, 'I', N'Ghế đôi'),
(1, 'J', N'Ghế đôi'), (2, 'J', N'Ghế đôi'), (3, 'J', N'Ghế đôi'), (4, 'J', N'Ghế đôi'), (5, 'J', N'Ghế đôi');

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng movies 
--------------------------------------------------------------------------------------
INSERT INTO movies(name, duration, star, old, type, image, thumbnail, trailer, id_director, description, release_date) 
VALUES
(N'Tee Yod: Quỷ Ăn Tạng Phần 2','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/10/10/tee-yod-2-750_1728531356119.jpg', 'https://cdn.galaxycine.vn/media/2024/10/10/tee-yod-2-500_1728531355521.jpg','https://youtu.be/kZZkCDc38yI',1, N'Description of Tee Yod', '2024-10-10'),
(N'Venom: Kèo Cuối','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/10/16/venom-sneak-750_1729048420375.jpg', 'https://cdn.galaxycine.vn/media/2024/10/16/venom-sneak-500_1729048419589.jpg','https://youtu.be/P0C9ccMXtqc',2, N'Description of Venom', '2024-10-16'),
(N'Ác Quỷ Truy Hồn','2:00:00',8, 18,N'ĐANG CHIẾU', 'https://cdn.galaxycine.vn/media/2024/10/11/ac-qu-truy-hon-750_1728616391362.jpg', 'https://cdn.galaxycine.vn/media/2024/10/11/ac-qu-truy-hon-500_1728616391060.jpg','https://youtu.be/KStJ_SXQEi8',3, N'Description of Ác Quỷ Truy Hồn', '2024-10-11'),
(N'Vùng Đất Bị Nguyền Rủa','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/10/15/vung-dat-bi-nguyen-rua-750_1728961947843.jpg', 'https://cdn.galaxycine.vn/media/2024/10/15/vung-dat-bi-nguyen-rua-500_1728961947385.jpg','https://youtu.be/TTHThG-pj6s',4, N'Description of Vùng Đất Bị Nguyền Rủa', '2024-10-15'),
(N'Võ Sĩ Giác Đấu II','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/7/15/vo-si-giac-dau-2-750_1721032801413.jpg','https://cdn.galaxycine.vn/media/2024/10/1/gladiator-2-500_1731752024675.jpg','https://youtu.be/VTZ4heeft1A',5, N'Description of Võ Sĩ Giác Đấu II', '2024-07-15'),
(N'Công Tử Bạc Liêu','2:00:00',8, 18,N'ĐANG CHIẾU', 'https://cdn.galaxycine.vn/media/2024/10/16/cong-tu-bac-lieu-750_1729070300753.jpg', 'https://cdn.galaxycine.vn/media/2024/10/16/cong-tu-bac-lieu-500_1729070300283.jpg','https://youtu.be/kPJGB2EGCnU',6, N'Description of Công Tử Bạc Liêu', '2024-10-16'),
(N'Captain America: Trật Tự Thế Giới Mới','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/7/15/captain-america-brave-new-world-750_1721030812687.jpg', 'https://cdn.galaxycine.vn/media/2024/10/11/ac-qu-truy-hon-500_1728616391060.jpg','https://youtu.be/KStJ_SXQEi8',7, N'Description of Captain America', '2024-07-15'),
(N'Một Bộ Phim Minecraft','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/9/9/minecraft-750_1725866141419.jpg', 'https://cdn.galaxycine.vn/media/2024/9/9/minecraft-500_1725866141382.jpg','https://youtu.be/QQKkvqUZaTI',8, N'Description of Minecraft', '2024-09-09'),
(N'Mufasa: Vua Sư Tử','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/5/2/mufasa-750_1714620600428.jpg', 'https://cdn.galaxycine.vn/media/2024/5/2/mufasa-500_1714620600495.jpg','https://youtu.be/XcS9JwQEUag',9, N'Description of Mufasa', '2024-05-02'),
(N'Nhím Sonic 3','2:00:00',8, 18,N'ĐANG CHIẾU', 'https://cdn.galaxycine.vn/media/2024/9/5/sonic-3-750_1725508090665.jpg', 'https://cdn.galaxycine.vn/media/2024/9/5/sonic-3_1725508090051.jpg','https://youtu.be/9ZQMzTr0K4I',10, N'Description of Nhím Sonic 3', '2024-09-05'),
(N'Bóng Đá Nữ Việt Nam: Chuyện Lần Đầu Kể','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/8/26/bong-da-nu-viet-nam-chuyen-chua-ke-750_1724644030738.jpg', 'https://cdn.galaxycine.vn/media/2024/10/7/bong-da-nu-viet-nam_1728295404365.jpg','https://youtu.be/RGyM7PbHP1M',11, N'Description of Bóng Đá Nữ Việt Nam', '2024-10-07'),
(N'Chúa Tể Của Những Chiếc Nhẫn: Cuộc Chiến Của Rohirrim','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/8/26/the-lord-of-the-rings-the-war-of-the-rohirrim-750_1724658681013.jpg', 'https://cdn.galaxycine.vn/media/2024/9/24/chua-te-nhung-chiec-nhan-noi-chien-cua-rohirrim_1731146765628.jpg','https://youtu.be/DPjv_GWqK88',12, 'Description of Chúa Tể Của Những Chiếc Nhẫn', '2024-09-24'),
(N'Kraven - Thợ Săn Thủ Lĩnh','2:00:00',8, 18,N'ĐANG CHIẾU', 'https://cdn.galaxycine.vn/media/2024/6/20/kraven-the-hunter_1687246462669.jpg', 'https://cdn.galaxycine.vn/media/2024/8/29/kraven-500_1724918593694.jpg','https://youtu.be/EHMescXQuqA',13, N'Description of Kraven', '2024-08-29'),
(N'Tín Hiệu Cầu Cứu','2:00:00',8, 18,N'ĐANG CHIẾU', 'https://cdn.galaxycine.vn/media/2024/10/2/blink-twice-750_1731855007945.jpg','https://cdn.galaxycine.vn/media/2024/10/2/blink-twice-500_1731855008547.jpg','https://youtu.be/dkEhsRb4g-c',14, N'Description of Tín Hiệu Cầu Cứu', '2024-10-02'),
(N'Cười 2','2:00:00',8, 18,N'SẮP CHIẾU', 'https://cdn.galaxycine.vn/media/2024/9/24/smile-2-750_1731160158125.jpg','https://cdn.galaxycine.vn/media/2024/9/24/smile-2-500_1731160157450.jpg','https://youtu.be/Aax82Ea0Tbk',15, N'Description of Cười 2', '2024-09-24');

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng actor
--------------------------------------------------------------------------------------
INSERT INTO actors_movies(id_actor, id_movie) VALUES
(1, 4),  -- Nadech Kugimiya, Vùng Đất Bị Nguyền Rủa
(2, 4),  -- Denise Jelilcha Kapaun, Vùng Đất Bị Nguyền Rủa
(3, 4),  -- Mim Rattawadee Wongthong, Vùng Đất Bị Nguyền Rủa
(4, 5),  -- Paul Mescal, Võ Sĩ Giác Đấu II
(5, 5),  -- Denzel Washington, Võ Sĩ Giác Đấu II
(6, 5),  -- Pedro Pascal, Võ Sĩ Giác Đấu II
(7, 6),  -- Hoài Linh, Công Tử Bạc Liêu
(8, 6),  -- Đức Trí, Công Tử Bạc Liêu
(9, 6),  -- Kiều Minh Tuấn, Công Tử Bạc Liêu
(10, 7), -- Chris Evans, Captain America
(11, 7), -- Anthony Mackie, Captain America
(12, 7), -- Scarlett Johansson, Captain America
(13, 8), -- Jason Momoa, Một Bộ Phim Minecraft
(14, 8), -- Mark Wahlberg, Một Bộ Phim Minecraft
(15, 8), -- Anne Hathaway, Một Bộ Phim Minecraft
(16, 9), -- Aaron Pierre, Mufasa: Vua Sư Tử
(17, 9), -- Kelvin Harrison Jr., Mufasa: Vua Sư Tử
(18, 9), -- Beyoncé, Mufasa: Vua Sư Tử
(19, 10), -- Ben Schwartz, Nhím Sonic 3
(20, 10), -- Idris Elba, Nhím Sonic 3
(21, 10), -- Colleen O'Shaughnessey, Nhím Sonic 3
(22, 11), -- TBA, Bóng Đá Nữ Việt Nam
(31, 11), -- TBA, Bóng Đá Nữ Việt Nam
(24, 11), -- TBA, Bóng Đá Nữ Việt Nam
(25, 12), -- Brian Cox, Chúa Tể Của Những Chiếc Nhẫn
(26, 12), -- Miranda Otto, Chúa Tể Của Những Chiếc Nhẫn
(31, 12), -- Luke Newberry, Chúa Tể Của Những Chiếc Nhẫn
(28, 13), -- Aaron Taylor-Johnson, Kraven - Thợ Săn Thủ Lĩnh
(29, 13), -- Ariana DeBose, Kraven - Thợ Săn Thủ Lĩnh
(30, 13); -- Russell Crowe, Kraven - Thợ Săn Thủ Lĩnh

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng director
--------------------------------------------------------------------------------------
INSERT INTO genres_movies(id_genre, id_movie) VALUES
(1, 1),  -- Tee Yod: Quỷ Ăn Tạng Phần 2 - Horror
(2, 2),  -- Venom: Kèo Cuối - Action
(1, 3),  -- Ác Quỷ Truy Hồn - Horror
(1, 4),  -- Vùng Đất Bị Nguyền Rủa - Horror
(2, 5),  -- Võ Sĩ Giác Đấu II - Action
(3, 6),  -- Công Tử Bạc Liêu - Drama
(2, 7),  -- Captain America: Trật Tự Thế Giới Mới - Action
(5, 8),  -- Một Bộ Phim Minecraft - Adventure
(4, 9),  -- Mufasa: Vua Sư Tử - Drama
(6, 10), -- Nhím Sonic 3 - Animation
(3, 11), -- Bóng Đá Nữ Việt Nam: Chuyện Lần Đầu Kể - Drama
(8, 12), -- Chúa Tể Của Những Chiếc Nhẫn: Cuộc Chiến Của Rohirrim - Fantasy
(2, 13), -- Kraven - Thợ Săn Thủ Lĩnh - Action
(9, 14), -- Tín Hiệu Cầu Cứu - Documentary
(4, 15); -- Cười 2 - Comedy

--------------------------------- insert TABLE ----------------------------------------------
--- Bảng sử dụng show_times
--------------------------------------------------------------------------------------
-- Thêm thời gian cho phim Ác Quỷ Truy Hồn (ID 3)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 1, '2024-11-11 06:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 2, '2024-11-11 06:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 3, '2024-11-11 06:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 4, '2024-11-11 07:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 5, '2024-11-11 07:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 6, '2024-11-11 07:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 7, '2024-11-11 07:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 8, '2024-11-11 08:00:00');

-- Thêm thời gian cho phim Công Tử Bạc Liêu (ID 6)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 1, '2024-11-11 09:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 2, '2024-11-11 09:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 3, '2024-11-11 09:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 4, '2024-11-11 10:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 5, '2024-11-11 10:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 6, '2024-11-11 10:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 7, '2024-11-11 10:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 8, '2024-11-11 11:00:00');

-- Thêm thời gian cho phim Nhím Sonic 3 (ID 10)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 1, '2024-11-11 12:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 2, '2024-11-11 12:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 3, '2024-11-11 12:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 4, '2024-11-11 13:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 5, '2024-11-11 13:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 6, '2024-11-11 13:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 7, '2024-11-11 13:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 8, '2024-11-11 14:00:00');

-- Thêm thời gian cho phim Kraven - Thợ Săn Thủ Lĩnh (ID 13)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 1, '2024-11-11 15:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 2, '2024-11-11 15:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 3, '2024-11-11 15:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 4, '2024-11-11 16:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 5, '2024-11-11 16:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 6, '2024-11-11 16:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 7, '2024-11-11 16:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 8, '2024-11-11 17:00:00');

-- Thêm thời gian cho phim Tín Hiệu Cầu Cứu (ID 14)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 1, '2024-11-11 18:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 2, '2024-11-11 18:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 3, '2024-11-11 18:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 4, '2024-11-11 19:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 5, '2024-11-11 19:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 6, '2024-11-11 19:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 7, '2024-11-11 19:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 8, '2024-11-11 20:00:00');

INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 1, '2024-11-12 06:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 2, '2024-11-12 06:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 3, '2024-11-12 06:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 4, '2024-11-12 07:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 5, '2024-11-12 07:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 6, '2024-11-12 07:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 7, '2024-11-12 07:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (3, 8, '2024-11-12 08:00:00');

-- Thêm thời gian cho phim Công Tử Bạc Liêu (ID 6)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 1, '2024-11-12 09:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 2, '2024-11-12 09:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 3, '2024-11-12 09:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 4, '2024-11-12 10:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 5, '2024-11-12 10:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 6, '2024-11-12 10:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 7, '2024-11-12 10:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (6, 8, '2024-11-12 11:00:00');

-- Thêm thời gian cho phim Nhím Sonic 3 (ID 10)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 1, '2024-11-12 12:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 2, '2024-11-12 12:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 3, '2024-11-12 12:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 4, '2024-11-12 13:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 5, '2024-11-12 13:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 6, '2024-11-12 13:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 7, '2024-11-12 13:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (10, 8, '2024-11-12 14:00:00');

-- Thêm thời gian cho phim Kraven - Thợ Săn Thủ Lĩnh (ID 13)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 1, '2024-11-12 15:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 2, '2024-11-12 15:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 3, '2024-11-12 15:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 4, '2024-11-12 16:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 5, '2024-11-12 16:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 6, '2024-11-12 16:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 7, '2024-11-12 16:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (13, 8, '2024-11-12 17:00:00');

-- Thêm thời gian cho phim Tín Hiệu Cầu Cứu (ID 14)
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 1, '2024-11-12 18:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 2, '2024-11-12 18:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 3, '2024-11-12 18:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 4, '2024-11-12 19:00:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 5, '2024-11-12 19:15:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 6, '2024-11-12 19:30:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 7, '2024-11-12 19:45:00');
INSERT INTO show_times (id_movie, id_screen_room, time_start) VALUES (14, 8, '2024-11-12 20:00:00');


INSERT INTO customers (name, email, phone, rank)
VALUES
    (N'Nguyễn Văn A', 'nguyenvana@example.com', '0123456789', N'CẤP ĐỒNG'),
    (N'Trần Thị B', 'tranthib@example.com', '0987654321', N'CẤP BẠC'),
    (N'Lê Văn C', 'levanc@example.com', '0112233445', N'CẤP VÀNG'),
    (N'Phạm Thị D', 'phamthid@example.com', '0122334455', N'CẤP BẠCH KIM'),
    (N'Đỗ Văn E', 'dovan@example.com', '0133445566', N'CẤP KIM CƯƠNG'),
    (N'Nguyễn Thị F', 'nguyenthif@example.com', '0144556677', N'CẤP ĐỒNG'),
    (N'Bùi Văn G', 'buivang@example.com', '0155667788', N'CẤP BẠC'),
    (N'Vũ Thị H', 'vuthih@example.com', '0166778899', N'CẤP VÀNG'),
    (N'Tống Văn I', 'tongvani@example.com', '0177889900', N'CẤP BẠCH KIM'),
    (N'Phan Thị J', 'panthij@example.com', '0188999001', N'CẤP KIM CƯƠNG');

INSERT INTO tickets (id_show_time, id_seat)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (3, 6),
    (1, 7),
    (2, 8),
    (3, 9),
    (1, 10);

----------------------------------------------------------------------------
INSERT INTO transactions (id_customer, id_staff, id_ticket, total_amount, time_transaction, type_transaction) VALUES
(1, NULL, 1, 150.00, '2024-10-15 10:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-10-18 14:05:32.000', NULL),
(1, NULL, 1, 300.00, '2024-10-11 08:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-10-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-10-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-10-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-10-15 08:20:40.000', NULL),
(1, NULL, 1, 210.00, '2024-10-17 13:32:10.000', NULL),
(2, NULL, 1, 315.00, '2024-10-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-10-21 08:10:15.000', NULL),
(1, NULL, 1, 150.00, '2024-09-15 09:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-09-18 14:05:32.000', NULL),
(1, NULL, 1, 300.00, '2024-09-11 09:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-09-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-09-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-09-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-09-15 08:20:40.000', NULL),
(1, NULL, 1, 209.00, '2024-09-17 13:32:09.000', NULL),
(2, NULL, 1, 315.00, '2024-09-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-09-21 09:09:15.000', NULL),
(1, NULL, 1, 150.00, '2024-08-15 08:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-08-18 14:05:32.000', NULL),
(1, NULL, 1, 300.00, '2024-08-11 08:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-08-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-08-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-08-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-08-15 08:20:40.000', NULL),
(1, NULL, 1, 208.00, '2024-08-17 13:32:08.000', NULL),
(2, NULL, 1, 315.00, '2024-08-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-08-21 08:08:15.000', NULL),
(1, NULL, 1, 150.00, '2024-07-15 07:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-07-18 14:05:32.000', NULL),
(1, NULL, 1, 300.00, '2024-07-11 07:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-07-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-07-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-07-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-07-15 07:20:40.000', NULL),
(1, NULL, 1, 207.00, '2024-07-17 13:32:07.000', NULL),
(2, NULL, 1, 315.00, '2024-07-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-07-21 07:07:15.000', NULL),
(1, NULL, 1, 150.00, '2024-06-15 06:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-06-18 14:05:32.000', NULL),
(1, NULL, 1, 300.00, '2024-06-11 06:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-06-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-06-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-06-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-06-15 06:20:40.000', NULL),
(1, NULL, 1, 206.00, '2024-06-17 13:32:06.000', NULL),
(2, NULL, 1, 315.00, '2024-06-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-06-21 06:06:15.000', NULL),
(1, NULL, 1, 150.00, '2024-05-15 05:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-05-18 14:05:32.000', NULL),
(1, NULL, 1, 300.00, '2024-05-11 05:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-05-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-05-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-05-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-05-15 05:20:40.000', NULL),
(1, NULL, 1, 205.00, '2024-05-17 13:32:05.000', NULL),
(2, NULL, 1, 315.00, '2024-05-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-05-21 05:05:15.000', NULL),
(1, NULL, 1, 150.00, '2024-04-15 04:12:45.000', NULL),
(2, NULL, 1, 420.00, '2024-04-18 14:04:32.000', NULL),
(1, NULL, 1, 300.00, '2024-04-11 04:30:20.000', NULL),
(1, NULL, 1, 215.00, '2024-04-14 16:31:02.000', NULL),
(2, NULL, 1, 180.00, '2024-04-01 12:45:32.000', NULL),
(1, NULL, 1, 95.00, '2024-04-12 11:00:00.000', NULL),
(2, NULL, 1, 320.00, '2024-04-15 04:20:40.000', NULL),
(1, NULL, 1, 204.00, '2024-04-17 13:32:04.000', NULL),
(2, NULL, 1, 315.00, '2024-04-19 15:45:28.000', NULL),
(1, NULL, 1, 340.00, '2024-04-21 04:04:15.000', NULL),
(1, NULL, 1, 150.00, '2024-10-30 10:00:00.000', NULL),
(2, NULL, 1, 420.00, '2024-10-30 11:00:00.000', NULL),
(3, NULL, 1, 300.00, '2024-10-30 12:00:00.000', NULL),
(4, NULL, 1, 215.00, '2024-10-30 13:00:00.000', NULL),
(5, NULL, 1, 180.00, '2024-10-30 14:00:00.000', NULL),
(6, NULL, 1, 95.00, '2024-10-30 15:00:00.000', NULL),
(7, NULL, 1, 320.00, '2024-10-30 16:00:00.000', NULL),
(8, NULL, 1, 210.00, '2024-10-30 17:00:00.000', NULL),
(9, NULL, 1, 315.00, '2024-10-30 18:00:00.000', NULL),
(10, NULL, 1, 340.00, '2024-10-30 19:00:00.000', NULL),
(1, NULL, 1, 150.00, '2024-10-29 10:00:00.000', NULL),
(2, NULL, 1, 420.00, '2024-10-29 11:00:00.000', NULL),
(3, NULL, 1, 300.00, '2024-10-29 12:00:00.000', NULL),
(4, NULL, 1, 215.00, '2024-10-29 13:00:00.000', NULL),
(5, NULL, 1, 180.00, '2024-10-29 14:00:00.000', NULL),
(6, NULL, 1, 95.00, '2024-10-29 15:00:00.000', NULL),
(7, NULL, 1, 320.00, '2024-10-29 16:00:00.000', NULL),
(8, NULL, 1, 210.00, '2024-10-29 17:00:00.000', NULL),
(9, NULL, 1, 315.00, '2024-10-29 18:00:00.000', NULL),
(10, NULL, 1, 340.00, '2024-10-29 19:00:00.000', NULL),
(1, NULL, 1, 150.00, '2024-10-28 10:00:00.000', NULL),
(2, NULL, 1, 420.00, '2024-10-28 11:00:00.000', NULL),
(3, NULL, 1, 300.00, '2024-10-28 12:00:00.000', NULL),
(4, NULL, 1, 215.00, '2024-10-28 13:00:00.000', NULL),
(5, NULL, 1, 180.00, '2024-10-28 14:00:00.000', NULL),
(6, NULL, 1, 95.00, '2024-10-28 15:00:00.000', NULL),
(7, NULL, 1, 320.00, '2024-10-28 16:00:00.000', NULL),
(8, NULL, 1, 210.00, '2024-10-28 17:00:00.000', NULL),
(9, NULL, 1, 315.00, '2024-10-28 18:00:00.000', NULL),
(10, NULL, 1, 340.00, '2024-10-28 19:00:00.000', NULL),
(3, NULL, 1, 300.00, '2024-10-28 12:00:00.000', NULL),
(4, NULL, 1, 215.00, '2024-10-28 13:00:00.000', NULL),
(5, NULL, 1, 180.00, '2024-10-28 14:00:00.000', NULL),
(6, NULL, 1, 95.00, '2024-10-28 15:00:00.000', NULL),
(7, NULL, 1, 320.00, '2024-10-28 16:00:00.000', NULL),
(8, NULL, 1, 210.00, '2024-10-28 17:00:00.000', NULL),
(9, NULL, 1, 315.00, '2024-10-28 18:00:00.000', NULL),
(10, NULL, 1, 340.00, '2024-10-28 19:00:00.000', NULL),
(3, NULL, 1, 300.00, '2024-10-28 12:00:00.000', NULL),
(4, NULL, 1, 215.00, '2024-10-28 13:00:00.000', NULL),
(5, NULL, 1, 180.00, '2024-10-28 14:00:00.000', NULL),
(6, NULL, 1, 95.00, '2024-10-28 15:00:00.000', NULL),
(7, NULL, 1, 320.00, '2024-10-28 16:00:00.000', NULL),
(8, NULL, 1, 210.00, '2024-10-28 17:00:00.000', NULL),
(9, NULL, 1, 315.00, '2024-10-28 18:00:00.000', NULL),
(10, NULL, 1, 340.00, '2024-10-28 19:00:00.000', NULL),
(3, NULL, 1, 300.00, '2024-10-28 12:00:00.000', NULL),
(4, NULL, 1, 215.00, '2024-10-28 13:00:00.000', NULL),
(5, NULL, 1, 180.00, '2024-10-28 14:00:00.000', NULL),
(6, NULL, 1, 95.00, '2024-10-28 15:00:00.000', NULL),
(7, NULL, 1, 320.00, '2024-10-28 16:00:00.000', NULL),
(8, NULL, 1, 210.00, '2024-10-28 17:00:00.000', NULL),
(9, NULL, 1, 315.00, '2024-10-28 18:00:00.000', NULL),
(10, NULL, 1, 340.00, '2024-10-28 19:00:00.000', NULL);
