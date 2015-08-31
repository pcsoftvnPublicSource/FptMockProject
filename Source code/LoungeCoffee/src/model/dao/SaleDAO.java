package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.CusOrdersDetail;
import model.bean.Food;
import model.bean.FoodType;

//type _comment to add generic comment here

public class SaleDAO extends BaseDAO {

    // Default constructor
    public SaleDAO() {
        super();
    }

    /**
	 * Get list of food types (food categories)
	 *
	 * @return ArrayList that contains all FoodType objects
	 */
    public ArrayList<FoodType> getFoodType() {
        ArrayList<FoodType> foodType = new ArrayList<>();
        FoodType f;

        try {

            connect();
            String sql = String.format("SELECT * FROM FoodType");
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                f = new FoodType();
                f.setFoodTypeID(rs.getInt("foodTypeID"));
                f.setFoodTypeName(rs.getString("foodTypeName"));
                foodType.add(f);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            disconnect();
        }
        return foodType;
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
        ArrayList<Food> food = new ArrayList<>();
        Food f;

        try {

            connect();
            String sql = String.format("SELECT * FROM Food WHERE foodTypeID = '%s'", foodTypeID);
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                f = new Food();
                f.setFoodID(rs.getInt("foodID"));
                f.setFoodName(rs.getString("foodName"));
                f.setFoodPrice(rs.getDouble("foodPrice"));
                f.setFoodTypeID(foodTypeID);
                food.add(f);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            disconnect();
        }

        return food;
    }

    /**
	 * Get all food information form database.
	 *
	 * @return ArrayList that contains all Food objects
	 */
    public ArrayList<Food> getAllFood() {
        ArrayList<Food> food = new ArrayList<>();
        Food f;

        try {

            connect();
            String sql = String.format("SELECT * FROM Food");
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                f = new Food();
                f.setFoodID(rs.getInt("foodID"));
                f.setFoodName(rs.getString("foodName"));
                f.setFoodPrice(rs.getDouble("foodPrice"));
                f.setFoodTypeID(rs.getInt("foodTypeID"));
                food.add(f);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            disconnect();
        }

        return food;
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
        CusOrdersDetail cus = new CusOrdersDetail();

        try {

            connect();
            String sql = String.format(
                    "SELECT foodID, foodName, foodPrice " + " FROM Food WHERE foodID = %s AND shopID = '%s'", foodID,
                    shopID);
            ResultSet rs = executeQuery(sql);

            if (rs.next()) {
                cus.setFoodID(foodID);
                cus.setFoodName(rs.getString("foodName"));
                double foodPrice = rs.getDouble("foodPrice");
                cus.setFoodPrice(foodPrice);
                cus.setOrdersQuantity(ordersQuantity);
                cus.setOrdersTotalPrice(ordersQuantity * foodPrice);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            disconnect();
        }

        return cus;
    }

    /**
	 * Get detail of current orders
	 *
	 * @return list of CusOrderDetail object in current orders
	 */
    public ArrayList<CusOrdersDetail> getCusOrderDetail(String shopID) {
        ArrayList<CusOrdersDetail> cusOrdersDetail = new ArrayList<>();
        CusOrdersDetail cus;

        try {

            connect();
            String sql = String.format("SELECT * FROM CusOrdersDetail WHERE shopID = '%s'", shopID);
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                cus = new CusOrdersDetail();
                cus.setId(rs.getInt("id"));
                cus.setFoodID(rs.getInt("foodID"));
                cus.setFoodName(rs.getString("foodName"));
                cus.setFoodPrice(rs.getDouble("foodPrice"));
                cus.setOrdersQuantity(rs.getInt("ordersQuantity"));
                cus.setOrdersTotalPrice(rs.getDouble("ordersTotalPrice"));
                cusOrdersDetail.add(cus);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            disconnect();
        }

        return cusOrdersDetail;
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
        String sql = String.format("EXEC SP_CusOrdersDetail_INSERT %s,%s,'%s'", foodID, ordersQuantity, shopID);
        executeStoreProcedure(sql);
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
    public void deteleRequestFromOrder(double id, String shopID) {
        try {
            connect();
            String sql = String.format("DELETE FROM CusOrdersDetail WHERE id = %s AND shopID = '%s'", id, shopID);
            executeUpdateQuery(sql);

        } finally {
            disconnect();
        }
    }

    /**
     * Get information of last-added food
     *
     * @param shopID
     *            ID of current shop, get from session attribute
     * @return CusOrdersDetail object that hold detail infor, null for otherwise
     */
    public CusOrdersDetail getLastAddedFood(String shopID) {
        CusOrdersDetail cus = new CusOrdersDetail();
        ResultSet rs = null;

        try {
            connect();
            String functionCall = String.format("loadCusOrdersDetail('%s') ", shopID);
            rs = executeFunction(functionCall);

            if (rs.next()) {
                cus.setId(rs.getDouble("id"));
                cus.setFoodID(rs.getInt("foodID"));
                cus.setFoodName(rs.getString("foodName"));
                cus.setOrdersQuantity(rs.getInt("ordersQuantity"));
                cus.setFoodPrice(rs.getDouble("foodPrice"));
                cus.setOrdersTotalPrice(rs.getDouble("ordersTotalPrice"));

            } else {
                // do some things

            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            disconnect();
        }

        return cus;
    }

	/**
     * Get amount of current orders (incomplete orders)
     *
     * @param shopID
     *            ID of current shop, get from session attribute
     * @return
     */
    public double getCurrentOrdersAmount(String shopID) {
        double ordersAmount = 0;

        try {

            connect();
            String sql = String
                    .format("SELECT SUM(ordersTotalPrice) AS Amount FROM CusOrdersDetail WHERE shopId = '%s'", shopID);
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                ordersAmount = rs.getDouble(1);
            }

        } catch (SQLException e) {
            ordersAmount = 0;
            e.printStackTrace();

        } finally {

            disconnect();
        }

        return ordersAmount;
    }

	/**
     * Complete current orders
     *
     * @param shopID
     *            ID of current shop, get from session attribute
     */

	public void completeOrders(String shopID) {
		String sql = String.format("EXEC SP_OrdersDetail_INSERT '%s'", shopID);
		executeStoreProcedure(sql);
	}

}