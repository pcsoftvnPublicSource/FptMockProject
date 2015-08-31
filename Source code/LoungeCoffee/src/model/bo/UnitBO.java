package model.bo;

import java.util.ArrayList;

import model.dao.UnitDAO;

public class UnitBO {
	private UnitDAO unitDAO = new UnitDAO();
	public ArrayList<String> getUnitList() {
		return unitDAO.getUnitList();
	}
	
}
