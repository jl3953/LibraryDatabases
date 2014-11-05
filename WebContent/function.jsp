<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- This import is necessary for jdbc -->
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<%
Connection conn = null;
ResultSet rset = null;
String error_msg = ""; 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String derp = request.getParameter("item");
String searchString = request.getParameter("searchString");
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL("jdbc:oracle:thin:jl3953/LeighanneAndJennifer@//w4111b.cs.columbia.edu:1521/ADB");
			conn = ods.getConnection();
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("select * from books where "+derp+" like '%"+searchString+"%'");
		} 
		catch (SQLException e) {
			error_msg = e.getMessage();
			if( conn != null ) {
				conn.close();
				}
			}
		if(rset != null) {
			out.print("<table>");
			out.print("<th>Item ID</th><th>Title</th><th>ISBN</th><th>Genre</th>");
			String itemid = "";
			while(rset.next()) {
				out.print("<tr>");
				out.print("<td>" + (itemid = rset.getString("itemid")) + "</td>" +
				"<td>" + rset.getString("title") + "</td>" + 
				"<td>" + rset.getString("isbn") + "</td>" +
				"<td>" + rset.getString("genre") + "</td>");
				out.print("</tr>");
				}
			out.print("</table>");
			} else {
				out.print(error_msg);
				}
		if( conn != null ) {
			conn.close();
			}
%>	

<form action="reserve.jsp">
Item ID <input type="text" name="itemID">
Card Number <input type="text" name="cardNumber">
Preferred Pickup Location:
<select name="location">
  <option value="115th Street Library">115th Street Library</option>
  <option value="125th Street Library">125th Street Library</option>
  <option value="58th Street Library">58th Street Library</option>
  <option value="67th Street Library">67th Street Library</option>
  <option value="96th Street Library">96th Street Library</option>
  <option value="Aguilar Library">Aguilar Library</option>
  <option value="Andrew Heiskell Braille and Talking Book Library">Andrew Heiskell Braille and Talking Book Library</option>
  <option value="Battery Park City Library">Battery Park City Library</option>
  <option value="Bloomingdale Library">Bloomingdale Library</option>
  <option value="Stephen A. Schwarzman">Stephen A. Schwarzman</option>
</select>
<button type="submit">Reserve Book</button>
</form>
</body>
</html>