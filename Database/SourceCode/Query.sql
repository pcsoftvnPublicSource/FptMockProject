-- Unit ------------------------------------------------------------------------------
CREATE TABLE Unit (
	unit Nvarchar(20) PRIMARY KEY
)

INSERT INTO Unit VALUES (N'chai'),(N'hũ'),(N'kg'),(N'hộp'),(N'lít'),(N'quả'),(N'bao')

-- FoodType --------------------------------------------------------------------------
CREATE TABLE FoodType (
	foodTypeId Integer IDENTITY(1,1) PRIMARY KEY,
	foodTypeName Nvarchar(255) 
)

DELETE FROM FoodType
DBCC CHECKIDENT (FoodType, RESEED, 0)

EXEC SP_FoodType_INSERT N'Cà phê'
EXEC SP_FoodType_INSERT N'Kem'
EXEC SP_FoodType_INSERT N'Nước giải khát'

-- Shop ------------------------------------------------------------------------------
CREATE TABLE Shop (
	shopId Varchar(50) PRIMARY KEY,
	shopName Nvarchar(255),
	shopAddress Nvarchar(255),
	shopPassword Varchar(50),
	shopPhoneNumber Varchar(20),
	managerName Nvarchar(255),
	managerAddress Nvarchar(255),
	managerPhoneNumber Varchar(20)
)
DELETE FROM Shop
EXEC SP_Shop_INSERT 'nv01',N'Lounge Coffee Sơn Trà',N'174 Ngô Quyền, Q. Sơn Trà, Tp. Đà Nẵng','123','0511 3550502',N'Lương Đình Nguyên',N'627 Ngô Quyền, Q. Sơn Trà, Tp. Đà Nẵng','0123456789'
EXEC SP_Shop_INSERT 'nv02',N'Lounge Coffee Hải Châu',N'1041 Nguyễn Chí Thanh, Q. Hải Châu, Tp. Đà Nẵng','123','0511 3550503',N'Nguyễn Thành Nhân',N'97 Bùi Thị Xuân, Q. Hải Châu, Tp. Đà Nẵng','0148556789'
EXEC SP_Shop_INSERT 'nv03',N'Lounge Coffee Thanh Khê',N'797 Xuân Thủy, Q. Thanh Khê, Tp. Đà Nẵng','123','0511 3550504',N'Lê Thu Na',N'627 Nguyễn Chí Thanh, Q. Thanh Khê, Tp. Đà Nẵng','0123412889'

-- Food ------------------------------------------------------------------------------
CREATE TABLE Food (
	foodId Integer IDENTITY(1,1) PRIMARY KEY,
	foodName Nvarchar(255),
	foodTypeId Integer,
	foodPrice Money CHECK(FoodPrice > 0),
	CONSTRAINT FK_Food_FoodType FOREIGN KEY (foodTypeId) REFERENCES FoodType(foodTypeId) ON UPDATE CASCADE ON DELETE CASCADE
)

DELETE FROM Food
DBCC CHECKIDENT (Food, RESEED, 0)

EXEC SP_Food_INSERT N'Cà phê đen',1,21000
EXEC SP_Food_INSERT N'Cà phê sữa',1,23000
EXEC SP_Food_INSERT N'Cà phê đen siêu sạch',1,27000
EXEC SP_Food_INSERT N'Cà phê sữa siêu sạch',1,29000
EXEC SP_Food_INSERT N'Cà phê rượu kem Bailey',1,35000
EXEC SP_Food_INSERT N'Kem dâu tây',2,25000
EXEC SP_Food_INSERT N'Kem dừa',2,25000
EXEC SP_Food_INSERT N'Kem vani',2,25000
EXEC SP_Food_INSERT N'Kem chocolate',2,22000
EXEC SP_Food_INSERT N'Kem trái dừa',2,45000
EXEC SP_Food_INSERT N'CocaCola',3,18000
EXEC SP_Food_INSERT N'Pepsi',3,19000
EXEC SP_Food_INSERT N'Number 1',3,18000

