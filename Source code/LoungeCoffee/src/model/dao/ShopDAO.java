package model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.ShopName;

public class ShopDAO extends BaseDAO {

    public ArrayList<ShopName> getListShopName() {
	ArrayList<ShopName> listShopName = new ArrayList<ShopName>();
        String sql = "select shopId, shopName from dbo.Shop WHERE shopID <> 'lounge'";
	try {
	    PreparedStatement pr = connect().prepareStatement(sql);
	    ResultSet rs = pr.executeQuery();
	    while (rs.next()) {
		ShopName shopName = new ShopName();
		shopName.setShopId(rs.getString("shopId"));
		shopName.setShopName(rs.getString("shopName"));
		listShopName.add(shopName);
	    }
	    return listShopName;
	} catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	} finally {
	    disconnect();
	}
	return listShopName;
    }

    public String getAddressShop(String shopId) {
	String sql = "select shopAddress from Shop where shopId = ?";
	String address = "";
	try {
	    PreparedStatement pr = connect().prepareStatement(sql);
	    pr.setString(1, shopId);
	    ResultSet rs = pr.executeQuery();
	    while (rs.next()) {
		address = rs.getString("shopAddress");
	    }
	    return address;
	} catch (SQLException e) {
	    // TODO Auto-generated catch block
	    e.printStackTrace();
	} finally {
	    disconnect();
	}

	return address;
    }

    /**
     * @param sCSId
     * @param sCS
     * @param shopId
     * @return
     */
    public void inputCS(String[] sCSId, String[] sCS, String shopId) {

	try {
	    connect();
	    for (int i = 1; i < sCSId.length; i++) {
		String sql = String.format("SP_TmpConsumeReceiptDetail_INSERT %s, %s, '%s'", Long.parseLong(sCSId[i]),
		        Float.parseFloat(sCS[i]), shopId);
		executeStoreProcedure(sql);
	    }
	    String sql = String.format("SP_ConsumeReceiptDetail_INSERT '%s'", shopId);
	    executeStoreProcedure(sql);
	} finally {
	    disconnect();
	}

    }
}
