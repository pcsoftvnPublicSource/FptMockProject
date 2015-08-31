package controller.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.Shop;
import model.bo.StatisticSaleBO;
import model.form.StatisticSaleForm;

//type _comment to add generic comment here

public class StatisticSaleInitAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        StatisticSaleForm statisticSaleForm = (StatisticSaleForm) form;
        StatisticSaleBO statisticSaleBO = new StatisticSaleBO();
        ArrayList<Shop> listShop = statisticSaleBO.getListShop();
        statisticSaleForm.setListShop(listShop);

        return mapping.findForward("statisticSaleInited");
    }
}

