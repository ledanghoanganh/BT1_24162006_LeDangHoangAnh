-- Thêm tài khoản test (Mật khẩu: 123456)
-- Tài khoản admin (roleid = 1) vào được trang quản lý /admin/category/list
INSERT INTO `user` (`email`, `username`, `fullname`, `password`, `avatar`, `roleid`, `phone`, `createddate`)
VALUES 
('admin@gmail.com', 'admin', 'Quản trị viên', '123456', NULL, 1, '0987654321', CURDATE()),
('user@gmail.com', 'user1', 'Nguyễn Văn A', '123456', NULL, 5, '0901234567', CURDATE());

-- Thêm danh mục mẫu ban đầu
INSERT INTO `category` (`cate_name`, `icons`) 
VALUES 
('Quần Áo Nam', 'avata.png'),
('Quần Áo Nữ', 'avata.png'),
('Giày Dép', 'avata.png');