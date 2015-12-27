package database;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
	private static Connection connection=null; 
	public static Connection getConnection(){
		try{
			if(connection==null||connection.isClosed())
			{
				Class.forName("com.mysql.jdbc.Driver");
				connection=DriverManager.getConnection("jdbc:mysql://localhost/new","root","dbadmin");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return  connection;
	}
}
