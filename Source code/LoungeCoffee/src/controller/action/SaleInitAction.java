package controller.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.FoodType;
import model.bo.SaleBO;
import model.form.SaleForm;

//type _comment to add generic comment here

public class SaleInitAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        SaleForm saleForm = (SaleForm) form;
        SaleBO saleBO = new SaleBO();

		// Get list of food type (food category)
        ArrayList<FoodType> listFoodType = saleBO.getFoodType();
        saleForm.setListFoodType(listFoodType);

		// Get all food in first time to load
		/*
		 * ArrayList<Food> listFood; listFood = saleBO.getAllFood();
		 * saleForm.setListFood(listFood);
		 */
		saleForm.setListFood(saleBO.getAllFood());

        return mapping.findForward("saleInited");
    }
}

