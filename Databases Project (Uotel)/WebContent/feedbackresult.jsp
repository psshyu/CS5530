<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="cs5530.testdriver2"%>
<%@ page import="cs5530.Connector"%>
<%@ page import="cs5530.TH"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Uotel - PH </title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/simple-sidebar.css" rel="stylesheet">

    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<% 
    Connector con = new Connector(); 
	String login = (String) session.getAttribute("login");
%>
	<div id="wrapper">
    <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="menu.jsp">
                        <b>Feedback Query</b>
                    </a>
                </li>
                <li>
                    <a href="browseth.jsp">Browse TH</a>
                </li>
                <li>
                    <a href="reserve.jsp">Reserve</a>
                </li>
                <li>
                    <a href="stays.jsp">Stays</a>
                </li>
                <li>
                    <a href="ph.jsp">PH</a>
                </li>
                <li>
                    <a href="addfav.jsp">Add Favorite</a>
                </li>
                <li>
                    <a href="feedbackmenu.jsp">Feedback</a>
                </li>
                <li>
                    <a href="trust.jsp">Trust Users</a>
                </li>
                <li>
                    <a href="stats.jsp">Statistics</a>
                </li>
                <li>
                    <a href="checkout.jsp">Checkout</a>
                </li>
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1>Feedback Query</h1>
						<% 
						
						if (request.getParameter("FIRST") != null) 
						{
							out.println("First clicked");
							
							String TryName = request.getParameter("THname");
							TH ATH = new TH();
							int THid = ATH.getTHid(TryName, con.stmt);
							int RatingID = ATH.generateRatingid(con.stmt);
							String rateINT = request.getParameter("rating");
							java.sql.Date sqlDate = new java.sql.Date(Calendar.getInstance().getTime().getTime()); 
						   	String opttext = request.getParameter("Text1");
						   	 
						   	try
					      	 {
					  			 String AddFeedback = "INSERT INTO THRatings " +
					                       "VALUES (" + THid + ", " + RatingID + ", " + rateINT + ", '" + opttext + "', '" + sqlDate + "', '" + login + "')";
					  			 System.out.println(AddFeedback);
					  			 out.println(AddFeedback);
					      		 con.stmt.executeUpdate(AddFeedback);
					      		 out.println("Feedback successfully added!");
					      	 }
					      	 catch(Exception e)
					      	 {
					      		 
					      		e.printStackTrace();
					      		out.println("Could not add feedback");
					      	 } 
							
						
    					} 
						
						else if (request.getParameter("SECOND") != null) 
						{
							String ratingID = request.getParameter("rateID");
							TH someTH = new TH();
							
							if(!someTH.SelfAuthor(login, ratingID, con.stmt))
							{
								
								String UsefulSTR = request.getParameter("Useful");
								String Useful = UsefulSTR.substring(0,1); 
								try
					           	 {
					       			 String AddRating = "INSERT INTO FeedbackRatings " +
					                            "VALUES (" + ratingID + ", " + Useful + ")";
					           		 con.stmt.executeUpdate(AddRating);
					           	 }
					           	 catch(Exception e)
					           	 {
					           		 System.out.println("Could not rate feedback");
					           	 } 
							}
							else
							{
								System.out.println("You can't rate your own feedback!");
							}
    					}
						
						
						
						else if (request.getParameter("THIRD") != null) 
						{
							
							String name = request.getParameter("THname");
							String n = request.getParameter("nMostUseful");
							
							String query = "Select opttext, AVG(FeedbackRatings.usefulness) AS avFeed " 
											+ "From FeedbackRatings, THRatings, TH " 
											+ "Where TH.THid = THRatings.THid AND THRatings.RatingID = FeedbackRatings.RatingID AND " 
											+ "TH.name = '" + name 
											+ "' GROUP BY FeedbackRatings.RatingID " 
											+ "ORDER BY avFeed DESC "
											+ "LIMIT " + n + ";";
							out.println(query);
							ResultSet rs = null;
							
							try{
					   		 	rs = con.stmt.executeQuery(query);
					   		 	while (rs.next())
								 {
								        out.println(rs.getString("opttext"));
								 }
							 	}
							catch(Exception e)
							 	{
							 		e.printStackTrace();
							 		out.println("cannot execute the query");
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
							 			out.println("cannot close resultset");
							 		}
							 	}
    					}
						%>
						
						
                        <br>
                        <a href="#menu-toggle" class="btn btn-default" id="menu-toggle">Toggle Menu</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    </script>

</body>

</html>