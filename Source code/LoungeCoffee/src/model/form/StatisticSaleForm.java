package model.form;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

import model.bean.Shop;

/**
 * StatisticSaleForm
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Form-bean for statistic sale screen
 *
 * Copyright (c) 2015, AnhCT
 *
 */

public class StatisticSaleForm extends ActionForm {

    // Properties
    private String shopID;
    private ArrayList<Shop> listShop;
    private String startDate;
    private String endDate;

    // Encapsulate fields
    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getShopID() {
        return shopID;
    }

    public void setShopID(String shopID) {
        this.shopID = shopID;
    }

    public ArrayList<Shop> getListShop() {
        return listShop;
    }

    public void setListShop(ArrayList<Shop> listShop) {
        this.listShop = listShop;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    private static final long serialVersionUID = 1L;
}