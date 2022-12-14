USE [master]
GO
/****** Object:  Database [qlht]    Script Date: 10/29/2021 2:44:04 PM ******/
CREATE DATABASE [qlht]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'qlht', FILENAME = N'E:\Microsoft SQL Server\MSSQL15.LUUPOT\MSSQL\DATA\qlht.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'qlht_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL15.LUUPOT\MSSQL\DATA\qlht_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [qlht] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [qlht].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [qlht] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [qlht] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [qlht] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [qlht] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [qlht] SET ARITHABORT OFF 
GO
ALTER DATABASE [qlht] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [qlht] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [qlht] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [qlht] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [qlht] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [qlht] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [qlht] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [qlht] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [qlht] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [qlht] SET  DISABLE_BROKER 
GO
ALTER DATABASE [qlht] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [qlht] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [qlht] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [qlht] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [qlht] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [qlht] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [qlht] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [qlht] SET RECOVERY FULL 
GO
ALTER DATABASE [qlht] SET  MULTI_USER 
GO
ALTER DATABASE [qlht] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [qlht] SET DB_CHAINING OFF 
GO
ALTER DATABASE [qlht] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [qlht] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [qlht] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'qlht', N'ON'
GO
ALTER DATABASE [qlht] SET QUERY_STORE = OFF
GO
USE [qlht]
GO
/****** Object:  UserDefinedFunction [dbo].[autoMaHD]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[autoMaHD]()
returns nvarchar(255)
as
	begin 
	declare @id nvarchar(255),@maNV int
	select @maNV = MaNhanVien from dbo.HoaDon
	if (select COUNT(MaHoaDon) from dbo.HoaDon) = 0
		set @id= '0'
	else 
		select @id = MAX(RIGHT(LEFT(MaHoaDon,7),5)) from dbo.HoaDon
		select @id = CASE
				WHEN @id = 99999 then 'HD00001'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 0 and @id < 9 then 'HD0000'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 9 then 'HD000'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 99 then 'HD00'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 999 then 'HD0'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 9999 then 'HD'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				end
	return @id
	end
GO
/****** Object:  Table [dbo].[CT_HoaDon]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_HoaDon](
	[MaHoaDon] [nvarchar](50) NOT NULL,
	[MaThuoc] [int] NOT NULL,
	[DonGia] [float] NULL,
	[GiamGia] [float] NULL,
	[SoLuong] [int] NULL,
	[DonViTinh] [nvarchar](50) NULL,
 CONSTRAINT [PK_CT_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaChi]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaChi](
	[MaDiaChi] [int] IDENTITY(1,1) NOT NULL,
	[SoNha] [nvarchar](50) NULL,
	[TenDuong] [nvarchar](50) NULL,
	[Phuong] [nvarchar](50) NULL,
	[Quan] [nvarchar](50) NULL,
	[ThanhPho] [nvarchar](50) NULL,
	[QuocGia] [nvarchar](50) NULL,
 CONSTRAINT [PK_DiaChi] PRIMARY KEY CLUSTERED 
(
	[MaDiaChi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [nvarchar](50) NOT NULL,
	[NgayLap] [datetime] NOT NULL,
	[MaNhanVien] [int] NOT NULL,
	[MaKhachHang] [int] NULL,
	[TongTien] [float] NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[Ho] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nchar](10) NULL,
	[CMND] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[MaDiaChi] [int] NOT NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNhaCungCap] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[Gmail] [nvarchar](50) NULL,
	[MaDiaChi] [int] NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[MaNhaCungCap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[CaLamViec] [nvarchar](50) NULL,
	[Ten] [nvarchar](50) NULL,
	[Ho] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nchar](10) NULL,
	[CMND] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[MaDiaChi] [int] NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[LoaiNhanVien] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_NhanVien] UNIQUE NONCLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thuoc]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thuoc](
	[MaThuoc] [int] IDENTITY(1,1) NOT NULL,
	[SoDangKi] [nvarchar](50) NOT NULL,
	[TenThuoc] [nvarchar](50) NULL,
	[PhanLoai] [nvarchar](50) NULL,
	[NhomThuoc] [nvarchar](50) NULL,
	[HoatChat] [nvarchar](100) NULL,
	[HamLuong] [nvarchar](50) NULL,
	[DangBaoChe] [nvarchar](50) NULL,
	[QuyCachDongGoi] [nvarchar](50) NULL,
	[TieuChuan] [nvarchar](50) NULL,
	[MaNhaCungCap] [int] NOT NULL,
	[NgaySanXuat] [date] NULL,
	[HanSuDung] [date] NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[GiaNhap] [float] NULL,
	[DonGia] [float] NULL,
	[SoLuongNhap] [int] NULL,
	[HinhAnh] [image] NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_Thuoc] PRIMARY KEY CLUSTERED 
(
	[MaThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [MaHoaDon_default]  DEFAULT ([dbo].[autoMaHD]()) FOR [MaHoaDon]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_NgayLap]  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_CT_HoaDon_HoaDon] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaHoaDon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CT_HoaDon] CHECK CONSTRAINT [FK_CT_HoaDon_HoaDon]
GO
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_CT_HoaDon_Thuoc] FOREIGN KEY([MaThuoc])
REFERENCES [dbo].[Thuoc] ([MaThuoc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CT_HoaDon] CHECK CONSTRAINT [FK_CT_HoaDon_Thuoc]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_KhachHang] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_KhachHang]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([MaNhanVien])
REFERENCES [dbo].[NhanVien] ([MaNhanVien])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_DiaChi] FOREIGN KEY([MaDiaChi])
REFERENCES [dbo].[DiaChi] ([MaDiaChi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_KhachHang_DiaChi]
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD  CONSTRAINT [FK_NhaCungCap_DiaChi] FOREIGN KEY([MaDiaChi])
REFERENCES [dbo].[DiaChi] ([MaDiaChi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NhaCungCap] CHECK CONSTRAINT [FK_NhaCungCap_DiaChi]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_DiaChi] FOREIGN KEY([MaDiaChi])
REFERENCES [dbo].[DiaChi] ([MaDiaChi])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_DiaChi]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_TaiKhoan] FOREIGN KEY([TenTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([TenTaiKhoan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_TaiKhoan]
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD  CONSTRAINT [FK_Thuoc_NhaCungCap] FOREIGN KEY([MaNhaCungCap])
REFERENCES [dbo].[NhaCungCap] ([MaNhaCungCap])
GO
ALTER TABLE [dbo].[Thuoc] CHECK CONSTRAINT [FK_Thuoc_NhaCungCap]
GO
/****** Object:  StoredProcedure [dbo].[LocNgayTHongKeTinhTrang]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[LocNgayTHongKeTinhTrang]    
AS
BEGIN
	select  NgayLap --CONVERT (nvarchar(10), ngayban, 103)
	from HoaDon 
	order by  NgayLap desc-- CONVERT (nvarchar(10), ngayban, 103) desc
 END
GO
/****** Object:  StoredProcedure [dbo].[LocTenNhanVien]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[LocTenNhanVien] 
@ma nvarchar(50)
AS
	BEGIN
		select distinct MaNhanVien,TenNhanVien=nv.Ho+''+nv.Ten
		from NhanVien nv
		where @ma =MaNhanVien
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeBaoCao]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeBaoCao] 
@ngay nvarchar(50)
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.DonGia,t.GiaNhap,SUM(t.SoLuongNhap) AS SoLuongNhap,sum(ct.SoLuong) as SoLuongBan,sum(ct.SoLuong*t.DonGia) as TienBan ,CONVERT (nvarchar(10), t.HanSuDung, 103) as HanSuDung,t.[SoDangKi]
		from CT_HoaDon ct join Thuoc t on ct.maThuoc= t.maThuoc join HoaDon h on  ct.MaHoaDon=h.MaHoaDon
		where h.NgayLap=@ngay
		group by  t.MaThuoc,t.TenThuoc,t.DonGia,t.GiaNhap,CONVERT (nvarchar(10), t.HanSuDung, 103),t.[SoDangKi]
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeNhanVien]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeNhanVien] 
 @ngay nvarchar(50)
 AS
	BEGIN
		select t.[MaThuoc],t.[TenThuoc],sum(ct.[SoLuong]) as SoLuong,t.DonGia,nv.[MaNhanVien],TenNhanVien=nv.Ho+''+nv.Ten,nv.[CaLamViec],h.[NgayLap],sum(ct.[SoLuong]*t.[DonGia])
		from [dbo].[CT_HoaDon] ct left join [dbo].[Thuoc] t on ct.[MaThuoc]= t.[MaThuoc] left join [dbo].[HoaDon] h on h.[MaHoaDon]= ct.[MaHoaDon] left join [dbo].[NhanVien] nv on h.[MaNhanVien] = nv.[MaNhanVien]
		where h.[NgayLap] = @ngay 
		group by t.MaThuoc,t.TenThuoc,ct.[SoLuong],t.[DonGia],t.PhanLoai,nv.[MaNhanVien],nv.Ho+''+nv.Ten,nv.[CaLamViec],h.[NgayLap]
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeNhanVien_CoDon]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[ThongKeNhanVien_CoDon] 
 @ngay nvarchar(50)
 AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,sum(ct.SoLuong) as SoLuong,t.DonGia,nv.MaNhanVien,TenNhanVien=nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap,sum(ct.SoLuong*t.DonGia)
		from CT_HoaDon ct left join Thuoc t on ct.MaThuoc = t.MaThuoc left join HoaDon h on h.MaHoaDon = ct.MaHoaDon left join NhanVien nv on h.MaNhanVien = nv.MaNhanVien
		where h.NgayLap = @ngay and  h.maKhachHang is not null
		group by  t.MaThuoc,t.TenThuoc,ct.SoLuong,t.DonGia,nv.MaNhanVien,nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeNhanVien_KhongCoDon]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeNhanVien_KhongCoDon] 
@ngay nvarchar(50)
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,sum(ct.SoLuong) as SoLuong,t.DonGia,nv.MaNhanVien,TenNhanVien=nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap,sum(ct.SoLuong*t.DonGia)
		from CT_HoaDon ct left join Thuoc t on ct.MaThuoc = t.MaThuoc left join HoaDon h on h.MaHoaDon = ct.MaHoaDon left join NhanVien nv on h.MaNhanVien = nv.MaNhanVien
		where h.NgayLap = @ngay and  h.MaKhachHang is null
		group by  t.MaThuoc,t.TenThuoc,ct.SoLuong,t.DonGia,nv.MaNhanVien,nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeThuocConLai]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[ThongKeThuocConLai] 
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103) as NgaySanXuat,CONVERT (nvarchar(10), t.HanSuDung, 103) as HanSuDung
		from  Thuoc t
		where t.SoLuongNhap>0 
		group by t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103),CONVERT (nvarchar(10), t.HanSuDung, 103)
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeThuocDaBan]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeThuocDaBan] 
@ngay nvarchar(30)
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.PhanLoai,SUM(ct.SoLuong) as SoLuong,CONVERT (nvarchar(10), t.NgaySanXuat, 103) as NgaySanXuat,CONVERT (nvarchar(10) , t.HanSuDung, 103) as HanSuDung,h.NgayLap
		from CT_HoaDon ct left join Thuoc t on t.MaThuoc = ct.MaThuoc  join HoaDon h on h.MaHoaDon=ct.MaHoaDon
		where ct.MaHoaDon is not null and h.NgayLap=@ngay
		group by t.MaThuoc,t.TenThuoc,t.PhanLoai,SoLuong,CONVERT (nvarchar(10), t.NgaySanXuat, 103),CONVERT (nvarchar(10) , t.HanSuDung, 103),h.NgayLap
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeThuocHetHan]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeThuocHetHan] 
@ngay nvarchar(50)
 AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103)as NgaySanXuat,CONVERT (nvarchar(10), t.HanSuDung, 103)as HanSuDung
		from  Thuoc t
		where YEAR(t.HanSuDung)<=YEAR(@ngay) and MONTH(t.HanSuDung)<=MONTH(@ngay) 
		group by t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103),CONVERT (nvarchar(10), t.HanSuDung, 103)
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTinhTrang_TongLoaiThuocBan]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[ThongKeTinhTrang_TongLoaiThuocBan] 
@ngay nvarchar(50)
AS
	BEGIN
		select COUNT(distinct ct.MaThuoc) as TongThuocDaBan
		from CT_HoaDon ct join HoaDon h on ct.MaHoaDon=h.MaHoaDon
		where h.NgayLap=@ngay
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTinhTrang_TongLoaiThuocConLai]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[ThongKeTinhTrang_TongLoaiThuocConLai] 
 AS
	BEGIN
		select COUNT(distinct MaThuoc) as TongThuocConLai
		from Thuoc
		where SoLuongNhap>0
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTinhTrang_TongLoaiThuocHetHan]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[ThongKeTinhTrang_TongLoaiThuocHetHan] 
 @ngay nvarchar(50)
 AS
	BEGIN
		select COUNT(distinct MaThuoc) as TongThuocHetHan
		from Thuoc
		where YEAR(HanSuDung)<=YEAR(@ngay) and MONTH(HanSuDung)<=MONTH(@ngay)  and DAY(HanSuDung)<  DAY(@ngay)
	END
GO
/****** Object:  StoredProcedure [dbo].[TongTienSLNhap]    Script Date: 10/29/2021 2:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TongTienSLNhap]
AS
BEGIN
   select SUM(t.[GiaNhap]*t.[SoLuongNhap])as TongTienSoLuongNhap from Thuoc t
 END
GO
USE [master]
GO
ALTER DATABASE [qlht] SET  READ_WRITE 
GO
