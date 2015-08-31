package model.bean;

public class Ingredient {
	private int ingredientId;
	private String ingredientName;
	private String ingredientUnit;


	public int getIngredientId() {
		return ingredientId;
	}

	public void setIngredientId(int ingredientId) {
		this.ingredientId = ingredientId;
	}

	public String getIngredientName() {
		return ingredientName;
	}

	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}

	public String getIngredientUnit() {
		return ingredientUnit;
	}

	public void setIngredientUnit(String ingredientUnit) {
		this.ingredientUnit = ingredientUnit;
	}

    private int ingID = 0;
    private String ingName = "";
    private String ingUnit = "";

	public int getIngID() {
		return ingID;
	}

	public void setIngID(int ingID) {
		this.ingID = ingID;
	}

	public String getIngName() {
		return ingName;
	}

	public void setIngName(String ingName) {
		this.ingName = ingName;
	}

	public String getIngUnit() {
		return ingUnit;
	}

	public void setIngUnit(String ingUnit) {
		this.ingUnit = ingUnit;
	}

}
