USE [master]
GO
/****** Object:  Database [QLSanPham]    Script Date: 01/01/2023 11:50:10 CH ******/
CREATE DATABASE [QLSanPham]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLSanPham', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\QLSanPham.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLSanPham_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\QLSanPham_log.ldf' , SIZE = 3520KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLSanPham] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLSanPham].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLSanPham] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLSanPham] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLSanPham] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLSanPham] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLSanPham] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLSanPham] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLSanPham] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLSanPham] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLSanPham] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLSanPham] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLSanPham] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLSanPham] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLSanPham] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLSanPham] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLSanPham] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLSanPham] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLSanPham] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLSanPham] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLSanPham] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLSanPham] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLSanPham] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLSanPham] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLSanPham] SET RECOVERY FULL 
GO
ALTER DATABASE [QLSanPham] SET  MULTI_USER 
GO
ALTER DATABASE [QLSanPham] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLSanPham] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLSanPham] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLSanPham] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLSanPham] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLSanPham', N'ON'
GO
ALTER DATABASE [QLSanPham] SET QUERY_STORE = OFF
GO
USE [QLSanPham]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [QLSanPham]
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[MaLoaiSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](60) NOT NULL,
	[MoTa] [nvarchar](255) NULL,
 CONSTRAINT [FK_LoaiSanPham] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[IDSanPham] [int] IDENTITY(1,1) NOT NULL,
	[MaSP] [varchar](10) NOT NULL,
	[TenSP] [nvarchar](60) NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonViTinh] [nvarchar](15) NULL,
	[GiaNhap] [money] NOT NULL,
	[GiaBan] [money] NOT NULL,
	[MaLoaiSP] [int] NOT NULL,
	[MoTa] [nvarchar](255) NULL,
 CONSTRAINT [FK_SanPham] PRIMARY KEY CLUSTERED 
