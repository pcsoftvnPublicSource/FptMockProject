-- Trigger OrdersDetail ---------------------------------------------------------
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_OrdersDetail_INSERT' AND TYPE='TR') DROP TRIGGER TR_OrdersDetail_INSERT
GO
CREATE TRIGGER TR_OrdersDetail_INSERT ON OrdersDetail
FOR INSERT AS
BEGIN 
	UPDATE Orders 
		SET ordersAmount = ordersAmount + tmp.Amount
	FROM (
		SELECT inserted.ordersNo, SUM(inserted.ordersQuantity*f.foodPrice) as Amount
		FROM inserted join Food f on inserted.foodId = f.foodId
		GROUP BY inserted.ordersNo
	) as tmp
	WHERE tmp.ordersNo = Orders.ordersNo
END

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_OrdersDetail_DELETE' AND TYPE='TR') DROP TRIGGER TR_OrdersDetail_DELETE
GO
CREATE TRIGGER TR_OrdersDetail_DELETE ON OrdersDetail
FOR DELETE, UPDATE AS
BEGIN 
	UPDATE Orders 
		SET ordersAmount = ordersAmount - tmp.Amount
	FROM (
		SELECT deleted.ordersNo, SUM(deleted.ordersQuantity*f.foodPrice) as Amount
		FROM deleted join Food f on deleted.foodId = f.foodId
		GROUP BY deleted.ordersNo
	) as tmp
	WHERE tmp.ordersNo = Orders.ordersNo
END

IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_OrdersDetail_UPDATE' AND TYPE='TR') DROP TRIGGER TR_OrdersDetail_UPDATE
GO
CREATE TRIGGER TR_OrdersDetail_UPDATE ON OrdersDetail
FOR UPDATE AS
BEGIN 
	IF UPDATE (ordersQuantity)
	BEGIN
	UPDATE Orders 
		SET ordersAmount = ordersAmount - tmp.Amount
	FROM (
		SELECT deleted.ordersNo, SUM(deleted.ordersQuantity*f.foodPrice) as Amount
		FROM deleted join Food f on deleted.foodId = f.foodId
		GROUP BY deleted.ordersNo
	) as tmp
	WHERE tmp.ordersNo = Orders.ordersNo
	
	UPDATE Orders 
		SET ordersAmount = ordersAmount + tmp.Amount
	FROM (
		SELECT inserted.ordersNo, SUM(inserted.ordersQuantity*f.foodPrice) as Amount
		FROM inserted join Food f on inserted.foodId = f.foodId
		GROUP BY inserted.ordersNo
	) as tmp
	WHERE tmp.ordersNo = Orders.ordersNo
	END	
END

-- Trigger ImportReceipt -----------------------------------------------------------------------
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_ImportReceipt_DELETE' AND TYPE='TR') DROP TRIGGER TR_ImportReceipt_DELETE
GO
CREATE TRIGGER TR_ImportReceipt_DELETE ON ImportReceipt
FOR DELETE AS
BEGIN 
	DELETE FROM ImportReceiptDetail
	WHERE impNo in (SELECT deleted.impNo FROM deleted)
END

-- Trigger ImportReceiptDetail ------------------------------------------------------------------
-- Mỗi nguyên liệu được nhập kho cho cửa hàng thì cộng thêm Quantity và cập nhật lại Price bình quân cho nguyên liệu tại cửa hàng đó
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_ImportReceiptDetail_INSERT' AND TYPE='TR') DROP TRIGGER TR_ImportReceiptDetail_INSERT
GO
CREATE TRIGGER TR_ImportReceiptDetail_INSERT ON ImportReceiptDetail
FOR INSERT AS
BEGIN 
	UPDATE ShopIngredient
		SET ingPrice = (ingPrice*ingQuantity + tmp.impPrice*tmp.impQuantity)/(ingQuantity + tmp.impQuantity), 
			ingQuantity = ingQuantity + tmp.impQuantity
	FROM (
		SELECT inserted.ingId, inserted.impQuantity, inserted.impPrice, ir.shopId
		FROM inserted join ImportReceipt ir on inserted.impNo = ir.impNo
	) as tmp
	WHERE tmp.ingId = ShopIngredient.ingId and tmp.shopId = ShopIngredient.shopId
END

-- Nếu xóa 1 chi tiết nhập kho thì trừ đi Quantity đang có của nguyên liệu đó (lượng trừ bằng deleted Quantity) và cập nhật lại Price cũ
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_ImportReceiptDetail_DELETE' AND TYPE='TR') DROP TRIGGER TR_ImportReceiptDetail_DELETE
GO
CREATE TRIGGER TR_ImportReceiptDetail_DELETE ON ImportReceiptDetail
FOR DELETE AS
BEGIN 
	-- Trừ đi số lượng đang có cho giá trị trong deleted
	UPDATE ShopIngredient
		SET ingQuantity = ingQuantity - tmp.impQuantity
	FROM (
		SELECT deleted.ingId, deleted.impQuantity, ir.shopId
		FROM deleted join ImportReceipt ir on deleted.impNo = ir.impNo
	) as tmp
	WHERE tmp.ingId = ShopIngredient.ingId and tmp.shopId = ShopIngredient.shopId
	
	-- Kiểm tra Quantity sau khi đã trừ
	IF (
		SELECT ingQuantity
		FROM ShopIngredient
		WHERE ingId = (SELECT ingId FROM deleted)
		and shopId = (SELECT ir.shopId
		FROM deleted join ImportReceipt ir on deleted.impNo = ir.impNo
		)
	) = 0
	BEGIN -- Trường hợp Quantity đã bằng 0
	UPDATE ShopIngredient
		SET ingQuantity = 0, ingPrice = 0
	FROM (
		SELECT deleted.ingId, deleted.impPrice, deleted.impQuantity, ir.shopId
		FROM deleted join ImportReceipt ir on deleted.impNo = ir.impNo
	) as tmp
	WHERE tmp.ingId = ShopIngredient.ingId and tmp.shopId = ShopIngredient.shopId
	END
	ELSE -- Trường hợp Quantity != 0, cập nhật lại Price cũ cho nguyên liệu
	BEGIN
	UPDATE ShopIngredient
		SET ingPrice = (ingPrice*(ingQuantity + tmp.impQuantity) - tmp.impPrice*tmp.impQuantity)/ingQuantity
	FROM (
		SELECT deleted.ingId, deleted.impPrice, deleted.impQuantity, ir.shopId
		FROM deleted join ImportReceipt ir on deleted.impNo = ir.impNo
	) as tmp
	WHERE tmp.ingId = ShopIngredient.ingId and tmp.shopId = ShopIngredient.shopId
	END
