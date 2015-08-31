package controller.action;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bo.FoodTypeBO;
import model.form.FoodForm;

/**				
 * FoodTypeAddAction				
 *				
 * Version 1.1				
 *				
 * Date: Aug 29, 2015			
 *
 * Describe: Update a food type infor
 *				
 * Copyright (c) 2015, NghiaTK
 *				
 * Modification Logs:				
 * DATE                 AUTHOR                  DESCRIPTION				
 * -----------------------------------------------------------------------				
 * Aug 21, 2015         NghiaTK                 Created
 * Aug 29, 2015			AnhCT					Fix convention
 */

public class FoodTypeUpdateAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		// Change encoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		// Get food type id and name that need to update
		FoodForm foodForm = (FoodForm) form;
		FoodTypeBO foodTypeBO = new FoodTypeBO();
		String foodTypeId = foodForm.getUpdateFoodTypeId();
		String foodTypeName = foodForm.getDetailFoodTypeName();
		
		// Update infor
		foodTypeBO.updateFoodType(foodTypeId, foodTypeName);
		
		return mapping.findForward("forwardFood");
	}
}
