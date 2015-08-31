package model.bean;

/**
 * FoodType
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Mapping to FoodType table in database
 *
 * Copyright (c) 2015, AnhCT
 *
 */

public class FoodType {

    // Properties
    private int foodTypeID;
    private String foodTypeName;

    // Encapsutale fields
    public int getFoodTypeID() {
        return foodTypeID;
    }

    public void setFoodTypeID(int foodTypeID) {
        this.foodTypeID = foodTypeID;
    }

    public String getFoodTypeName() {
        return foodTypeName;
    }

    public void setFoodTypeName(String foodTypeName) {
        this.foodTypeName = foodTypeName;
    }

}