END

-- Trigger ConsumeReceiptDetail ------------------------------------------------------------------
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_ConsumeReceiptDetail_INSERT' AND TYPE='TR') DROP TRIGGER TR_ConsumeReceiptDetail_INSERT
GO
CREATE TRIGGER TR_ConsumeReceiptDetail_INSERT ON ConsumeReceiptDetail
FOR INSERT AS
BEGIN 
	-- Kiểm tra xem lượng tiêu thụ của nguyên liệu có lớn hơn lượng đang có trong kho hay không?
	IF EXISTS (
		SELECT *
		FROM (
			SELECT cr.shopId, inserted.ingId, inserted.conQuantity as quantity
			FROM ConsumeReceipt cr join inserted on cr.conNo = inserted.conNo
		) as tmp join Ingredient i on tmp.ingId = i.ingId join ShopIngredient si on i.ingId = si.ingId
		WHERE tmp.quantity > si.ingQuantity and si.shopId = tmp.shopId
	)
	BEGIN
		ROLLBACK TRAN
		PRINT N'Lượng nguyên liệu không hợp lệ.'
	END
	ELSE -- Nếu lượng tiêu thụ nhỏ hơn hoặc bằng lượng hàng trong kho

	BEGIN
	-- Trừ đi lượng tiêu thụ vào ShopIngredient
	UPDATE ShopIngredient
		SET	ingQuantity = ingQuantity - tmp.conQuantity
	FROM (
		SELECT inserted.ingId, inserted.conQuantity, cr.shopId
		FROM inserted join ConsumeReceipt cr on inserted.conNo = cr.conNo
	) as tmp
	WHERE tmp.ingId = ShopIngredient.ingId and tmp.shopId = ShopIngredient.shopId
	
	-- Cập nhật lại giá trị conAmount
	UPDATE ConsumeReceipt
		SET conAmount = conAmount + tmp.amount
	FROM (
		SELECT SUM(inserted.conQuantity*si.ingPrice) as amount
		FROM inserted join Ingredient i on inserted.ingId = i.ingId join ShopIngredient si on i.ingId = si.ingId
		WHERE si.shopId in (SELECT cr.shopId FROM inserted join ConsumeReceipt cr on inserted.conNo = cr.conNo)
		GROUP BY inserted.conNo
	) as tmp
	WHERE ConsumeReceipt.conNo in (SELECT inserted.conNo FROM inserted)
	END
END

-- Xóa một dòng ConsumeReceiptDetail
IF EXISTS (SELECT NAME FROM SYSOBJECTS WHERE NAME='TR_ConsumeReceiptDetail_DELETE' AND TYPE='TR') DROP TRIGGER TR_ConsumeReceiptDetail_DELETE
GO
CREATE TRIGGER TR_ConsumeReceiptDetail_DELETE ON ConsumeReceiptDetail
FOR DELETE AS
BEGIN 
	-- Cộng thêm lượng đã bị xóa vào ShopIngredient
	UPDATE ShopIngredient
		SET	ingQuantity = ingQuantity + tmp.conQuantity
	FROM (
		SELECT deleted.ingId, deleted.conQuantity, cr.shopId
		FROM deleted join ConsumeReceipt cr on deleted.conNo = cr.conNo
	) as tmp
	WHERE tmp.ingId = ShopIngredient.ingId and tmp.shopId = ShopIngredient.shopId
	
	-- Trừ bớt đi conAmount
	UPDATE ConsumeReceipt
		SET conAmount = conAmount - tmp.amount
	FROM (
		SELECT deleted.ingId, (deleted.conQuantity*si.ingPrice) as amount
		FROM deleted join Ingredient i on deleted.ingId = i.ingId join ShopIngredient si on i.ingId = si.ingId
		WHERE si.shopId in (SELECT cr.shopId FROM deleted join ConsumeReceipt cr on deleted.conNo = cr.conNo)
	) as tmp
	WHERE ConsumeReceipt.conNo in (SELECT deleted.conNo FROM deleted)
END

INSERT INTO ImportReceiptDetail VALUES (1,1,1,100000),(1,2,5,15000), (1,3,5,10000)
INSERT INTO ImportReceiptDetail VALUES (4,1,2,100000),(4,2,10,15000), (4,3,10,10000)

INSERT INTO ConsumeReceiptDetail VALUES (1,1,0.5),(1,2,2), (1,3,3)
INSERT INTO ConsumeReceiptDetail VALUES (6,1,1),(6,2,5), (6,3,5)