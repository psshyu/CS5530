package cs5530;

import java.lang.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.awt.List;
import java.io.*;

public class testdriver2 {

	/**
	 * @param args
	 * @throws IOException 
	 */
	
	
	public static ArrayList<Pair<Integer, Pair<Date, Date>>> ResCart = new ArrayList<Pair<Integer, Pair<Date, Date>>>(); 
	//private static HashMap<Integer, HashMap<Date, Date>> ResCart = new HashMap<Integer, HashMap<Date, Date>>();
	public static ArrayList<Pair<String, Stay>> StayCart = new ArrayList<Pair<String, Stay>>(); 
	
	
	public static void displayStartMenu(String name)
	{
		 System.out.println("\n        Welcome to the Uotel System, " + name + "!     \n");
    	 System.out.println(
      			  "1. Browse TH"
    			+ "\n2. Reserve"
    	 		+ "\n3. Stay"
    	 		+ "\n4. PH"
    	 		+ "\n5. Add Favorite"
    	 		+ "\n6. Feedback"
    	 		+ "\n7. Trust Users"
    	 		+ "\n8. Degree of Separation"
    	 		+ "\n9. Statistics"
    	 		+ "\n10. Awards [ADMIN ONLY]"
    	 		+ "\n11. EXIT"
    			 );

    	 System.out.println("please enter your choice:");
	}
	
	public static String[] UserQuery(String login, String pw, BufferedReader in, Connector con)
	{
		 Users user = new Users();
		 String[] userinfo = user.getUser(login, pw, con.stmt);
		 System.out.println(userinfo[0] + " " + userinfo[1]);
		 return userinfo;
	}
	public static void Housing(String login, BufferedReader in, Connector con) throws IOException
	{
		TH PH = new TH();
		System.out.println(
    			  "Please Choose one of the following options:"
    		+ "\n1. Record new PH"
  			+ "\n2. Update PH");
		String choice = in.readLine(); 
		switch(choice){
		case "1":
			PH.AddPH(login, con.stmt);
			break;
		case "2":
			PH.ShowListed(login, con.stmt);
			//PH.Edit(login, con.stmt);
			break;
		default:
			System.out.println("Invalid Choice");
			break;
		}
	}
	public static void THFeedback(String login, BufferedReader in, Connector con) throws IOException
	{
		TH th = new TH();
		System.out.println("Feedback Menu: " 
				+ "\n1. Leave Feedback for a TH"
				+ "\n2. Assess Usefulness of Others' Feedback(s)"
				+ "\n3. Rate Trustworthiness of Other Users"
				+ "\n4. Read Most Useful Feedback for a TH");
		
		String choice = in.readLine();
		switch(choice){
		case "1":
			th.AddTHFeedback(login, con.stmt);
			break;
		case "2":
			th.RateFeedback(login, con.stmt);
			break;
		case "3":
			Users user = new Users();
			user.RateUser(login, con.stmt);
			break;
		case "4":
			th.nMostUseful(login, con.stmt);
		default:
			System.out.println("Invalid choice.");
			break;
		}
		
		
	}
	public static void SetFavorite(String login, String fav, BufferedReader in, Connector con)
	{
		Users user = new Users();
		user.Favorite(login, fav, con.stmt);
		
	}
	
	public static void queueReservations(String login, BufferedReader in, Connector con) throws IOException
	{
		Booking book = new Booking();
		while(true)
		{
			System.out.println("Name of TH you wish to make a reservation: ");
			String name = in.readLine();
			int THid = book.getTHid(name, con.stmt);
			System.out.println("Enter starting date (YYYY-MM-DD)");
			String start = in.readLine();
			Date startdate = Date.valueOf(start);
			System.out.println("Enter end date (YYYY-MM-DD)");
			String end = in.readLine();
			Date enddate = Date.valueOf(end);
			
			if(book.Available(THid, startdate, enddate, con.stmt))
			{
				Pair<Date, Date> Dates = new Pair<Date, Date>(startdate, enddate);
				Pair<Integer, Pair<Date, Date>> Reservation = new Pair<Integer, Pair<Date, Date>>(THid, Dates);
				ResCart.add(Reservation);
			}
			
			System.out.println("Queue another reservation? (Y/N)");
			String yn = in.readLine();
			if(!yn.toUpperCase().equals("Y"))
				break;
		}
	}
	
