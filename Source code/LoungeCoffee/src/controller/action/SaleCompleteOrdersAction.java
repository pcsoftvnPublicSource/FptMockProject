package controller.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bo.SaleBO;
import model.form.SaleForm;

//type _comment to add generic comment here

public class SaleCompleteOrdersAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

        // Get shopID
        form = (SaleForm) form;
		HttpSession session = request.getSession();
		String shopID = (String) session.getAttribute("shopID");

        // Init value to return value for ajax
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        // Get current amount
		SaleBO saleBO = new SaleBO();
        double ordersAmount = saleBO.getCurrentOrdersAmount(shopID);

        // Complete orders
        if (ordersAmount > 0) {
            saleBO.completeOrders(shopID);
            pw.print("success");

        } else
            pw.print("fail");

        return null;
	}
}
