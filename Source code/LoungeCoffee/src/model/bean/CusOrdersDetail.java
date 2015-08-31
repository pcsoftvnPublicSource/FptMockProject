package model.bean;

/**
 * CusOrdersDetail
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Store a detail of selected food for sale screen
 *
 * Copyright (c) 2015, AnhCT
 *
 */

public class CusOrdersDetail {

    // Properties
    private double id;
    private int foodID;
    private String foodName;
    private double foodPrice;
    private int ordersQuantity;
    private double ordersTotalPrice;

    // Encapsulate fields
    public double getId() {
        return id;
    }

    public void setId(double id) {
        this.id = id;
    }

    public double getOrdersTotalPrice() {
        return ordersTotalPrice;
    }

    public void setOrdersTotalPrice(double ordersTotalPrice) {
        this.ordersTotalPrice = ordersTotalPrice;
    }

    public int getFoodID() {
        return foodID;
    }

    public void setFoodID(int foodID) {
        this.foodID = foodID;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public double getFoodPrice() {
        return foodPrice;
    }

    public void setFoodPrice(double foodPrice) {
        this.foodPrice = foodPrice;
    }

    public int getOrdersQuantity() {
        return ordersQuantity;
    }

    public void setOrdersQuantity(int ordersQuantity) {
        this.ordersQuantity = ordersQuantity;
    }
}
