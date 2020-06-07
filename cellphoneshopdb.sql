-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 31, 2020 lúc 02:57 PM
-- Phiên bản máy phục vụ: 10.4.11-MariaDB
-- Phiên bản PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cellphoneshopdb`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--
CREATE DATABASE `cellphoneshopdb`;
USE `cellphoneshopdb`;
CREATE TABLE `cart` (
  `customerID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`customerID`, `productID`, `amount`) VALUES
(7, 31, 6),
(7, 7, 3),
(7, 3, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customers`
--

CREATE TABLE `customers` (
  `customerID` int(15) NOT NULL,
  `username` text NOT NULL,
  `password` varchar(20) NOT NULL,
  `customerName` varchar(255) NOT NULL,
  `phoneNumber` varchar(11) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `customers`
--

INSERT INTO `customers` (`customerID`, `username`, `password`, `customerName`, `phoneNumber`, `address`) VALUES
(1, 'cauchumoc123', '123123132', '', '0865007564', ''),
(2, '18020153', '123123', 'Pham Duc Anh', '0335229871', '1 Pham Van Dong, 1 Pham Van Dong, 1 Pham Van Dong'),
(7, 'admin', 'admin1', 'Pham Duc Anh', '0335229871', 'Hai Duong');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orderdetails`
--

CREATE TABLE `orderdetails` (
  `orderCode` int(11) NOT NULL,
  `productID` int(15) NOT NULL,
  `amount` int(11) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `orderdetails`
--

INSERT INTO `orderdetails` (`orderCode`, `productID`, `amount`, `buyPrice`) VALUES
(19, 3, 1, '29.99'),
(19, 7, 1, '36.99'),
(20, 11, 1, '5.49'),
(20, 21, 1, '3.69'),
(20, 22, 1, '2.99'),
(20, 26, 1, '5.99'),
(20, 27, 1, '3.29');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `orderCode` int(11) NOT NULL,
  `orderDate` date NOT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `customerID` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`orderCode`, `orderDate`, `shippedDate`, `status`, `customerID`) VALUES
(19, '2020-05-21', NULL, 'Shipping', 2),
(20, '2020-05-21', NULL, 'Shipping', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `productbrands`
--

CREATE TABLE `productbrands` (
  `productBrand` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `countryOrigin` varchar(255) NOT NULL,
  `image` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `productbrands`
--

INSERT INTO `productbrands` (`productBrand`, `description`, `countryOrigin`, `image`) VALUES
('Apple', '', 'USA', ''),
('Huawei', 'Huawei là một tập đoàn đa quốc gia về thiết bị mạng và viễn thông, có trụ sở chính tại Thâm Quyến, Quảng Đông, Trung Quốc.', 'China', ''),
('OPPO', '', 'China', ''),
('Samsung', '', 'South Korea', ''),
('Vsmart', 'Công ty cổ phần nghiên cứu và sản xuất VinSmart là một công ty sản xuất và phân phối các thiết bị viễn thông trực thuộc tập đoàn Vingroup do Phạm Nhật Vượng thành lập ngày 12/6/2018.', 'Vietnam', ''),
('Xiaomi', '', 'China', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `productID` int(15) NOT NULL,
  `productName` varchar(60) NOT NULL,
  `productBrand` varchar(50) NOT NULL,
  `productScreen` varchar(20) NOT NULL,
  `productCPU` varchar(50) NOT NULL,
  `productRAM` int(3) NOT NULL,
  `productROM` int(4) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL,
  `productOS` varchar(255) DEFAULT NULL,
  `productBattery` int(5) DEFAULT NULL,
  `mainCamera` varchar(255) DEFAULT NULL,
  `secondaryCamera` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`productID`, `productName`, `productBrand`, `productScreen`, `productCPU`, `productRAM`, `productROM`, `description`, `quantityInStock`, `buyPrice`, `productOS`, `productBattery`, `mainCamera`, `secondaryCamera`) VALUES
(3, 'Galaxy S20 ULTRA', 'Samsung', '6.9 inches, 2K+', 'Exynos 990, 8 nhân', 12, 128, NULL, 20, '29.99', 'Android 10', 5000, 'chính 108MP, 12MP góc rộng, 48MP zoom', '40MP'),
(7, 'Galaxy Z Flip', 'Samsung', '6.7 inches, Full HD', 'Snapdragon 855+, 8 nhân', 8, 256, NULL, 15, '36.99', 'Android 10', 3300, 'chính 12MP, 12MP góc rộng', '10MP'),
(9, 'Galaxy Note 10 Lite', 'Samsung', '6.7 inches, Full HD', 'Exynos 9810, 8 nhân', 8, 128, NULL, 32, '10.99', 'Android 10', 3300, 'chính 12MP, 12MP siêu rộng, 12MP zoom', '32MP'),
(11, 'Galaxy M21', 'Samsung', '6.4 inches, Full HD+', 'Exynos 9611, 8 nhân', 4, 64, NULL, 60, '5.49', 'Android 10', 6000, 'chính 48MP, 8MP góc rộng, 5MP đo chiều sâu', '20MP'),
(12, 'iPhone 11 Pro Max', 'Apple', '6.5 inches, Full HD+', 'Apple A13 Bionic', 4, 64, NULL, 33, '33.99', 'iOS 13', 3969, '12MP góc siêu rộng, 12MP rộng, 12MP zoom', '12MP'),
(14, 'iPhone 11 Pro', 'Apple', '5.8 inches, Full HD+', 'Apple A13 Bionic', 4, 64, NULL, 67, '30.99', 'iOS 13', 3046, '12MP góc siêu rộng, 12MP góc rộng, 12MP zoom', '12MP'),
(16, 'iPhone 11', 'Apple', '6.1 inches, HD', 'Apple A13 Bionic', 4, 64, NULL, 100, '21.99', 'iOS 13', 3110, '12MP góc siêu rộng, 12MP góc rộng', '12MP'),
(17, 'iPhone XS Max', 'Apple', '6.5 inches, Full HD ', 'Apple A12 Bionic', 4, 64, NULL, 35, '26.99', 'iOS 12', 3174, '12MP góc rộng, 12MP zoom', '7MP'),
(19, 'Xiaomi Mi Note 10 Pro', 'Xiaomi', '6.47 inches, Full HD', 'Snapdragon 730G, 8 nhân', 8, 256, NULL, 96, '13.49', 'Android 9.0', 5260, 'chính 108MP, 20MP góc siêu rộng, 2MP macro, 5MP zoom 5x, 12MP zoom 2x ', '32MP'),
(20, 'Xiaomi Redmi Note 8', 'Xiaomi', '6.3 inches, Full HD ', 'Snapdragon 665, 8 nhân', 4, 128, NULL, 77, '5.09', 'Android 9.0', 4000, 'chính 48MP, 8MP góc rộng, 2MP đo chiều sâu, 2MP macro', '13MP'),
(21, 'Xiaomi Redmi Note 7', 'Xiaomi', '6.3 inches, Full HD', 'Snapdragon 660, 8 nhân', 4, 64, NULL, 35, '3.69', 'Android 9.0', 4000, 'chính 48MP, 5MP đo chiều sâu', '13MP'),
(22, 'Xiaomi Redmi 8', 'Xiaomi', '6.22 inches, HD', 'Snapdragon 439, 8 nhân', 4, 64, NULL, 12, '2.99', 'Android 9.0', 5000, 'chính 12MP, 2MP đo chiều sâu', '8MP'),
(23, 'OPPO Find X2', 'OPPO', '6.78 inches, 2K', 'Snapdragon 865, 8 nhân', 12, 256, NULL, 66, '23.99', 'Android 10.0', 4200, '48MP góc rộng, 13MP zoom, 12MP góc rộng', '32MP'),
(25, 'OPPO Reno 2', 'OPPO', '6.55 inches, Full HD', 'Snapdragon 730G, 8 nhân', 8, 256, NULL, 78, '12.49', 'Android 9.0', 4000, 'chính 48MP, 8MP góc siêu rộng, 13MP zoom 5x, 2MP', '16MP'),
(26, 'OPPO A9 2020', 'OPPO', '6.5 inches, HD', 'Snapdragon 665, 8 nhân', 8, 128, NULL, 95, '5.99', 'Android 9.0', 5000, 'chính 48MP, 8MP góc siêu rộng, 2MP + 2MP đo chiều sâu', '16MP'),
(27, 'OPPO A5s', 'OPPO', '6.2 inches, HD', 'MediaTek 6765, 8 nhân', 3, 32, NULL, 101, '3.29', 'Android 8.1', 4230, '', '8MP'),
(28, 'Huawei Mate 30 Pro', 'Huawei', '1080 x 2400 Pixels 6', 'HUAWEI Kirin 990', 8, 256, NULL, 52, '19.90', 'Android 10.0', 4500, 'Chính 40 MP & Phụ 40 MP, 8MP, TOF 3D Chính 32 MP & Phụ TOF 3D', 'Chính 32 MP & Phụ TOF 3D'),
(29, 'Huawei P30 Pro', 'Huawei', '6.47 inches, FHD+, 2', 'HUAWEI Kirin 980, Octa-Core, 2*Nhân Cortex-A76 2,6', 8, 256, NULL, 12, '15.00', 'Android™ 9.0 + EMUI 9.1', 4200, '40Mp (khẩu độ f/1.8) + 20Mp (khẩu độ f/2.2) + 8Mp (khẩu độ f/2.4) + Camera Time-of-Flight (4 Camera Leica)', '32.0Mp'),
(30, 'Huawei Nova 5T', 'Huawei', '6.26 inches, FHD+', 'HUAWEI Kirin 980, Octa-Core, 2xCortex A76 2.6 GHz ', 8, 128, NULL, 54, '9.00', 'Android™ 9.0 + EMUI 9.1', 3750, '48 MP,16 MP +2 MP+2 MP ( 4 camera)', '	32.0Mp'),
(31, 'Huawei Nova 7i', 'Huawei', '6.4 inches, FHD+', '	HiSilicon Kirin 810 (7 nm), Octa-Core, 2x2.27 GHz', 8, 125, NULL, 12, '7.00', 'Android 10.0', 4200, '48MP+ 8MP+2MP+2MP', '16.0 MP'),
(32, 'Huawei Y9s', 'Huawei', '6.59 inchs, FHD+', 'HUAWEI Kirin 710F, Octa-Core, 4xCortex A73 2.2GHz ', 6, 128, NULL, 55, '5.80', 'Android™ 9.0 + EMUI 9.1', 4000, '48 MP,8 MP +2 MP ( 3 camera )', '16.0 MP'),
(33, 'Huawei P30 Lite', 'Huawei', '6.15 inches, FHD+', 'HUAWEI Kirin 710, Octa-Core, 4xCortex A73 2.2GHz +', 6, 128, NULL, 102, '5.00', 'Android™ 9.0 + EMUI 9.1', 3340, '24 MP+8 MP+2 MP (3 camera)', '32.0Mp'),
(34, 'Huawei Y7 Pro', 'Huawei', '6.23 inches, HD +', 'Qualcomm Snapdragon 450, 8, 8xCortex A53 1.8GHz', 3, 32, NULL, 23, '3.50', 'Android™ 8.0 + EMUI 8.0', 4000, '13 MP và 2 MP (2 camera)', '16.0 MP'),
(35, 'Vsmart Bee 3', 'Vsmart', '6.0 inches, HD+', 'MediaTek MT6739WW, 4, 1.5Ghz', 2, 16, NULL, 66, '1.40', 'Android 9.0 (Pie)', 3000, '8.0 MP, f2.0', '5.0 MP'),
(36, 'Vsmart Joy 2+', 'Vsmart', '6.2 inchs, HD +, 720', 'Qualcomm® Snapdragon™ 450, 8, 1.8Ghz', 2, 32, NULL, 22, '2.00', 'Android 9', 4500, '13MP f/2.0 + 5 MP f/2.4', '8.0 MP'),
(37, 'Vsmart Star 3', 'Vsmart', '6.1 inches, HD +, 72', 'Snapdragon 215, 4, 1.3GHz', 2, 16, NULL, 87, '1.80', 'VOS (Based on Android 9.0)', 3520, '8MP AF f/1.9 + 5MP f/2.2', '8 MP, F/2.0'),
(38, 'Vsmart Active 3', 'Vsmart', '6.39 inchs, Full HD ', 'MediaTek Helio P60 8 nhân, 8, 2.0Ghz', 6, 64, NULL, 33, '4.00', 'Android 9', 4020, '48 MP f/1.7 + 8MP f/2.2 + 2MP', '16.0 MP');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD KEY `product_id_cart` (`productID`),
  ADD KEY `customer_id_cart` (`customerID`);

--
-- Chỉ mục cho bảng `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerID`);

--
-- Chỉ mục cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD KEY `orderCode` (`orderCode`),
  ADD KEY `productID` (`productID`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderCode`),
  ADD KEY `customerID` (`customerID`);

--
-- Chỉ mục cho bảng `productbrands`
--
ALTER TABLE `productbrands`
  ADD PRIMARY KEY (`productBrand`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productID`),
  ADD KEY `product_brand` (`productBrand`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customers`
--
ALTER TABLE `customers`
  MODIFY `customerID` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `orderCode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `productID` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `customer_id_cart` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_id_cart` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`orderCode`) REFERENCES `orders` (`orderCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customers` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `product_brand` FOREIGN KEY (`productBrand`) REFERENCES `productbrands` (`productBrand`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