(
	[IDSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[xemThongTin]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[xemThongTin]
as
select MaSP,TenSP,GiaBan,TenLoai,LoaiSanPham.MoTa
From SanPham,LoaiSanPham
where LoaiSanPham.MaLoaiSP = SanPham.MaLoaiSP
GO
/****** Object:  View [dbo].[View_XemThongTinSanPham]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_XemThongTinSanPham]
AS
SELECT       TOP (100) PERCENT dbo.SanPham.MaSP, dbo.SanPham.TenSP, dbo.SanPham.GiaBan, dbo.LoaiSanPham.TenLoai, dbo.LoaiSanPham.MoTa
FROM            dbo.LoaiSanPham INNER JOIN
                         dbo.SanPham ON dbo.LoaiSanPham.MaLoaiSP = dbo.SanPham.MaLoaiSP
ORDER BY dbo.SanPham.GiaBan
GO
/****** Object:  View [dbo].[View_2]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT       dbo.KhachHang.TenKhachHang, dbo.KhachHang.DiaChi, dbo.LoaiSanPham.TenLoai, dbo.SanPham.TenSP, dbo.ChiTietHoaDon.SoLuong, dbo.SanPham.GiaBan, dbo.HoaDon.NgayTaoHD, 
                         dbo.LoaiSanPham.MoTa,(dbo.SanPham.GiaBan*dbo.ChiTietHoaDon.SoLuong) as N'Tổng Tiền'
FROM            dbo.SanPham INNER JOIN
                         dbo.LoaiSanPham ON dbo.SanPham.MaLoaiSP = dbo.LoaiSanPham.MaLoaiSP INNER JOIN
                         dbo.ChiTietHoaDon ON dbo.SanPham.IDSanPham = dbo.ChiTietHoaDon.IDSanPham INNER JOIN
                         dbo.HoaDon ON dbo.ChiTietHoaDon.MaHD = dbo.HoaDon.MaHD INNER JOIN
                         dbo.KhachHang ON dbo.HoaDon.MaKhachHang = dbo.KhachHang.MaKH
WHERE        (dbo.KhachHang.TenKhachHang LIKE N'%Nguyên')
GO
/****** Object:  Table [dbo].[LuotDangNhap]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LuotDangNhap](
	[MaLuotDangNhap] [int] NOT NULL,
	[SoLuotDangNhap] [int] NOT NULL,
 CONSTRAINT [PK_LuotDangNhap] PRIMARY KEY CLUSTERED 
(
	[MaLuotDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[TenNhanVien] [nvarchar](80) NOT NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SoDienThoai] [varchar](11) NULL,
	[GioiTinh] [bit] NULL,
	[ChucVu] [nvarchar](30) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[NgayVaoLam] [date] NOT NULL,
 CONSTRAINT [FK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quyen]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quyen](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[TenQuyen] [nvarchar](30) NOT NULL,
	[MoTa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Quyen] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/01/2023 11:50:11 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[Password] [varchar](30) NOT NULL,
	[RoleID] [int] NULL,
	[Fullname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON 

INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoai], [MoTa]) VALUES (1, N'Điện thoại', N'Các sản phẩm điện thoại')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoai], [MoTa]) VALUES (2, N'Laptop', N'Các sản phẩm Laptop')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoai], [MoTa]) VALUES (3, N'Linh kiện', N'Các loại linh kiện điện thoại')
INSERT [dbo].[LoaiSanPham] ([MaLoaiSP], [TenLoai], [MoTa]) VALUES (9, N'Điện Lạnh', N'các mặt hàng điện tử ^^ ^^!')
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
GO
INSERT [dbo].[LuotDangNhap] ([MaLuotDangNhap], [SoLuotDangNhap]) VALUES (1, 38)
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [DiaChi], [SoDienThoai], [GioiTinh], [ChucVu], [NgaySinh], [NgayVaoLam]) VALUES (1, N'Nguyễn Duy Đô', N'73 Trường Chinh, Tp.BMT, DakLak', N'0976888222', 1, N'Kỹ thuật viên', CAST(N'1994-11-10' AS Date), CAST(N'2014-11-20' AS Date))
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [DiaChi], [SoDienThoai], [GioiTinh], [ChucVu], [NgaySinh], [NgayVaoLam]) VALUES (2, N'Trần Đình Hoài', N'72 Trường Chinh, Tp.BMT, DakLak', N'978123123', 0, N'Nhân viên IT', CAST(N'1993-10-20' AS Date), CAST(N'2015-11-20' AS Date))
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [DiaChi], [SoDienThoai], [GioiTinh], [ChucVu], [NgaySinh], [NgayVaoLam]) VALUES (3, N'Trần Phương Phi', N'69 Hai Bà Trưng, Tp.Hồ Chí Minh', N'90000398', 1, N'Bảo vệ', CAST(N'1992-11-10' AS Date), CAST(N'2014-11-20' AS Date))
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [DiaChi], [SoDienThoai], [GioiTinh], [ChucVu], [NgaySinh], [NgayVaoLam]) VALUES (12, N'Trần Phương Phi', N'69 Hai Bà Trưng, Tp.Hồ Chí Minh', N'90000398', 0, N'Lao động', CAST(N'1992-11-10' AS Date), CAST(N'2014-11-20' AS Date))
INSERT [dbo].[NhanVien] ([MaNhanVien], [TenNhanVien], [DiaChi], [SoDienThoai], [GioiTinh], [ChucVu], [NgaySinh], [NgayVaoLam]) VALUES (13, N'Trần Phương Phi', N'69 Hai Bà Trưng, Tp.Hồ Chí Minh', N'90000398', 0, N'Lau Chùi Nhà Vệ Sinh', CAST(N'1992-11-10' AS Date), CAST(N'2014-11-20' AS Date))
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[Quyen] ON 

INSERT [dbo].[Quyen] ([RoleID], [TenQuyen], [MoTa]) VALUES (1, N'ADMIN', N'Được Sử Dụng tất cả các bảng')
INSERT [dbo].[Quyen] ([RoleID], [TenQuyen], [MoTa]) VALUES (2, N'IT', N'Được chỉnh sửa bảng người dùng')
INSERT [dbo].[Quyen] ([RoleID], [TenQuyen], [MoTa]) VALUES (3, N'Nhân Viên', N'Được sử dụng bảng Sản Phẩm')
INSERT [dbo].[Quyen] ([RoleID], [TenQuyen], [MoTa]) VALUES (4, N'Quản Trị Viên', N'Quản trị nhân viên và sản phẩm')
SET IDENTITY_INSERT [dbo].[Quyen] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [TenSP], [SoLuong], [DonViTinh], [GiaNhap], [GiaBan], [MaLoaiSP], [MoTa]) VALUES (1, N'DT01', N'Zenfone 2', 10, N'Cái', 7000000.0000, 9000000.0000, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [TenSP], [SoLuong], [DonViTinh], [GiaNhap], [GiaBan], [MaLoaiSP], [MoTa]) VALUES (2, N'DT02', N'Zenfone 9', 200, N'Chiếc', 4000000.0000, 8000000.0000, 9, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [TenSP], [SoLuong], [DonViTinh], [GiaNhap], [GiaBan], [MaLoaiSP], [MoTa]) VALUES (4, N'LT02', N'Dell Inspiron 3537', 10, N'Cái', 11000000.0000, 13000000.0000, 2, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [TenSP], [SoLuong], [DonViTinh], [GiaNhap], [GiaBan], [MaLoaiSP], [MoTa]) VALUES (5, N'LK01', N'Bao da IPhone 7', 29, N'Cái', 10000.0000, 50000.0000, 3, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [TenSP], [SoLuong], [DonViTinh], [GiaNhap], [GiaBan], [MaLoaiSP], [MoTa]) VALUES (6, N'LK02', N'Miếng dán keo', 50, N'Miếng', 20000.0000, 60000.0000, 1, NULL)
INSERT [dbo].[SanPham] ([IDSanPham], [MaSP], [TenSP], [SoLuong], [DonViTinh], [GiaNhap], [GiaBan], [MaLoaiSP], [MoTa]) VALUES (8, N'LT01', N'Acer 511', 9, N'Cái', 17000000.0000, 19000000.0000, 2, NULL)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Username], [Password], [RoleID], [Fullname]) VALUES (1, N'admin', N'admin', 1, N'Nguyễn Chí Tuấn')
INSERT [dbo].[Users] ([ID], [Username], [Password], [RoleID], [Fullname]) VALUES (2, N'tuannc', N'123123', 2, N'Nguyễn Ngọc Tuấn')
INSERT [dbo].[Users] ([ID], [Username], [Password], [RoleID], [Fullname]) VALUES (3, N'danhtp', N'123456', 1, N'Trần Phước Danh')
INSERT [dbo].[Users] ([ID], [Username], [Password], [RoleID], [Fullname]) VALUES (4, N'taolhpk', N'123123', 3, N'Lê Hữu Tạo')
INSERT [dbo].[Users] ([ID], [Username], [Password], [RoleID], [Fullname]) VALUES (5, N'tuan1994', N'123456', 3, N'Nguyễn Tuấn')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[LoaiSanPham] ADD  CONSTRAINT [DF_LoaiSanPham_MoTa]  DEFAULT ('ko co') FOR [MoTa]
GO
ALTER TABLE [dbo].[NhanVien] ADD  DEFAULT ((0)) FOR [GioiTinh]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((0)) FOR [GiaNhap]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ((0)) FOR [GiaBan]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_RoleID]  DEFAULT ((3)) FOR [RoleID]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_LoaiSanPham] FOREIGN KEY([MaLoaiSP])
REFERENCES [dbo].[LoaiSanPham] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_LoaiSanPham]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Quyen] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Quyen] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Quyen]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [CK_SanPham_GiaBan_LonHon_GiaNhap] CHECK  (([GiaBan]>[GiaNhap]))
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [CK_SanPham_GiaBan_LonHon_GiaNhap]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [CK_SanPham_GiaNhapPhaiDuong] CHECK  (([GiaNhap]>=(0)))
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [CK_SanPham_GiaNhapPhaiDuong]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [CK_SanPham_SoLuong_PhaiLonHonHoacBang_0] CHECK  (([SoLuong]>=(0)))
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [CK_SanPham_SoLuong_PhaiLonHonHoacBang_0]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'So luong phai lon hon hoac bang 0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SanPham', @level2type=N'CONSTRAINT',@level2name=N'CK_SanPham_SoLuong_PhaiLonHonHoacBang_0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[15] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -384
         Left = 0
      End
      Begin Tables = 
         Begin Table = "KhachHang"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 221
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LoaiSanPham"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 221
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 6
               Left = 457
               Bottom = 222
               Right = 627
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ChiTietHoaDon"
            Begin Extent = 
               Top = 251
               Left = 661
               Bottom = 436
               Right = 831
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "HoaDon"
            Begin Extent = 
               Top = 253
               Left = 241
               Bottom = 445
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1845
         Width = 1500
         Width = 1500
         Width = 1680
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1455
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LoaiSanPham"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 185
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SanPham"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 223
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_XemThongTinSanPham'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_XemThongTinSanPham'
GO
USE [master]
GO
ALTER DATABASE [QLSanPham] SET  READ_WRITE 
GO
