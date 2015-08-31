package controller.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.Shop;
import model.bo.ShopListBO;
import model.form.WareHousingBillForm;

public class WareHousingBillShowShopAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        WareHousingBillForm wareHousingBillForm = (WareHousingBillForm) form;
        ShopListBO shopBO = new ShopListBO();
        ArrayList<Shop> shopList = new ArrayList<Shop>();
        if ("XÁC NHẬN".equals(wareHousingBillForm.getButton()) == false) {

            shopList = shopBO.getAllShop();

            wareHousingBillForm.setShopList(shopList);

            return mapping.findForward("showShopWareHousingBill");
        } else {
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
