package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.Shop;

public class ShopListDAO extends BaseDAO {
    Shop shop;

    public ArrayList<Shop> getAllShop() throws SQLException {
        // TODO Auto-generated method stub
        ArrayList<Shop> shopList = new ArrayList<>();
        try {
            connect();
			String sql = String.format("SELECT * FROM Shop WHERE shopID <> 'lounge'");
            ResultSet rs = executeQuery(sql);
            while (rs.next()) {
                shop = new Shop();
                shop.setShopID(rs.getString("shopID"));
                shop.setShopName(rs.getString("shopName"));
                shop.setShopAddress(rs.getString("shopAddress"));
                shop.setShopPassword(rs.getString("shopPassword"));
                shop.setManagerAddress(rs.getString("managerAddress"));
                shop.setManagerName(rs.getString("managerName"));
                shop.setManagerPhoneNumber(rs.getString("managerPhoneNumber"));
                shop.setShopPhoneNumber(rs.getString("shopPhoneNumber"));
                shopList.add(shop);
            }
        } finally {
            disconnect();
        }
        return shopList;
    }

    public boolean addShop(Shop shop2) {
        // TODO Auto-generated method stub
        try {
            connect();
            String sql = String.format("EXEC SP_Shop_INSERT '%s',N'%s',N'%s','%s','%s',N'%s',N'%s','%s'",
                    shop2.getShopID(), shop2.getShopName(), shop2.getShopAddress(), shop2.getShopPassword(),
                    shop2.getShopPhoneNumber(), shop2.getManagerName(), shop2.getManagerAddress(),
                    shop2.getManagerPhoneNumber());
            System.out.println(shop2.getShopID());
            System.out.println(shop2.getManagerName());
            System.out.println(shop2.getShopPassword());
            System.out.println(shop2.getShopName());
            System.out.println(shop2.getManagerAddress());
            System.out.println(shop2.getShopPhoneNumber());
            System.out.println(shop2.getShopAddress());
            System.out.println(shop2.getManagerPhoneNumber());
            return executeStoreProcedure(sql);
        } finally {
            disconnect();
        }
    }

    public Shop getDetailShop(String shopID) throws SQLException {
        try {
            connect();
            String sql = String.format("SELECT * FROM Shop WHERE shopID = '%s'", shopID);
            ResultSet rs = executeQuery(sql);
            while (rs.next()) {
                shop = new Shop();
                shop.setShopID(rs.getString("shopID"));
                shop.setShopName(rs.getString("shopName"));
                shop.setShopAddress(rs.getString("shopAddress"));
                shop.setShopPassword(rs.getString("shopPassword"));
                shop.setManagerAddress(rs.getString("managerAddress"));
                shop.setManagerName(rs.getString("managerName"));
                shop.setManagerPhoneNumber(rs.getString("managerPhoneNumber"));
                shop.setShopPhoneNumber(rs.getString("shopPhoneNumber"));
            }
        } finally {
            disconnect();
        }
        return shop;
    }

    public int updateShop(Shop shop2) {
        // TODO Auto-generated method stub
        try {
            connect();
            String sql = String.format(
                    "UPDATE Shop SET shopPassword='%s', shopName=N'%s', shopAddress = N'%s', shopPhoneNumber = '%s', managerName= N'%s', managerAddress= N'%s', managerPhoneNumber='%s' WHERE shopID = '%s'",
                    shop2.getShopPassword(), shop2.getShopName(), shop2.getShopAddress(), shop2.getShopPhoneNumber(),
                    shop2.getManagerName(), shop2.getManagerAddress(), shop2.getManagerPhoneNumber(),
                    shop2.getShopID());
            return executeUpdateQuery(sql);
        } finally {
            disconnect();
        }
    }

    public void deleteShop(String shopID) {
        // TODO Auto-generated method stub
        try {
            connect();
            String sql = String.format("DELETE FROM Shop WHERE shopID = '%s'", shopID);
            executeUpdateQuery(sql);
        } finally {
            disconnect();
        }
    }

    public boolean checkShopID(String shopID) throws SQLException {
        // TODO Auto-generated method stub
        boolean result = false;
        try {
            connect();
            String sql = String.format("SELECT * FROM Shop WHERE shopID = '%s'", shopID);
            ResultSet rs = executeQuery(sql);
            if (rs.next()) {
                result = true;
            }
        } finally {
            disconnect();
        }
        System.out.println(result);
        return result;
    }

}
