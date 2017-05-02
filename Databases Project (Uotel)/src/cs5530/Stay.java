package cs5530;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.GregorianCalendar;

import org.joda.time.DateTime;
import org.joda.time.Days;

public class Stay {
	public String loginname;
	public Date arrival;
	public Date departure; 
    public int cost;
    public int THid;
    public int party;
    
    public Stay(String login, Date start, Date end, String name, int ppl, Statement stmt)
    {
    	loginname = login;
    	arrival = start;
    	departure = end;
    	THid = getTHid(name, stmt);
    	party = ppl;
    	
    	DateTime startJ = new DateTime(start);
    	DateTime endJ = new DateTime(end);
    	int numberOfDays = Days.daysBetween(startJ, endJ).getDays();
    	//System.out.println("# of days: " + numberOfDays);
    	
    	cost = numberOfDays * CostPerDay(THid, ppl, stmt);
    }
    
    public int getTHid(String name, Statement stmt)
	{
		int THid = 0;
		ResultSet rs = null;
       	try
      	 {
       		 //System.out.println(name);
  			 String GetTHid = "SELECT THid from TH WHERE name like '"+name+"'";
  			 //System.out.println(GetTHid);
      		 rs = stmt.executeQuery(GetTHid);
      		 while (rs.next())
      		 {
      			THid = rs.getInt("THid");
      		 }
      	 }
      	 catch(Exception e)
      	 {
      		 System.out.println("Please verify the name of the TH of your stay.");
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
    
    private int CostPerDay(int ID, int party, Statement stmt)
    {
    	int total = 0;
		String sql = "select price from TH where THid = "+ID;
		//System.out.println(sql);
		ResultSet rs = null;
		try
	 	{
	 		rs = stmt.executeQuery(sql);
	 		while (rs.next())
			{
   		 		return (rs.getInt("price") * party);
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
    	return total;
    	
    }
}
