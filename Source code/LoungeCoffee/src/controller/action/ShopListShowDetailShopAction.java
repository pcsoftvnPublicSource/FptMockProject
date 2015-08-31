package controller.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.Shop;
import model.bo.ShopListBO;
import model.form.ShopListForm;

public class ShopListShowDetailShopAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        ShopListForm shopListForm = (ShopListForm) form;

        ShopListBO shopBO = new ShopListBO();

        Shop shop = new Shop();

        shop = shopBO.getDetailShop(shopListForm.getShopID());

        String str = "";

        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        if (shop.getShopID() == null) {
            pw.println("false");
        } else {
            str += shop.getShopID() + "-" + shop.getShopPassword() + "-" + shop.getShopName() + "-"
                    + shop.getShopAddress() + "-" + shop.getShopPhoneNumber() + "-" + shop.getManagerName() + "-"
                    + shop.getManagerAddress() + "-" + shop.getManagerPhoneNumber();
            pw.print(str);
        }
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
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
