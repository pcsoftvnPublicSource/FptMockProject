package model.bean;

import java.math.BigDecimal;

public class ImportReceipt {

    private BigDecimal id;
    private int idTmpReceipt;
    private String shopID;
    private int ingID;
    private int impQuantity;
    private double impPrice;
    private String ingName;
    private String unit;
    private String dateTime;
    private String shopName;

    public ImportReceipt() {
        super();
        // TODO Auto-generated constructor stub
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public int getIdTmpReceipt() {
        return idTmpReceipt;
    }

    public void setIdTmpReceipt(int idTmpReceipt) {
        this.idTmpReceipt = idTmpReceipt;
    }

    public String getShopID() {
        return shopID;
    }

    public void setShopID(String shopID) {
        this.shopID = shopID;
    }

    public int getIngID() {
        return ingID;
    }

    public void setIngID(int i) {
        this.ingID = i;
    }

    public int getImpQuantity() {
        return impQuantity;
    }

    public void setImpQuantity(int impQuantity) {
        this.impQuantity = impQuantity;
    }

    public double getImpPrice() {
        return impPrice;
    }

    public void setImpPrice(double impPrice) {
        this.impPrice = impPrice;
    }

    public String getIngName() {
        return ingName;
    }

    public void setIngName(String ingName) {
        this.ingName = ingName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

}
