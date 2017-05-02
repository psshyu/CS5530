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
                        <h1>Feedbacks</h1>
                        
						<p>Click on the buttons to open the collapsible content.</p>
						<button class="accordion">Leave Feedback for a TH</button>
						<div class="panel">
						<form action="feedbackresult.jsp" method="GET">
						  <p>
						  	Name of TH: 
						  	<% 
							ResultSet resultset = null; 
							resultset = con.stmt.executeQuery("SELECT name from TH") ; 
							%>
	
					        <select id="THnames" name="THname">
					        <%  while(resultset.next()){ %>
					            <option><%= resultset.getString("name")%></option>
					        <% } %>
					        </select>
					        
					        <br>
						  	
						  	Rating: 
						  	<select id="rating" name="rating">
						  	<option>10</option>
						  	<option>9</option>
						  	<option>8</option>
						  	<option>7</option>
						  	<option>6</option>
						  	<option>5</option>
						  	<option>4</option>
						  	<option>3</option>
						  	<option>2</option>
						  	<option>1</option>
						  	<option>0</option>
						  	</select>
						  	<br>
						  	Date: <p id="date"></p>
						  	<script>
						  		n =  new Date();
						  		y = n.getFullYear();
						  		m = n.getMonth() + 1;
						  		d = n.getDate();
						  		document.getElementById("date").innerHTML = m + "/" + d + "/" + y;
						  	</script>
						  	<br>
						  	Optional Text:
						  	<br>
						  	<textarea name="Text1" cols="40" rows="5"></textarea>
						  	<br>
						  	<input type="submit" value="Leave feedback" onClick="" name="FIRST">
						  </p>
						</form>
						</div>
						
						
						
						
						
						
						
						<button class="accordion">Read Most Useful Feedback for a TH </button>
						<div class="panel">
						<form action="feedbackresult.jsp" method="GET">
						  <p>
						  	<% 
							ResultSet resultset3 = null; 
							resultset3 = con.stmt.executeQuery("SELECT name from TH") ; 
							%>
					     
					        Retrieve the top- 
					        <input type="number" name="nMostUseful"> results for 
					        <select id="THnames" name="THname">
					        <%  while(resultset3.next()){ %>
					            <option><%= resultset3.getString("name")%></option>
					        <% } %>
					        </select>
					        <br> 
					        <input type="submit" value="Get the most useful feedback" onClick="" name="THIRD">
						  </p>
						  </form>
						</div>
						
						
						
						
						
						<button class="accordion">Rate Others'Feedbacks</button>
						<div class="panel">
						<form action="feedbackresult.jsp" method="GET">
						  <p>
						  	Name of TH: 
						  	<% 
							ResultSet resultset2 = null; 
							resultset2 = con.stmt.executeQuery("SELECT RatingID from THRatings") ; 
							%>
	
					        <select id="THnames" name="rateID">
					        <%  while(resultset2.next()){ %>
					            <option><%= resultset2.getInt("RatingID")%></option>
					        <% } %>
					        </select>
					        <br>
					        How useful is this rating? 
					        <select id="useful" name="Useful">
					        <option>2 - Very Useful</option>
						  	<option>1 - Useful</option>
						  	<option>0 - Useless</option>
					        </select>
					        <br>
					        <input type="submit" value="Rate Feedback" onClick="" name="SECOND">
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