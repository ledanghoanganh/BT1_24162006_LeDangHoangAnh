CREATE DATABASE IF NOT EXISTS `BanHang` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `BanHang`;

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `username` VARCHAR(100) NOT NULL UNIQUE,
    `fullname` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `password` VARCHAR(255) NOT NULL,
    `avatar` VARCHAR(500) NULL,
    `roleid` INT NOT NULL DEFAULT 5, -- 1: Admin, 2: Manager, 5: User
    `phone` VARCHAR(20) NULL,
    `createddate` DATE NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
    `cate_id` INT AUTO_INCREMENT PRIMARY KEY,
    `cate_name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `icons` VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


