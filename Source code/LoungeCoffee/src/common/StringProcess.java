package common;

public class StringProcess {
    /*
     * * Ham tra ve gioi tinh:1=Nam,0=Nu**
     * 
     * @param val
     * 
     * @return String
     */

    /**
     * Ham in ra mot xau, null in ra xau rong
     * 
     * @param s
     * @return String
     */
    public static String getVaildString(String s) {
        if (s == null)
            return "";
        return s;
    }

    /**
     * Ham kiem tra xau rong hay khong
     * 
     * @param s
     * @return boolean
     */
    public static boolean notVaild(String s) {
        if (s == null || s.length() == 0)
            return true;
        return false;
    }

    /**
     * Ham kiem tra xem xau co bao gom chi chu so hay khong
     * 
     * @param s
     * @return boolean
     */
    public static boolean notVaildNumber(String s) {
        if (notVaild(s))
            return true;
        String regex = "[0-9]+";
        if (s.matches(regex))
            return false;
        return true;
    }

    public static boolean notVaildFloatNumber(String s) {
        if (notVaild(s))
            return true;
        String regex = "[0-9]+[.]*[0-9]?";
        if (s.matches(regex))
            return false;
        return true;
    }

    public static boolean isNotSame(String password, String confirmPass) {
        // TODO Auto-generated method stub
        if (notVaild(password) || notVaild(confirmPass))
            return true;
        if (password.equals(confirmPass)) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean isNotEmail(String email) {
        // TODO Auto-generated method stub
        if (notVaild(email))
            return true;
        String regex = "^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
        if (email.matches(regex))
            return false;
        return true;
    }

    public static boolean isNotPhone(String phone) {
        // TODO Auto-generated method stub
        if (notVaild(phone))
            return true;
        String regex = "^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$";
        if (phone.matches(regex))
            return false;
        return true;
    }

}
