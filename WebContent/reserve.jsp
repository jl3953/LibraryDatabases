<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!
public String myDate() {
	DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
	Date date = new Date();
	return dateFormat.format(date);
}
%>
<%
String itemID = request.getParameter("itemID");
String cardNumber = request.getParameter("cardNumber");
String location = request.getParameter("location");
//if the book is already on reserve, add their id to the queue number
Connection conn = null;
ResultSet rset = null;
String error_msg = "";
try {
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:jl3953/LeighanneAndJennifer@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	Statement stmt = conn.createStatement();
	Statement stmt2 = conn.createStatement();
	rset = stmt.executeQuery("select itemid from reserves where itemid="+itemID);
	if (rset.next()){
		ResultSet resultset = stmt.executeQuery("select numinqueue from reserves where itemid="+itemID);
		int numinqueue = 0;
		if (resultset.next())
			numinqueue = resultset.getInt("numinqueue");
		String date = myDate();
		int count = stmt2.executeUpdate("insert into reserves (itemid, cardnumber, addtime, librarychosen, numinqueue) "+
		"values('"+itemID+"'," +
		"'"+cardNumber+"'," +
		"'"+ date+"'," + 
		"'" + location + "',"+
		"'"+ numinqueue++ + "')");
	}
	else {
		String date = myDate();
		int count = stmt2.executeUpdate("insert into reserves (itemid, cardnumber, addtime, librarychosen, numinqueue) "+
		"values('"+itemID+"'," +
		"'"+cardNumber+"'," +
		"'"+ date+"'," + 
		"'" + location + "',"+
		"'1')");
	}
	out.print("<p> Reservation was successful! </p>");
} 
catch (SQLException e) {
	out.print(e.getMessage());
	if( conn != null ) {
		conn.close();
		}
	}

//if not, add the book to the queue
//select where cardnumber is in the reserves table
//check constraints
%>
<p> Go back to <a href="oracle_sample.jsp">Home Page</a></p>
</body>
</html>