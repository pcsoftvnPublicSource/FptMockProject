package model.bo;

import model.dao.LoginDAO;

//type _comment to add generic comment here
public class LoginBO {

    /**
     * Check login information and get permission base on logged account.
     *
     * @param shopID
     *            known as "username"
     * @param shopPassword
     *            password to login
     * @return 3 if system administrator logged </br>
     *         2 if material manager logged </br>
     *         1 if employee logged </br>
     *         0 if logged fail
     */
    public int checkLogin(String shopID, String shopPassword) {
	LoginDAO loginDAO = new LoginDAO();
	return loginDAO.checkLogin(shopID, shopPassword);
    }
}