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
ResultSet titleAuthor = null;
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
<%
String cardNumber = request.getParameter("cardNumber");
try {
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:jl3953/LeighanneAndJennifer@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	Statement stmt = conn.createStatement();
	borrows = stmt.executeQuery("select * from borrows where cardnumber="+cardNumber);
	reserves = stmt.executeQuery("select * from reserves where cardnumber="+cardNumber);
	latefee = stmt.executeQuery("select * from returns where cardNumber="+cardNumber);
} 
catch (SQLException e) {
	error_msg = e.getMessage();
	if( conn != null ) {
		conn.close();
		}
	}
%>
<br>
<h1>BORROWED</h1>
<table>
<tr>
<th>Title</th><th>Author</th><th>Checkout Date</th><th>Return Date</th>
</tr>

</table>
</body>
</html>