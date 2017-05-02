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
                        <b>Browse TH Result</b>
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
                        <h1>Browse Results</h1>
						<%
						ResultSet rs = null;
						String ByPrice = " ORDER BY price;";
						
						String query = request.getParameter("browseTH");
						String sortSTR = request.getParameter("sort");
						String sort = sortSTR.substring(0,1); 
						String[] splits = query.split("Where|where|WHERE|From|from|FROM|;");
						if (sort == "1")
						{
							query = splits[0] + "FROM" + splits[1] + "WHERE" + splits[2] + ByPrice; 
						}
						if (sort == "2")
						{
							query = splits[0] + ", AVG(THRatings.Rating)AS AvRate FROM THRatings," + splits[1] + 
									"WHERE TH.THid = THRatings.THid AND " + splits[2] + 
									" GROUP BY name ORDER BY AvRate DESC;";
						}
						if (sort == "3")
						{
							
						}
						System.out.println(query);
						try{
				   		 	rs = con.stmt.executeQuery(query);
				   		 	while (rs.next())
							 {
							        out.println(rs.getString("name")); %> <br> <%
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