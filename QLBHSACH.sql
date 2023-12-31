﻿CREATE DATABASE QUANLYBANHANGSACH
GO
USE QUANLYBANHANGSACH
GO
CREATE TABLE TACGIA
(
	MATACGIA VARCHAR(5) PRIMARY KEY,
	TENTACGIA NVARCHAR(50) NOT NULL,
	WEBSITE VARCHAR(100) NULL,
	GHICHU NVARCHAR(255) NULL
);
GO
CREATE TABLE THELOAI
(
	MATHELOAI VARCHAR(5) PRIMARY KEY,
	TENTHELOAI NVARCHAR(50) NOT NULL
);
GO
CREATE TABLE NXB
(
	MANXB VARCHAR(5) PRIMARY KEY,
	TENNXB NVARCHAR(50) NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	NGDAIDIEN NVARCHAR(50) NULL
);
GO
CREATE TABLE NCC
(
	MANCC VARCHAR(5) PRIMARY KEY,
	TENNCC NVARCHAR(50) NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL
);
GO
CREATE TABLE SDT
(
	MANCC VARCHAR(5),
	SDT VARCHAR(15),
	PRIMARY KEY(MANCC, SDT)
);
GO
CREATE TABLE NHANVIEN
(
	MANV VARCHAR(5) PRIMARY KEY,
	TENNV NVARCHAR(50) NOT NULL,
	NGAYSINH DATE NOT NULL,
	SDT VARCHAR(15) NOT NULL
);
GO
CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(5) PRIMARY KEY,
	TENKH NVARCHAR(50) NOT NULL,
	DIACHI NVARCHAR(100) NULL,
	SDT VARCHAR(15) NOT NULL
);
GO
CREATE TABLE SACH
(
	MASACH VARCHAR(5) PRIMARY KEY,
	TENSACH NVARCHAR(100) NOT NULL,
	MATACGIA VARCHAR(5),
	MATHELOAI VARCHAR(5),
	MANXB VARCHAR(5),
	NAMXB DATE NOT NULL,
	FOREIGN KEY (MATACGIA) REFERENCES TACGIA(MATACGIA),
	FOREIGN KEY(MATHELOAI) REFERENCES THELOAI(MATHELOAI),
	FOREIGN KEY (MANXB) REFERENCES NXB(MANXB)
);
GO
CREATE TABLE PHIEUNHAP
(
	MAPN VARCHAR(5) PRIMARY KEY,
	MANV VARCHAR(5),
	MANCC VARCHAR(5),
	NGAYNHAP DATE NOT NULL,
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	FOREIGN KEY (MANCC) REFERENCES NCC(MANCC)
);
GO
CREATE TABLE PHIEUXUAT
(
	MAPX VARCHAR(5) PRIMARY KEY,
	MANV VARCHAR(5),
	MAKH VARCHAR(5),
	NGAYXUAT DATE NOT NULL,
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
	FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
);
GO
CREATE TABLE CTPN
(
	MAPN VARCHAR(5),
	MASACH VARCHAR(5),
	SOLUONG INT NOT NULL,
	DONGIA FLOAT NOT NULL,
	PRIMARY KEY(MAPN, MASACH)
);
GO
CREATE TABLE CTPX
(
	MAPX VARCHAR(5),
	MASACH VARCHAR(5),
	SOLUONG INT NOT NULL,
	DONGIA FLOAT NOT NULL,
	PRIMARY KEY(MAPX, MASACH)
);
GO
--Số lượng sách mà khách hàng khi mua phải ít nhất 1 sách
ALTER TABLE CTPX 
ADD CONSTRAINT check_so_luong_mua 
CHECK( SOLUONG >=1)
--Sô lượng sách mà nhà cung cấp giao phải ít nhất 50 sách
GO
ALTER TABLE CTPN
ADD CONSTRAINT check_so_luong_nhap
CHECK(SOLUONG>50)
--Tạo ngày nhập tự động lấy ngày hiện tại
GO
ALTER TABLE PHIEUNHAP
ADD CONSTRAINT df_ngay_nhap
DEFAULT GETDATE() FOR NGAYNHAP
--Tạo ngày xuất tự động lấy ngày hiện tại
GO
ALTER TABLE PHIEUXUAT
ADD CONSTRAINT df_ngay_xuat
DEFAULT GETDATE() FOR NGAYXUAT
--Các thể loại sách
GO
ALTER TABLE THELOAI
ADD CONSTRAINT check_the_loai
CHECK( TENTHELOAI IN('Trinh thám','Tình cảm','Kinh di','Tiểu thuyết','Truyện ngắn'))
--Thêm thuộc tính GIOITINH cho bảng NHANVIEN
GO
ALTER TABLE NHANVIEN 
ADD GIOITINH NVARCHAR(10)
--Thêm thuộc tính LOAIKH CHO BẢNG KHACHHANG
GO
ALTER TABLE KHACHHANG 
ADD LOAIKH NVARCHAR(20)
--Thêm ràng buộc cho cột GIOITINH nhận giá trị là Nam hoặc Nữ
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT check_gt
CHECK(GIOITINH IN('NAM', 'Nữ'))
--Các loại khách hàng
GO
ALTER TABLE KHACHHANG
ADD CONSTRAINT check_loaikh
CHECK( LOAIKH IN('VIP','Thân thiết','Vãng lai'))
--Tạo ràng buộc UNIQUE cho cột SDT bảng NHANVIEN
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT uq_sdt
UNIQUE(SDT)
--Ngày sinh nhân viên phải lớn hơn ngày hiện tại
GO
ALTER TABLE NHANVIEN
ADD CONSTRAINT check_ngaysinh
CHECK( GETDATE() >NGAYSINH)
--Tạo ràng buộc DEFAULT  cho LOAIKH 
GO
ALTER TABLE KHACHHANG
ADD CONSTRAINT df_loaikh
DEFAULT 'Vãng lai' FOR LOAIKH

