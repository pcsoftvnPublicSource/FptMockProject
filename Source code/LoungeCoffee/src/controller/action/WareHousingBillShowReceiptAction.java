package controller.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bean.ImportReceipt;
import model.bean.Shop;
import model.bo.ImportReceiptBO;
import model.bo.ShopListBO;
import model.form.WareHousingBillForm;

public class WareHousingBillShowReceiptAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// Check permission
		try {
			HttpSession session = request.getSession();
			int permission = (int) session.getAttribute("permission");

			if (permission == -1) {
				return mapping.findForward("index");

			} else {
				// do some things
			}

		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("index");
		}

		WareHousingBillForm wareHousingBillForm = (WareHousingBillForm) form;

		ImportReceiptBO importReceiptBO = new ImportReceiptBO();
		ShopListBO shopBO = new ShopListBO();

		ArrayList<Shop> shopList = new ArrayList<Shop>();
		ArrayList<ImportReceipt> importReceiptList = new ArrayList<ImportReceipt>();

		shopList = shopBO.getAllShop();

		System.out.println(shopList.size());

		if (shopList.isEmpty()) {
			wareHousingBillForm.setValid(-1);
			return mapping.findForward("error");
		} else {

			importReceiptList = importReceiptBO.getImportReceipt(wareHousingBillForm.getDateTime(),
					wareHousingBillForm.getShopID());

			wareHousingBillForm.setShopList(shopList);
			wareHousingBillForm.setImportReceiptList(importReceiptList);
			wareHousingBillForm.setValid(1);
			return mapping.findForward("showReceiptWareHousingBill");
		}
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
