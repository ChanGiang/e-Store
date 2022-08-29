-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 23, 2022 lúc 04:17 PM
-- Phiên bản máy phục vụ: 10.4.11-MariaDB
-- Phiên bản PHP: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `spring_webbanhang`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `parent_id`) VALUES
(12, 'Tai nghe Over-ear', 9),
(9, 'Tai nghe', 0),
(10, 'Chuột không dây', 11),
(11, 'Chuột', 0),
(13, 'Chuột có dây', 11),
(14, 'Tai nghe Gaming In-ear', 9),
(15, 'Bàn phím', 0),
(16, 'Bàn phím Bluetooth', 15),
(17, 'Bàn phím thương hiệu', 15);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `text` mediumtext DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `comment`
--

INSERT INTO `comment` (`id`, `created_at`, `rate`, `text`, `product_id`, `user_id`) VALUES
(19, NULL, 4, 'ok', 9, 16),
(20, NULL, 2, '', 9, 16);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `discount_code`
--

CREATE TABLE `discount_code` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `end_date` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `percent` int(11) DEFAULT NULL,
  `start_date` varchar(255) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `discount_code`
--

INSERT INTO `discount_code` (`id`, `code`, `end_date`, `name`, `percent`, `start_date`, `product_id`) VALUES
(1, 'QUOCKHANH', '2022-09-06', 'Free 2/9', 10, '2022-08-17', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) NOT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `favorite`
--