	public static void queueStay(String login, BufferedReader in, Connector con) throws IOException
	{
		Booking book = new Booking();
		while(true)
		{
			System.out.println("Name of TH you wish to record a stay: ");
			String name = in.readLine();
			book.GetReservations(login, name, con.stmt);
			Date arrival = Date.valueOf(in.readLine());
			Date departure = book.CheckReservations(login, name, arrival, con.stmt);
			if(departure != null)
			{
				System.out.println("Party size for stay: ");
				String party = in.readLine();
				int partyINT = Integer.parseInt(party);
				Stay record = new Stay(login, arrival, departure, name, partyINT, con.stmt);
				Pair<String, Stay> AStay = new Pair<String, Stay>(name, record);
				StayCart.add(AStay);
			}
			
			System.out.println("Queue another stay to record? (Y/N)");
			String yn = in.readLine();
			if(!yn.toUpperCase().equals("Y"))
				break;
		}
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connector con = null;
		String choice;
        String login = null;
        String pw = null;
        String sql = null;
        String[] lookup;
        int c = 0;
         try
		 {
			//remember to replace the password
			 	 con = new Connector();
	             System.out.println ("Database connection established");
	         
	             BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	             
	             while(true)
	             {
	            	 
	            	 System.out.println("Login Name: ");
	            	 login = in.readLine();
	            	 System.out.println("Password: ");
	            	 pw = in.readLine();
            		 lookup = UserQuery(login, pw, in, con);
	            	 
	            	 if(lookup[0] != null && lookup[1] != null)
	            	 {
	            		 break;
	            	 }
	            	 else
	            	 {
	            		 try
		            	 {
	            			 String AddUser = "INSERT INTO Users (loginname, password)" +
		                             "VALUES ('" + login + "', '" + pw + "')";
		            		 con.stmt.executeUpdate(AddUser);
		            		 break;
		            	 }
		            	 catch(Exception e)
		            	 {
		            		 System.out.println("That loginname is taken.");
		            	 } 
	            	 }
	             }
	             
	             while(true)
	             {
	            	 displayStartMenu(login);
	            	 while ((choice = in.readLine()) == null && choice.length() == 0);
	            	 
	            	 try
	            	 {
	            		 c = Integer.parseInt(choice);
	            	 }
	            	 catch (Exception e)
	            	 {
	            		 System.out.println("Invalid choice.");
	            		 continue;
	            	 }
	            	 
	            	 if(c == 11)
	            	 {
	            		 if(!ResCart.isEmpty())
	            		 {
	            			 Booking res = new Booking();
	            			 res.VerifyReservations(login, ResCart, con.stmt);
	            		 }
	            		 if(!StayCart.isEmpty())
	            		 {
	            			 Booking res = new Booking();
	            			 res.VerifyStays(login, StayCart, con.stmt);
	            		 }
	            		 System.out.println("EoM");
	            		 con.stmt.close(); 
	            		 break;
	            	 }

	            	 switch (c) {
	            	 case 1: // Browse 
	            		 TH th = new TH();
	            		 System.out.println("Enter a query: ");
	            		 String query = in.readLine();
	            		 th.Browse(query, con.stmt);
	                	 break;
	                 case 2: // Reserve
	                	 queueReservations(login, in, con);
	                	 break;
	                 case 3: // Stay
	                	 queueStay(login, in, con);
	                	 break;
	                 case 4: // PH
	                	 Housing(login, in, con);
	                	 break;
	                 case 5: // Favorite
	                	 System.out.println("Enter the Name of a TH to favorite: ");
	                	 String fav = in.readLine();
	                	 SetFavorite(login, fav, in, con);
	                	 break;
	                 case 6: // Feedback
	                	 THFeedback(login, in, con);
	                	 break;
	                 case 7: // Trust
	                	 Users user = new Users();
	                	 user.RateUser(login, con.stmt);
	                	 break;
	                 case 8: //Separation
	                	 break;
	                 case 9: // Stats
	                	 break;
	                 case 10: // Awards
	                	 break;
	                 
	                 default: 
	                	 System.out.println("Invalid choice.");
	                	 break;
	            	 }
	             }     
		 }
         
         catch (Exception e)
         {
        	 e.printStackTrace();
        	 System.err.println ("Either connection error or query execution error!");
         }
         
         finally
         {
        	 if (con != null)
        	 {
        		 try
        		 {
        			 con.closeConnection();
        			 System.out.println ("Database connection terminated");
        		 }
        	 
        		 catch (Exception e) { /* ignore close errors */ }
        	 }	 
         }
	}

}
