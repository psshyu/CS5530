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
                        <form action ="trustresult.jsp" method="GET">
                        <p>
						
						<% 
						ResultSet resultset = null; 
						resultset = con.stmt.executeQuery("select loginname from Users") ; 
						%>

				        <select id="ratee" name="ratee">
				        <%  while(resultset.next()){ %>
				            <option><%= resultset.getString("loginname")%></option>
				        <% } %>
				        </select>
				        
						<select id="trust" name="trust">
						<option>is trustworthy</option>
						<option>is NOT trustworthy</option>
						</select>
						
						<input type="submit" value="Rate!" onClick="">
                        </p>
                        </form>
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