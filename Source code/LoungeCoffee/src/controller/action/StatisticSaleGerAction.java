package controller.action;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.StatisticSale;
import model.bo.StatisticSaleBO;
import model.form.StatisticSaleForm;

/**
 * StatisticSaleGerAction
 *
 * Version 1.0
 *
 * Date: Aug 28, 2015
 *
 * Describe: Get total amount of all shop in time range
 *
 * Copyright (c) 2015, AnhCT
 *
 */

public class StatisticSaleGerAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        // Init variable
        StatisticSaleForm statisticSaleForm = (StatisticSaleForm) form;
        StatisticSaleBO statisticSaleBO = new StatisticSaleBO();

        // Get time range
        String startDate = statisticSaleForm.getStartDate();
        String endDate = statisticSaleForm.getEndDate();

        // Get data from server and prepare variable
        ArrayList<StatisticSale> allShopStatisticSale = statisticSaleBO.getAllShopSale(startDate, endDate);
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();
        String str = "";

        // Parse result to get data for ajax
        for (StatisticSale s : allShopStatisticSale) {
            str += s.getShopID() + "-" + s.getAmount() + "-";
        }

        pw.print(str + "#");

        return null;
    }
}
