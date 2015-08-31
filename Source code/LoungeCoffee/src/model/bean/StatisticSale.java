package model.bean;

/**
 * StatisticSale
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Store the detail for statistic sale screen
 *
 * Copyright (c) 2015, AnhCT
 *
 */

public class StatisticSale {

    // Properties
    private String shopID;
    private String foodName;
    private int quantity;
    private double amount;

    // Encapsulate fields
    public String getFoodName() {
        return foodName;
    }

    public String getShopID() {
        return shopID;
    }

    public void setShopID(String shopID) {
        this.shopID = shopID;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

}
