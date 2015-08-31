-- Bảng tạm OrdersDetail -----------------------------------------------------------------------
CREATE TABLE CusOrdersDetail (
	id Integer IDENTITY(1,1) PRIMARY KEY,
	foodId Integer, 
	foodName Nvarchar(255),
	ordersQuantity Integer,
	foodPrice Money, 
	ordersTotalPrice Money DEFAULT(0),
	shopId Varchar(50)
)

CREATE TABLE Cus2OrdersDetail (
	foodId Integer, 
	ordersQuantity Integer,
	shopId Varchar(50)
)

-- Procedure insert CusOrdersDetail: chỉ truyền vào foodId, ordersQuantity và shopId
CREATE PROC SP_CusOrdersDetail_INSERT
	@foodId Integer,
	@ordersQuantity Integer,
	@shopId Varchar(255)
AS
BEGIN
	DECLARE @foodName Nvarchar(255) 
	DECLARE @foodPrice Money
	SELECT @foodName = foodName, @foodPrice = foodPrice
	FROM Food
	WHERE foodId = @foodId

	INSERT INTO CusOrdersDetail(foodId, foodName, ordersQuantity, foodPrice, shopId) VALUES 
	(@foodId, @foodName, @ordersQuantity, @foodPrice, @shopId)
END	

-- Trigger insert CusOrdersDetail : tự tính thành tiền từng món
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_CusOrdersDetail_INSERT' AND TYPE='TR') DROP TRIGGER TR_CusOrdersDetail_INSERT
GO
CREATE TRIGGER TR_CusOrdersDetail_INSERT ON CusOrdersDetail FOR INSERT AS BEGIN 
	UPDATE CusOrdersDetail
		SET ordersTotalPrice = ordersTotalPrice + tmp.amount
	FROM (
		SELECT inserted.Id, (inserted.ordersQuantity*f.foodPrice) as amount
		FROM inserted join Food f on inserted.foodId = f.foodId
	) as tmp 
	WHERE tmp.Id = CusOrdersDetail.Id
END

EXEC SP_CusOrdersDetail_INSERT 3,2,'nv01'
EXEC SP_CusOrdersDetail_INSERT 3,3,'nv01'
EXEC SP_CusOrdersDetail_INSERT 3,1,'nv02'
EXEC SP_CusOrdersDetail_INSERT 3,2,'nv02'

EXEC SP_CusOrdersDetail_INSERT 4,2,'nv02'
EXEC SP_CusOrdersDetail_INSERT 5,1,'nv02'
EXEC SP_CusOrdersDetail_INSERT 6,3,'nv02'

-- Procedure load dữ liệu từ CusOrdersDetailDetail ra bảng tạm trên form
CREATE FUNCTION loadCusOrdersDetail(@shopId Varchar(255))
RETURNS TABLE
AS
RETURN
	SELECT id, foodId, foodName, ordersQuantity, foodPrice, ordersTotalPrice
	FROM CusOrdersDetail
	WHERE shopId = @shopId and id = ( SELECT MAX(id)
		FROM CusOrdersDetail
		WHERE shopId = @shopId
	)

DROP FUNCTION loadCusOrdersDetail
SELECT * FROM loadCusOrdersDetail('nv01')

-- Procedure tính tổng tiền orders hiện tại của 1 shop 
CREATE PROC SP_CusOrdersDetail_AMOUNT
	@shopId Varchar(255)
AS
BEGIN
	SELECT SUM(ordersTotalPrice) AS Amount
	FROM CusOrdersDetail
	WHERE shopId = @shopId
END	

EXEC SP_CusOrdersDetail_AMOUNT 'nv01'


DELETE FROM CusOrdersDetail
DBCC CHECKIDENT (CusOrdersDetail, RESEED, 0)

-- =========================================================================================
-- Bảng tạm  TmpImportReceiptDetail --------------------------------------------------------
CREATE TABLE TmpImportReceiptDetail (
	Id Integer IDENTITY(1,1) PRIMARY KEY,
	ingId Integer, 
	ingName Nvarchar(255), 
	impQuantity Money,
	impPrice Money,
	shopId Varchar(50)
)

-- Procedure insert TmpImportReceiptDetail: tham số ingId, impQuantity, impPrice và shopId
CREATE PROC SP_TmpImportReceiptDetail_INSERT
	@ingId Integer, 
	@impQuantity Integer,
	@impPrice Money,
	@shopId Varchar(50)
AS
BEGIN
	DECLARE @ingName Nvarchar(255) 
	SELECT @ingName = ingName
	FROM Ingredient
	WHERE ingId = @ingId

	INSERT INTO TmpImportReceiptDetail(ingId, ingName, impQuantity, impPrice, shopId) VALUES 
	(@ingId, @ingName, @impQuantity, @impPrice, @shopId)
END	

EXEC SP_TmpImportReceiptDetail_INSERT 3,1,25000,'nv01'
EXEC SP_TmpImportReceiptDetail_INSERT 2,1,18000,'nv01'
EXEC SP_TmpImportReceiptDetail_INSERT 4,2,18000,'nv02'
EXEC SP_TmpImportReceiptDetail_INSERT 6,2,28000,'nv02'

-- Procedure Insert into ImportReceiptDetail : sự kiện nút Xác Nhân trong form NHẬP KHO -----
-- Đưa hết dữ liệu từ bảng TmpImportReceiptDetail vào ImportReceiptDetail
CREATE PROC SP_ImportReceiptDetail_INSERT
	@impDate Date,
	@shopId Varchar(255)
