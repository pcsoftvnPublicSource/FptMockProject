package model.bo;

import java.util.ArrayList;

import model.bean.ShopName;
import model.dao.ShopDAO;

public class ShopBO {
    ShopDAO shopDAO = new ShopDAO();

    public ArrayList<ShopName> getListShopName() {
	return shopDAO.getListShopName();
    }

    public String getAddressShop(String shopId) {
	return shopDAO.getAddressShop(shopId);
    }

    /**
     * @param sCSId
     * @param sCS
     * @param shopId
     */
    public void inputCS(String[] sCSId, String[] sCS, String shopId) {
	shopDAO.inputCS(sCSId, sCS, shopId);
	
    }

}
