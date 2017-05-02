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

    <title>Uotel - Statistics</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/simple-sidebar.css" rel="stylesheet">

    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style>
	button.accordion {
	    background-color: #eee;
	    color: #444;
	    cursor: pointer;
	    padding: 18px;
	    width: 100%;
	    border: none;
	    text-align: left;
	    outline: none;
	    font-size: 15px;
	    transition: 0.4s;
	}
	
	button.accordion.active, button.accordion:hover {
	    background-color: #ddd;
	}
	
	div.panel {
	    padding: 0 18px;
	    background-color: white;
	    max-height: 0;
	    overflow: hidden;
	    transition: max-height 0.2s ease-out;
	}
	</style>
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
                        <h1>Statistics</h1>        
                        
						<p></p>
						<button class="accordion"><i>m</i> most popular THs for each category</button>
						<div class="panel">
						<form action="statsresult.jsp" method="GET">
						  <p>Retrieve the names of the
					        <input type="number" name="m1"> most popular THs 
						  </p>
						  <p>
						  <input type="submit" value="Retrieve!" onClick="" name="FIRST">
						  </p>
						</form>
						</div>
						
						<button class="accordion"><i>m</i> most expensive THs for each category</button>
						<div class="panel">
						<form action="statsresult.jsp" method="GET">
						  <p>Retrieve the names of the
					        <input type="number" name="m2"> most expensive THs
						  </p>
						  <p>
						  <input type="submit" value="Retrieve!" onClick="" name="SECOND">
						  </p>
						</form>  
						</div>
						
						<button class="accordion"><i>m</i> highly rated PHs for each category</button>
						<div class="panel">
						<form action="statsresult.jsp" method="GET">
						  <p>
						  	Retrieve the names of the
					        <input type="number" name="m3"> most highly rated PHs
						  </p>
						  <p>
						  <input type="submit" value="Retrieve!" onClick="" name="THIRD">
						  </p>
						</form>  
						</div>
						<script>
						var acc = document.getElementsByClassName("accordion");
						var i;
						
						for (i = 0; i < acc.length; i++) {
						  acc[i].onclick = function() {
						    this.classList.toggle("active");
						    var panel = this.nextElementSibling;
						    if (panel.style.maxHeight){
						      panel.style.maxHeight = null;
						    } else {
						      panel.style.maxHeight = panel.scrollHeight + "px";
						    } 
						  }
						}
						</script>
                        
                        
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