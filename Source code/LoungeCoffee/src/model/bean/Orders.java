package model.bean;

/**
 * Orders
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Mapping to Orders table in database
 *
 * Copyright (c) 2015, name
 *
 */

public class Orders {

    // Properties
    private double ordersNo;
    private String ordersDate;
    private String shopID;
    private double ordersAmount;

    // Encapsulate fields
    public double getOrdersNo() {
        return ordersNo;
    }

    public void setOrdersNo(double ordersNo) {
        this.ordersNo = ordersNo;
    }

    public String getOrdersDate() {
        return ordersDate;
    }

    public void setOrdersDate(String ordersDate) {
        this.ordersDate = ordersDate;
    }

    public String getShopID() {
        return shopID;
    }

    public void setShopID(String shopID) {
        this.shopID = shopID;
    }

    public double getOrdersAmount() {
        return ordersAmount;
    }

    public void setOrdersAmount(double ordersAmount) {
        this.ordersAmount = ordersAmount;
    }

}
