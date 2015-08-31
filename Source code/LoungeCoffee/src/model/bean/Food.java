package model.bean;

/**
 * Food
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Mapping to Food table in database
 *
 * Copyright (c) 2015, AnhCT
 *
 */

public class Food {

    // Properties
    private int foodID = 0;
    private String foodName = "";
    private int foodTypeID = 0;
    private double foodPrice = 0.0;

    // Encapsulate fields
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

    public int getFoodTypeID() {
        return foodTypeID;
    }

    public void setFoodTypeID(int foodTypeID) {
        this.foodTypeID = foodTypeID;
    }

    public double getFoodPrice() {
        return foodPrice;
    }

    public void setFoodPrice(double foodPrice) {
        this.foodPrice = foodPrice;
    }

}
