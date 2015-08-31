-- Procedure Insert into FoodType ---------------------------------------------------------
CREATE PROC SP_FoodType_INSERT
	@foodTypeName Nvarchar(255)
AS
BEGIN
	INSERT INTO FoodType(foodTypeName) VALUES (@foodTypeName)
END

-- Procedure Delete foodType
CREATE PROC SP_FoodType_DELETE
	@foodTypeId Integer
AS
BEGIN
	DELETE FROM FoodType WHERE foodTypeId = @foodTypeId
END

EXEC SP_FoodType_DELETE 5


-- Procedure Update foodType
CREATE PROC SP_FoodType_UPDATE
	@foodTypeId Integer,
	@foodTypeName Nvarchar(255)
AS
BEGIN
	UPDATE FoodType SET foodTypeName = @foodTypeName WHERE foodTypeId = @foodTypeId
END

EXEC SP_FoodType_UPDATE 5,N'Nước trái cây'

-- Procedure Insert & Update into Food -------------------------------------------------------------
CREATE PROC SP_Food_INSERT
	@foodName Nvarchar(255),
	@foodTypeId Integer,
	@foodPrice Money
AS
BEGIN
	INSERT INTO Food(foodName, foodTypeId, foodPrice) VALUES (@foodName, @foodTypeId, @foodPrice)
END	
-- UPDATE Food
CREATE PROC SP_Food_UPDATE
	@foodId Integer,
	@foodName Nvarchar(255),
	@foodTypeId Integer,
	@foodPrice Money
AS
BEGIN
	UPDATE Food 
		SET foodName = @foodName, foodTypeId = @foodTypeId, foodPrice = @foodPrice
	WHERE foodId = @foodId
END	
-- DELETE Food
CREATE PROC SP_Food_DELETE
	@foodId Integer
AS
BEGIN
	DELETE FROM Food WHERE foodId = @foodId
END	

EXEC SP_Food_DELETE 15

-- Procedure Insert into Orders ------------------------------------------------------------
CREATE PROC SP_Orders_INSERT
	@shopId Varchar(50)
AS
BEGIN
	INSERT INTO Orders(ordersDate, shopId) VALUES (GETDATE(), @shopId)
END	

EXEC SP_Orders_INSERT 'nv01'

-- Procedure Insert into OrdersDetail : sự kiện nút Xác Nhân trong form BÁN HÀNG ---------------
-- Đưa dữ liệu từ CusOrdersDetail vào Cus2OrdersDetail: xử lý trường hợp trùng thức uống
-- Đưa dữ liệu từ bảng Cus2OrdersDetail vào OrdersDetail 
CREATE PROC SP_OrdersDetail_INSERT
	@shopId Varchar(255)
AS
BEGIN
	INSERT INTO Orders(ordersDate, shopId) VALUES (GETDATE(), @shopId)
	
	-- Lấy số Hóa đơn vừa được thêm vào (ordersNo lớn nhất)
	DECLARE @ordersNo Decimal
	SELECT @ordersNo = MAX(ordersNo)
	FROM Orders
	
	-- Đưa dữ liệu từ CusOrdersDetail vào Cus2OrdersDetail
	INSERT INTO Cus2OrdersDetail 
	SELECT foodId, SUM(ordersQuantity) AS ordersQuantity, shopId
	FROM CusOrdersDetail
	WHERE shopId = @shopId
	GROUP BY foodId, shopId
	
	-- Thêm lần lượt từ Cus2OrdersDetail vào bảng OrdersDetail
	DECLARE pointer CURSOR
		FOR SELECT foodId, ordersQuantity FROM Cus2OrdersDetail WHERE shopId = @shopId
	
		OPEN pointer
		DECLARE @foodId Integer
		DECLARE @ordersQuantity Integer

		FETCH NEXT FROM pointer into @foodId, @ordersQuantity
		WHILE @@fetch_status=0 
		BEGIN 
			INSERT INTO OrdersDetail(ordersNo, foodId, ordersQuantity) VALUES (@ordersNo, @foodId, @ordersQuantity)
			FETCH NEXT FROM pointer into @foodId, @ordersQuantity
		END
		CLOSE pointer
	DEALLOCATE pointer
	
	-- Xóa các bản ghi trong bảng tạm có shopId = @shopId
	DELETE FROM CusOrdersDetail WHERE shopId = @shopId
	DELETE FROM Cus2OrdersDetail WHERE shopId = @shopId
END	

EXEC SP_OrdersDetail_INSERT 'nv01'
EXEC SP_OrdersDetail_INSERT 'nv02'

-- Procedure Insert into ImportReceipt ----------------------------------------------------
CREATE PROC SP_ImportReceipt_INSERT
	@impDate Date,
	@shopId Varchar(50)
AS
BEGIN
	INSERT INTO ImportReceipt(impDate, shopId) VALUES (@impDate, @shopId)
END	

EXEC SP_ImportReceipt_INSERT '2015-08-20', 'nv01'

-- Load Receipt (Toàn bộ cửa hàng theo ngày)
CREATE PROC SP_ImportReceipt_LOAD
	@date DATE
AS
BEGIN
	SELECT ir.impNo, ir.impDate, s.shopName
	FROM ImportReceipt ir join Shop s on ir.shopId = s.shopId
	WHERE ir.impDate = @date
END	

DROP PROC SP_ImportReceipt_LOAD
EXEC SP_ImportReceipt_LOAD '2015-8-15'

