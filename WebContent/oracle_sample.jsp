<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- This import is necessary for jdbc -->
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<!-- Database lookup -->
<%
Connection conn = null;
ResultSet rset = null;
String error_msg = "";
try {
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:jl3953/LeighanneAndJennifer@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	Statement stmt = conn.createStatement();
	rset = stmt.executeQuery("select * from authors");
} 
catch (SQLException e) {
	error_msg = e.getMessage();
	if( conn != null ) {
		conn.close();
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="stylesheet.css" type="text/css">
<title>Employee Table JSP Sample</title>
</head>
<body>
<div id="menu">
<ul>
<li class="first active"><a href="#" accesskey="1" title="">Home</a></li>
<li><a href="LinkPage.jsp" accesskey="2" title="">Link Page</a></li>
<li><a href="#" accesskey="3" title="">Photographs</a></li>
<li><a href="#" accesskey="4" title="">Videos</a></li>
<li><a href="contactUs.html" accesskey="5" title="">Contact Us</a></li>
</ul>
</div>
<H2>Employee Table</H2>
<p> <a href="function.jsp">link page</a>
<p> <a href="reserve.jsp">reserve books</a>
<form action = "function.jsp">
<input type="text" name="searchString">
<select name="item">
  <option value="title">Title</option>
  <option value="isbn">ISBN</option>
  <option value="deweydecimal">Dewey Decimal</option>
  <option value="genre">Genre</option>
</select>
<input type="submit" value="Submit">
</form>
<TABLE>
<tr>
<td>AUTHORID</td><td>FIRSTNAME</td><td>LASTNAME</td>
</tr>
<tr>
<td><b>----------</b></td><td><b>----------</b></td><td><b>----------</b></td>
</tr>
<%
if(rset != null) {
	while(rset.next()) {
		out.print("<tr>");
		out.print("<td>" + rset.getInt("authorid") + "</td><td>" +
		rset.getString("firstname") + "</td>" +
				"<td>" + rset.getString("lastname") + "</td>");
		out.print("</tr>");
		}
	} else {
		out.print(error_msg);
		}
if( conn != null ) {
	conn.close();
	}
%>
</TABLE>
</body>
</html>