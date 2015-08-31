package model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.Ingredient;
import model.bean.ShopIngredient;

public class IngredientDAO extends BaseDAO {

    public ArrayList<Ingredient> getListIngredient(String ingredientSearchText) {
	ArrayList<Ingredient> ingredientList = new ArrayList<Ingredient>();

	String sql = String.format("SELECT * FROM searchIngredient(N'%s')", ingredientSearchText);
	try {
	    connect();
	    ResultSet rs = executeQuery(sql);
	    while (rs.next()) {
		Ingredient ingredient = new Ingredient();
		ingredient.setIngredientId(rs.getInt("ingId"));
		ingredient.setIngredientName(rs.getString("ingName"));
		ingredient.setIngredientUnit(rs.getString("ingUnit"));
		ingredientList.add(ingredient);
	    }
	    return ingredientList;
	} catch (SQLException e) {
	} finally {
	    disconnect();
	}
	return ingredientList;
    }

    public String insertIngredient(String ingredientName, String ingredientUnit) {
	try {
	    connect();
	    String sql = String.format("SP_Ingredient_INSERT N'%s', N'%s'", ingredientName, ingredientUnit);
	    executeStoreProcedure(sql);
	    return "Thành công";
	} finally {
	    disconnect();
	}
    }

    public void deleteIngredient(String deleteIngredientId) {
	try {
	    connect();
	    String sql = "delete Ingredient where ingId = ?";
	    PreparedStatement pr = connect().prepareStatement(sql);
	    pr.setString(1, deleteIngredientId);
	    pr.executeUpdate();
	} catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	} finally {
	    disconnect();
	}
    }

    public void updateIngredient(String updateIngredientId, String updateIngredientName, String updateIngredientUnit) {
	try {
	    connect();
	    String sql = "update Ingredient set ingName = ? , ingUnit = ? where ingId = ?";
	    PreparedStatement pr = connect().prepareStatement(sql);
	    pr.setString(1, updateIngredientName);
	    pr.setString(2, updateIngredientUnit);
	    pr.setInt(3, Integer.parseInt(updateIngredientId));
	    pr.executeUpdate();
	} catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	} finally {
	    disconnect();
	}
    }

    public ArrayList<ShopIngredient> getListShopIngredient(String shopId) {
	ArrayList<ShopIngredient> listShopIngredient = new ArrayList<ShopIngredient>();
	String sql = " select Ingredient.ingId, ingName, ingUnit, ingQuantity " + " from dbo.Ingredient inner join dbo.ShopIngredient "
	        + " on dbo.Ingredient.ingId = dbo.ShopIngredient.ingId " + " where shopId = ? ";
	try {
	    PreparedStatement pr = connect().prepareStatement(sql);
	    pr.setString(1, shopId);
	    ResultSet rs = pr.executeQuery();
	    while (rs.next()) {
		// System.out.println(rs.getString("ingName"));
		ShopIngredient shopIngredient = new ShopIngredient();
		shopIngredient.setIngredientId(rs.getInt("ingId"));
		shopIngredient.setShopIngName(rs.getString("ingName"));
		shopIngredient.setShopIngUnit(rs.getString("ingUnit"));
		shopIngredient.setShopIngQuantity(rs.getInt("ingQuantity"));
		listShopIngredient.add(shopIngredient);
	    }
	    return listShopIngredient;
	} catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	} finally {
	    disconnect();
	}
	return listShopIngredient;
    }

    public ArrayList<ShopIngredient> getListShopIngredientCS() {
	ArrayList<ShopIngredient> ingredientList = new ArrayList<ShopIngredient>();
	String sql = String.format("SELECT ingId, ingName, ingUnit, 0 AS quantity FROM Ingredient");
	try {
	    connect();
	    ResultSet rs = executeQuery(sql);
	    while (rs.next()) {
		ShopIngredient ingredient = new ShopIngredient();
		ingredient.setIngredientId(rs.getInt("ingId"));
		ingredient.setShopIngName(rs.getString("ingName"));
		ingredient.setShopIngUnit(rs.getString("ingUnit"));
		ingredient.setShopIngQuantity(rs.getInt("quantity"));
		ingredientList.add(ingredient);
	    }
	} catch (SQLException e) {
	} finally {
	    disconnect();
	}
	return ingredientList;
    }

	/*
	 * private int ingID; private ArrayList<Ingredient> ingredientList; private
	 * Ingredient ingredient;
	 * 
	 * public int getIngredientID(String ingName) {
	 * 
	 * 
	 * try { connect(); String sql = String.format(
	 * "SELECT ingID FROM Ingredient "); ResultSet rs = executeQuery(sql);
	 * 
	 * while (rs.next()) { ingID = rs.getInt("ingID"); }
	 * 
	 * } catch (SQLException e) { e.printStackTrace();
	 * 
	 * } finally { disconnect(); } return ingID;
	 * 
	 * }
	 */

	public ArrayList<Ingredient> loadIngredient() {
		ArrayList<Ingredient> ingredientList = new ArrayList<>();
		Ingredient ingredient;

		try {
			connect();
			String sql = String.format("SELECT ingID, ingName FROM Ingredient");
			ResultSet rs = executeQuery(sql);

			while (rs.next()) {
				ingredient = new Ingredient();
				ingredient.setIngID(rs.getInt("ingID"));
				ingredient.setIngName(rs.getString("ingName"));
				ingredientList.add(ingredient);
			}

		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			disconnect();
		}

		return ingredientList;
	}
}
