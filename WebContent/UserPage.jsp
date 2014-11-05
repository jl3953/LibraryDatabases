<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<!-- Database lookup -->
<%
Connection conn = null;
ResultSet borrows = null;
ResultSet reserves = null;
ResultSet latefee = null;
ResultSet title = null;
ResultSet author = null;
String error_msg = "";
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="stylesheet.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
<div id="menu">
<ul>
<li class="first active"><a href="#" accesskey="1" title="">Home</a></li>
<li><a href="oracle_sample.jsp" accesskey="2" title="">Search Books</a></li>
<li><a href="#" accesskey="3" title="">Search DVD/CD</a></li>
<li><a href="#" accesskey="4" title="">Search Journals</a></li>
<li><a href="#" accesskey="5" title="">Search Newspapers</a></li>
<li><a href="#" accesskey="6" title="">Libraries</a></li>
</ul>
</div>
<br>
<h1>Borrows</h1>
<table>
<tr>
<th>Title</th><th>Type</th><th>Checkout Date</th><th>Return Date</th>
</tr>
<%
String cardNumber = request.getParameter("cardNumber");
try {
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:jl3953/LeighanneAndJennifer@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	Statement stmt = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	borrows = stmt.executeQuery("select itemid, checkoutdate, returndate from borrows where cardnumber="+cardNumber);
	
	while(borrows.next()) {
		String checkout = borrows.getString("checkoutdate");
		String returndate = borrows.getString("returnDate");
		int itemid = borrows.getInt("itemid");
		String myTitle = "";
		String type = "";
		if (itemid < 300){
			title = stmt2.executeQuery("select title from books where itemid="+itemid);
			title.next();
			myTitle = title.getString("title");
			type = "Book";
		}
		else{
			title = stmt2.executeQuery("select name from DVDCD where itemid="+itemid);
			title.next();
			myTitle = title.getString("name");
			type = "Dvd/Cd";
		}
		out.print("<tr>");
		out.print("<td>" + myTitle + "</td>");
		out.print("<td>" + type + "</td>");
		out.print("<td>" + checkout.substring(0,10) + "</td>");
		out.print("<td>" + returndate.substring(0,10) + "</td>");
		out.print("</tr>");
	}
	out.print("</Table>");
	reserves = stmt.executeQuery("select itemid, librarychosen, numinqueue from reserves where cardnumber="+cardNumber);
	out.print("<h1> Reserves </h1>");
	out.print("<Table>");
	out.print("<tr>" + 
	"<th>Title</th><th>Type</th><th>Pickup</th><th>Place in Line</th>" +
	"</tr>");
	while(reserves.next()) {
		String libraryChosen = reserves.getString("librarychosen");
		String numinqueue = reserves.getString("numinqueue");
		int itemid = reserves.getInt("itemid");
		String myTitle = "";
		String type = "";
		if (itemid < 300){
			title = stmt2.executeQuery("select title from books where itemid="+itemid);
			title.next();
			myTitle = title.getString("title");
			type = "Book";
		}
		else{
			title = stmt2.executeQuery("select name from DVDCD where itemid="+itemid);
			title.next();
			myTitle = title.getString("name");
			type = "Dvd/Cd";
		}
		out.print("<tr>");
		out.print("<td>" + myTitle + "</td>");
		out.print("<td>" + type + "</td>");
		out.print("<td>" + libraryChosen + "</td>");
		out.print("<td>" + numinqueue + "</td>");
		out.print("</tr>");
	}
	out.print("</Table>");
	latefee = stmt.executeQuery("select * from returns where cardNumber="+cardNumber);
	out.print("<h1>Late Fees </h1>");
	out.print("<Table>");
	out.print("<tr>" + 
	"<th>Title</th><th>Type</th><th>Return Date</th><th>Late Date</th><th>Fee</th>" +
	"</tr>");
	while(latefee.next()) {
		String returndate = latefee.getString("assigneddate");
		String latedate = latefee.getString("actualdate");
		int fee = latefee.getInt("latefee");
		int itemid = latefee.getInt("itemid");
		String myTitle = "";
		String type = "";
		if (itemid < 300){
			title = stmt2.executeQuery("select title from books where itemid="+itemid);
			title.next();
			myTitle = title.getString("title");
			type = "Book";
		}
		else{
			title = stmt2.executeQuery("select name from DVDCD where itemid="+itemid);
			title.next();
			myTitle = title.getString("name");
			type = "Dvd/Cd";
		}
		out.print("<tr>");
		out.print("<td>" + myTitle + "</td>");
		out.print("<td>" + type + "</td>");
		out.print("<td>" + returndate.substring(0,10) + "</td>");
		out.print("<td>" + latedate.substring(0,10) + "</td>");
		out.print("<td>" + fee + "</td>");
		out.print("</tr>");
	}
	out.print("</Table>");
} 
catch (SQLException e) {
	out.print(e.getMessage());
	if( conn != null ) {
		conn.close();
		}
	}
%>


</table>
</body>
</html>