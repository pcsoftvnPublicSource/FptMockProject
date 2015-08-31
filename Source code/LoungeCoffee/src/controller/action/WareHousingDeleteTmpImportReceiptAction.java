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

public class WareHousingDeleteTmpImportReceiptAction extends Action {
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

        int i = importReceiptBO.deleteTmpImportReceiptDetai(Integer.parseInt(insert.getIdTmpImportReceipt()));
        // debug
        System.out.println("aaaa " + insert.getIdTmpImportReceipt()
                + "| Location: (p) controller.action > (f) WareHousingDeleteTmpImportReceiptAction  > (m) execute");
        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        if (i == 1) {
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
