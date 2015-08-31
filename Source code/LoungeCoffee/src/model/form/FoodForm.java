package model.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import model.bean.FoodT;
import model.bean.FoodTypeNew;
import model.bean.FoodTypeT;

public class FoodForm extends ActionForm {

	private String foodName;
	private String chooseFoodType;
	private ArrayList<String> foodTypeList;
	private double foodPrice;
	private String foodSearch="";
	private ArrayList<FoodT> listFood;
	private String foodTypeNew;
	private ArrayList<FoodTypeNew> listNewFoodType;
	private String detailFoodName;
	private String detailChooseFoodType;
	private String detailFoodPrice;
	private String updateFoodId;
	private String deleteFoodId;
	private String detailFoodTypeName;
	private String updateFoodTypeId;
	private String deleteFoodTypeId;
	private String chooseFoodTypeId;
	private ArrayList<FoodTypeT> foodTypeIdList;
	private static final long serialVersionUID = 1L;

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getChooseFoodType() {
		return chooseFoodType;
	}

	public void setChooseFoodType(String chooseFoodType) {
		this.chooseFoodType = chooseFoodType;
	}

	public ArrayList<String> getFoodTypeList() {
		return foodTypeList;
	}

	public void setFoodTypeList(ArrayList<String> foodTypeList) {
		this.foodTypeList = foodTypeList;
	}

	public double getFoodPrice() {
		return foodPrice;
	}

	public void setFoodPrice(double foodPrice) {
		this.foodPrice = foodPrice;
	}

	public String getFoodSearch() {
		return foodSearch;
	}

	public void setFoodSearch(String foodSearch) {
		this.foodSearch = foodSearch;
	}

	public ArrayList<FoodT> getListFood() {
		return listFood;
	}

	public void setListFood(ArrayList<FoodT> listFood) {
		this.listFood = listFood;
	}

	public String getFoodTypeNew() {
		return foodTypeNew;
	}

	public void setFoodTypeNew(String foodTypeNew) {
		this.foodTypeNew = foodTypeNew;
	}

	public ArrayList<FoodTypeNew> getListNewFoodType() {
		return listNewFoodType;
	}

	public void setListNewFoodType(ArrayList<FoodTypeNew> listNewFoodType) {
		this.listNewFoodType = listNewFoodType;
	}

	public String getDetailFoodName() {
		return detailFoodName;
	}

	public void setDetailFoodName(String detailFoodName) {
		this.detailFoodName = detailFoodName;
	}

	public String getDetailChooseFoodType() {
		return detailChooseFoodType;
	}

	public void setDetailChooseFoodType(String detailChooseFoodType) {
		this.detailChooseFoodType = detailChooseFoodType;
	}

	public String getDetailFoodPrice() {
		return detailFoodPrice;
	}

	public void setDetailFoodPrice(String detailFoodPrice) {
		this.detailFoodPrice = detailFoodPrice;
	}

	public String getUpdateFoodId() {
		return updateFoodId;
	}

	public void setUpdateFoodId(String updateFoodId) {
		this.updateFoodId = updateFoodId;
	}

	public String getDeleteFoodId() {
		return deleteFoodId;
	}

	public void setDeleteFoodId(String deleteFoodId) {
		this.deleteFoodId = deleteFoodId;
	}

	public String getDetailFoodTypeName() {
		return detailFoodTypeName;
	}

	public void setDetailFoodTypeName(String detailFoodTypeName) {
		this.detailFoodTypeName = detailFoodTypeName;
	}

	public String getUpdateFoodTypeId() {
		return updateFoodTypeId;
	}

	public void setUpdateFoodTypeId(String updateFoodTypeId) {
		this.updateFoodTypeId = updateFoodTypeId;
	}

	public String getDeleteFoodTypeId() {
		return deleteFoodTypeId;
	}

	public void setDeleteFoodTypeId(String deleteFoodTypeId) {
		this.deleteFoodTypeId = deleteFoodTypeId;
	}

	public String getChooseFoodTypeId() {
		return chooseFoodTypeId;
	}

	public void setChooseFoodTypeId(String chooseFoodTypeId) {
		this.chooseFoodTypeId = chooseFoodTypeId;
	}

	public ArrayList<FoodTypeT> getFoodTypeIdList() {
		return foodTypeIdList;
	}

	public void setFoodTypeIdList(ArrayList<FoodTypeT> foodTypeIdList) {
		this.foodTypeIdList = foodTypeIdList;
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
