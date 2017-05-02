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
                        <b>Statistics Query</b>
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
                        <h1>Statistics Query</h1>
						<% 
						
						if (request.getParameter("FIRST") != null) 
						{
							String n = request.getParameter("m1");
							String catQuerry = "Select category from TH";

							//System.out.println(query);
							ResultSet rs = null;
							Set<String> listofcategories = new HashSet<String>();
							
							try{
					   		 		rs = con.stmt.executeQuery("SELECT category from TH");
						   		 	while (rs.next())
									 {
						   		 	 	listofcategories.add(rs.getString("category"));
									 }
							 	}
							catch(Exception e)
							 	{
							 		e.printStackTrace();
							 		out.println(e);
							 	}
							finally
							 	{
							 		try{
						   		 		if (rs != null)
						   		 		{
						   		 			rs.close();
						   		 		}
							 		}
							 		catch(Exception e)
							 		{
							 			e.printStackTrace();
							 			out.println("cannot close resultset");
							 		}
							 	}
							
							for(String s : listofcategories)
				   		 	{
								%><h3> <% out.println(s); %></h3> <%
								ResultSet rq = null;
								String query = "Select TH.name from TH, (Select V.THid, COUNT(*) as THCount from Stays V Group By V.THid) as VC "		
										+ "WHERE TH.THid = VC.THid "
				   						+ "AND TH.category = '" + s + "' "
										+ "ORDER BY VC.THCount DESC " 
										+ "LIMIT " + n + ";";
								
								
										
									try{
											//out.println(query);
							   		 		rq = con.stmt.executeQuery(query);
								   		 	while (rq.next())
											 {
								   		 	 	%> - <% out.println(rq.getString("name")); %><br><%
											 }
									 	}
									catch(Exception e)
									 	{
									 		e.printStackTrace();
									 		out.println(e);
									 	}
									finally
									 	{
									 		try{
								   		 		if (rq != null)
								   		 		{
								   		 			rq.close();
								   		 		}
									 		}
									 		catch(Exception e)
									 		{
									 			e.printStackTrace();
									 			out.println("cannot close resultset");
									 		}
									 	}
										
				   		 	}
							
							
							
						
    					} 
						
						else if (request.getParameter("SECOND") != null) 
						{
							
							String n = request.getParameter("m2");
							String catQuerry = "Select category from TH";

							//System.out.println(query);
							ResultSet rs = null;
							Set<String> listofcategories = new HashSet<String>();
							
							try{
					   		 		rs = con.stmt.executeQuery("SELECT category from TH");
						   		 	while (rs.next())
									 {
						   		 	 	listofcategories.add(rs.getString("category"));
									 }
							 	}
							catch(Exception e)
							 	{
							 		e.printStackTrace();
							 		out.println(e);
							 	}
							finally
							 	{
							 		try{
						   		 		if (rs != null)
						   		 		{
						   		 			rs.close();
						   		 		}
							 		}
							 		catch(Exception e)
							 		{
							 			e.printStackTrace();
							 			out.println("cannot close resultset");
							 		}
							 	}
							
							for(String s : listofcategories)
				   		 	{
								%><h3> <% out.println(s); %></h3> <%
								ResultSet rq = null;
								String query = "Select TH.name, TH.category, AVG(TH.price) "
				   						+ "FROM TH "
				   						+ "WHERE TH.category = '" + s + "' "
				   						+ "GROUP BY TH.name "
										+ "ORDER BY AVG(TH.price) DESC, TH.name , TH.category " 
										+ "LIMIT " + n + ";";
								
								//out.println(query);
										
									try{
											//out.println(query);
							   		 		rq = con.stmt.executeQuery(query);
								   		 	while (rq.next())
											 {
								   		 	 	%> - <% out.println(rq.getString("name")); %><br><%
											 }
									 	}
									catch(Exception e)
									 	{
									 		e.printStackTrace();
									 		out.println(e);
									 	}
									finally
									 	{
									 		try{
								   		 		if (rq != null)
								   		 		{
								   		 			rq.close();
								   		 		}
									 		}
									 		catch(Exception e)
									 		{
									 			e.printStackTrace();
									 			out.println("cannot close resultset");
									 		}
									 	}
										
				   		 	}
							
							
							
							
							
							
							
							
    					}
						
						else if (request.getParameter("THIRD") != null) 
						{
							
							
							
							String n = request.getParameter("m3");
							String catQuerry = "Select category from TH";

							//System.out.println(query);
							ResultSet rs = null;
							Set<String> listofcategories = new HashSet<String>();
							
							try{
					   		 		rs = con.stmt.executeQuery("SELECT category from TH");
						   		 	while (rs.next())
									 {
						   		 	 	listofcategories.add(rs.getString("category"));
									 }
							 	}
							catch(Exception e)
							 	{
							 		e.printStackTrace();
							 		out.println(e);
							 	}
							finally
							 	{
							 		try{
						   		 		if (rs != null)
						   		 		{
						   		 			rs.close();
						   		 		}
							 		}
							 		catch(Exception e)
							 		{
							 			e.printStackTrace();
							 			out.println("cannot close resultset");
							 		}
							 	}
							
							for(String s : listofcategories)
				   		 	{
								%><h3> <% out.println(s); %></h3> <%
								ResultSet rq = null;
								String query = "Select TH.name, TH.category, THRating.TR from TH, (Select THR.THid as THID, AVG(THR.Rating) as TR from THRatings as THR GROUP BY THR.THid) AS THRating "
										+ "WHERE TH.THid = THRating.THID "
				   						+ "AND TH.category = '" + s + "' "
										+ "ORDER BY THRating.TR DESC, TH.name , TH.category " 
										+ "LIMIT " + n + ";";
								
								
										
									try{
											//out.println(query);
							   		 		rq = con.stmt.executeQuery(query);
								   		 	while (rq.next())
											 {
								   		 	 	%> - <% out.println(rq.getString("name")); %><br><%
											 }
									 	}
									catch(Exception e)
									 	{
									 		e.printStackTrace();
									 		out.println(e);
									 	}
									finally
									 	{
									 		try{
								   		 		if (rq != null)
								   		 		{
								   		 			rq.close();
								   		 		}
									 		}
									 		catch(Exception e)
									 		{
									 			e.printStackTrace();
									 			out.println("cannot close resultset");
									 		}
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