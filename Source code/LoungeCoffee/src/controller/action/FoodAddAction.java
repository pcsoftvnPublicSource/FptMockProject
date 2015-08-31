package controller.action;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bo.FoodBO;
import model.form.FoodForm;

/**				
 * FoodAddAction				
 *				
 * Version 1.1			
 *				
 * Date: Aug 29, 2015			
 *
 * Describe: Add new food
 *				
 * Copyright (c) 2015, name
 *				
 * Modification Logs:				
 * DATE                 AUTHOR                  DESCRIPTION				
 * -----------------------------------------------------------------------				
 * Aug 21, 2015         NghiaTK                 Created
 * Aug 29, 2015         AnhCT                 	Fix convention
 */


public class FoodAddAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		// Change ecoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		FoodForm foodForm = (FoodForm) form;
		FoodBO foodBO = new FoodBO();
		
		// Get new food infor from input form
		String foodName = foodForm.getFoodName();
		String foodTypeId = foodForm.getChooseFoodTypeId();
		double foodPrice = foodForm.getFoodPrice();
		
		// Insert new food
		foodBO.insertFood(foodName,foodTypeId,foodPrice);
		
		return mapping.findForward("forwardFood");
	}
}
