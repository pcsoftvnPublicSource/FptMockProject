package model.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UnitDAO extends BaseDAO{

	public ArrayList<String> getUnitList() {
		ArrayList<String> unitList = new ArrayList<String>();
		String sql = "select unit from dbo.Unit";
		try {
			PreparedStatement pr = connect().prepareStatement(sql);
			ResultSet rs = pr.executeQuery();
			while(rs.next()){
				unitList.add(rs.getString("unit"));
			}
			disconnect();
			return unitList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			disconnect();
		}
		return unitList;
	}

}
