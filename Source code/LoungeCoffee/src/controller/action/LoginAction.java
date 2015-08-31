package controller.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bo.LoginBO;
import model.form.LoginForm;

//type _comment to add generic comment here

public class LoginAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        LoginForm loginForm = (LoginForm) form;
        String shopID = loginForm.getShopID();
        String shopPassword = loginForm.getShopPassword();

        LoginBO loginBO = new LoginBO();
        int permission = loginBO.checkLogin(shopID, shopPassword);

        HttpSession session = request.getSession();
        session.setAttribute("shopID", shopID);
        session.setAttribute("permission", permission);

        if (permission == 3) {
            return mapping.findForward("adminScreen");

        } else if (permission == 2) {
            return mapping.findForward("managerScreen");

        } else if (permission == 1) {
            return mapping.findForward("chooseLoginModeDialog");

        } else {
            return mapping.findForward("loginFail");
        }
    }
}
