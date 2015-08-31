package model.bo;

import java.util.ArrayList;

import model.bean.FoodT;
import model.bean.FoodTypeT;
import model.bean.FoodTypeNew;
import model.dao.FoodDAO;

public class FoodBO {
	private FoodDAO foodDAO = new FoodDAO();

	public ArrayList<String> getFoodTypeList() {
		return foodDAO.getFoodTypeList();
	}

	public ArrayList<FoodT> getListFood(String searchFoodText) {
		return foodDAO.getListFood(searchFoodText);
	}

	public ArrayList<FoodTypeNew> getListNewFoodType() {
		return foodDAO.getListNewFoodType();
	}

	public void insertFood(String foodName, String foodTypeId, double foodPrice) {
		foodDAO.insertFood(foodName, foodTypeId, foodPrice);

	}

	public ArrayList<FoodTypeT> getFoodTypeListId() {
		return foodDAO.getFoodTypeListId();
	}

	public void updateFood(String updateFoodId, String detailFoodName, String detailChooseFoodType,
			String detailFoodPrice) {
		foodDAO.updateFood(updateFoodId, detailFoodName , detailChooseFoodType, detailFoodPrice);
	}

	public void deleteFood(String foodId) {
		foodDAO.deleteFood(foodId);
	}

}