-- Load Receipt (Từng cửa hàng theo ngày)
CREATE PROC SP_ImportReceipt_LOAD_WithShopId
	@date DATE,
	@shopId Varchar(50)
AS
BEGIN
	SELECT ir.impNo, ir.impDate, s.shopName
	FROM ImportReceipt ir join Shop s on ir.shopId = s.shopId
	WHERE ir.impDate = @date AND ir.shopId = @shopId
END	

DROP PROC SP_ImportReceipt_LOAD_WithShopId
EXEC SP_ImportReceipt_LOAD_WithShopId '2015-8-15','nv01'

-- Load ReceiptDetail
CREATE PROC SP_ImportReceiptDetail_LOAD
	@impNo Decimal
AS
BEGIN
	SELECT i.ingName, i.ingUnit, ird.impQuantity
	FROM ImportReceiptDetail ird join Ingredient i on ird.ingId = i.ingId
	WHERE ird.impNo = @impNo
END	

EXEC SP_ImportReceiptDetail_LOAD 3

/*
-- Procedure Insert into ConsumeReceipt ---------------------------------------------------
CREATE PROC SP_ConsumeReceipt_INSERT
	@conDate Date,
	@shopId Varchar(50)
AS
BEGIN
	INSERT INTO ConsumeReceipt(conDate, shopId) VALUES (@conDate, @shopId)
END	

EXEC SP_ConsumeReceipt_INSERT '2015-08-20', 'nv01'
DROP PROCEDURE SP_ConsumeReceipt_INSERT

-- Procedure Insert into ConsumeReceiptDetail ---------------------------------------------
CREATE PROC SP_ConsumeReceiptDetail_INSERT
	@conNo Decimal,
	@ingId Integer,
	@conQuantity Money
AS
BEGIN
	INSERT INTO ConsumeReceiptDetail(conNo, ingId, conQuantity) VALUES (@conNo, @ingId, @conQuantity)
END	

EXEC SP_ConsumeReceiptDetail_INSERT 1,'1',0.5
DROP PROCEDURE SP_ConsumeReceiptDetail_INSERT
*/
-- Procedure Insert into Shop -------------------------------------------------------------
-- Với mỗi bản ghi mới được thêm vào bảng Shop thì thêm các 
-- bản ghi với cấu trúc (AllShopId, ingId) vào bảng ShopIngredient
CREATE PROC SP_Shop_INSERT
	@shopId Varchar(50),
	@shopName Nvarchar(255),
	@shopAddress Nvarchar(255),
	@shopPassword Varchar(50),
	@shopPhoneNumber Varchar(20),
	@managerName Nvarchar(255),
	@managerAddress Nvarchar(255),
	@managerPhoneNumber Varchar(20)
AS
BEGIN
	-- Thêm vào bảng Shop
	IF NOT EXISTS ( SELECT * FROM Shop WHERE shopId = @shopId)
	BEGIN
		INSERT INTO Shop(shopId, shopName, shopAddress, shopPassword, shopPhoneNumber, managerName, managerAddress, managerPhoneNumber)
			 VALUES (@shopId, @shopName, @shopAddress, @shopPassword, @shopPhoneNumber, @managerName, @managerAddress, @managerPhoneNumber)
	
		-- Thêm vào bảng ShopIngredient toàn bộ nguyên liệu cho cửa hàng mới
		IF EXISTS ( SELECT * FROM Ingredient )
		BEGIN
			DECLARE pointer CURSOR
			FOR SELECT ingId FROM Ingredient
		
			OPEN pointer
			DECLARE @ingId Integer

			FETCH NEXT FROM pointer into @ingId
			WHILE @@fetch_status=0 
			BEGIN 
				INSERT INTO ShopIngredient(shopId, ingId) VALUES (@shopId, @ingId)
				FETCH NEXT FROM pointer into @ingId
			END
			CLOSE pointer
			DEALLOCATE pointer
		END
	END
END

-- Procedure Insert into Ingredient -------------------------------------------------------
-- Với mỗi bản ghi mới được thêm vào bảng Ingredient thì thêm các 
-- bản ghi với cấu trúc (shopId, allIngId) vào bảng ShopIngredient
CREATE PROC SP_Ingredient_INSERT
	@ingName Nvarchar(255),
	@ingUnit Nvarchar(50)
AS
BEGIN
	-- Thêm vào bảng Ingredient
	INSERT INTO Ingredient(ingName, ingUnit)
	VALUES (@ingName, @ingUnit)
	
	-- Lấy ra mã nguyên liệu mới được thêm vào
	DECLARE @newIngId Integer
	SELECT @newIngId = MAX(ingId)
	FROM Ingredient
	
	-- Thêm vào bảng ShopIngredient toàn bộ nguyên liệu cho cửa hàng mới
	IF EXISTS ( SELECT * FROM Shop )
	BEGIN
		DECLARE pointer CURSOR
		FOR SELECT shopId FROM Shop
	
		OPEN pointer
		DECLARE @shopId Varchar(50)

		FETCH NEXT FROM pointer into @shopId
		WHILE @@fetch_status=0 
		BEGIN 
			INSERT INTO ShopIngredient(shopId, ingId) VALUES (@shopId, @newIngId)
			FETCH NEXT FROM pointer into @shopId
		END
		CLOSE pointer
		DEALLOCATE pointer
	END
END




