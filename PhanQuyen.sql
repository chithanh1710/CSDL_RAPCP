-- Tạo login và user cho từng thành viên
CREATE LOGIN Thanh WITH PASSWORD = 'Thanh123!';
CREATE LOGIN Tai WITH PASSWORD = 'Tai456!';
CREATE LOGIN Phong WITH PASSWORD = 'Phong789!';
CREATE LOGIN Sang WITH PASSWORD = 'Sang987!';

USE QuanLy_RapChieuPhim; -- Sử dụng cơ sở dữ liệu của bạn

CREATE USER Thanh FOR LOGIN Thanh;
CREATE USER Tai FOR LOGIN Tai;
CREATE USER Phong FOR LOGIN Phong;
CREATE USER Sang FOR LOGIN Sang;

-- Gán quyền cho từng thành viên
-- 1. Thành - Quản trị viên (Admin)
EXEC sp_addrolemember 'db_owner', 'Thanh';

-- 2. Tài, Phong, Sáng - Quyền cơ bản trên toàn bộ cơ sở dữ liệu
GRANT SELECT, INSERT, UPDATE ON DATABASE::QuanLy_RapChieuPhim TO Tai;
GRANT SELECT, INSERT, UPDATE ON DATABASE::QuanLy_RapChieuPhim TO Phong;
GRANT SELECT, INSERT, UPDATE ON DATABASE::QuanLy_RapChieuPhim TO Sang;