INSERT INTO `favorite` (`id`, `created_at`, `product_id`, `user_id`) VALUES
(5, '2022-08-17', 10, 16);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `order_date` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_payment` int(11) DEFAULT NULL,
  `method_payment` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `address`, `amount`, `description`, `order_date`, `phone_number`, `status`, `user_id`, `is_payment`, `method_payment`) VALUES
(31, 'a', 9075003, 'a', '2022-08-17', '0394073759', 3, 16, 1, 1),
(33, '0394073759', 1500003, 'a', '2022-08-23', '0795911987', 1, 16, 0, 1),
(34, 'GHa', 2850003, 'thanh toán paypal', '2022-08-23', '0379135465', 1, 16, 0, 2),
(35, 'QN', 750003, 'paypal', '2022-08-23', '0394073759', 1, 16, 1, 2),
(36, 'abc', 2850003, 'Momo', '2022-08-23', '0379135465', 1, 16, 2, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(11) NOT NULL,
  `discount` float DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `order_detail`
--

INSERT INTO `order_detail` (`id`, `discount`, `unit_price`, `order_id`, `product_id`) VALUES
(21, 1, 2850000, 31, 6),
(22, 3, 1500000, 31, 9),
(23, 1, 1725000, 31, 11),
(25, 1, 1500000, 33, 9),
(26, 1, 2850000, 34, 6),
(27, 1, 750000, 35, 5),
(28, 1, 2850000, 36, 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `quantityimport` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `description`, `image`, `name`, `view_count`, `category_id`, `quantity`, `discount`, `price`, `created`, `quantityimport`) VALUES
(5, '<h2><strong>Đánh giá chi tiết chuột Havit MS989GT Grey</strong></h2><p>Bên cạnh mang đến những dòng sản phẩm <a href=\"https://gearvn.com/pages/tai-nghe-may-tinh\">tai nghe máy tính</a> đã làm nên thương hiệu của mình. Havit còn mang đến thị trường thiết bị gaming gear những dòng <a href=\"https://gearvn.com/collections/chuot-wireless\">chuột máy tính không dây</a> với độ trễ thấp, thiết kế nhỏ gọn, tiện nghi giúp bạn dễ dàng di chuyển và làm việc ở bất kỳ đâu.</p><p>&nbsp;</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-chuot-havit-ms989gt-grey_4d8c6a5d861d4f16b2c232904956672f_grande.png\" alt=\"GEARVN-chuot-havit-ms989gt-grey\"></p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><h3><strong>Công nghệ không dây 2.4GHz&nbsp;tăng khoảng cách làm việc lên đến 8m</strong></h3><p>&nbsp;</p><p>Để việc kết nối nhanh chóng,&nbsp;Havit MS989GT Grey trang bị công nghệ không dây 2.4GHz hỗ trợ khoảng cách làm việc lên đến 8m, giúp trình bày ý tưởng trong công việc và học tập.</p><p>&nbsp;</p><h3><strong>Thiết kế đối xứng, sử dụng tốt cả hai tay</strong></h3><p>&nbsp;</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-chuot-havit-ms989gt-1_88dfcdd47133404aa68162d32e7f8901_grande.png\" alt=\"GEARVN-chuot-havit-ms989gt-grey\"></p><p>&nbsp;</p><p>Sở hữu thiết kế đối xứng, ôm sát lòng bàn tay giúp bạn có những thao tác sử dụng dễ dàng và thoải mái trong nhiều giờ liền.&nbsp;MS989GT được làm từ chất liệu hợp kim và nhựa cao cấp nên có trọng lượng nhẹ.&nbsp;Đặc biệt, đây là một trong những dòng sản phẩm&nbsp;<a href=\"https://gearvn.com/pages/chuot-may-tinh\">chuột máy tính</a>&nbsp;có thể dùng với tay trái và tay phải tùy thuộc vào thói quen của từng người.</p><h3><strong>Havit MS989GT Grey được bố trí nút bấm hợp lý</strong></h3><p>&nbsp;</p><p>Chuột được tích hợp 4&nbsp;nút bấm tiện lợi phù hợp cho các bạn dùng chuột trong các công việc đơn giản. Tốc độ phản hồi nhanh, giúp bạn có những thao tác nhanh chóng xử lý công việc hiệu quả. Bạn có thể thay đổi DPI chuột chỉ với thao tác đơn giản nhờ vào nút bấm được trang bị trên thân chuột.</p><h3><strong>Công nghệ 800 – 1600 DPI</strong></h3><p>&nbsp;</p><p>&nbsp;</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-chuot-havit-ms989gt_ca1eb3b1ad7d4adc9b2a1313a8bc38f6_grande.png\" alt=\"GEARVN-chuot-havit-ms989gt-grey\"></p><p>&nbsp;</p><p>Một trong những dòng chuột máy tính giá rẻ sở hữu chỉ số DPI&nbsp;(dots per linear inch) hay còn được gọi là độ nhạy của chuột ấn tượng. Với Havit MS989GT bạn hoàn toàn có thể điều chỉnh DPI để phù hợp với công việc, học tập và cả chơi game giải trí.</p>', '1657104345705.jpg', 'Havit MS989GT Grey', 20, 10, 100, 25, 1000000, '2022-07-06', 100),
(6, '<h2>Chuột Logitech G Pro Hero</h2><p>HERO 16K là một trong những dòng <a href=\"https://gearvn.com/collections/chuot-logitech\"><strong>chuột logitech</strong></a> đưuọc trang bị cảm biến chơi game chính xác nhất từ trước tới nay của chúng tôi với độ chính xác thế hệ tiếp theo và cấu trúc toàn diện. HERO 16K có khả năng tạo ra 400+ IPS, 100 - 16,000 DPI, và làm mịn, lọc hay tăng tốc trên toàn bộ dải DPI.</p><p>HERO 16K đạt được độ chính xác cấp độ thi đấu và độ nhạy ổn định nhất từ trước tới nay. Hãy chắc chắn tùy chỉnh và sửa các cài đặt DPI của bạn bằng Logitech G HUB.</p>', '1657104416985.jpg', 'Logitech G Pro Hero', 85, 13, 99, 5, 3000000, '2022-07-06', 100),
(9, '<h2><strong>Đánh giá chi tiết tai nghe HyperX Cloud Core Wireless</strong></h2><p><a href=\"https://gearvn.com/collections/tai-nghe-hyperx\">Tai nghe HyperX</a> Cloud Core Wireless là tai nghe gaming mới của nhà Hyper. Dòng Cloud Core luôn ghi dấu ấn trong lòng người dùng bởi chất lượng âm thanh tuyệt vời, người chơi sẽ đắm chìm vào những thanh âm trong trẻo sống động. HyperX Cloud Core Wireless có thể nói là một trong những <a href=\"https://gearvn.com/collections/tai-nghe-wireless\">tai nghe không dây</a> đáng sở hữu nhất cho game thủ thời điểm hiện tại.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-tai-nghe-hyperx-cloud-core-wireless-1_d63ef4c2b9ba482a9099d416045ec19c.png\" alt=\"GEARVN - Tai nghe HyperX Cloud Core Wireless\"></p><h3><strong>Thiết kế HyperX Cloud Core đẹp mắt</strong></h3><p><a href=\"https://gearvn.com/pages/tai-nghe-may-tinh\">Tai nghe máy tính</a> HyperX Cloud Core sở hữu thiết kế chụp tai đơn giản với logo HyperX đặc trưng ngay trên ear cup. Sự kết hợp giữa tông màu đen và đỏ đã tạo nên tổng thể vô cùng hài hòa, sang trọng và sạch sẽ.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-tai-nghe-hyperx-cloud-core-wireless-2_58d405b473cc41d7841365c4519d364b_grande.png\" alt=\"GEARVN - Tai nghe HyperX Cloud Core Wireless\"></p><p>Phần khung được gia công tỉ mỉ bằng kim loại chắc chắn với độ bền cao. Phần đệm tai nghe được thiết kế bằng mút than hoạt tín mềm mại, giúp gây ra tình trạng đau tai khi đeo tai nghe quá lâu, giúp bạn thoải mái chiến game hàng giờ liền.</p><h3><strong>Microphone tháo rời</strong></h3><p>Điểm đặc biệt trên HyperX Cloud Core Wireless chính là phần <a href=\"https://gearvn.com/collections/microphone\">microphone</a> có khả năng khử tiếng ồn khá tốt. Âm thanh thu vào cực kỳ trong trẻo và êm tai. Ngoài ra, phần microphone còn có thể tháo rời dễ dàng, giúp cho bạn dễ dàng tháo lắp và di chuyển đi khắp nơi.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-tai-nghe-hyperx-cloud-core-wireless-3_0dc2eed55357490eb69042979b53f190_grande.png\" alt=\"GEARVN - Tai nghe HyperX Cloud Core Wireless\"></p><h3><strong>Thời lượng pin tốt</strong></h3><p>Tai nghe HyperX Cloud Core Wireless được trang bị viên pin lithium-polymer giúp quá trình sạc chỉ mất 3 giờ nhưng thời gian sử dụng lại lên đến 20 tiếng ấn tượng. Bạn sẽ không cần lo lắng tai nghe hết pin giữa trận, làm gián đoạn cuộc chơi.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-tai-nghe-hyperx-cloud-core-wireless-5_bd3f0d89f3df44a288e6c3bea240491b.jpg\" alt=\"GEARVN - Tai nghe HyperX Cloud Core Wireless\"></p><h3><strong>Khả năng tương thích tốt</strong></h3><p>HyperX Cloud Core Wireless&nbsp; sở hữu khả năng tương thích cực kỳ ấn tượng. Ngoài thiết bị <a href=\"https://gearvn.com/pages/pc-gvn\">PC</a>, bạn có thể kết nối với các thiết bị chơi game như&nbsp;<a href=\"https://gearvn.com/collections/sony-playstation\">PS4</a> và PS5 để tận hưởng những trải nghiệm chơi game mới mẻ và ấn tượng.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-tai-nghe-hyperx-cloud-core-wireless-1_d63ef4c2b9ba482a9099d416045ec19c.png\" alt=\"GEARVN - Tai nghe HyperX Cloud Core Wireless\"></p>', '1657104498336.jpg', 'HyperX Cloud Core Wireless', 100, 12, 97, 25, 2000000, '2022-07-06', 100),
(10, '<h3><strong>Đánh giá chi tiết&nbsp;tai nghe Razer Hammerhead True Wireless Pro</strong></h3><p>Tai nghe Razer Hammerhead True Wireless Pro là một trong những dòng <a href=\"https://gearvn.com/collections/tai-nghe-gaming-bluetooth\">tai nghe bluetooth chơi game</a>&nbsp;mang đến&nbsp;sự thoải mái cho người dùng trong suốt thời gian dài.</p><p><img src=\"https://file.hstatic.net/1000026716/file/tai-nghe-razer-hammerhead-true-wireless-pro-1_b13b74ca164044528f527cbe64ed4872.jpg\"></p><h3><strong>Thiết kế true wireless mới lạ và đậm chất Razer</strong></h3><p><a href=\"https://gearvn.com/pages/tai-nghe-may-tinh\">Tai nghe máy tính</a> không dây&nbsp;Hammerhead True Wireless Pro có khá nhiều điểm tương đồng với dòng tai nghe airpots&nbsp;pro đến từ Apple. Nhưng vẫn mang những thiết kế riêng và đậm chất Razer với vẻ ngoài mạnh mẽ, chắc chắn và đẳng cấp.</p><p><img src=\"https://file.hstatic.net/1000026716/file/tai-nghe-razer-hammerhead-true-wireless-pro-4_2a1ada9ebfd542eab561da2a704cb94e.jpg\"></p><h3><strong>Thoải mái sử dụng</strong></h3><p>Tai nghe Razer Hammerhead True Wireless Pro là một trong những dòng sản phẩm tai nghe true wireless với kích thước vừa vặn trong tai và cách ly tiếng ồn nâng cao với các đầu mút Comply. Để có các mức độ thoải mái hoặc tùy chọn âm thanh tùy chỉnh Razer còn mang đến cho người dùng thêm 6 bộ tip silicone. Mang đến những trải nghiệm tuyệt vời đồng thời nâng cao chất lượng giải trí với các trò chơi cạnh tranh cùng chất lượng âm thanh hoàn hảo.</p><p><img src=\"https://file.hstatic.net/1000026716/file/tai-nghe-razer-hammerhead-true-wireless-pro-5_259debfa3ef54ceea7f8f082f4d81f10.jpg\"></p><h3><strong>Thời gian sử dụng lâu dài</strong></h3><p>Tai nghe chơi game Razer Hammerhead True Wireless Pro giúp người dùng tận hưởng việc giải trí với thời gian sử dụng lên đến 4 giờ chỉ với một lần sạc và hộp sạc cung cấp thêm thời lượng pin lên đến 16 giờ.</p><p><img src=\"https://file.hstatic.net/1000026716/file/tai-nghe-razer-hammerhead-true-wireless-pro-6_7049e484886b4e4789f79b45f4dab611.jpg\"></p>', '1657104647329.jpg', 'Razer Hammerhead True', 5, 14, 100, 25, 2000000, '2022-07-06', 100),
(11, '<p><strong>Thông tin chung:</strong></p><ul><li><strong>Hãng sản xuất:</strong>&nbsp;Leopold&nbsp;</li><li><strong>Tình trạng:</strong> Mới</li><li><strong>Bảo hành:</strong> 24 Tháng</li><li><strong>Switch:</strong>&nbsp;Cherry Blue / Brown / Red&nbsp;/ Silent Red</li></ul>', '1657104735096.jpg', 'Leopold FC750R Bluetooth', 1, 16, 99, 25, 2300000, '2022-07-06', 100),
(12, '<h2><strong>Đánh giá bàn phím cơ Steelseries Apex&nbsp;Pro</strong></h2><p>&nbsp;</p><h3><strong>Sự kêt hợp hoàn hảo</strong></h3><p>Bàn phím cơ <strong>Apex Pro</strong>&nbsp;là kết hợp sự mượt mà của membrane switch với độ bền, hiệu suất và cảm giác thoải mái khi gõ, cho trải nghiệm chơi game tuyệt vời.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-2_7ab666b505dd4e18b9ece178578d784f_grande.jpg\"></p><h3><strong>Màn hình OLED thông minh</strong></h3><p>Tùy chỉnh với&nbsp;màn hình OLED với các gif yêu thích của bạn, xem thông tin trò chơi đang hoạt động, tin nhắn discord đến, cài đặt, v.v. và hiển thị thông tin trong game</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-3_aea099d292204d22aede31bbbe3b446a_grande.png\"></p><h3><strong>Công tắc cơ điều chỉnh</strong></h3><p>Thay vì những công tắc truyền động cố định truyền thống&nbsp;các công tắc OmniPoint có thể được điều chỉnh để chỉnh sửa tại bất kỳ điểm nào từ 0,4-3,6mm, cho phép bạn sử dụng bàn phím hoàn hảo cho các trò chơi và kiểu gõ khác nhau.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-1_94d6834466884e94873eab6b9478f601_grande.jpg\"></p><p>&nbsp;</p><h3><strong>Kê tay&nbsp;cao cấp</strong></h3><p>Phụ kiện tuyệt vời cho&nbsp;bàn phím cơ, với nam chân gắn dễ dàng hơn sẽ xóa bỏ mọi phiền toái khi lắp không vừa ý bạn. Bao quát lòng bàn tay để hỗ trợ, cho dù là nghỉ ngơi hay làm việc thì bạn cũng sẽ cảm thấy cực kì thoải mái.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-4_eea03aa39f8547a1b2e8fe2350a03aee_grande.jpg\"></p><h3><strong>Điểu khiển đa phương tiện chuyên dụng</strong></h3><p>Một con lăn kim loại và các phím phương tiện có thể nhấp cho phép bạn điều chỉnh âm lượng và cài đặt một cách nhanh chóng: thay đổi độ sáng, tua lại, bỏ qua, tạm dừng và hơn thế nữa, tất cả chỉ bằng một nút bấm.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-5_af9121206a01433fa2f4d9f5b5a5c901_grande.jpg\"></p><h3><strong>Thiết kế vững chắc hầm hố</strong></h3><p>Khung kim loại hợp kim nhôm khiến cho tuổi thọ và độ bền lên cao ngất ngưởng. Khiến nó trở thành trung tâm hoàn hảo của bất kỳ thiết lập nào.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-6_24967305ea794c3ba4018e47e0c3ea1c_grande.jpg\"></p><h3><strong>Led Per-Key RGB</strong></h3><p>Led Per-Key RGB động&nbsp;với&nbsp;16,8 triệu màu chiếu sáng mỗi phím cho phép&nbsp;thoải mái tùy chỉnh theo phong cách ,cá tính của người dùng.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-apexpro-7_824e604f49e14e3fb7f7d5662f44ca32_grande.jpg\"></p>', '1657104822224.jpg', 'Steelseries Apex PRO', 2, 17, 100, 25, 2700000, '2022-07-06', 100),
(13, '<h3><strong>Giới thiệu&nbsp;Bàn phím cơ Gaming Razer Blackwidow 2019 Green Switch</strong></h3><p>Razer Blackwidow một trong những dòng <a href=\"https://gearvn.com/pages/ban-phim-may-tinh\">bàn phím cơ</a> được thiết kế và sản xuất bởi hãng Razer Inc. - một công ty của Mỹ, được thành lập bởi Min-Liang Tan, và Robert Krakoff có trụ sở ở Califoria chuyên cung cấp các sản phẩm, phụ kiện chất lượng dành cho game thủ. Các sản phẩm đến từ Razer thường được giới game thủ đánh giá cao về mặt chất lượng lẫn giá cả.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-blackwidow-2019-1_be1ff2bac9904ee9814d7c1eb59053bf_grande.jpg\"></p><h3><strong>Chất liệu cao cấp</strong></h3><p>Bàn phím Razer Blackwidow được thiết kế với khung được làm từ chất liệu chắc chắn, bền bỉ, mượt mà. Cùng với các keycap được làm từ nhựa cao cấp đảm bảo tuổi thọ lâu dài cho thiết bị, không bị mờ phím sau thời gian dài.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-blackwidow-2019-2_9a800769dd804339888820bd293b43d0_grande.jpg\"></p><h3><strong>Thiết kế Full-Size</strong></h3><p>Razer Blackwidow được thiết kế theo kiểu dáng <a href=\"https://gearvn.com/collections/ban-phim-may-tinh\">bàn phím</a> full layout đầy đủ 104 phím, có các phím chức năng mang đến cho người dùng một công cụ hỗ trợ các thao tác hotkey tiện lợi trong các tựa game Moba, RTS, FPS thịnh hành hiện nay.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-blackwidow-2019-3_ee0d17f2a5c24be4a6f74fc49d7a90e6_grande.jpg\"></p><h3><strong>Hệ thống Led RGB</strong></h3><p>Bàn phím Razer Blackwidow được trang bị với hệ thống LED độc đáo hiển thị tới 16,8 triệu màu. Giúp người dùng có thể nhìn được rõ chữ hơn khi sử dụng bàn phìm vào ban đêm hay khi thiếu ánh sáng. Độ sáng vừa phải, bắt mắt làm đẹp thêm cho không gian của bạn.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-blackwidow-2019-4_0eacd15e933f4b3cad2af19b01a19ef4_grande.jpg\"></p><h3><strong>Tuổi thọ bàn phím</strong></h3><p>Bàn phím Razer Blackwidow sử dụng Green Switch của cho lực nhấn ổn định mang lại cảm giác đầm tay hơn cho các game thủ và có tuổi thọ lên đến 80 triệu lần bấm. Mỗi nút ấn được trang bị các lớp dày để ổn định hơn và bảo vệ chống bụi và nước.</p><p><img src=\"https://file.hstatic.net/1000026716/file/gearvn-blackwidow-2019-5_1a6fa5a343614f4db0e319ae0d81885e_grande.jpg\"></p><p>Bên cạnh những dòng bàn phím cao cấp, Razer còn mang đến cho người tiêu dùng nhiều sự lựa chọn ở nhiều phân khúc khác nhau từ những chiếc <a href=\"https://gearvn.com/pages/ban-phim-may-tinh\">bàn phím giả cơ</a> cho đến các dòng bàn phím cơ chất lượng, đáp ứng tốt nhu cầu chơi game, làm việc&nbsp;như&nbsp;Razer Blackwidow Green Switch và đây sẽ là một trong những dòng bàn phím bạn không nên bỏ qua.</p>', '1657104889076.jpg', 'Razer Green Switch', 1, 17, 100, 25, 2900000, '2022-07-06', 100);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_CUSTOMER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `email`, `enable`, `full_name`, `password`, `phone_number`, `role_id`, `user_name`) VALUES
(1, 'admin@gmail.com', 1, 'admin', '$2a$10$gOE9r2m8cY7iD0DQIim.UOx3qlbbMQsHrpJAF4Dmopu20vMGCAG0O', '01223415449', 1, 'admin'),
(16, 'nguoidung@gmail.com', 1, 'Nguyen Nguyen Cao', 'e10adc3949ba59abbe56e057f20f883e', '0394043752', 2, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKm1rmnfcvq5mk26li4lit88pc5` (`product_id`),
  ADD KEY `FK8kcum44fvpupyw6f5baccx25c` (`user_id`);

--
-- Chỉ mục cho bảng `discount_code`
--
ALTER TABLE `discount_code`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK4jjwap5hbtcyowj0ddb9irrjs` (`product_id`);

--
-- Chỉ mục cho bảng `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKbg4txsew6x3gl6r9swcq190hg` (`product_id`),
  ADD KEY `FKh3f2dg11ibnht4fvnmx60jcif` (`user_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKel9kyl84ego2otj2accfd8mr7` (`user_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKrws2q0si6oyd6il8gqe2aennc` (`order_id`),
  ADD KEY `FKb8bg2bkty0oksa3wiq5mp5qnc` (`product_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKowomku74u72o6h8q0khj7id8q` (`category_id`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKn82ha3ccdebhokx3a8fgdqeyy` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `discount_code`
--
ALTER TABLE `discount_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
