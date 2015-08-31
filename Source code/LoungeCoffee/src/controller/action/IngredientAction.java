package controller.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

import model.bean.Ingredient;
import model.bo.IngredientBO;
import model.bo.UnitBO;
import model.form.IngredientForm;

/**				
 * FoodTypeAddAction				
 *				
 * Version 1.1				
 *				
 * Date: Aug 29, 2015			
 *
 * Describe:Get ingredientAction list to display
 *				
 * Copyright (c) 2015, NghiaTK
 *				
 * Modification Logs:				
 * DATE                 AUTHOR                  DESCRIPTION				
 * -----------------------------------------------------------------------				
 * Aug 21, 2015         NghiaTK                 Created
 * Aug 29, 2015			AnhCT					Fix convention
 */

public class IngredientAction extends Action {
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
		
		// Change encoding
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

		} catch (NullPointerException e) {
			e.printStackTrace();
			return mapping.findForward("index");
		}

		IngredientForm ingredientForm = (IngredientForm) form;
		ArrayList<String> ingUnitList = new ArrayList<String>();
		UnitBO unitBO = new UnitBO();
		ingUnitList = unitBO.getUnitList();
		ingredientForm.setIngUnitList(ingUnitList);

		ArrayList<Ingredient> listIngredient = new ArrayList<Ingredient>();
		IngredientBO ingredientBO = new IngredientBO();

		String ingredientSearchText = ingredientForm.getIngredientSearch();
		listIngredient = ingredientBO.getListIngredient(ingredientSearchText);
		ingredientForm.setListIngredient(listIngredient);
		ingredientForm.setListIngLeng(listIngredient.size());

		String buttonAddIng = ingredientForm.getAddIngredient();

		if (buttonAddIng != null) {
		    ActionErrors actionErrors = new ActionErrors();
		    actionErrors.add("errorInputNameIng", new ActionMessage("error.errorInputNameIng"));
		    saveErrors(request, actionErrors);
		}

		return mapping.findForward("forwardMe");

    }
}
