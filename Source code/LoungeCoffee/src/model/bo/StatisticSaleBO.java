package model.bo;

import java.util.ArrayList;

import model.bean.Shop;
import model.bean.StatisticSale;
import model.dao.StatisticSaleDAO;

public class StatisticSaleBO {

    public ArrayList<Shop> getListShop() {
        StatisticSaleDAO statisticSaleDAO = new StatisticSaleDAO();
        return statisticSaleDAO.getListShop();
    }


    public ArrayList<StatisticSale> getAllShopSale(String startDate, String endDate) {
        StatisticSaleDAO statisticSaleDAO = new StatisticSaleDAO();
        return statisticSaleDAO.getAllShopSale(startDate, endDate);
    }

    public ArrayList<StatisticSale> getShopSaleData(String shopID, String startDate, String endDate) {
        StatisticSaleDAO statisticSaleDAO = new StatisticSaleDAO();
        return statisticSaleDAO.getShopSaleData(shopID, startDate, endDate);
    }

}