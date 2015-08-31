package model.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import model.bean.Ingredient;

public class IngredientForm extends ActionForm {
	private String ingredientName;
	private String chooseIngUnit;
	private String ingredientSearch = "";
	private ArrayList<String> ingUnitList;
	private ArrayList<Ingredient> listIngredient;
	private long listIngLeng;
	private String addIngredient;
	private String deleteIngredientId;
	private String detailIngredientName;
	private String detailChooseIngUnit;
	private String updateIngredientId;
	private String errorInputNameIng;
	private static final long serialVersionUID = 1L;

	public long getListIngLeng() {
		return listIngLeng;
	}

	public void setListIngLeng(long listIngLeng) {
		this.listIngLeng = listIngLeng;
	}

	public String getErrorInputNameIng() {
		return errorInputNameIng;
	}

	public void setErrorInputNameIng(String errorInputNameIng) {
		this.errorInputNameIng = errorInputNameIng;
	}

	public String getIngredientName() {
		return ingredientName;
	}

	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}

	public String getChooseIngUnit() {
		return chooseIngUnit;
	}

	public void setChooseIngUnit(String chooseIngUnit) {
		this.chooseIngUnit = chooseIngUnit;
	}

	public ArrayList<String> getIngUnitList() {
		return ingUnitList;
	}

	public void setIngUnitList(ArrayList<String> ingUnitList) {
		this.ingUnitList = ingUnitList;
	}

	public ArrayList<Ingredient> getListIngredient() {
		return listIngredient;
	}

	public void setListIngredient(ArrayList<Ingredient> listIngredient) {
		this.listIngredient = listIngredient;
	}

	public String getIngredientSearch() {
		return ingredientSearch;
	}

	public void setIngredientSearch(String ingredientSearch) {
		this.ingredientSearch = ingredientSearch;
	}

	public String getAddIngredient() {
		return addIngredient;
	}

	public void setAddIngredient(String addIngredient) {
		this.addIngredient = addIngredient;
	}

	public String getDeleteIngredientId() {
		return deleteIngredientId;
	}

	public void setDeleteIngredientId(String deleteIngredientId) {
		this.deleteIngredientId = deleteIngredientId;
	}

	public String getDetailIngredientName() {
		return detailIngredientName;
	}

	public void setDetailIngredientName(String detailIngredientName) {
		this.detailIngredientName = detailIngredientName;
	}

	public String getDetailChooseIngUnit() {
		return detailChooseIngUnit;
	}

	public void setDetailChooseIngUnit(String detailChooseIngUnit) {
		this.detailChooseIngUnit = detailChooseIngUnit;
	}

	public String getUpdateIngredientId() {
		return updateIngredientId;
	}

	public void setUpdateIngredientId(String updateIngredientId) {
		this.updateIngredientId = updateIngredientId;
	}

	@Override
	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.validate(mapping, request);
	}

	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		super.reset(mapping, request);
	}

}
