<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="cs5530.testdriver2"%>
<%@ page import="cs5530.Connector"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.List.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Uotel - Trust </title>
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
                        <b>Main Menu</b>
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
                        <h1>Rate Trustworthiness of Other Users</h1>
						<p>
 
							<%
							 String other = request.getParameter("ratee");
							 String trust  = request.getParameter("trust");
							 out.println(login + " attempting to rate " + other + " as " + trust); %>
						</p>

                        <%
                        String error;
                        boolean trustworthy;
                        
                        if(login.equals(other))
            			{
							out.println("You can't rate yourself!");
							out.println("User rating unsuccessful");
            			}
                        
                        if(trust.equals("is trustworthy"))
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
                      		 con.stmt.executeUpdate(AddRating);
                      	}
                      	catch(Exception e)
                      	{
                      		 System.out.println("User rating unsuccessful");
                      		 response.sendRedirect("error.jsp");
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