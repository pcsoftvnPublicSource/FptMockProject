package controller.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.ImportReceipt;
import model.bo.ImportReceiptBO;
import model.form.WareHousingBillForm;

public class WareHousingBillShowDetailReceiptAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        WareHousingBillForm wareHousingBillForm = (WareHousingBillForm) form;

        ImportReceiptBO importReceiptBO = new ImportReceiptBO();

        response.setCharacterEncoding("UTF-8");
        PrintWriter pw = response.getWriter();

        ArrayList<ImportReceipt> importReceiptList = new ArrayList<ImportReceipt>();

        importReceiptList = importReceiptBO.getDetailReceipt(wareHousingBillForm.getIdImportReceipt());

        if (importReceiptList.size() == 0) {
            pw.print("false");
        } else {
            String str = "";
            for (int i = 0; i < importReceiptList.size(); i++) {
                ImportReceipt importReceipt2 = importReceiptList.get(i);
                str += "+" + "-" + importReceipt2.getIngName() + "-" + importReceipt2.getUnit() + "-"
                        + String.valueOf(importReceipt2.getImpQuantity()) + "-" + "#" + "-";
            }
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
