package controller.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.Food;
import model.bo.SaleBO;
import model.form.SaleForm;

//type _comment to add generic comment here

public class SaleGetFoodAction extends Action {

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

		// Support unicode encoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

        // Init variables
        SaleForm saleForm = (SaleForm) form;
        SaleBO saleBO = new SaleBO();

        // Get id of food type
        int foodTypeID = saleForm.getFoodTypeID();

        // Get foods base on foodTypeID
		ArrayList<Food> listFood;

		if (foodTypeID == 0) {
			listFood = saleBO.getAllFood();

		} else {
			listFood = saleBO.getFoodByFoodType(foodTypeID);

		}

        // Re-set data to form-bean to show
        saleForm.setListFood(listFood);

		// Returning data to ajax
		String s = "";
		for (Food f : listFood) {
			s += Integer.toString(f.getFoodID()) + "-" + f.getFoodName() + "-";
		}

		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		pw.print(s + "#");

		return null;
    }


	public void reset(ActionMapping mapping, HttpServletRequest request) {
		// Support unicode encoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public void validate(ActionMapping mapping, HttpServletRequest request) {
		// Support unicode encoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

}
