package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.Shop;
import model.bean.StatisticSale;

//type _comment to add generic comment here

public class StatisticSaleDAO extends BaseDAO {

    // Default constructor
    public StatisticSaleDAO() {
        super();
    }

    public ArrayList<Shop> getListShop() {

        ArrayList<Shop> listShop = new ArrayList<>();
        Shop s;

        try {

            connect();
            String sql = String.format("SELECT shopID, shopName FROM Shop WHERE shopID <> 'lounge'");
            ResultSet rs = executeQuery(sql);

            while (rs.next()) {
                s = new Shop();
                s.setShopID(rs.getString("shopID"));
                s.setShopName(rs.getString("shopName"));
                listShop.add(s);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            disconnect();
        }

        return listShop;
    }


    public ArrayList<StatisticSale> getAllShopSale(String startDate, String endDate) {
        ArrayList<StatisticSale> shopList = new ArrayList<>();
        StatisticSale s;

        try {
            connect();
            String functionCall = String.format("shopStatistics('%s','%s') ", startDate, endDate);
            ResultSet rs = executeFunction(functionCall);

            while (rs.next()) {
                s = new StatisticSale();
                s.setShopID(rs.getString("shopID"));
                s.setAmount(rs.getDouble("amount"));
                shopList.add(s);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            disconnect();
        }

        return shopList;
    }

    public ArrayList<StatisticSale> getShopSaleData(String shopID, String startDate, String endDate) {
        ArrayList<StatisticSale> saleData = new ArrayList<>();
        StatisticSale s;

        try {
            connect();
            String functionCall = String.format("shopQuantityStatistics('%s','%s','%s') ", startDate, endDate, shopID);
            ResultSet rs = executeFunction(functionCall);

            while (rs.next()) {
                s = new StatisticSale();
                s.setFoodName(rs.getString("foodName"));
                s.setQuantity(rs.getInt("Quantity"));
                s.setAmount(rs.getDouble("Amount"));
                saleData.add(s);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            disconnect();
        }

        return saleData;
    }

}