package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import utilis.Utilis;

//type _comment to add generic comment here

public class LoginDAO extends BaseDAO {

    // Default constructor
    public LoginDAO() {
	super();
    }

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
	int permission = -1;

	try {

	    connect();

			// Encode password
			String password = Utilis.Md5Encode(shopPassword);

			String sql = String.format("SELECT shopID FROM Shop WHERE shopID = '%s' AND shopPassword = '%s'", shopID,
					password);
	    ResultSet rs = executeQuery(sql);

	    if (rs.next()) {
		String user = rs.getString(1);

		if ("lounge".equals(user))
		    permission = 3;

		else if ("manager".equals(user))
		    permission = 2;

		else
		    permission = 1;

	    } else
		permission = -1;


	} catch (SQLException e) {
	    e.printStackTrace();

	} finally {
	    disconnect();
	}

	return permission;
    }

}