GO
INSERT INTO TACGIA VALUES
 ('TG001','Nguyễn Văn A','anguyen@gmail.com',null),
 ('TG002','Trần Văn Bình','anbinh@gmail.com',null),
 ('TG003','Mai Quế Nhân','nhanque@gmail.com',null),
 ('TG004','Đặng Tấn Phước','phuoc602@gmail.com',null),
 ('TG005','La Thất Bồng','labong09@gmail.com',null); 
 GO
INSERT INTO THELOAI VALUES
 ('TH001','Tình cảm'),
 ('TH002','Trinh thám'),
 ('TH003','Kinh di'),
 ('TH004','Tiểu thuyết'),
 ('TH005','Truyện ngắn');
 GO
INSERT INTO NXB VALUES
 ('NXB01','Nguyễn Văn Công','TP.HCM','cnguyen@gmail.com','Trần Thị Bé'),
 ('NXB02','Nguyễn Văn Dương','Đồng Tháp','dnguyen@gmail.com','Mai Thị Nga'),
 ('NXB03','Mai Thái Tư','Bình Định','tthai@gmail.com','Lương Thu Hiền'),
 ('NXB04','Trần Tửu Lượng','Huế','ltuu@gmail.com','Nguyễn Minh San'),
 ('NXB05','Thế Thái Sa','Quảng Trị','sthai@gmail.com','Nguyễn Công Cường');
 GO
INSERT INTO NCC VALUES
 ('NCC01','Trần Y Lan','Hà Nội'),
 ('NCC02','Nguyễn Thi Khánh','Hải Dương'),
 ('NCC03','Lý Công An','Bình Định'),
 ('NCC04','Trần Trúc Ly','Tp.HCM'),
 ('NCC05','Nguyễn Khải Xuân','Quảng Ngãi');
 GO
INSERT INTO SDT  VALUES
 ('NCC01','0367581354'),
 ('NCC02','0975621468'),
 ('NCC03','0335781658'),
 ('NCC04','0367141682'),
 ('NCC05','0954381356');
 GO
INSERT INTO NHANVIEN(MANV,TENNV,NGAYSINH,SDT,GIOITINH) VALUES
 ('NV001','Nguyễn Thái Minh','2003-12-25','0364125874','Nam'),
 ('NV002','Nguyễn Anh Sơn','1996-02-15','034863272','Nam'),
 ('NV003','Lý Thu An','2005-05-14','0972356264','Nữ'),
 ('NV004','Chế Nguyễn Dan','1995-07-23','0931475826','Nữ'),
 ('NV005','Trần Văn Bảo','1989-11-05','0931473582','Nam');
 GO
INSERT INTO KHACHHANG(MAKH,TENKH,DIACHI,SDT,LOAIKH) VALUES
 ('KH001','Nguyên Thu Hà', 'Tp.HCM', '0354791365','VIP'),
 ('KH002','Đồng Kim Hồng', 'Bình Dương', '0354879353','Thân thiết'),
 ('KH003','Nguyễn Lai Mai', 'Hà Nội', '0359723522','VIP'),
 ('KH004','Mai Hà Xuân', 'Tp.HCM', '0978213365','Vãng lai'),
 ('KH005','Kim Lương Y', 'Quảng Trị', '0978234585','Vãng lai');
 GO
