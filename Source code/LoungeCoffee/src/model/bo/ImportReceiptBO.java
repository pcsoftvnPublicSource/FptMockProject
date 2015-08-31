package model.bo;

import java.sql.SQLException;
import java.util.ArrayList;

import model.bean.ImportReceipt;
import model.dao.ImportReceiptDAO;

public class ImportReceiptBO {

    ImportReceiptDAO importReceiptDAO = new ImportReceiptDAO();

    public void addTmpImportReceiptDetail(ImportReceipt importReceipt) throws SQLException {
        importReceiptDAO.addTmpImportReceiptDetail(importReceipt);
    }

    public ImportReceipt getTmpImportReceiptDetai(String string) throws SQLException {
        // TODO Auto-generated method stub
        return importReceiptDAO.getTmpImportReceiptDetai(string);
    }

    public int deleteTmpImportReceiptDetai(int string) {
        // TODO Auto-generated method stub
        return importReceiptDAO.deleteTmpImportReceiptDetai(string);
    }

    public ArrayList<ImportReceipt> getImportReceipt(String dateTime, String shopID) throws SQLException {
        // TODO Auto-generated method stub
        return importReceiptDAO.getImportReceipt(dateTime, shopID);
    }

    public boolean addImportReceipt(String dateTime, String string) {
        // TODO Auto-generated method stub
        return importReceiptDAO.addImportReceipt(dateTime, string);
    }

    public ArrayList<ImportReceipt> getDetailReceipt(String idImportReceipt) throws SQLException {
        return importReceiptDAO.getDetailReceipt(idImportReceipt);
    }

}
