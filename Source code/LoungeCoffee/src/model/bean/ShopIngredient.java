package model.bean;

public class ShopIngredient {
    private int ingredientId;
    private String shopIngName;
    private String shopIngUnit;
    private int shopIngQuantity;
    private int quantity;

    public int getIngredientId() {
	return ingredientId;
    }

    public void setIngredientId(int ingredientId) {
	this.ingredientId = ingredientId;
    }

    public int getQuantity() {
	return quantity;
    }

    public void setQuantity(int quantity) {
	this.quantity = quantity;
    }

    public String getShopIngName() {
	return shopIngName;
    }

    public void setShopIngName(String shopIngName) {
	this.shopIngName = shopIngName;
    }

    public String getShopIngUnit() {
	return shopIngUnit;
    }

    public void setShopIngUnit(String shopIngUnit) {
	this.shopIngUnit = shopIngUnit;
    }

    public int getShopIngQuantity() {
	return shopIngQuantity;
    }

    public void setShopIngQuantity(int shopIngQuantity) {
	this.shopIngQuantity = shopIngQuantity;
    }

}
