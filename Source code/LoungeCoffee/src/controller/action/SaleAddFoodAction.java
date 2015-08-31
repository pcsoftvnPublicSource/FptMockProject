package controller.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.CusOrdersDetail;
import model.bo.SaleBO;
import model.form.SaleForm;
import utilis.Utilis;

//type _comment to add generic comment here

public class SaleAddFoodAction extends Action {
    @Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

        SaleForm saleForm = (SaleForm) form;
        SaleBO saleBO = new SaleBO();
        HttpSession session = request.getSession();

        // Get current foodID and its quantity
        int foodID = saleForm.getFoodID();
        int ordersQuantity = saleForm.getOrdersQuantity();
        String shopID = (String) session.getAttribute("shopID");
        String s = "";

        if (ordersQuantity > 0) {

            // Insert to database
            saleBO.addRequestToOrder(foodID, ordersQuantity, shopID);

            // Retrieve last added-food
            CusOrdersDetail cus = saleBO.getLastAddedFood(shopID);

            // Get current order amount
            double ordersAmount = saleBO.getCurrentOrdersAmount(shopID);
            saleForm.setOrdersAmount(ordersAmount);

            // Set data to return to ajax
            s = Double.toString(cus.getId()) + "-" + Integer.toString(cus.getFoodID()) + "-" + cus.getFoodName() + "-"
                    + Integer.toString(cus.getOrdersQuantity()) + "-" + Utilis.formatCurrency(cus.getFoodPrice()) + "-"
                    + Utilis.formatCurrency(cus.getOrdersTotalPrice()) + "-" + Utilis.formatCurrency(ordersAmount);

        } else {
            s += "#";
        }

        // Return data to ajax
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();
        pw.print(s + "-#");

        return null;
	}
}
