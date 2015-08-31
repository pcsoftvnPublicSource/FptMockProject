package common;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateTimeProcess {
    public String convertSQLDateToString(java.sql.Date date) {
        if ("".equals(date)) {
            java.util.Date utilDate = new java.util.Date(date.getTime());
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
            return sdf.format(utilDate);
        } else {
            return "";
        }
    }

    public java.sql.Date convertStringToSQLDate(String date) {

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
            java.util.Date convertedCurrentDate = sdf.parse(date);
            java.sql.Date sDate = new java.sql.Date(convertedCurrentDate.getTime());
            return sDate;
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        } finally {

        }
    }
}
