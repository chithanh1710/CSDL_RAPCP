-- 1. Tắt kiểm tra khóa ngoại cho tất cả các bảng
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- 2. Xóa dữ liệu từ tất cả các bảng theo thứ tự phụ thuộc
DELETE FROM voucher_uses;
DELETE FROM vouchers;
DELETE FROM transactions_foods_drinks;
DELETE FROM foods_drinks;
DELETE FROM problems;
DELETE FROM transactions;
DELETE FROM tickets;
DELETE FROM screen_rooms_seats;
DELETE FROM seats;
DELETE FROM show_times;
DELETE FROM screen_rooms;
DELETE FROM cinemas;
DELETE FROM actors_movies;
DELETE FROM genres_movies;
DELETE FROM movies;
DELETE FROM actors;
DELETE FROM genres;
DELETE FROM directors;
DELETE FROM customers;
DELETE FROM staffs;

-- 3. Reset lại IDENTITY cho tất cả các bảng
DBCC CHECKIDENT ('voucher_uses', RESEED, 0);
DBCC CHECKIDENT ('vouchers', RESEED, 0);
DBCC CHECKIDENT ('transactions_foods_drinks', RESEED, 0);
DBCC CHECKIDENT ('foods_drinks', RESEED, 0);
DBCC CHECKIDENT ('problems', RESEED, 0);
DBCC CHECKIDENT ('transactions', RESEED, 0);
DBCC CHECKIDENT ('tickets', RESEED, 0);
DBCC CHECKIDENT ('screen_rooms_seats', RESEED, 0);
DBCC CHECKIDENT ('seats', RESEED, 0);
DBCC CHECKIDENT ('show_times', RESEED, 0);
DBCC CHECKIDENT ('screen_rooms', RESEED, 0);
DBCC CHECKIDENT ('cinemas', RESEED, 0);
DBCC CHECKIDENT ('actors_movies', RESEED, 0);
DBCC CHECKIDENT ('genres_movies', RESEED, 0);
DBCC CHECKIDENT ('movies', RESEED, 0);
DBCC CHECKIDENT ('actors', RESEED, 0);
DBCC CHECKIDENT ('genres', RESEED, 0);
DBCC CHECKIDENT ('directors', RESEED, 0);
DBCC CHECKIDENT ('customers', RESEED, 0);
DBCC CHECKIDENT ('staffs', RESEED, 0);

-- 4. Bật lại kiểm tra khóa ngoại cho tất cả các bảng
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
