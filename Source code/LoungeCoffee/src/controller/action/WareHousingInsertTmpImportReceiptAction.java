package controller.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.ImportReceipt;
import model.bo.ImportReceiptBO;
import model.form.WareHousingForm;

public class WareHousingInsertTmpImportReceiptAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        WareHousingForm insert = (WareHousingForm) form;
        ImportReceiptBO importReceiptBO = new ImportReceiptBO();
        ImportReceipt importReceipt = new ImportReceipt();

        importReceipt.setIngID(Integer.parseInt(insert.getIngID()));
        importReceipt.setImpQuantity(Integer.parseInt(insert.getQuantity()));
        importReceipt.setImpPrice(Double.parseDouble(insert.getPrice()));
        importReceipt.setShopID("nv01");
        System.out.println(insert.getQuantity());
        // Insert the student, and retrieve the same student
        importReceiptBO.addTmpImportReceiptDetail(importReceipt);

        importReceipt = importReceiptBO.getTmpImportReceiptDetai("nv01");

        String s = "";

        s += String.valueOf(importReceipt.getIdTmpReceipt()) + "-" + importReceipt.getIngName() + "-"
                + importReceipt.getUnit() + "-" + String.valueOf(importReceipt.getImpQuantity()) + "-"
                + String.valueOf(importReceipt.getImpPrice()) + "-";
        // debug
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        if ("".equals(s)) {
            pw.print("false");
        } else {
            pw.print(s + "#");
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
