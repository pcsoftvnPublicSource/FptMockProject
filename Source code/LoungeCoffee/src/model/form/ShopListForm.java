package model.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import model.bean.Shop;

public class ShopListForm extends ActionForm {
    /**
     *
     */
    private static final long serialVersionUID = 1L;
    private String shopID;
    private String shopName;
    private String shopAddress;
    private String shopPhoneNumber;
    private String shopPassword;
    private String managerName;
    private String managerAddress;
    private String managerPhoneNumber;
    private String error;
    private ArrayList<Shop> shopList;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public ShopListForm() {
        super();
        // TODO Auto-generated constructor stub
    }

    public String getShopID() {
        return shopID;
    }

    public void setShopID(String shopID) {
        this.shopID = shopID;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getShopAddress() {
        return shopAddress;
    }

    public void setShopAddress(String shopAddress) {
        this.shopAddress = shopAddress;
    }

    public String getShopPhoneNumber() {
        return shopPhoneNumber;
    }

    public void setShopPhoneNumber(String shopPhoneNumber) {
        this.shopPhoneNumber = shopPhoneNumber;
    }

    public String getShopPassword() {
        return shopPassword;
    }

    public void setShopPassword(String shopPassword) {
        this.shopPassword = shopPassword;
    }

    public String getManagerAddress() {
        return managerAddress;
    }

    public void setManagerAddress(String managerAddress) {
        this.managerAddress = managerAddress;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerPhoneNumber() {
        return managerPhoneNumber;
    }

    public void setManagerPhoneNumber(String managerPhoneNumber) {
        this.managerPhoneNumber = managerPhoneNumber;
    }

    public ArrayList<Shop> getShopList() {
        return shopList;
    }

    public void setShopList(ArrayList<Shop> shopList) {
        this.shopList = shopList;
    }

    @Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
        // TODO Auto-generated method stub
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        super.reset(mapping, request);
    }

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        // TODO Auto-generated method stub
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return super.validate(mapping, request);
    }
}
