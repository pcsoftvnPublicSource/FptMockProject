package model.bean;

/**
 * OrdersDetail
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Mapping to OrdersDetail table in database
 *
 * Copyright (c) 2015, AnhCt
 *
 */

public class OrdersDetail {

    // Properties
    private double ordersNo;
    private int foodID;
    private int ordersQuantity;

    // Encapsulate fields
    public double getOrdersNo() {
        return ordersNo;
    }

    public void setOrdersNo(double ordersNo) {
        this.ordersNo = ordersNo;
    }

    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public int getOrdersQuantity() {
        return ordersQuantity;
    }

    public void setOrdersQuantity(int ordersQuantity) {
        this.ordersQuantity = ordersQuantity;
    }

}
