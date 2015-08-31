package model.dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.DateTimeProcess;
import model.bean.ImportReceipt;

public class ImportReceiptDAO extends BaseDAO {

    DateTimeProcess dateTimeProcess = new DateTimeProcess();

    public void addTmpImportReceiptDetail(ImportReceipt importReceipt) throws SQLException {
        // TODO Auto-generated method stub
        try {
            connect();
            String sql = String.format("EXEC SP_TmpImportReceiptDetail_INSERT %s,%s,%s,'%s'", importReceipt.getIngID(),
                    importReceipt.getImpQuantity(), importReceipt.getImpPrice(), importReceipt.getShopID());
            System.out.println(importReceipt.getIngID());
            executeStoreProcedure(sql);
        } finally {
            disconnect();
        }
    }

    public ImportReceipt getTmpImportReceiptDetai(String string) throws SQLException {
        ImportReceipt importReceipt = new ImportReceipt();
        try {
            connect();
            String sql = String.format("SELECT * FROM loadTmpImportReceiptDetail('%s')", string);
            ResultSet rs = executeQuery(sql);
            if (rs.next()) {
                importReceipt.setIngName(rs.getString(2));
                importReceipt.setUnit(rs.getString(3));
                importReceipt.setImpQuantity(rs.getInt(4));
                importReceipt.setImpPrice(rs.getDouble(5));
                importReceipt.setIdTmpReceipt(rs.getInt(1));
            }
        } finally {
            disconnect();
        }
        return importReceipt;
    }

    public int deleteTmpImportReceiptDetai(int string) {
        // TODO Auto-generated method stub
        int i = -1;
        try {
            connect();
            String sql = String.format("DELETE FROM TmpImportReceiptDetail where ID = %s", string);
            i = executeUpdateQuery(sql);
        } finally {
            disconnect();
        }
        return i;
    }

    public boolean addImportReceipt(String dateTime, String string) {
        // TODO Auto-generated method stub
        try {
            connect();
            String sql = String.format("EXEC SP_ImportReceiptDetail_INSERT '%s','%s'", dateTime, string);
            executeStoreProcedure(sql);
            return true;
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }

    public ArrayList<ImportReceipt> getImportReceipt(String dateTime, String shopID) throws SQLException {
        // TODO Auto-generated method stub
        ArrayList<ImportReceipt> importReceiptList = new ArrayList<ImportReceipt>();
        ;
        try {
            String sql;
            connect();
            System.out.println(dateTimeProcess.convertStringToSQLDate(dateTime));
            if ("0".equals(shopID)) {
                sql = String.format("EXEC SP_ImportReceipt_LOAD '%s' ",
                        dateTimeProcess.convertStringToSQLDate(dateTime));
            } else {
                sql = String.format("SP_ImportReceipt_LOAD_WithShopId '%s','%s'",
                        dateTimeProcess.convertStringToSQLDate(dateTime), shopID);
            }
            ResultSet rs = executeQuery(sql);
            while (rs.next()) {
                ImportReceipt importReceipt = new ImportReceipt();
                importReceipt.setId(rs.getBigDecimal(1));
                importReceipt.setDateTime(rs.getString(2));
                importReceipt.setShopName(rs.getString(3));
                importReceiptList.add(importReceipt);
            }
            return importReceiptList;
        } finally {
            disconnect();
        }
    }

    public ArrayList<ImportReceipt> getDetailReceipt(String idImportReceipt) throws SQLException {

        ArrayList<ImportReceipt> improtReceiptList = new ArrayList<ImportReceipt>();
        try {
            connect();
            String sql = String.format("EXEC SP_ImportReceiptDetail_LOAD '%s'",
                    BigDecimal.valueOf(Double.parseDouble(idImportReceipt)));
            ResultSet rs = executeQuery(sql);
            while (rs.next()) {
                ImportReceipt importReceipt = new ImportReceipt();
                importReceipt.setIngName((rs.getString("ingName")));
                importReceipt.setUnit(rs.getString("ingUnit"));
                importReceipt.setImpQuantity(rs.getInt("impQuantity"));
                improtReceiptList.add(importReceipt);
            }
        } finally {
            disconnect();
        }
        return improtReceiptList;
    }

}
