USE [master]
GO
/****** Object:  Database [ShopBridge]    Script Date: 5/7/2021 9:32:01 AM ******/
CREATE DATABASE [ShopBridge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShopBridge', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ShopBridge.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ShopBridge_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ShopBridge_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ShopBridge] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShopBridge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShopBridge] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShopBridge] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShopBridge] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShopBridge] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShopBridge] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShopBridge] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ShopBridge] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ShopBridge] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShopBridge] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShopBridge] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShopBridge] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShopBridge] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShopBridge] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShopBridge] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShopBridge] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShopBridge] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ShopBridge] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShopBridge] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShopBridge] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShopBridge] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShopBridge] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShopBridge] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShopBridge] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShopBridge] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ShopBridge] SET  MULTI_USER 
GO
ALTER DATABASE [ShopBridge] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShopBridge] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShopBridge] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShopBridge] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ShopBridge]
GO
/****** Object:  StoredProcedure [dbo].[Add_Into_Inventory]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Add_Into_Inventory]
@ProductName varchar(max),
@Suffix varchar(max),
@ManufacturerName varchar(max),
@ModelNumber varchar(max),
@MDate varchar(max),
@Categories varchar(max),
@MName varchar(max),
@Cost varchar(max),
@Quantity int,
@PDescription varchar(max)
AS
BEGIN
INSERT INTO Inventory
VALUES
(
@ProductName,
@Suffix,
@ManufacturerName,
@ModelNumber,
@MDate,
@Categories,
@MName,
@Cost,
@Quantity,
@PDescription
)
END

GO
/****** Object:  StoredProcedure [dbo].[AdminLogin]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AdminLogin]
@UserID varchar(max),
@PWD varchar(max)
AS
BEGIN
SELECT * FROM Admin_SB
WHERE
UserID = @UserID
AND
PWD = @PWD
END
GO
/****** Object:  StoredProcedure [dbo].[BindByProductID]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BindByProductID]
@ProductID int
AS
BEGIN
SELECT * FROM Inventory
WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_From_Inventory]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Delete_From_Inventory]
@ProductID int
As
BEGIN
DELETE FROM Inventory
WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[Update_Into_Inventory]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Into_Inventory]
@ProductID int,
@ProductName varchar(max),
@Suffix varchar(max),
@ManufacturerName varchar(max),
@ModelNumber varchar(max),
@MDate varchar(max),
@Categories varchar(max),
@MName varchar(max),
@Cost varchar(max),
@Quantity int,
@PDescription varchar(max)
AS
BEGIN
UPDATE [dbo].[Inventory]
SET
ProductName = @ProductName,
Suffix = @Suffix,
ManufacturerName = @ManufacturerName,
ModelNumber = @ModelNumber,
ManufacturerDate = @MDate,
PoductCategory = @Categories,
ModelName = @MName,
ProductCost = @Cost,
ProductQuantity = @Quantity,
ProductDescription = @PDescription
WHERE ProductID = @ProductID
END


GO
/****** Object:  Table [dbo].[Admin_SB]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Admin_SB](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](max) NOT NULL,
	[PWD] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/7/2021 9:32:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventory](
	[ProductID] [int] IDENTITY(101,1) NOT NULL,
	[ProductName] [varchar](max) NOT NULL,
	[Suffix] [varchar](max) NULL,
	[ManufacturerName] [varchar](max) NULL,
	[ModelNumber] [varchar](max) NULL,
	[ManufacturerDate] [varchar](max) NULL,
	[PoductCategory] [varchar](max) NULL,
	[ModelName] [varchar](max) NULL,
	[ProductCost] [varchar](max) NULL,
	[ProductQuantity] [int] NULL,
	[ProductDescription] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Admin_SB] ON 

INSERT [dbo].[Admin_SB] ([AdminID], [UserID], [PWD]) VALUES (1, N'Admin', N'Admin')
SET IDENTITY_INSERT [dbo].[Admin_SB] OFF
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([ProductID], [ProductName], [Suffix], [ManufacturerName], [ModelNumber], [ManufacturerDate], [PoductCategory], [ModelName], [ProductCost], [ProductQuantity], [ProductDescription]) VALUES (101, N'Mobile Phone', N'Black', N'Samsung', N'S10+', N'', N'', N'Galaxy', N'78000.00', 10, N'17.04 centimeters (6.7-inch) Super AMOLED Plus display and FHD+ capacitive multi-touch touchscreen with 2400 x 1080 pixels resolution | 16M color support, full rectangle & rounded corners')
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [Suffix], [ManufacturerName], [ModelNumber], [ManufacturerDate], [PoductCategory], [ModelName], [ProductCost], [ProductQuantity], [ProductDescription]) VALUES (102, N'Graphic Card', N'4gb VRM Graphic card', N'Nvidia', N'21855NV657', N'2021-05-06', N'Consumer Electronics', N'Geforce', N'10000.00', 15, N'Memory Bus: 64 bit, Core - base clock: 902 MHz and GT 730 series
NVIDIA GeForce and Model: ZT-71115-20L
4GB memory size
DVI, HDMI and VGA ports')
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [Suffix], [ManufacturerName], [ModelNumber], [ManufacturerDate], [PoductCategory], [ModelName], [ProductCost], [ProductQuantity], [ProductDescription]) VALUES (103, N'Seat Cover', N'Brown Color', N'Dhas Cousion Works', N'MDL456', N'2018-01-16', N'Auto Parts and Accessories', N'Brown Color Seat Cover', N'550.00', 100, N'Fits Royal Enfied Classic Model both 350cc and 500CC soft coushioning confort ')
SET IDENTITY_INSERT [dbo].[Inventory] OFF
USE [master]
GO
ALTER DATABASE [ShopBridge] SET  READ_WRITE 
GO
