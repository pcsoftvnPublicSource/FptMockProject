package model.form;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

import model.bean.CusOrdersDetail;
import model.bean.Food;
import model.bean.FoodType;

//type _comment to add generic comment here

public class SaleForm extends ActionForm {
	private int foodTypeID = 0;
    private ArrayList<FoodType> listFoodType;

    private ArrayList<Food> listFood;

    private int foodID;
    private int ordersQuantity;

    private double id;

    private double ordersAmount;

    private double ordersTotalPay;
    private double ordersReCash;

    private ArrayList<CusOrdersDetail> listCusOrdersDetail;

    public int getFoodTypeID() {
        return foodTypeID;
    }

    public void setFoodTypeID(int foodTypeID) {
        this.foodTypeID = foodTypeID;
    }

    public ArrayList<FoodType> getListFoodType() {
        return listFoodType;
    }

    public void setListFoodType(ArrayList<FoodType> listFoodType) {
        this.listFoodType = listFoodType;
    }

    public ArrayList<Food> getListFood() {
        return listFood;
    }

    public void setListFood(ArrayList<Food> listFood) {
        this.listFood = listFood;
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

    public double getId() {
        return id;
    }

    public void setId(double id) {
        this.id = id;
    }

    public double getOrdersAmount() {
        return ordersAmount;
    }

    public void setOrdersAmount(double ordersAmount) {
        this.ordersAmount = ordersAmount;
    }

    public double getOrdersTotalPay() {
        return ordersTotalPay;
    }

    public void setOrdersTotalPay(double ordersTotalPay) {
        this.ordersTotalPay = ordersTotalPay;
    }

    public double getOrdersReCash() {
        return ordersReCash;
    }

    public void setOrdersReCash(double ordersReCash) {
        this.ordersReCash = ordersReCash;
    }

    public ArrayList<CusOrdersDetail> getListCusOrdersDetail() {
        return listCusOrdersDetail;
    }

    public void setListCusOrdersDetail(ArrayList<CusOrdersDetail> listCusOrdersDetail) {
        this.listCusOrdersDetail = listCusOrdersDetail;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    private static final long serialVersionUID = 1L;
}
