USE [master]
GO
/****** Object:  Database [MCAlbany]    Script Date: 9/22/2016 2:46:34 PM ******/
CREATE DATABASE [MCAlbany]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MCAlbany', FILENAME = N'E:\MSSQL\DATA\MCAlbany.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MCAlbany_log', FILENAME = N'E:\MSSQL\DATA\MCAlbany_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MCAlbany] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MCAlbany].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MCAlbany] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MCAlbany] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MCAlbany] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MCAlbany] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MCAlbany] SET ARITHABORT OFF 
GO
ALTER DATABASE [MCAlbany] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MCAlbany] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MCAlbany] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MCAlbany] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MCAlbany] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MCAlbany] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MCAlbany] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MCAlbany] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MCAlbany] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MCAlbany] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MCAlbany] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MCAlbany] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MCAlbany] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MCAlbany] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MCAlbany] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MCAlbany] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MCAlbany] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MCAlbany] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MCAlbany] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MCAlbany] SET  MULTI_USER 
GO
ALTER DATABASE [MCAlbany] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MCAlbany] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MCAlbany] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MCAlbany] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [MCAlbany]
GO
/****** Object:  User [wwAdmin]    Script Date: 9/22/2016 2:46:34 PM ******/
CREATE USER [wwAdmin] FOR LOGIN [wwAdmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [wwAdmin]
GO
/****** Object:  StoredProcedure [dbo].[BrandUpdate]    Script Date: 9/22/2016 2:46:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Brandon Ray, ICC Inc.
-- Create date: 09/08/2016
-- Description:	Used in the Promix web form to add, edit, and delete 
-- brands from the FMBRecipes database
-- =============================================
CREATE PROCEDURE [dbo].[BrandUpdate]
	@Action varchar(8),
	@OverRide bit,
	@D3Code real,
	@NewD3Code real = null,
	@D3PartBrand varchar(4),
	@BeerCode integer,
	@NewBrandName varchar(50) = null,
	@BrandAbbr varchar(2),
	@ErrorMsg varchar(80) OUTPUT

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE
		@ReturnVal int,
		@Count int

	SET @ReturnVal = 0
	SET @ErrorMsg = ''

	-- Handle brand add
	IF @Action = 'ADDBRAND'
	BEGIN --BRANDADD

		IF @NewD3Code = '' OR @NewBrandName = ''
			BEGIN
				SET @ErrorMsg = 'Please provide a D3Code and a Brand Name'
				GOTO LocalExit
			END

		SELECT @Count = COUNT(D3Code) FROM Brands WHERE D3Code = @NewD3Code

		If @Count > 0
			BEGIN
			SET @ErrorMsg = 'ERROR: D3Code already exists for this table.'
			GOTO LocalExit
			END

		INSERT INTO Brands (D3Code, D3PartBrand, BeerCode, BrandName, BrandAbbr) VALUES (@NewD3Code, @D3PartBrand, @BeerCode, @NewBrandName, @BrandAbbr)
		SET @ReturnVal = 1
		GOTO LocalExit
	END --BRANDADD

	-- Handle brand delete
	IF @Action = 'DELBRAND'
	BEGIN --DELETEBRAND
		IF @D3Code = ''
			BEGIN
				SET @ErrorMsg = 'A D3Code is required to delete a brand'
				GOTO LocalExit
			END

		IF @OverRide = 1
			BEGIN
				DELETE FROM Recipes WHERE D3Code = @D3Code
				DELETE FROM Brands WHERE D3Code = @D3Code
				SET @ReturnVal = 1
				GOTO LocalExit
			END
		ELSE
			BEGIN
				SET @ErrorMsg = 'CONFIRM: Are you sure you want to delete this brand?.'
				SET @ReturnVal = 99
				GOTO LocalExit
			END
	GOTO LocalExit
	END --DELETEBRAND

	-- Handle brand edit
	IF @Action = 'EDTBRAND'
	BEGIN --EDITBRAND
		

		SELECT @Count = COUNT(D3Code) FROM Brands WHERE D3Code = @NewD3Code

		If @Count > 0
			BEGIN
			SET @ErrorMsg = 'ERROR: D3Code already exists for this table.'
			GOTO LocalExit
			END
		IF @Override = 1
			BEGIN
				UPDATE Brands SET D3Code = ISNULL(@NewD3Code, D3Code), D3PartBrand = @D3PartBrand, BeerCode = @BeerCode, BrandName = ISNULL(@NewBrandName, BrandName), BrandAbbr = @BrandAbbr WHERE D3Code = @D3Code
				UPDATE Recipes SET D3Code = ISNULL(@NewD3Code, D3Code) WHERE D3Code = @D3Code
				SET @ReturnVal = 1
			GOTO LocalExit 
			END
		ELSE
			BEGIN
			SET @ErrorMsg = 'CONFIRM, Are you sure you want to modify this brand?'
			SET @ReturnVal = 99
			GOTO LocalExit
			END

		SET @ReturnVal = 1
		GOTO LocalExit
	END --EDITBRAND
	
LocalExit:

	RETURN @ReturnVal
END


GO
/****** Object:  Table [dbo].[Brands]    Script Date: 9/22/2016 2:46:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Brands](
	[D3Code] [real] NOT NULL,
	[D3PartBrand] [varchar](4) NULL,
	[BeerCode] [int] NULL,
	[BrandName] [varchar](50) NULL,
	[BrandAbbr] [varchar](2) NULL,
 CONSTRAINT [PK_Brands] PRIMARY KEY CLUSTERED 
(
	[D3Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Recipes]    Script Date: 9/22/2016 2:46:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipes](
	[D3Code] [real] NOT NULL,
	[Version] [int] NOT NULL,
	[Prod_bbls] [real] NULL,
	[Prod_SGU] [real] NULL,
	[Prod_alc] [real] NULL,
	[Prod_re] [real] NULL,
	[Prod_CO2] [real] NULL,
	[Paar_alc_ofst] [real] NULL,
	[Paar_re_ofst] [real] NULL,
	[Base_bbls] [real] NULL,
	[Base_SGU] [real] NULL,
	[Base_alc] [real] NULL,
	[Base_re] [real] NULL,
	[Syrup_bbls] [real] NULL,
	[Syrup_lbs] [real] NULL,
	[Diluent_bbls] [real] NULL,
	[DFC_bbls] [real] NULL,
	[DFC_sgu] [real] NULL,
	[DFC_alc] [real] NULL,
	[DFC_re] [real] NULL,
	[DFC_co2] [real] NULL,
	[Buf_tk_psi] [real] NULL,
	[Chill_temp] [real] NULL,
	[OB_Prod_bbls] [real] NULL,
	[OB_Prod_sgu] [real] NULL,
	[OB_Prod_alc] [real] NULL,
	[OB_Prod_re] [real] NULL,
	[OB_FLC_bbls] [real] NULL,
	[OB_FLC_sgu] [real] NULL,
	[OB_FLC_alc] [real] NULL,
	[OB_FLC_re] [real] NULL,
	[OB_Diluent_bbls] [real] NULL,
	[OB_Buf_tk_psi] [real] NULL,
	[OB_Paar_alc_ofst] [real] NULL,
	[OB_Paar_re_ofst] [real] NULL,
	[St1_prv] [bit] NULL,
	[St2_prv] [bit] NULL,
	[St3_prv] [bit] NULL,
	[St4_prv] [bit] NULL,
	[St5_prv] [bit] NULL,
	[St6_prv] [bit] NULL,
	[St7_prv] [bit] NULL,
	[Tank_Brand] [real] NULL,
	[Prod_Type] [bit] NULL,
	[Prod_700] [bit] NULL,
	[Prod_Formula] [real] NULL,
	[Prod_alc_abv] [real] NULL,
	[Prod_Lqd_Flvrs] [real] NULL,
 CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED 
(
	[D3Code] ASC,
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[BrandRecipes]    Script Date: 9/22/2016 2:46:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BrandRecipes]
AS
SELECT     dbo.Brands.D3Code, dbo.Recipes.Version, dbo.Brands.D3PartBrand, dbo.Brands.BeerCode, dbo.Brands.BrandName, dbo.Brands.BrandAbbr, dbo.Recipes.Prod_bbls, 
                      dbo.Recipes.Prod_SGU, dbo.Recipes.Prod_alc, dbo.Recipes.Prod_re, dbo.Recipes.Prod_CO2, dbo.Recipes.Paar_alc_ofst, dbo.Recipes.Paar_re_ofst, 
                      dbo.Recipes.Base_bbls, dbo.Recipes.Base_SGU, dbo.Recipes.Base_alc, dbo.Recipes.Base_re, dbo.Recipes.Syrup_bbls, dbo.Recipes.Syrup_lbs, 
                      dbo.Recipes.Diluent_bbls, dbo.Recipes.DFC_bbls, dbo.Recipes.DFC_sgu, dbo.Recipes.DFC_alc, dbo.Recipes.DFC_re, dbo.Recipes.DFC_co2, dbo.Recipes.Buf_tk_psi, 
                      dbo.Recipes.Chill_temp, dbo.Recipes.OB_Prod_bbls, dbo.Recipes.OB_Prod_sgu, dbo.Recipes.OB_Prod_alc, dbo.Recipes.OB_Prod_re, dbo.Recipes.OB_FLC_bbls, 
                      dbo.Recipes.OB_FLC_sgu, dbo.Recipes.OB_FLC_alc, dbo.Recipes.OB_FLC_re, dbo.Recipes.OB_Diluent_bbls, dbo.Recipes.OB_Buf_tk_psi, 
                      dbo.Recipes.OB_Paar_alc_ofst, dbo.Recipes.OB_Paar_re_ofst, dbo.Recipes.St1_prv, dbo.Recipes.St2_prv, dbo.Recipes.St3_prv, dbo.Recipes.St4_prv, 
                      dbo.Recipes.St5_prv, dbo.Recipes.St6_prv, dbo.Recipes.St7_prv, dbo.Recipes.Tank_Brand, dbo.Recipes.Prod_Type, dbo.Recipes.Prod_700, 
                      dbo.Recipes.Prod_Formula, dbo.Recipes.Prod_alc_abv, dbo.Recipes.Prod_Lqd_Flvrs
FROM         dbo.Brands INNER JOIN
                      dbo.Recipes ON dbo.Brands.D3Code = dbo.Recipes.D3Code

GO
ALTER TABLE [dbo].[Brands]  WITH CHECK ADD  CONSTRAINT [FK_Brands_Brands] FOREIGN KEY([D3Code])
REFERENCES [dbo].[Brands] ([D3Code])
GO
ALTER TABLE [dbo].[Brands] CHECK CONSTRAINT [FK_Brands_Brands]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[18] 2[3] 3) )"
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
         Begin Table = "Brands"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Recipes"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 393
            End
            DisplayFlags = 280
            TopColumn = 42
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 52
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BrandRecipes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BrandRecipes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'BrandRecipes'
GO
USE [master]
GO
ALTER DATABASE [MCAlbany] SET  READ_WRITE 
GO
