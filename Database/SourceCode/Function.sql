-- Function return foodTypeId from foodTypeName
CREATE FUNCTION returnFoodTypeId(@foodTypeName Nvarchar(255) = NULL)
RETURNS TABLE
AS
RETURN
	SELECT foodTypeId 
	FROM FoodType
	WHERE foodTypeName = @foodTypeName
	
SELECT * FROM returnFoodTypeId(N'Cà phê')

-- Function search Ingredient --------------------------------------------------------------
CREATE FUNCTION searchIngredient(@ingName Nvarchar(255) = NULL)
RETURNS TABLE
AS
RETURN
	SELECT * 
	FROM Ingredient
	WHERE ingName LIKE N'%' + @ingName + '%'

SELECT * FROM searchIngredient(N'Cà phê bột')
DROP FUNCTION searchIngredient

CREATE PROCEDURE SP_searchIngredient
	@ingName Nvarchar(255) = NULL
AS
BEGIN
	SELECT * FROM searchIngredient(@ingName)
END

EXEC SP_searchIngredient N'Cà phê bột'

-- Function search Shop -----------------------------------------------------------------
CREATE FUNCTION searchShop(@searchString Nvarchar(255) = NULL)
RETURNS TABLE
AS
RETURN
	SELECT * 
	FROM Shop
	WHERE shopName LIKE N'%' + @searchString + '%'
	OR shopAddress LIKE N'%' + @searchString + '%'
	OR managerName LIKE N'%' + @searchString + '%'

SELECT * FROM searchShop(N'Sơn Trà')

CREATE PROCEDURE SP_searchShop
	@searchString Nvarchar(255) = NULL
AS
BEGIN
	SELECT * FROM searchShop(@searchString)
END

EXEC SP_searchShop N'Lương Đình Nguyên'

-- Function search Food -----------------------------------------------------------------
CREATE FUNCTION searchFood(@foodName Nvarchar(255) = NULL)
RETURNS TABLE
AS
RETURN
	SELECT f.foodId, f.foodName, ft.foodTypeId, ft.foodTypeName, f.foodPrice
	FROM Food f JOIN FoodType ft on f.foodTypeId = ft.foodTypeId
	WHERE foodName LIKE N'%' + @foodName + '%'

SELECT * FROM searchFood(N'Kem dừa')
DROP FUNCTION searchFood

CREATE PROCEDURE SP_searchFood
	@foodName Nvarchar(255) = NULL
AS
BEGIN
	SELECT * FROM searchFood(@foodName)
END

EXEC SP_searchFood N'Kem dừa'

-- Procedure filter ShopIngredient ------------------------------------------------------
CREATE PROCEDURE SP_ShopIngredient_FILTER
	@shopId Varchar(50)
AS
BEGIN
	SELECT i.ingName, i.ingUnit, si.ingQuantity, si.ingPrice
	FROM ShopIngredient si join Ingredient i on si.ingId = i.ingId
	WHERE shopId = @shopId
END

EXEC SP_ShopIngredient_FILTER 'nv01'
DROP PROCEDURE SP_ShopIngredient_FILTER 


SELECT i.ingName, i.ingUnit, CONVERT(varchar(12), si.ingQuantity, 0) AS ingQuantity,CONVERT(varchar(12), si.ingPrice, 0) AS ingPrice
FROM ShopIngredient si JOIN Ingredient i ON si.ingId = i.ingId
WHERE shopId = 'nv01'

-- THỐNG KÊ -- THỐNG KÊ -- THỐNG KÊ -- THỐNG KÊ -- THỐNG KÊ -- THỐNG KÊ -- THỐNG KÊ -- THỐNG KÊ -- 

-- Function thống kê doanh thu trong 1 khoảng thời gian của 1 cửa hàng (tổng tiền bán hàng - lượng nguyên liệu đã tiêu thụ). Tính theo từng ngày
-- Tham số bắt buộc: shopId, startDate, endDate
CREATE FUNCTION shopSalesStatistics(@startDate Date, @endDate Date, @shopId Varchar(50))
RETURNS TABLE
AS RETURN
SELECT Tmp2.shopId, Tmp2.conDate, SUM(Tmp1.amount - Tmp2.amount) AS amount
FROM
(
	SELECT shopId, DAY(ordersDate) as day, MONTH(ordersDate) as month, YEAR(ordersDate) as year, SUM(ordersAmount) AS amount
	FROM Orders
	GROUP BY DAY(ordersDate), MONTH(ordersDate), YEAR(ordersDate), shopId
) AS Tmp1,
(
	SELECT shopId, DAY(conDate) as day, MONTH(conDate) as month, YEAR(conDate) as year, conDate, SUM(conAmount) AS amount
	FROM ConsumeReceipt
	GROUP BY DAY(conDate), MONTH(conDate), YEAR(conDate), conDate, shopId
) AS Tmp2
WHERE Tmp1.day = Tmp2.day AND Tmp1.month = Tmp2.month AND Tmp1.year = Tmp2.year
AND Tmp1.shopId = Tmp2.shopId 
AND Tmp1.shopId = @shopId
AND Tmp2.conDate BETWEEN @startDate AND @endDate
GROUP BY Tmp2.shopId, Tmp2.conDate

