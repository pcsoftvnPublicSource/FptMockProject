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
 * FoodTypeAddAction				
 *				
 * Version 1.1				
 *				
 * Date: Aug 29, 2015			
 *
 * Describe: Update a food information
 *				
 * Copyright (c) 2015, NghiaTK
 *				
 * Modification Logs:				
 * DATE                 AUTHOR                  DESCRIPTION				
 * -----------------------------------------------------------------------				
 * Aug 21, 2015         NghiaTK                 Created
 * Aug 29, 2015			AnhCT					Fix convention
 */

public class FoodUpdateAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
	    HttpServletResponse response) throws Exception {
	
    	// Change encoding
    	try {
		    request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
		    e.printStackTrace();
		}

		FoodForm foodForm = (FoodForm) form;
		FoodBO foodBO = new FoodBO();

		// Get data
		String updateFoodId = foodForm.getUpdateFoodId();
		String detailFoodName = foodForm.getDetailFoodName();
		String detailChooseFoodType = foodForm.getDetailChooseFoodType();
		String detailFoodPrice = foodForm.getDetailFoodPrice();

		// Update food infor
		foodBO.updateFood(updateFoodId, detailFoodName, detailChooseFoodType, detailFoodPrice);

		return mapping.findForward("forwardFood");
    }
}