AS
BEGIN
	INSERT INTO ImportReceipt(impDate, shopId) VALUES (@impDate, @shopId)
	
	-- Lấy số Hóa đơn nhập kho vừa được thêm vào (impNo lớn nhất)
	DECLARE @impNo Decimal
	SELECT @impNo = MAX(impNo)
	FROM ImportReceipt
	
	-- Thêm lần lượt vào bảng ImportReceiptDetail
	DECLARE pointer CURSOR
		FOR SELECT ingId, impQuantity, impPrice
		FROM TmpImportReceiptDetail 
		WHERE shopId = @shopId
	
		OPEN pointer
		DECLARE @ingId Integer
		DECLARE @impQuantity Money
		DECLARE @impPrice Money

		FETCH NEXT FROM pointer into @ingId, @impQuantity, @impPrice
		WHILE @@fetch_status=0 
		BEGIN 
			INSERT INTO ImportReceiptDetail(impNo, ingId, impQuantity, impPrice) VALUES 
			(@impNo, @ingId, @impQuantity, @impPrice)
			FETCH NEXT FROM pointer into @ingId, @impQuantity, @impPrice
		END
		CLOSE pointer
	DEALLOCATE pointer
	
	-- Xóa các bản ghi trong bảng tạm có shopId = @shopId
	DELETE FROM TmpImportReceiptDetail  WHERE shopId = @shopId
END	

EXEC SP_ImportReceiptDetail_INSERT '2015-08-24','nv01'

-- Procedure load dữ liệu từ TmpImportReceiptDetail ra bảng tạm trên form
CREATE FUNCTION loadTmpImportReceiptDetail(@shopId Varchar(255))
RETURNS TABLE
AS
RETURN
	SELECT i.ingId, i.ingName, i.ingUnit, tmp.impQuantity, tmp.impPrice
	FROM TmpImportReceiptDetail tmp join Ingredient i on tmp.ingId = i.ingId
	WHERE tmp.shopId = @shopId and tmp.Id = ( SELECT MAX(ID)
		FROM TmpImportReceiptDetail
		WHERE shopId = @shopId
	)

DROP FUNCTION loadTmpImportReceiptDetail
SELECT * FROM loadTmpImportReceiptDetail('nv02')

DELETE FROM TmpImportReceiptDetail
DBCC CHECKIDENT (TmpImportReceiptDetail, RESEED, 0)

-- =========================================================================================
-- Load lên Form Báo cáo tiêu thụ nguyên liệu
CREATE PROC SP_ComsumeIngredient_LOAD
AS
BEGIN
	SELECT ingId, ingName, ingUnit, 0 AS quantity
	FROM Ingredient
END

EXEC SP_ComsumeIngredient_LOAD


-- Bảng tạm TmpConsumeReceiptDetail --------------------------------------------------------
CREATE TABLE TmpConsumeReceiptDetail (
	Id Integer IDENTITY(1,1) PRIMARY KEY,
	ingId Integer, 
	conQuantity Money,
	shopId Varchar(50)
)

-- Proc thêm vào TmpConsumeReceiptDetail
CREATE PROCEDURE SP_TmpConsumeReceiptDetail_INSERT 
	@ingId Integer, 
	@conQuantity Money,
	@shopId Varchar(50)
AS
BEGIN
	INSERT INTO TmpConsumeReceiptDetail(ingId, conQuantity, shopId) VALUES (@ingId, @conQuantity, @shopId)
END

EXEC SP_TmpConsumeReceiptDetail_INSERT 1,0.5,'nv01'
EXEC SP_TmpConsumeReceiptDetail_INSERT 2,2,'nv01'
EXEC SP_TmpConsumeReceiptDetail_INSERT 1,0.8,'nv02'
EXEC SP_TmpConsumeReceiptDetail_INSERT 2,3,'nv02'

-- Proc thêm vào ConsumeReceiptDetail: sự kiện nút Xác Nhận, đưa hết dữ liệu từ TmpConsumeReceiptDetail vào ConsumeReceiptDetail và xóa dữ liệu tương ứng tại TmpConsumeReceiptDetail
CREATE PROC SP_ConsumeReceiptDetail_INSERT
	@shopId Varchar(255)
AS
BEGIN
	INSERT INTO ConsumeReceipt(conDate, shopId) VALUES (GETDATE(), @shopId)
	
	-- Lấy số Hóa đơn báo cáo tiêu thụ vừa được thêm vào (conNo lớn nhất)
	DECLARE @conNo Decimal
	SELECT @conNo = MAX(conNo)
	FROM ConsumeReceipt
	
	-- Thêm lần lượt vào bảng ConsumeReceiptDetail
	DECLARE pointer CURSOR
		FOR SELECT ingId, conQuantity
		FROM TmpConsumeReceiptDetail
		WHERE shopId = @shopId
	
		OPEN pointer
		DECLARE @ingId Integer
		DECLARE @conQuantity Money

		FETCH NEXT FROM pointer into @ingId, @conQuantity
		WHILE @@fetch_status=0 
		BEGIN 
			INSERT INTO ConsumeReceiptDetail(conNo, ingId, conQuantity) VALUES 
			(@conNo, @ingId, @conQuantity)
			FETCH NEXT FROM pointer into @ingId, @conQuantity
		END
		CLOSE pointer
	DEALLOCATE pointer
	
	-- Xóa các bản ghi trong bảng tạm có shopId = @shopId
	DELETE FROM TmpConsumeReceiptDetail  WHERE shopId = @shopId
	
	-- Xóa các bản ghi có lượng tiêu thụ bằng 0 trong ConsumeReceiptDetail
	DELETE FROM ConsumeReceiptDetail WHERE conQuantity = 0
END	

EXEC SP_ConsumeReceiptDetail_INSERT 'nv01'
EXEC SP_ConsumeReceiptDetail_INSERT 'nv02'
DROP PROC SP_ConsumeReceiptDetail_INSERT
