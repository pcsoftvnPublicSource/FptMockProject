package model.form;

import org.apache.struts.action.ActionForm;

//type _comment to add generic comment here

public class LoginForm extends ActionForm {
    private String shopID;
    private String shopPassword;

    public String getShopID() {
	return shopID;
    }

    public void setShopID(String shopID) {
	this.shopID = shopID;
    }

    public String getShopPassword() {
	return shopPassword;
    }

    public void setShopPassword(String shopPassword) {
	this.shopPassword = shopPassword;
    }

    public static long getSerialversionuid() {
	return serialVersionUID;
    }
    private static final long serialVersionUID = 1L;
}
