package model.dao;

public class FoodTypeDAO extends BaseDAO{

	public void insertFoodType(String foodTypeName) {
		try {
			connect();
			String sql = String.format("SP_FoodType_INSERT N'%s'", foodTypeName);
			executeStoreProcedure(sql);
		} finally {
			disconnect();
		}
		
	}


	public void updateFoodType(String foodTypeId, String foodTypeName) {
		try {
			connect();
			// System.out.println(foodTypeId);
			int foodTypeIdInt = Integer.parseInt(foodTypeId);
			String sql = String.format("SP_FoodType_UPDATE %d , N'%s' ",foodTypeIdInt, foodTypeName);
			executeStoreProcedure(sql);
		} finally {
			disconnect();
		}
	}


	public void deleteFoodType(String foodTypeId) {
		try {
			connect();
			// System.out.println(foodTypeId);
			int foodTypeIdInt = Integer.parseInt(foodTypeId);
			String sql = String.format("SP_FoodType_DELETE %d ",foodTypeIdInt);
			executeStoreProcedure(sql);
		} finally {
			disconnect();
		}
		
	}

}
