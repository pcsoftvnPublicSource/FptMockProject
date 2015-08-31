package model.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.sql.rowset.CachedRowSet;

import com.sun.rowset.CachedRowSetImpl;

//type _comment to add generic comment here

public class BaseDAO {

	// Connection properties
	private String servername;
	private String port;
	private String dbname;
	private String username;
	private String password;
	private String connectionString = "";

	private Connection connection = null;
	private Statement statement = null;

	/***
	 * Create a new instance of BaseDAO class and get string connection
	 * properties from config file.
	 */
	public BaseDAO() {

		// Read properties file
		Properties properties = new Properties();
		InputStream inputStream = null;

		try {

			String filename = "config.properties";
			inputStream = getClass().getClassLoader().getResourceAsStream(filename);

			if (inputStream == null) {
				System.out.println("BaseDAO class > constructor > Can not find or/and load config file");
				return;
			}

			// Load a properties file from class path, inside static method
			properties.load(inputStream);

			// Get connection properties
			servername = properties.getProperty("servername");
			port = properties.getProperty("port");
			dbname = properties.getProperty("dbname");
			username = properties.getProperty("username");
			password = properties.getProperty("password");

			connectionString = "jdbc:sqlserver://" + servername + ":" + port + ";databaseName=" + dbname;

		} catch (IOException ex) {

			System.out.println("BaseDAO class > constructor > Can not find or/and load config file");
			ex.printStackTrace();
			return;

		} finally {

			if (inputStream != null) {
				try {

					inputStream.close();

				} catch (IOException e) {

					System.out.println("BaseDAO class > constructor > Can not close input stream");
					e.printStackTrace();
				}
			}
		}
	}

	/***
	 * Connect to Microsoft SQL Server
	 *
	 * @return connection object if success, null for otherwise.
	 */
	public Connection connect() {
		try {

			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			connection = DriverManager.getConnection(connectionString, username, password);

		} catch (ClassNotFoundException e) {

			System.out.println("BaseDAO class > connect (M) > Can not load driver");
			e.printStackTrace();

		} catch (SQLException e) {

			System.out.println("BaseDAO > connect (M) > Can not connect to database");
			System.out.println("Connection String: " + connectionString);
			e.printStackTrace();
		}

		return connection;
	}

	/***
	 * Disconnect the current instance connection
	 */
	public void disconnect() {
		try {

			if (!connection.isClosed()) {
				connection.close();
			}

		} catch (SQLException e) {

			System.out.println("BaseDAO class > disconnect (M) > Can not close connection");
			e.printStackTrace();

		} finally {

			try {

				if (!connection.isClosed())
					connection.close();

			} catch (SQLException e) {

				System.out.println("BaseDAO class > disconnect (M) > Can not close connection");
				e.printStackTrace();
			}
		}
	}

	/***
	 * Execute a select query to get data from db.
	 *
	 * @param sql
	 *            query will be executed
	 * @return resultset object that stores result of query, null for otherwise.
	 */
	public ResultSet executeQuery(String sql) {

		ResultSet resultSet = null;

		try {

			statement = connection.createStatement();
			resultSet = statement.executeQuery(sql);

		} catch (SQLException e) {

			System.out.println("Can not execute query " + sql);
			e.printStackTrace();
		}

		return resultSet;
	}

	/**
	 * Execute a store procedure
	 *
	 * @param sql
	 *            Store Procedure statement
	 * @return true if execute success, false for ortherwise
	 */
	public boolean executeStoreProcedure(String sql) {

		boolean isExecuteSuccess = true;

		try {
			connect();
			statement = connection.createStatement();
			statement.execute(sql);

		} catch (SQLException e) {

			System.out.println("Can not execute query " + sql);
			e.printStackTrace();
			isExecuteSuccess = false;

		} finally {
			disconnect();

		}

		return isExecuteSuccess;
	}

	/***
	 * Execute an Insert/ Update or Delete query
	 *
	 * @param sql
	 *            query will be executed
	 * @return number of effected row by query if success, -1 for otherwise
	 */
	public int executeUpdateQuery(String sql) {

		int rowEffected = -1;

		try {
			statement = connection.createStatement();
			rowEffected = statement.executeUpdate(sql);

		} catch (SQLException e) {

			System.out.println("Can not execute query" + sql);
			e.printStackTrace();
		}

		return rowEffected;
	}

	/**
	 * Execute a sql function call and return a result set.
	 *
	 * @param functionCall
	 *            Function-call statement
	 * @return Resultset object if succeess, null for otherwise
	 */
	public ResultSet executeFunction(String functionCall) {
		ResultSet resultSet = null;

		try {
			statement = connection.createStatement();
			String sql = "SELECT * FROM " + functionCall;
			resultSet = executeQuery(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return resultSet;
	}

	/**
	 * Convert ResultSet to CachedRowSet for ajax
	 *
	 * @param rs
	 *            ResultSet that need to convert to
	 *
	 * @return CachedRowSet object if success,null for otherwise
	 */
	public CachedRowSet convertToCachedRowSet(ResultSet rs) {

		CachedRowSet crs = null;

		try {
			crs = new CachedRowSetImpl();
			crs.populate(rs);
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return crs;
	}
}