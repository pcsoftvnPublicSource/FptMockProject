package controller.action;

import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * StatisticSaleShopAction
 *
 * Version 1.0
 *
 * Date: Aug 29, 2015
 *
 * Describe: Get detail sale for each food in a shop
 *
 * Copyright (c) 2015, AnhCT
 *
 */

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.StatisticSale;
import model.bo.StatisticSaleBO;
import model.form.StatisticSaleForm;
import utilis.Utilis;

//type _comment to add generic comment here

public class StatisticSaleShopAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        StatisticSaleForm statisticSaleForm = (StatisticSaleForm) form;

        // Get current shop id, and time range
        String shopID = statisticSaleForm.getShopID();
        String startDate = statisticSaleForm.getStartDate();
        String endDate = statisticSaleForm.getEndDate();

        // Get sale data
        StatisticSaleBO statisticSaleBO = new StatisticSaleBO();
        ArrayList<StatisticSale> saleData = statisticSaleBO.getShopSaleData(shopID, startDate, endDate);

        // Prepare variable to return data for ajax
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();
        StringBuffer str = new StringBuffer("");

        // Return data
        for (StatisticSale s : saleData) {
            str.append(s.getFoodName() + "-" + s.getQuantity() + "-" + Utilis.formatCurrency(s.getAmount()) + "-");
        }

        pw.print(str.toString() + "#");

        return null;
    }
}

