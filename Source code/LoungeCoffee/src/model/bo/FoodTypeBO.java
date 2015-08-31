package model.bo;

import model.dao.FoodTypeDAO;

public class FoodTypeBO {
	FoodTypeDAO foodTypeDAO = new FoodTypeDAO();
	public void insertFoodType(String foodTypeName) {
		foodTypeDAO.insertFoodType(foodTypeName);
		
	}
	public void updateFoodType(String foodTypeId , String foodTypeName) {
		foodTypeDAO.updateFoodType(foodTypeId, foodTypeName);
	}
	public void deleteFoodType(String foodTypeId) {
		foodTypeDAO.deleteFoodType(foodTypeId);
	}

}
