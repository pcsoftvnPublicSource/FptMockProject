package controller.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bo.ImportReceiptBO;
import model.form.WareHousingForm;

public class WareHousingAddImportRecieptAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        WareHousingForm wareHousingForm = (WareHousingForm) form;

        ImportReceiptBO importReceiptBO = new ImportReceiptBO();

        PrintWriter pw = response.getWriter();

        if ("".endsWith(wareHousingForm.getDateTime())) {
            pw.print("false");
            return null;
        } else {
            boolean result = importReceiptBO.addImportReceipt(wareHousingForm.getDateTime(), "nv01");

            if (result == true) {
                pw.print("true");
                return null;
            } else {
                pw.print("false");
                return null;
            }
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