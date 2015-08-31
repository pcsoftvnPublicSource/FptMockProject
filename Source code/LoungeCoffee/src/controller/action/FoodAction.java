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

import model.bean.FoodT;
import model.bean.FoodTypeNew;
import model.bean.FoodTypeT;
import model.bo.FoodBO;
import model.form.FoodForm;

public class FoodAction extends Action {
    /**
     * Action to show element on Food.jsp Get data for list food, list type of
     * food.
     */
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

		} catch (NullPointerException e) {
			e.printStackTrace();
			return mapping.findForward("index");
		}

		FoodForm foodForm = (FoodForm) form;
		FoodBO foodBO = new FoodBO();

		// Get food type list
		ArrayList<String> foodTypeList = new ArrayList<String>();
		foodTypeList = foodBO.getFoodTypeList();
		foodForm.setFoodTypeList(foodTypeList);

		// Get food type id
		ArrayList<FoodTypeT> foodTypeListId = new ArrayList<FoodTypeT>();
		foodTypeListId = foodBO.getFoodTypeListId();
		foodForm.setFoodTypeIdList(foodTypeListId);

		// Search food
		ArrayList<FoodT> listFood = new ArrayList<FoodT>();
		String searchFoodText = foodForm.getFoodSearch();
		listFood = foodBO.getListFood(searchFoodText);
		foodForm.setListFood(listFood);

		// New food type
		ArrayList<FoodTypeNew> listNewFoodType = new ArrayList<FoodTypeNew>();
		listNewFoodType = foodBO.getListNewFoodType();
		foodForm.setListNewFoodType(listNewFoodType);

		return mapping.findForward("forwardMe");
    }
}
