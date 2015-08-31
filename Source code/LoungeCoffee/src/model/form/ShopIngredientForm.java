package model.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import model.bean.ShopIngredient;
import model.bean.ShopName;

public class ShopIngredientForm extends ActionForm {
	private String shopId;
	private ArrayList<ShopName> shopNameList;
	private ArrayList<ShopIngredient> listShopIngredient;
	private String addresssShop;
	private static final long serialVersionUID = 1L;

	public String getShopId() {
		return shopId;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

	public ArrayList<ShopName> getShopNameList() {
		return shopNameList;
	}

	public void setShopNameList(ArrayList<ShopName> shopNameList) {
		this.shopNameList = shopNameList;
	}

	public ArrayList<ShopIngredient> getListShopIngredient() {
		return listShopIngredient;
	}

	public void setListShopIngredient(ArrayList<ShopIngredient> listShopIngredient) {
		this.listShopIngredient = listShopIngredient;
	}

	public String getAddresssShop() {
		return addresssShop;
	}

	public void setAddresssShop(String addresssShop) {
		this.addresssShop = addresssShop;
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