SELECT * FROM shopSalesStatistics('2015-8-15','2015-8-28','nv01')
SELECT * FROM shopSalesStatistics('2015-8-15','2015-8-28','nv02')

-- Function thống kê doanh thu trong 1 khoảng thời gian (tính theo từng ngày) của toàn hệ thống (tổng tiền bán hàng - lượng nguyên liệu đã tiêu thụ).
-- Tham số bắt buộc: startDate, endDate
CREATE FUNCTION salesStatistics(@startDate Date, @endDate Date)
RETURNS TABLE
AS RETURN
SELECT Tmp2.conDate, SUM(Tmp1.amount - Tmp2.amount) AS amount
FROM
(
SELECT DAY(ordersDate) as day, MONTH(ordersDate) as month, YEAR(ordersDate) as year, SUM(ordersAmount) AS amount
FROM Orders
GROUP BY DAY(ordersDate), MONTH(ordersDate), YEAR(ordersDate)
) AS Tmp1,
(
SELECT DAY(conDate) as day, MONTH(conDate) as month, YEAR(conDate) as year, conDate, SUM(conAmount) AS amount
FROM ConsumeReceipt
GROUP BY DAY(conDate), MONTH(conDate), YEAR(conDate), conDate
) AS Tmp2
WHERE Tmp1.day = Tmp2.day AND Tmp1.month = Tmp2.month AND Tmp1.year = Tmp2.year
GROUP BY Tmp2.conDate

DROP FUNCTION salesStatistics
SELECT * FROM salesStatistics('2015-8-15','2015-8-29')

-- Function thống kê doanh thu trong 1 khoảng thời gian của toàn bộ cửa hàng, GROUP BY shopId
-- Tham số bắt buộc: shopId, startDate, endDate
CREATE DROP FUNCTION shopStatistics(@startDate Date, @endDate Date)
RETURNS TABLE
AS RETURN
SELECT Tmp2.shopId, SUM(Tmp1.amount) - SUM(Tmp2.amount) AS amount
FROM
(
	SELECT DAY(ordersDate) as day, MONTH(ordersDate) as month, YEAR(ordersDate) as year, shopId, SUM(ordersAmount) AS amount
	FROM Orders
	GROUP BY shopId, DAY(ordersDate), MONTH(ordersDate), YEAR(ordersDate)
) AS Tmp1,
(
	SELECT DAY(conDate) as day, MONTH(conDate) as month, YEAR(conDate) as year, conDate, shopId, SUM(conAmount) AS amount
	FROM ConsumeReceipt
	GROUP BY DAY(conDate), MONTH(conDate), YEAR(conDate), conDate, shopId
) AS Tmp2
WHERE Tmp1.shopId = Tmp2.shopId 
AND Tmp1.day = Tmp2.day AND Tmp1.month = Tmp2.month AND Tmp1.year = Tmp2.year
AND Tmp2.conDate BETWEEN @startDate AND @endDate
GROUP BY Tmp2.shopId, Tmp2.shopId

DROP FUNCTION shopStatistics
SELECT * FROM shopStatistics('2015-8-1','2015-8-29')

-- Function số lượng bán của từng món theo từng cửa hàng trong 1 khoảng thời gian ----------------
CREATE FUNCTION shopQuantityStatistics(@startDate Date, @endDate Date, @shopId Varchar(50))
RETURNS TABLE
AS RETURN
SELECT o.shopId, f.foodName, SUM(od.ordersQuantity) AS Quantity, f.foodPrice, SUM(od.ordersQuantity)*f.foodPrice AS Amount
FROM Orders o join OrdersDetail od on o.ordersNo = od.ordersNo join Food f on od.foodId = f.foodId
WHERE o.shopId = @shopId 
AND DAY(o.ordersDate) BETWEEN DAY(@startDate) AND DAY(@endDate)
AND MONTH(o.ordersDate) BETWEEN MONTH(@startDate) AND MONTH(@endDate)
AND YEAR(o.ordersDate) BETWEEN YEAR(@startDate) AND YEAR(@endDate)
GROUP BY f.foodName, o.shopId, f.foodPrice

DROP FUNCTION shopQuantityStatistics
SELECT * FROM shopQuantityStatistics('2015-8-1','2015-8-29','nv01')
SELECT * FROM shopQuantityStatistics('2015-8-15','2015-8-31','nv02')

-- Function số lượng bán của từng món trong toàn hệ thống
CREATE FUNCTION quantityStatistics(@startDate Date, @endDate Date)
RETURNS TABLE
AS RETURN
SELECT f.foodName, SUM(od.ordersQuantity) AS Quantity, f.foodPrice, SUM(od.ordersQuantity)*f.foodPrice AS Amount
FROM Orders o join OrdersDetail od on o.ordersNo = od.ordersNo join Food f on od.foodId = f.foodId
WHERE DAY(o.ordersDate) BETWEEN DAY(@startDate) AND DAY(@endDate)
AND MONTH(o.ordersDate) BETWEEN MONTH(@startDate) AND MONTH(@endDate)
AND YEAR(o.ordersDate) BETWEEN YEAR(@startDate) AND YEAR(@endDate)
GROUP BY f.foodName, f.foodPrice

DROP FUNCTION quantityStatistics
SELECT * FROM quantityStatistics('2015-8-1','2015-8-29')


