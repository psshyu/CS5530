package cs5530;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.*;

public class Users {
		public Users()
		{}
		
		public void RateUser(String login, Statement stmt) throws IOException
		{
			boolean trustworthy;
			System.out.println("Enter the login name of the user you wish to rate: ");
			BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
			String other = in.readLine();
			
			if(login.equals(other))
			{
				System.out.println("You can't rate yourself!");
				return;
			}
			
			System.out.println("Is " + other + " trustworthy? (Y/N)");
			String yn = in.readLine();
			yn.toUpperCase();
			
			if(yn.equals("Y"))
			{
				trustworthy = true;
			}
			else
			{
				trustworthy = false;
			}
			
			try
          	{
      			 String AddRating= "INSERT INTO UserRatings " +
                           "VALUES ('" + login + "', '" + other + "', " + trustworthy + ")";
          		 stmt.executeUpdate(AddRating);
          	}
          	catch(Exception e)
          	{
          		 System.out.println("User rating unsuccessful");
          	} 
		}
		
		public void Favorite(String login, String fav, Statement stmt)
		{
			 
			String THid = null;
			ResultSet rs = null;
	       	try
          	 {
      			 String GetTHid = "SELECT THid from TH WHERE name like '"+fav+"'";
          		 rs = stmt.executeQuery(GetTHid);
          		 while (rs.next())
          		 {
          			THid = rs.getString("THid");
          		 }
          		try
	           	 {
	       			 String AddFav = "INSERT INTO Favorite (loginname, THid)" +
	                            "VALUES ('" + login + "', " + THid + ")";
	           		 stmt.executeUpdate(AddFav);
	           	 }
	           	 catch(Exception e)
	           	 {
	           		 System.out.println("Could not add favorite");
	           	 } 
          		 
          	 }
          	 catch(Exception e)
          	 {
          		 System.out.println("Please verify the name of the TH.");
          	 }
	       	finally
	       	{
	       		try{
	   		 		if (rs != null)
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			e.printStackTrace();
   		 			System.out.println("cannot close resultset");
   		 		}
	       	}
	       	
	       	
	       	 
		}
		
		public String[] getUser(String loginname, String password, Statement stmt)
		{
			String sql = "select * from Users where loginname like '%"+loginname+"%' and password like '%"+password+"%'";
			String[] output = new String[2];
			ResultSet rs = null;

   		 	try{
	   		 	rs = stmt.executeQuery(sql);
	   		 	while (rs.next())
				 {
				        output[0] = rs.getString("loginname");
				        output[1] = rs.getString("password")+"\n"; 
				 }
   		 	}
   		 	catch(Exception e)
   		 	{
   		 		e.printStackTrace();
   		 		System.out.println("cannot execute the query");
   		 	}
   		 	finally
   		 	{
   		 		try{
	   		 		if (rs != null)
	   		 			rs.close();
   		 		}
   		 		catch(Exception e)
   		 		{
   		 			e.printStackTrace();
   		 			System.out.println("cannot close resultset");
   		 		}
   		 	}
		    return output;
		}
/*
		public void MostTrusted(int m, Statement stmt)
		{
			String sql = "SELECT THRatings.loginname FROM THRatings " +
						 "JOIN FeedbackRatings on THRatings.RatingID = FeedbackRatings.RatingID " +
						 "WHERE loginname like '"+loginname+"'";
		}
		
		public void MostTrusted(int m, Statement stmt)
		{
			String sql = "SELECT ratee, sum(trusted) from UserRatings Group BY ratee Order BY sum(trusted) DESC";
		}
		*/
}
