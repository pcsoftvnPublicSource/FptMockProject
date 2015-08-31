DELETE FROM FoodType
DBCC CHECKIDENT (FoodType, RESEED, 0)

DELETE FROM Orders
DBCC CHECKIDENT (Orders, RESEED, 0)

DELETE FROM Ingredient
DBCC CHECKIDENT (Ingredient, RESEED, 0)


DELETE FROM ImportReceipt
DBCC CHECKIDENT (ImportReceipt, RESEED, 0)

DELETE FROM ConsumeReceipt
DBCC CHECKIDENT (ConsumeReceipt, RESEED, 0)

DELETE FROM CusOrdersDetail
DBCC CHECKIDENT (CusOrdersDetail, RESEED, 0)

DELETE FROM Cus2OrdersDetail

DELETE FROM TmpConsumeReceiptDetail
DBCC CHECKIDENT (TmpConsumeReceiptDetail, RESEED, 0)

DELETE FROM TmpImportReceiptDetail
DBCC CHECKIDENT (TmpImportReceiptDetail, RESEED, 0)

--

EXEC SP_FoodType_INSERT N'Cà phê'
EXEC SP_FoodType_INSERT N'Kem'
EXEC SP_FoodType_INSERT N'Nước giải khát'

--

DELETE FROM Shop
EXEC SP_Shop_INSERT 'loungesontradn',N'Lounge Coffee Sơn Trà',N'174 Ngô Quyền, Q. Sơn Trà, Tp. Đà Nẵng','202cb962ac59075b964b07152d234b70','0511 3550502',N'Lương Đình Nguyên',N'627 Ngô Quyền, Q. Sơn Trà, Tp. Đà Nẵng','0123456789'
EXEC SP_Shop_INSERT 'loungehaichaudn',N'Lounge Coffee Hải Châu',N'1041 Nguyễn Chí Thanh, Q. Hải Châu, Tp. Đà Nẵng','202cb962ac59075b964b07152d234b70','0511 3550503',N'Nguyễn Thành Nhân',N'97 Bùi Thị Xuân, Q. Hải Châu, Tp. Đà Nẵng','0148556789'
EXEC SP_Shop_INSERT 'loungethanhkhedn',N'Lounge Coffee Thanh Khê',N'797 Xuân Thủy, Q. Thanh Khê, Tp. Đà Nẵng','202cb962ac59075b964b07152d234b70','0511 3550504',N'Lê Thu Na',N'627 Nguyễn Chí Thanh, Q. Thanh Khê, Tp. Đà Nẵng','0123412889'
EXEC SP_Shop_INSERT 'lounge',N'Trụ sở Lounge Coffee',N'777 Mai Xuân Thưởng, Tp. Nha Trang','202cb962ac59075b964b07152d234b70','0511 3550504',N'Lương Đình Nguyên',N'20 Mai Xuân Thưởng, Tp. Nha Trang','0123412889'

--

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

--

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

--



