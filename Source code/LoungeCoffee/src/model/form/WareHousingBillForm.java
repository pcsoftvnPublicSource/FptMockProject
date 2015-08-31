package model.form;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import model.bean.ImportReceipt;
import model.bean.Shop;

public class WareHousingBillForm extends ActionForm {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String dateTime;
    private String shopID;
    private ArrayList<Shop> shopList;
    private ArrayList<ImportReceipt> importReceiptList = null;
    private String button;
    private String idImportReceipt;
    private int valid = 0;

    public String getDateTime() {
        return dateTime;
    }

    public String getIdImportReceipt() {
        return idImportReceipt;
    }

    public void setIdImportReceipt(String idImportReceipt) {
        this.idImportReceipt = idImportReceipt;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getShopID() {
        return shopID;
    }

    public void setShopID(String shopID) {
        this.shopID = shopID;
    }

    public ArrayList<Shop> getShopList() {
        return shopList;
    }

    public void setShopList(ArrayList<Shop> shopList) {
        this.shopList = shopList;
    }

    public ArrayList<ImportReceipt> getImportReceiptList() {
        return importReceiptList;
    }

    public void setImportReceiptList(ArrayList<ImportReceipt> importReceiptList) {
        this.importReceiptList = importReceiptList;
    }

    public String getButton() {
        return button;
    }

    public void setButton(String button) {
        this.button = button;
    }

    public int getValid() {
        return valid;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        // TODO Auto-generated method stub
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return super.validate(mapping, request);
    }

    @Override
    public void reset(ActionMapping mapping, HttpServletRequest request) {
        // TODO Auto-generated method stub
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        super.reset(mapping, request);
    }
}