-- Orders ----------------------------------------------------------------------------
CREATE TABLE Orders (
	ordersNo Decimal IDENTITY(1,1) PRIMARY KEY,
	ordersDate Datetime,
	shopId Varchar(50),
	ordersAmount Money DEFAULT(0),
	CONSTRAINT FK_Orders_Shop FOREIGN KEY (shopId) REFERENCES Shop(shopId) ON UPDATE CASCADE ON DELETE CASCADE
)

DELETE FROM Orders
DBCC CHECKIDENT (Orders, RESEED, 0)

INSERT INTO Orders(ordersDate, shopId) VALUES
('2015-08-15','nv01'),('2015-08-16','nv01'),('2015-08-17','nv01'),
('2015-08-18','nv01'),('2015-08-19','nv01'),('2015-08-15','nv02'),
('2015-08-16','nv02'),('2015-08-17','nv02'),('2015-08-18','nv02'),
('2015-08-19','nv02'),('2015-08-15','nv03'),('2015-08-16','nv03'),

-- OrdersDetail ----------------------------------------------------------------------
CREATE TABLE OrdersDetail (
	ordersNo Decimal,
	foodId Integer,
	ordersQuantity Integer CHECK(ordersQuantity > 0),
	CONSTRAINT PK_OrdersDetail PRIMARY KEY (ordersNo, foodId),
	CONSTRAINT FK_OrdersDetail_Orders FOREIGN KEY (ordersNo) REFERENCES Orders(ordersNo) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_OrdersDetail_Food FOREIGN KEY (foodId) REFERENCES Food(foodId) ON UPDATE CASCADE ON DELETE CASCADE
)

INSERT INTO OrdersDetail VALUES 
(1,1,1),(1,2,1),(1,10,2),(2,4,2),(2,6,1),(2,12,1),(3,3,2),(3,6,1),(3,9,1),(4,10,2),(4,11,1),
(4,12,1),(5,7,2),(5,9,1),(5,8,1),(6,2,2),(6,13,1),(6,12,1),(7,7,2),(7,6,1),(7,4,1),(8,5,2),
(8,8,1),(8,6,1),(9,4,2),(9,6,1),(9,12,1),(10,4,2),(10,6,1),(10,12,1),(11,4,2),(11,6,1),(11,12,1),(12,4,2),(12,6,1),(13,12,1),(14,4,2),(14,6,1),(15,12,1)

-- Ingredient ------------------------------------------------------------------------
CREATE TABLE Ingredient (
	ingId Integer IDENTITY(1,1) PRIMARY KEY,
	ingName Nvarchar(255),
	ingUnit Nvarchar(50),
	CONSTRAINT U_ingName UNIQUE (ingName)
)

DELETE FROM Ingredient
DBCC CHECKIDENT (Ingredient, RESEED, 0)

EXEC SP_Ingredient_INSERT N'Cà phê bột',N'kg'
EXEC SP_Ingredient_INSERT N'Sữa đặc có đường',N'lon'
EXEC SP_Ingredient_INSERT N'Đường cát trắng',N'kg'
EXEC SP_Ingredient_INSERT N'Kem tươi Whipping',N'hộp'
EXEC SP_Ingredient_INSERT N'Rượu Bailey',N'chai'
EXEC SP_Ingredient_INSERT N'Kem dâu tây',N'kg'
EXEC SP_Ingredient_INSERT N'Kem dừa',N'kg'
EXEC SP_Ingredient_INSERT N'Kem vani',N'kg'
EXEC SP_Ingredient_INSERT N'Kem chocolate',N'kg'
EXEC SP_Ingredient_INSERT N'Kem trái dừa',N'kg'
EXEC SP_Ingredient_INSERT N'CocaCola',N'chai'
EXEC SP_Ingredient_INSERT N'Pepsi',N'chai'
EXEC SP_Ingredient_INSERT N'Number 1',N'lon'
EXEC SP_Ingredient_INSERT N'Trà xanh 0 độ',N'chai'

