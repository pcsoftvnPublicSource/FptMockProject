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
import model.bo.IngredientBO;
import model.bo.ShopBO;
import model.form.ShopIngredientCSForm;

public class ShopIngredientCSAction extends Action {
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

		ShopIngredientCSForm shopIngredientForm = (ShopIngredientCSForm) form;
		ShopBO shopBO = new ShopBO();
		IngredientBO ingredientBO = new IngredientBO();

		HttpSession session = request.getSession();
	    String shopId = (String) session.getAttribute("shopID");


	    String addresssShop = shopBO.getAddressShop(shopId);

	    shopIngredientForm.setAddresssShop(addresssShop);
	    ArrayList<ShopIngredient> listShopIngredient = new ArrayList<ShopIngredient>();
	    listShopIngredient = ingredientBO.getListShopIngredient(shopId);
	    shopIngredientForm.setListShopIngredient(listShopIngredient);

	    ArrayList<ShopIngredient> listShopIngredientCS = new ArrayList<ShopIngredient>();
	    listShopIngredientCS = ingredientBO.getListShopIngredientCS();
	    ArrayList<Integer> listCS = new ArrayList<Integer>();

	    for (int i = 0; i < listShopIngredientCS.size(); i++) {
			listCS.add(listShopIngredientCS.get(i).getShopIngQuantity());
	    }
	    shopIngredientForm.setListShopIngCS(listCS);

	    String listSCS = shopIngredientForm.getListSCS();
	    String listSCSId = shopIngredientForm.getListSCSId();

	    if (listSCS != null && listSCSId != null && !("".equals(listSCS)) && (!"".equals(listSCSId))) {
			String sCS[] = listSCS.split("_");
			String sCSId[] = listSCSId.split("_");
			shopBO.inputCS(sCSId, sCS, shopId);
	    }

	    return mapping.findForward("forwardMe");
    }
}
