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
import utilis.Utilis;

//type _comment to add generic comment here

public class SaleRemoveFoodAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        SaleForm saleForm = (SaleForm) form;
        SaleBO saleBO = new SaleBO();
        HttpSession session = request.getSession();

        // Remove selected from db
        double id = saleForm.getId();
        String shopID = (String) session.getAttribute("shopID");
        saleBO.deleteRequestFromOrder(id, shopID);

        // Get current orders amount and return data to ajax
        double ordersAmount = saleBO.getCurrentOrdersAmount(shopID);
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();
        pw.print(Utilis.formatCurrency(ordersAmount));

        return null;
    }
}
