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

    <title>Uotel - PHs</title>
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
	
	
	label{
	display:inline-block;
	width:200px;
	margin-right:30px;
	text-align:right;
	}
	
	input{
	
	}
	
	fieldset{
	border:none;
	width:500px;
	margin:0px auto;
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
                        <h1>My PHs</h1>
                        
						<p>Click on the buttons to open the collapsible content.</p>
						
						<button class="accordion">Add new PH</button>
						<div class="panel">
						  <p>
						  <form action="phresult.jsp" method="GET">
							 <fieldset>
							 <label for="txtName">Name:</label><input type="text" name="THname" size="20">
							 <label for="numYear">Year:</label><input type="number" name="THyear" size="20">
							 <label for="numPrice">Price:</label><input type="number" name="THprice" size="20">
							 <label for="txtCategory">Category:</label><input type="text" name="THcategory" size="20">
							 <label for="txtAddress">Address:</label><input type="text" name="THaddress" size="20">
							 <input type="submit" value="Add PH" onClick="" name="add">
							 </fieldset>
							 </form>
						  </p>
						</div>
						
						<button class="accordion">Update Existing PH</button>
						<div class="panel">
						  <p>
						  Select a PH to update: 
						  
						  	<% 
							ResultSet resultset = null; 
							resultset = con.stmt.executeQuery("SELECT TH.name from Listed, TH where TH.THid = Listed.THid AND Listed.loginname = '" + login + "'") ; 
							%>
							<form action="phresult.jsp" method="GET">
					        <select id="THnames" name="THnames">
					        <%  while(resultset.next()){ %>
					            <option><%= resultset.getString("name")%></option>
					        <% } %>
					        </select>
							<br>
							
							<fieldset>
							 <label for="txtName">Update Name:</label><input type="text" name="UpTHname" size="20">
							 <label for="numYear">Update Year:</label><input type="number" name="UpTHyear" size="20">
							 <label for="numPrice">Update Price:</label><input type="number" name="UpTHprice" size="20">
							 <label for="txtCategory">Update Category:</label><input type="text" name="UpTHcategory" size="20">
							 <label for="txtAddress">Update Address:</label><input type="text" name="UpTHaddress" size="20">
							 <br>
							 <input type="submit" value="Update PH" onClick="" name="update">
							 </fieldset>
							 </form>
						  </p>
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