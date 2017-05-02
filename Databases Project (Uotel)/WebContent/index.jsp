<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="cs5530.testdriver2"%>
<%@ page import="cs5530.Connector"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.List.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CS 5530 - Databases - Phase 3</title>
</head>
<body>
<center>


<% 
Connector con = new Connector(); 
%>





<p>
Login: 
	<% String login = request.getParameter("login"); %>
	<% out.println("Welcome, " + login + "!"); %>
</p>
<p>
Now logging you in...
	<% String pw  = request.getParameter("password"); %>
</p>

<% 


	BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
	String[] lookup = testdriver2.UserQuery(login, pw, in, con);


	if(lookup[0] != null && lookup[1] != null)
	{	
		 session.setAttribute("login", login);
		 response.sendRedirect("menu.jsp");
	}
	else
	{
		 try
		 {
			 String AddUser = "INSERT INTO Users (loginname, password)" +
	                "VALUES ('" + login + "', '" + pw + "')";
			 con.stmt.executeUpdate(AddUser);
			 session.setAttribute("login", login);
			 response.sendRedirect("menu.jsp");
		 }
		 catch(Exception e)
		 {
			 System.out.println("That loginname is taken.");
			 response.sendRedirect("index.html");
			 
		 } 
	}

%>



</center>
</body>
</html>