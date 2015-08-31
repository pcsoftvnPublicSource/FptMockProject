package model.bo;

import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.Shop;
import model.dao.ShopListDAO;

public class ShopListBO {

    ShopListDAO shopDAO = new ShopListDAO();

    public ArrayList<Shop> getAllShop() throws SQLException {
        // TODO Auto-generated method stub
        return shopDAO.getAllShop();
    }

    public boolean addShop(Shop shop) {
        // TODO Auto-generated method stub
        return shopDAO.addShop(shop);
    }

    public Shop getDetailShop(String shopID) throws SQLException {
        return shopDAO.getDetailShop(shopID);
    }

    public int updateShop(Shop shop) {
        // TODO Auto-generated method stub
        return shopDAO.updateShop(shop);
    }

    public void deleteShop(String shopID) {
        // TODO Auto-generated method stub
        shopDAO.deleteShop(shopID);
    }

    public boolean checkShopID(String shopID) throws SQLException {
        // TODO Auto-generated method stub
        return shopDAO.checkShopID(shopID);
    }

}