-- ShopIngredient ------------------------------------------------------------------------------
CREATE TABLE ShopIngredient (
	shopId Varchar(50),
	ingId Integer,
	ingQuantity Money DEFAULT(0),
	ingPrice Money DEFAULT(0),
	CONSTRAINT PK_ShopIngredient PRIMARY KEY (shopId, ingId),
	CONSTRAINT FK_ShopIngredient_Shop FOREIGN KEY (shopId) REFERENCES Shop(shopId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_ShopIngredient_Ingredient FOREIGN KEY (ingId) REFERENCES Ingredient(ingId) ON UPDATE CASCADE ON DELETE CASCADE
)

-- ImportReceipt -------------------------------------------------------------------------------
CREATE TABLE ImportReceipt (
	impNo Decimal IDENTITY(1,1) PRIMARY KEY,
	impDate Date,
	shopId Varchar(50),
	CONSTRAINT FK_ImportReceipt_Shop FOREIGN KEY (shopId) REFERENCES Shop(shopId) ON UPDATE CASCADE ON DELETE CASCADE,
)

DELETE FROM ImportReceipt
DBCC CHECKIDENT (ImportReceipt, RESEED, 0)

INSERT INTO ImportReceipt(impDate, shopId) VALUES 
('2015-08-15','nv01'),('2015-08-17','nv01'),('2015-08-19','nv01'),
('2015-08-15','nv02'),('2015-08-17','nv02'),('2015-08-19','nv02')

-- ImportReceiptDetail -------------------------------------------------------------------------
CREATE TABLE ImportReceiptDetail (
	impNo Decimal,
	ingId Integer,
	impQuantity Money CHECK(impQuantity >= 0),
	impPrice Money CHECK(impPrice >= 0),
	CONSTRAINT PK_ImportReceiptDetail PRIMARY KEY (impNo, ingId),
	CONSTRAINT FK_ImportReceiptDetail_ImportReceipt FOREIGN KEY (impNo) REFERENCES ImportReceipt(impNo) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_ImportReceiptDetail_Ingredient FOREIGN KEY (ingId) REFERENCES Ingredient(ingId) ON UPDATE CASCADE ON DELETE CASCADE,	
)

-- ConsumeReceipt ------------------------------------------------------------------------------
CREATE TABLE ConsumeReceipt (
	conNo Decimal IDENTITY(1,1) PRIMARY KEY,
	conDate Date,
	shopId Varchar(50),
	conAmount Money DEFAULT(0),
	CONSTRAINT FK_ConsumeReceipt_Shop FOREIGN KEY (shopId) REFERENCES Shop(shopId) ON UPDATE CASCADE ON DELETE CASCADE
)

DELETE FROM ConsumeReceipt
DBCC CHECKIDENT (ConsumeReceipt, RESEED, 0)

INSERT INTO ConsumeReceipt(conDate, shopId) VALUES 
('2015-08-15','nv01'),('2015-08-16','nv01'),('2015-08-17','nv01'),
('2015-08-18','nv01'),('2015-08-19','nv01'),
('2015-08-15','nv02'),('2015-08-16','nv02'),('2015-08-17','nv02'),
('2015-08-18','nv02'),('2015-08-19','nv02')

-- ConsumeReceiptDetail ------------------------------------------------------------------------
CREATE TABLE ConsumeReceiptDetail (
	conNo Decimal,
	ingId Integer,
	conQuantity Money CHECK(conQuantity >= 0),
	CONSTRAINT PK_ConsumeReceiptDetail PRIMARY KEY (conNo, ingId),
	CONSTRAINT FK_ConsumeReceiptDetail_ConsumeReceipt FOREIGN KEY (conNo) REFERENCES ConsumeReceipt(conNo) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_ConsumeReceiptDetail_Ingredient FOREIGN KEY (ingId) REFERENCES Ingredient(ingId) ON UPDATE CASCADE ON DELETE CASCADE,	
)

-- ---------------------------------------------------------------------------------------------

