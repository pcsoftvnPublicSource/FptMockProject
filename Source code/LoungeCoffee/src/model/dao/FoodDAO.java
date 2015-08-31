package model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import model.bean.FoodT;
import model.bean.FoodTypeT;
import model.bean.FoodTypeNew;

public class FoodDAO extends BaseDAO {

	public ArrayList<String> getFoodTypeList() {
		ArrayList<String> foodTypeList = new ArrayList<String>();
		String sql = "select foodTypeName from dbo.FoodType";
		try {
			PreparedStatement pr = connect().prepareStatement(sql);
			ResultSet rs = pr.executeQuery();
			while (rs.next()) {
				foodTypeList.add(rs.getString("foodTypeName"));
			}
			return foodTypeList;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return foodTypeList;
	}

	public ArrayList<FoodT> getListFood(String searchFoodText) {
		ArrayList<FoodT> foodList = new ArrayList<FoodT>();
		String sql = String.format("SELECT * FROM searchFood(N'%s')", searchFoodText);
		try {
			connect();
			ResultSet rs = executeQuery(sql);
			while (rs.next()) {
				FoodT foodT = new FoodT();
				foodT.setFoodId(rs.getString("foodId"));
				foodT.setFoodName(rs.getString("foodName"));
				foodT.setFoodType(rs.getString("foodTypeName"));
				foodT.setFoodTypeId(rs.getString("foodTypeId"));
				String foodPriceS = rs.getString("foodPrice");
				double foodPriceD = Double.parseDouble(foodPriceS);
				DecimalFormat format = new DecimalFormat("0.#");
				foodPriceS = format.format(foodPriceD);
				foodT.setFoodPrice(foodPriceS);
				foodList.add(foodT);
			}
			return foodList;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return foodList;
	}

	public ArrayList<FoodTypeNew> getListNewFoodType() {
		ArrayList<FoodTypeNew> foodTypeNewList = new ArrayList<FoodTypeNew>();
		String sql = "select foodTypeId, foodTypeName from dbo.FoodType";
		try {
			PreparedStatement pr = connect().prepareStatement(sql);
			ResultSet rs = pr.executeQuery();
			while (rs.next()) {
				FoodTypeNew foodTypeNew = new FoodTypeNew();
				foodTypeNew.setFoodTypeNewId(rs.getString("foodTypeId"));
				foodTypeNew.setFoodTypeNewName(rs.getString("foodTypeName"));
				foodTypeNewList.add(foodTypeNew);
			}
			return foodTypeNewList;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return foodTypeNewList;
	}

	public void insertFood(String foodName, String foodTypeId, double foodPrice) {
		try {
			connect();
			// System.out.println(foodTypeId);
			int foodTypeIdInt = Integer.parseInt(foodTypeId);
			String sql = String.format("SP_Food_INSERT N'%s', %d , %f", foodName, foodTypeIdInt, foodPrice);
			executeStoreProcedure(sql);
		} finally {
			disconnect();
		}
	}

	public ArrayList<FoodTypeT> getFoodTypeListId() {
		ArrayList<FoodTypeT> foodTypeListId = new ArrayList<FoodTypeT>();
		String sql = "select foodTypeId, foodTypeName from dbo.FoodType";
		try {
			PreparedStatement pr = connect().prepareStatement(sql);
			ResultSet rs = pr.executeQuery();
			while (rs.next()) {
				FoodTypeT foodTypeT = new FoodTypeT();
				foodTypeT.setFoodTypeId(rs.getString("foodTypeId"));
				foodTypeT.setFoodTypeName(rs.getString("foodTypeName"));
				foodTypeListId.add(foodTypeT);
			}
			return foodTypeListId;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return foodTypeListId;
	}

	public void updateFood(String updateFoodId, String detailFoodName, String detailChooseFoodType,
			String detailFoodPrice) {
		try {
			connect();
			int foodId = Integer.parseInt(updateFoodId);
			int foodTypeIdInt = getFoodTypeId(detailChooseFoodType);
			System.out.println(foodTypeIdInt);
			String sql = String.format("SP_Food_UPDATE %d, N'%s' , %d , %s ", foodId, detailFoodName, foodTypeIdInt,
					detailFoodPrice);
			executeStoreProcedure(sql);
		} finally {
			disconnect();
		}
	}
	
	public int getFoodTypeId(String foodTypeName){
		String sql = String.format("SELECT * FROM returnFoodTypeId(N'%s')", foodTypeName);
		int foodTypeId = 0;
		try {
			connect();
			ResultSet rs = executeQuery(sql);
			if (rs.next()) {
				foodTypeId = rs.getInt(1);
			}
			return foodTypeId;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return foodTypeId;
	}

	public void deleteFood(String foodId) {
		try {
			connect();
			// System.out.println(foodTypeId);
			int foodIdInt = Integer.parseInt(foodId);
			String sql = String.format("SP_Food_DELETE %d ",foodIdInt);
			executeStoreProcedure(sql);
		} finally {
			disconnect();
		}
		
	}

}
