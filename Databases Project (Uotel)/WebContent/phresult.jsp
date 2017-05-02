<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="cs5530.testdriver2"%>
<%@ page import="cs5530.Connector"%>
<%@ page import="cs5530.TH"%>
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
                        <h1>My PH</h1>
						<% 
						
						if (request.getParameter("add") != null) {
						//generate THid
						String name = request.getParameter("THname");	
						String year = request.getParameter("THyear");
						String price = request.getParameter("THprice");
						String category = request.getParameter("THcategory");
						String addr = request.getParameter("THaddress");
						
							try
					      	 {
								TH temp = new TH();
								int THid = temp.generateTHid(con.stmt);
								int yearINT = Integer.parseInt(year);
								int priceINT = Integer.parseInt(price);
					  			 String AddTH = "INSERT INTO TH " +
					                    "VALUES (" + THid + ", '" + name + "', " + yearINT + ", " + priceINT + ", '" + category + "', '" + addr +"')";
					  			//System.out.println(AddTH);
					      		 con.stmt.executeUpdate(AddTH);
					      		 String AddListed = "INSERT INTO Listed " +
					                    "VALUES ('" + login + "', " + THid + ")";
					      		 
					      		//System.out.println(AddListed);
					      		 con.stmt.executeUpdate(AddListed);
					      		 out.println(name + " has been successfully added to the database!");
					      	 }
					      	 catch(Exception e)
					      	 {
					      		 e.printStackTrace();
					      		 System.out.println("Add failed.");
					      	 } 
							
						
    					} 
						else if (request.getParameter("update") != null) 
						{
							String currentname = request.getParameter("THnames");
							String name = request.getParameter("UpTHname");	
							String year = request.getParameter("UpTHyear");
							String price = request.getParameter("UpTHprice");
							String category = request.getParameter("UpTHcategory");
							String addr = request.getParameter("UpTHaddress");
							
							//String statement = "UPDATE TH SET name='" + name + "' WHERE name ='" + currentname + "'";
							String statement = "UPDATE TH SET";
							try
							{
								if(name != "")
								{
									String namestmt =  " name='" + name + "'";
									statement += namestmt;
								}
								if(year != "")
								{ 
									if(statement.substring(statement.length() - 3) != "SET")
									{
										statement += ",";
									}
									String yrstmt =  " yearbuilt='" + year + "'";
									statement += yrstmt;
								}
								if(price != "")
								{
									if(statement.substring(statement.length() - 3) != "SET")
									{
										statement += ",";
									}
									String pricestmt =  " price='" + price + "'";
									statement += pricestmt;
								}
								if(category != "")
								{
									if(statement.substring(statement.length() - 3) != "SET")
									{
										statement += ",";
									}
									String catstmt =  " category='" + category + "'";
									statement += catstmt;
								}
								if(addr != "")
								{
									if(statement.substring(statement.length() - 3) != "SET")
									{
										statement += ",";
									}
									String addrstmt =  " address='" + addr + "'";
									statement += addrstmt;
								}
								statement+=  " WHERE name ='" + currentname + "'";
								
								con.stmt.executeUpdate(statement);
								out.println("Update successful!");
							}
							catch(Exception e)
					      	 {
					      		 e.printStackTrace();
					      		 out.println("Update failed.");
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