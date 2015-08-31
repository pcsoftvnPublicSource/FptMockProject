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
 * FoodDeleteAction				
 *				
 * Version 1.1		
 *				
 * Date: Aug 29, 2015			
 *
 * Describe: Delete a food from system
 *				
 * Copyright (c) 2015, name
 *				
 * Modification Logs:				
 * DATE                 AUTHOR                  DESCRIPTION				
 * -----------------------------------------------------------------------				
 * Aug 21, 2015         NghiaTK                 Created
 * Aug 21, 2015         AnhCT                 	Fix convention
 */


public class FoodDeleteAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
	    HttpServletResponse response) throws Exception {
		
    	// Change ecoding
    	try {
		    request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
		    e.printStackTrace();
		}

    	// Get food id need to delete
		FoodForm foodForm = (FoodForm) form;
		FoodBO foodBO = new FoodBO();
		String foodId = foodForm.getDeleteFoodId();
	
		// Delete food
		foodBO.deleteFood(foodId);
		
		return mapping.findForward("forwardFood");
    }
}
