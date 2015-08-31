package model.bo;

import java.util.ArrayList;

import model.bean.CusOrdersDetail;
import model.bean.Food;
import model.bean.FoodType;
import model.dao.SaleDAO;

public class SaleBO {

	/**
	 * Get list of food types (food categories)
	 *
	 * @return ArrayList that contains all FoodType objects
	 */
	public ArrayList<FoodType> getFoodType() {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getFoodType();
	}

	/**
	 * Get all foods information base on it's type (category)
	 *
	 * @param foodTypeID
	 *            ID of food type
	 * @return ArrayList that contains all Food objects which have matched
	 *         "foodTypeID"
	 */
	public ArrayList<Food> getFoodByFoodType(int foodTypeID) {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getFoodByFoodType(foodTypeID);
	}

	/**
	 * Get all food information form database.
	 *
	 * @return ArrayList that contains all Food objects
	 */
	public ArrayList<Food> getAllFood() {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getAllFood();
	}

	/**
	 * Get food information and request quantity to add into orders bill. <br>
	 * Pre-condition: user add foods from list to order bill
	 *
	 * @param foodID
	 *            ID of chosen food
	 * @param ordersQuantity
	 *            Quantity of buy
	 * @return CusOrderDetail object
	 */
	public CusOrdersDetail getCurrentOrdersDetail(int foodID, int ordersQuantity, String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getCurrentOrdersDetail(foodID, ordersQuantity, shopID);
	}

	/**
	 * Get detail of current orders
	 *
	 * @return list of CusOrderDetail object in current orders
	 */
	public ArrayList<CusOrdersDetail> getCusOrderDetail(String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getCusOrderDetail(shopID);
	}

	/**
	 * Add selected food to current orders
	 *
	 * @param foodID
	 *            ID of chosen food
	 * @param ordersQuantity
	 *            Quantity of buy
	 * @param shopID
	 *            ID of current shop, get from session attribute
	 */
	public void addRequestToOrder(int foodID, int ordersQuantity, String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		saleDAO.addRequestToOrder(foodID, ordersQuantity, shopID);
	}

	/**
	 * Delete selected food from current orders (incomplete orders)
	 *
	 * @param id
	 *            id of row that hold request
	 * 
	 * @param shopID
	 *            ID of current shop, get from session attribute
	 */
	public void deleteRequestFromOrder(double id, String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		saleDAO.deteleRequestFromOrder(id, shopID);
	}

	/**
	 * Get information of last-added food
	 * 
	 * @param shopID
	 *            ID of current shop, get from session attribute
	 * @return CusOrdersDetail object that hold detail infor, null for otherwise
	 */
	public CusOrdersDetail getLastAddedFood(String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getLastAddedFood(shopID);
	}

	/**
	 * Get amount of current orders (incomplete orders)
	 * 
	 * @param shopID
	 *            ID of current shop, get from session attribute
	 * @return
	 */
	public double getCurrentOrdersAmount(String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		return saleDAO.getCurrentOrdersAmount(shopID);
	}

	/**
	 * Complete current orders
	 * 
	 * @param shopID
	 *            ID of current shop, get from session attribute
	 */

	public void completeOrders(String shopID) {
		SaleDAO saleDAO = new SaleDAO();
		saleDAO.completeOrders(shopID);
	}

}
