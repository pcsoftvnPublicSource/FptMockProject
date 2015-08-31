package model.bo;

import java.util.ArrayList;

import model.bean.Ingredient;
import model.bean.ShopIngredient;
import model.dao.IngredientDAO;

public class IngredientBO {
    private IngredientDAO ingredientDAO = new IngredientDAO();

    public ArrayList<Ingredient> getListIngredient(String ingredientSearchText) {
	return ingredientDAO.getListIngredient(ingredientSearchText);
    }

    public String insertIngredient(String ingredientName, String ingredientUnit) {
	return ingredientDAO.insertIngredient(ingredientName, ingredientUnit);

    }

    public void deleteIngredient(String deleteIngredientId) {
	ingredientDAO.deleteIngredient(deleteIngredientId);

    }

    public void updateIngredient(String updateIngredientId, String updateIngredientName, String updateIngredientUnit) {
	ingredientDAO.updateIngredient(updateIngredientId, updateIngredientName, updateIngredientUnit);

    }

    public ArrayList<ShopIngredient> getListShopIngredient(String shopId) {
	return ingredientDAO.getListShopIngredient(shopId);
    }

    /**
     * @return list of shop ingredient consumed
     */
    public ArrayList<ShopIngredient> getListShopIngredientCS() {
	return ingredientDAO.getListShopIngredientCS();
    }

	/*
	 * public int getIngredientID(String ingID) { IngredientDAO ingredientDAO =
	 * new IngredientDAO(); return ingredientDAO.getIngredientID(ingID); }
	 */

    public ArrayList<Ingredient> loadIngredient() {
    	IngredientDAO ingredientDAO = new IngredientDAO();
        return ingredientDAO.loadIngredient();
    }
}
