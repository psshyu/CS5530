package cs5530;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Scanner;


public class TH{
	
	public TH() {
	}
	
	public String generateQuery(BufferedReader in) throws NumberFormatException, IOException
	{
		int max = 0;
		int min = 0;
		String addr = null;
		String name = null;
		String category = null;
		boolean AND = false;
		
		String Query = "Select name from TH ";
		
		System.out.println("Max price (ENTER 0 to skip): ");
		max = Integer.parseInt(in.readLine());
		
		System.out.println("Min price (ENTER 0 to skip): ");
		min = Integer.parseInt(in.readLine());
		
		System.out.println("Address (hit ENTER to skip): ");
		addr = in.readLine();
		
		System.out.println("Name (hit ENTER to skip): ");
		name = in.readLine();
				
		System.out.println("Category (hit ENTER to skip): ");
		category = in.readLine();
		
		if(max != 0)
		{
			Query = Query + "Where price <= " + max;
			AND = true;
		}
		
		
		
		if(min != 0)
		{
			if(AND)
			{
				Query+= " AND price >= " + min;
				AND = false;
			}
			else
			{
				Query = Query + "Where price >= " + min;
			}
			AND = true;
		}
		
		
		if(!addr.equals(""))
		{
			if(AND)
			{
				Query+= " AND address = " + "'"+addr+"'";
				AND = false;
			}
			else
			{
				Query = Query + "Where address = " + "'"+addr+"'";
			}
			AND = true;
		}
		
		if(!name.equals(""))
		{
			if(AND)
			{
				Query+= " AND name = " + "'%"+name+"%'";
				AND = false;
			}
			else
			{
				Query = Query + "Where name = " + "'%"+name+"%'";
			}
			AND = true;
		}
		
		if(!category.equals(""))
		{
			if(AND)
			{
				Query+= " AND category = " + "'"+category+"'";
				AND = false;
			}
			else
			{
				Query = Query + "Where category = " + "'"+category+"'";
			}
			AND = true;
		}
		return Query;
	}
	public void sortQuery(BufferedReader in) throws NumberFormatException, IOException
	{
		String Query = generateQuery(in);
   	 	System.out.println("Sort by: "
 			+ "\n1. Price"
			+ "\n2. Average Feedback Score"
	 		+ "\n3. Average Feedback Score (Trusted Users Only");
   	 	String input = in.readLine();
   	 	switch(input){
   	 	case "1":
   	 		Query += " ORDER BY price";
   	 		break;
   	 	case "2":
   	 		break;
   	 	case "3": 
   	 		break; 
   	 	}
	}
	public void Browse(String query, Statement stmt)
	{
		String[] splits = query.split("Where|where|WHERE|From|from|FROM|;");
	    System.out.println(Arrays.asList(splits));
	    
		String ByPrice = " ORDER BY price;";
		String ByAvgFeedback;
		String ByAvgTrustedFeedback; 
		
		ResultSet rs = null;
		
		System.out.println("How would you like your results sorted? \n"
				+ "1. By price (low to high)"
				+ "\n2. By avg feedback score"
				+ "\n3. By avg score of trusted user feedback");
		Scanner sorty = new Scanner(System.in);
		int sort = sorty.nextInt();
		
		if (sort == 1)
		{
			query = splits[0] + "FROM" + splits[1] + "WHERE" + splits[2] + ByPrice; 
		}
		if (sort == 2)
		{
			query = splits[0] + ", AVG(THRatings.Rating)AS AvRate FROM THRatings," + splits[1] + 
					"WHERE TH.THid = THRatings.THid AND " + splits[2] + 
					" GROUP BY name ORDER BY AvRate DESC;";
		}
		if (sort == 3)
		{
			
		}
		System.out.println(query);
		try{
   		 	rs = stmt.executeQuery(query);
   		 	while (rs.next())
			 {
			        System.out.println(rs.getString("name"));
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
	}
	
	public int generateRatingid(Statement stmt)
	{
		String getID = "SELECT COUNT(*) FROM THRatings";
		ResultSet rs = null;
		int output = 0;
		try{
   		 	rs = stmt.executeQuery(getID);
   		 	while (rs.next())
			 {
			        output = rs.getInt("COUNT(*)") + 1;
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
	
	public int generateTHid(Statement stmt)
	{
		String getID = "SELECT COUNT(*) FROM TH";
		ResultSet rs = null;
		int output = 0;
		try{
   		 	rs = stmt.executeQuery(getID);
   		 	while (rs.next())
			 {
			        output = rs.getInt("COUNT(*)") + 1;
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
	public void AddPH(String login, Statement stmt) throws IOException
	{
		 BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		 
		 int THid = generateTHid(stmt);
		 
		 System.out.println("PH name: ");
	   	 String name = in.readLine();
	   	 
	   	 System.out.println("Year Built (integers ONLY): ");
	   	 String year = in.readLine();
	   	 int yearINT;
	   	 try
	   	 {
	   		 yearINT = Integer.parseInt(year);
	   	 }
   	 
	   	 catch (Exception e)
	   	 {
	   		 System.out.println("Invalid input, please restrict input to numerical (0-9) characters only.");
	   		 System.out.println("Year Built: (integers ONLY)");
		   	 year = in.readLine();
		   	 yearINT = Integer.parseInt(year);
	   	 }
	   	 
	   	 System.out.println("Price (integer ONLY): ");
	   	 String price = in.readLine();
	   	 int priceINT;
	   	 try
	   	 {
	   		 priceINT = Integer.parseInt(price);
	   	 }
  	 
	   	 catch (Exception e)
	   	 {
	   		 System.out.println("Invalid input, please restrict input to numerical (0-9) characters only.");
	   		 System.out.println("Price (integer ONLY): ");
		   	 price = in.readLine();
		   	 priceINT = Integer.parseInt(price);
	   	 }
	   	 
	   	 System.out.println("Category: ");
	   	 String category = in.readLine();
	   	 
	   	System.out.println("Address: ");
	   	 String addr = in.readLine();
	   	 try
      	 {
  			 String AddTH = "INSERT INTO TH " +
                    "VALUES (" + THid + ", '" + name + "', " + yearINT + ", " + priceINT + ", '" + category + "', '" + addr +"')";
  			//System.out.println(AddTH);
      		 stmt.executeUpdate(AddTH);
      		 String AddListed = "INSERT INTO Listed " +
                    "VALUES ('" + login + "', " + THid + ")";
      		 
      		//System.out.println(AddListed);
      		 stmt.executeUpdate(AddListed);
      	 }
      	 catch(Exception e)
      	 {
      		 e.printStackTrace();
      		 System.out.println("Add failed.");
      	 } 
	   	 
	}
	
	public int getTHid(String name, Statement stmt)
	{
		 
		int THid = 0;

		ResultSet rs = null;
       	try
      	 {
  			 String GetTHid = "SELECT THid from TH WHERE name like '"+name+"'";
      		 rs = stmt.executeQuery(GetTHid);
      		 while (rs.next())
      		 {
      			THid = rs.getInt("THid");
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
		return THid;
	}
	public String[] ShowListed(String loginname, Statement stmt)
	{
		String sql = "SELECT TH.THid, TH.name FROM TH JOIN Listed on TH.THid = Listed.THid WHERE loginname like '"+loginname+"'";
		String[] output = new String[2];
		ResultSet rs = null;

		 	try{
   		 	rs = stmt.executeQuery(sql);
   		 	while (rs.next())
			 {
			        output[0] = rs.getString("TH.THid");
			        output[1] = rs.getString("TH.name")+"\n"; 
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
	
	public void AddTHFeedback(String login, Statement stmt) throws IOException
	{
		System.out.println("Name of TH you with to leave feedback on: ");
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		String TryName = in.readLine();
		
		int THid = getTHid(TryName, stmt);
		int RatingID = generateRatingid(stmt);
		java.sql.Date sqlDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
	   	 
	   	 System.out.println("Rating (0 to 10): ");
	   	 String rating = in.readLine();
	   	 int rateINT;
	   	 try
	   	 {
	   		 rateINT = Integer.parseInt(rating);
	   	 }
  	 
	   	 catch (Exception e)
	   	 {
	   		 System.out.println("Invalid input, please restrict input from 0 to 10");
	   		 System.out.println("Rating (0 to 10):");
		   	 rating = in.readLine();
		   	 rateINT = Integer.parseInt(rating);
	   	 }
	   	 
	   	 System.out.println("Short text (optional): ");
	   	 String opttext = in.readLine();
	   	 
	   	try
      	 {
  			 String AddFeedback = "INSERT INTO THRatings " +
                       "VALUES (" + THid + ", " + RatingID + ", " + rateINT + ", '" + opttext + "', '" + sqlDate + "', '" + login + "')";
  			 System.out.println(AddFeedback);
  			 
      		 stmt.executeUpdate(AddFeedback);
      	 }
      	 catch(Exception e)
      	 {
      		 
      		e.printStackTrace();
      		 System.out.println("Could not add feedback");
      	 } 
	}
	
	public boolean SelfAuthor(String login, String ID, Statement stmt)
	{
		String SQL = "SELECT loginname from THRatings WHERE RatingID = " + ID;
		ResultSet rs = null;
		String author = null;
		try
		{
			rs = stmt.executeQuery(SQL);
			while(rs.next())
			{
				author = rs.getString("loginname");
			}
		}
		catch (Exception e)
		{
			System.out.println("Could not verify authorship.");
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
		
		if(login.equals(author))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public void nMostUseful(String login, Statement stmt) throws IOException
	{
		System.out.println("For which TH would you like to obtain feedback?");
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		String name = in.readLine();
		
		System.out.println("How many of the top n feedback would you like to retrieve?");
		String n = in.readLine();
		
		String query = "Select opttext, AVG(FeedbackRatings.usefulness) AS avFeed " 
						+ "From FeedbackRatings, THRatings, TH " 
						+ "Where TH.THid = THRatings.THid AND THRatings.RatingID = FeedbackRatings.RatingID AND " 
						+ "TH.name = '" + name 
						+ "' GROUP BY FeedbackRatings.RatingID " 
						+ "ORDER BY avFeed DESC "
						+ "LIMIT " + n + ";";
		//System.out.println(query);
		ResultSet rs = null;
		
		try{
   		 	rs = stmt.executeQuery(query);
   		 	while (rs.next())
			 {
			        System.out.println(rs.getString("opttext"));
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
	}
	
	public void InEachCategory(String login, Statement stmt) throws IOException
	{
		String query = "SELECT TH.name" +
			    "FROM (SELECT TH.name, Rank() over (Partition BY TH.Category ORDER BY avFeed DESC) AS Rank "
			    + "FROM table) rs WHERE Rank <= 4;";
	}
	
	public void RateFeedback(String login, Statement stmt) throws IOException
	{
		System.out.println("RatingID you wish to leave feedback on: ");
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		String ratingID = in.readLine();
		
		if(!SelfAuthor(login, ratingID, stmt))
		{
			int rateID = Integer.parseInt(ratingID);
			System.out.println("How useful was Feedback No. " + rateID + "?"
					+ "\n 0. Useless"
					+ "\n 1. Useful"
					+ "\n 2. Very Useful \n");
			String UsefulSTR = in.readLine();
			int Useful = Integer.parseInt(UsefulSTR);
			
			if (Useful > 2 || Useful < 0)
			{
				
			}
			else
			{
				try
	           	 {
	       			 String AddRating = "INSERT INTO FeedbackRatings " +
	                            "VALUES (" + rateID + ", " + Useful + ")";
	           		 stmt.executeUpdate(AddRating);
	           	 }
	           	 catch(Exception e)
	           	 {
	           		 System.out.println("Could not rate feedback");
	           	 } 
			}
		}
		else
		{
			System.out.println("You can't rate your own feedback!");
		}
	}
}


