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
import utilis.Utilis;

public class ShopListAddShopListAction extends Action {
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

        shop.setShopID(shopListForm.getShopID());
        shop.setShopName(shopListForm.getShopName());
		shop.setShopPassword(Utilis.Md5Encode(shopListForm.getShopPassword()));
        shop.setShopPhoneNumber(shopListForm.getShopPhoneNumber());
        shop.setShopAddress(shopListForm.getShopAddress());
        shop.setManagerName(shopListForm.getManagerName());
        shop.setManagerPhoneNumber(shopListForm.getManagerPhoneNumber());
        shop.setManagerAddress(shopListForm.getManagerAddress());

        boolean result = shopBO.addShop(shop);

        PrintWriter pw = response.getWriter();
        if (result == true) {
            pw.print("true");
            return null;
        } else {
            pw.print("false");
            return null;
        }
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
