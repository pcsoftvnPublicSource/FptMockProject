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

public class ShopListUpdateShopListAction extends Action {
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
		shop.setShopPassword(Utilis.Md5Encode(shopListForm.getShopPassword()));
        shop.setShopName(shopListForm.getShopName());
        shop.setShopAddress(shopListForm.getShopAddress());
        shop.setShopPhoneNumber(shopListForm.getShopPhoneNumber());
        shop.setManagerName(shopListForm.getManagerName());
        shop.setManagerAddress(shopListForm.getManagerAddress());
        shop.setManagerPhoneNumber(shopListForm.getManagerPhoneNumber());

        int i = shopBO.updateShop(shop);
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        if (i > 0) {
            pw.print("true");
        } else {
            pw.print("false");
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
