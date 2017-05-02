package cs5530;

import java.sql.*;

public class Connector {
	public Connection con;
	public Statement stmt;

	public Connector() throws Exception {
		try{
		 	String userName = "5530u56";
	   		String password = "kt4r5mac";
	        String url = "jdbc:mysql://georgia.eng.utah.edu/5530db56";
		    Class.forName ("com.mysql.jdbc.Driver").newInstance ();
		    con = DriverManager.getConnection (url, userName, password);
			stmt = con.createStatement();

        } catch(Exception e) {
			System.err.println("Unable to open mysql jdbc connection. The error is as follows,\n");
            		System.err.println(e.getMessage());
			throw(e);
		}
	}
	
	public void closeConnection() throws Exception{
		con.close();
	}
}