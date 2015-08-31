package controller.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.ShopIngredient;
import model.bean.ShopName;
import model.bo.IngredientBO;
import model.bo.ShopBO;
import model.form.ShopIngredientForm;

public class ShopIngredientAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// Change encoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// Check permission
		try {
			HttpSession session = request.getSession();
			int permission = (int) session.getAttribute("permission");

			if (permission == -1) {
				return mapping.findForward("index");

			} else {
				// do some things
			}

		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("index");
		}

		ShopIngredientForm shopIngredientForm = (ShopIngredientForm) form;
		ShopBO shopBO = new ShopBO();
		IngredientBO ingredientBO = new IngredientBO();
		ArrayList<ShopName> shopNameList = new ArrayList<ShopName>();

		shopNameList = shopBO.getListShopName();
		shopIngredientForm.setShopNameList(shopNameList);

		String shopId = shopIngredientForm.getShopId();
		String addresssShop = shopBO.getAddressShop(shopId);

		shopIngredientForm.setAddresssShop(addresssShop);
		ArrayList<ShopIngredient> listShopIngredient = new ArrayList<ShopIngredient>();

		listShopIngredient = ingredientBO.getListShopIngredient(shopId);
		shopIngredientForm.setListShopIngredient(listShopIngredient);

		return mapping.findForward("forwardMe");
	}
}
