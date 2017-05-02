package cs5530;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Booking 
{
	public Booking()
	{
			
	}
	public Date CheckReservations(String login, String name, Date arrival, Statement stmt)
	{
		int THid = getTHid(name, stmt);
		String sql = "select departure from Reservations where THid = "+THid+" and loginname like '" +login+ "' and arrival = '"+arrival+"'";
		ResultSet rs = null;
		
		try
	 	{
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next())
			{
   		 		return rs.getDate("departure");
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
		
		return null;
	}
	public void GetReservations(String login, String name, Statement stmt)
	{
		int THid = getTHid(name, stmt);
		String sql = "select arrival, departure from Reservations where THid = "+THid+" and loginname like '" +login+ "'";
		ResultSet rs = null;
		 	try
		 	{
		 		rs = stmt.executeQuery(sql);
		 		System.out.println("  Arrival  |  Departure ");
	   		 	if (!rs.next())
	   		 	{
	   		 		System.out.println("You do not have any reservations at " + name);
	   		 		return;
	   		 	}
	   		 		
		 		while (rs.next())
				{
	   		 		System.out.println(rs.getDate("arrival").toString() + " | " + rs.getDate("departure").toString());
				}
		 		System.out.println("Please enter the ARRIVAL date of the reservation you would like to record a stay (YYYY-MM-DD): ");
		 	
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
	public void VerifyReservations(String login, ArrayList<Pair<Integer, Pair<Date, Date>>>Cart, Statement stmt) throws IOException
	{
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Please verify your reservations:");
		for(int i = 0; i < Cart.size(); i++)
		{
			int THid = Cart.get(i).getL();
			String THname = getTHname(THid, stmt);
			Date start = Cart.get(i).getR().getL();
			Date end = Cart.get(i).getR().getR();
			System.out.println(THname + " is booked from " + start + " to " + end
					+ "\n Do you wish to book this TH? (Y/N)");
			String yn = in.readLine().toUpperCase();
			if(yn.equals("Y"))
			{
				MakeReservation(login, THid, start, end, stmt);
			}
		}
	}
	
	public void VerifyStays(String login, ArrayList<Pair<String, Stay>> Cart, Statement stmt) throws IOException
	{
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Please verify your stays:");
		for(int i = 0; i < Cart.size(); i++)
		{
		
			String THname = Cart.get(i).getL();
			Stay record = Cart.get(i).getR();
			System.out.println(THname + " was visited between " + record.arrival.toString() + " and " + record.departure.toString()
					+ "\n Do you wish to record a stay at this TH? (Y/N)");
			String yn = in.readLine().toUpperCase();
			if(yn.equals("Y"))
			{
				MakeStay(record, stmt);
			}
		}
	}
	public void MakeStay(Stay record, Statement stmt)
	{
		try
     	 {
 			 String SQL = "INSERT INTO Stays " +
                      "VALUES ('" + record.loginname + "', '" + record.arrival + "', '" + record.departure+ "', " 
 					 + record.cost + ", " + record.party + ", " + record.THid +")";
     		 System.out.println(SQL);
 			 stmt.executeUpdate(SQL);
     		 
     	 }
     	 catch(Exception e)
     	 {
     		 e.printStackTrace();
     		 System.out.println("Could not add stay");
     	 } 
	}
	
	public void MakeReservation(String login, int THid, Date start, Date end, Statement stmt)
	{
		try
      	 {
  			 String SQL = "INSERT INTO Reservations " +
                       "VALUES (" + THid + ", '" + start + "', '" + end + "', '" + login +"')";
      		 stmt.executeUpdate(SQL);
      	 }
      	 catch(Exception e)
      	 {
      		 System.out.println("Could not add reservation");
      	 } 
		
	}
	
	public boolean Available(int THid, java.sql.Date start, java.sql.Date end, Statement stmt)
	{
		HashMap<java.sql.Date, java.sql.Date> unavailable = new HashMap<java.sql.Date, java.sql.Date>();
		
		String sql = "select start, end from Unavailable where THid like '"+THid+"'";
		String[] output = new String[2];
		ResultSet rs = null;
		 	try
		 	{
		 		rs = stmt.executeQuery(sql);
	   		 	while (rs.next())
				{
	   		 		unavailable.put(rs.getDate("start"), rs.getDate("end"));
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
		 	
		 for(Map.Entry<java.sql.Date, java.sql.Date> entry : unavailable.entrySet()) 
		 {
			 Date UAstart = entry.getKey();
			 Date UAend = entry.getValue();
			 
		 	 if(end.before(UAend) && end.after(UAstart))
		 	 {
		 		 return false;
		 	 }
		 	 else if(start.after(UAstart) && start.before(UAend))
		 	 {
		 		 return false;
		 	 }
		 	 else if(end.after(UAend) && start.before(UAstart))
		 	 {
		 		 return false;
		 	 }
		 	 else if (end.before(UAend) && start.after(UAstart))
		 	 {
		 		 return false;
		 	 }
		 	 else
		 	 {
		 		 
		 	 }
		 }
		 
		 return true;
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
	
	public String getTHname(int ID, Statement stmt)
	{
		String name = null;

		ResultSet rs = null;
       	try
      	 {
  			 String GetTHname = "SELECT name from TH WHERE THid = " + ID;
      		 rs = stmt.executeQuery(GetTHname);
      		 while (rs.next())
      		 {
      			return rs.getString("name");
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
		return name;
	}
	
}