INSERT INTO SACH VALUES
 ('S0001','Thám hiểm cùng Topa','TG002','TH003','NXB02','2013-03-16'),
 ('S0002','Tình yêu Macxolop','TG001','TH001','NXB01','2019-04-08'),
 ('S0003','Vùng đất hoang','TG002','TH003','NXB05','2015-11-25'),
 ('S0004','Làng ','TG004','TH003','NXB04','2013-08-14'),
 ('S0005','Độc chiến 001','TG005','TH002','NXB03','2012-03-05');
 GO
INSERT INTO PHIEUNHAP VALUES
 ('PN001','NV001','NCC01','2013-12-15'),
 ('PN002','NV002','NCC02','2015-02-06'),
 ('PN003','NV001','NCC03','2015-05-09'),
 ('PN004','NV003','NCC05','2019-11-10'),
 ('PN005','NV004','NCC02','2017-05-11');
 GO
INSERT INTO PHIEUXUAT VALUES
 ('PX001','NV003','KH002','2022-10-06'),
 ('PX002','NV002','KH001','2021-11-05'),
 ('PX003','NV004','KH003','2022-05-04'),
 ('PX004','NV005','KH005','2022-09-18'),
 ('PX005','NV003','KH001','2020-11-26');
 GO
INSERT CTPN VALUES
 ('PN001','S0002',150,25000),
 ('PN002','S0004',200,55000),
 ('PN003','S0001',320,30000),
 ('PN004','S0005',225,45000),
 ('PN005','S0003',135,17500);
 GO
INSERT INTO CTPX VALUES
 ('PX001','S0002',15,25000),
 ('PX002','S0003',23,17500),
 ('PX003','S0001',20,30000),
 ('PX004','S0004',4,55000),
 ('PX005','S0001',2,30000);
--Tính thành tiền cho mỗi phiếu xuất
GO
 SELECT MAPX AS'Mã phiếu xuất', (SOLUONG* DONGIA) AS'Thành tiền'
 FROM CTPX
 --Hiển thị tuổi của tất cả nhân viên
 GO
 SELECT MANV AS'Mã nhân viên', TENNV AS'Họ và tên', YEAR(GETDATE())-YEAR(NGAYSINH) AS'Tuổi', GIOITINH AS 'Giới tính'
 FROM NHANVIEN
 --Hiển thị thông tin nhà xuất bản có chuỗi 'Nguyễn' trong họ và tên
 GO
 SELECT *
 FROM NXB
 WHERE TENNXB LIKE '%Nguyễn%'
 --Thông tin  số lượng sách được nhập cho từng loại sách
 GO
 SELECT  A.MASACH AS'Mã sách', SUM(A.SOLUONG) AS' Số lượng'
 FROM CTPN A
 GROUP BY A.MASACH
--Xuất thông tin tên sách, năm xuất bản, thể loại, tên tác giả, tên nhà xuất bản, tên nhà cung cấp
GO
SELECT A.TENSACH AS'Tên sách',A.NAMXB AS' Năm xuất bản',B.TENTHELOAI AS'Tên thể loại',C.TENTACGIA AS'Tên tác giả',D.TENNXB AS'Tên nhà xuất bản', J.TENNCC AS' Tên nhà cung cấp'
FROM SACH A
INNER JOIN THELOAI B ON A.MATHELOAI= B.MATHELOAI
INNER JOIN TACGIA C ON A.MATACGIA= C.MATACGIA
INNER JOIN NXB D ON A.MANXB= D.MANXB
INNER JOIN CTPN E ON A.MASACH= E.MASACH
INNER JOIN PHIEUNHAP F ON E.MAPN= F.MAPN
INNER JOIN NCC J ON F.MANCC= J.MANCC
--Thông tin nhân viên nữ đã bán ít nhất 1 đơn hàng 
GO
SELECT * 
FROM NHANVIEN A
WHERE( A.GIOITINH='Nữ'
AND(1<= (SELECT COUNT(*)
         FROM PHIEUXUAT B
         WHERE A.MANV=B.MANV)))	  
--Hiên thị thông mã sách , tên sách và số lượng mỗi loại đã bán	 
GO
SELECT A.MASACH AS'Mã sách', A.TENSACH AS 'Tên sách', C.TONGSOLUONG AS'Tổng số lượng đã bán' 
FROM SACH A
INNER JOIN( SELECT B.MASACH, SUM(SOLUONG) AS'TONGSOLUONG'
            FROM CTPX B
			GROUP BY MASACH) C ON A.MASACH= C.MASACH




