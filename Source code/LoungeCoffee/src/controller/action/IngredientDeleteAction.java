package controller.action;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import model.bo.IngredientBO;
import model.form.IngredientForm;

/**				
 * FoodTypeAddAction				
 *				
 * Version 1.1				
 *				
 * Date: Aug 29, 2015			
 *
 * Describe: Detele an ingredient form system
 *				
 * Copyright (c) 2015, NghiaTK
 *				
 * Modification Logs:				
 * DATE                 AUTHOR                  DESCRIPTION				
 * -----------------------------------------------------------------------				
 * Aug 21, 2015         NghiaTK                 Created
 * Aug 29, 2015			AnhCT					Fix convention
 */

public class IngredientDeleteAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
	    HttpServletResponse response) throws Exception {

		// Change encoding
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		IngredientForm ingredientForm = (IngredientForm) form;
		String deleteIngredientId = ingredientForm.getDeleteIngredientId();
		IngredientBO ingredientBO = new IngredientBO();

		ingredientBO.deleteIngredient(deleteIngredientId);

		return mapping.findForward("forwardIngredient");
    }
}
