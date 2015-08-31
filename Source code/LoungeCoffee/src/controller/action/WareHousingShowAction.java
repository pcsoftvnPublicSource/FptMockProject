package controller.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.Ingredient;
import model.bo.IngredientBO;
import model.form.WareHousingForm;

public class WareHousingShowAction extends Action {
	public ActionForward execute(ActionMapping mapping, org.apache.struts.action.ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		// Check permission
		try {

			HttpSession session = request.getSession();
			int permission = (int) session.getAttribute("permission");

			if (permission == -1) {
				return mapping.findForward("index");

			} else {
				// do some things
			}

		} catch (NullPointerException e) {
			e.printStackTrace();
			return mapping.findForward("index");
		}

		WareHousingForm whr = (WareHousingForm) form;
		IngredientBO ingBO = new IngredientBO();
		ArrayList<Ingredient> list = ingBO.loadIngredient();
		whr.setIngredientList(list);

		return mapping.findForward("inputWareHousing");

	}
}
