package model.form;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

import model.bean.Ingredient;

//type _comment to add generic comment here

public class WareHousingForm extends ActionForm {

	private static final long serialVersionUID = 1L;

	private String dateTime = "";

	private ArrayList<Ingredient> ingredientList = new ArrayList<>();

	private String ingID = "";
	private String idTmpImportReceipt = "";
	private String price = "";
	private String quantity = "";
	private int isSuccess = 0;

	public String getDateTime() {
		return dateTime;
	}

	public void setDateTime(String dateTime) {
		this.dateTime = dateTime;
	}

	public ArrayList<Ingredient> getIngredientList() {
		return ingredientList;
	}

	public void setIngredientList(ArrayList<Ingredient> ingredientList) {
		this.ingredientList = ingredientList;
	}

	public String getIngID() {
		return ingID;
	}

	public void setIngID(String ingID) {
		this.ingID = ingID;
	}

	public String getIdTmpImportReceipt() {
		return idTmpImportReceipt;
	}

	public void setIdTmpImportReceipt(String idTmpImportReceipt) {
		this.idTmpImportReceipt = idTmpImportReceipt;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public int getIsSuccess() {
		return isSuccess;
	}

	public void setIsSuccess(int isSuccess) {
		this.isSuccess = isSuccess;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}