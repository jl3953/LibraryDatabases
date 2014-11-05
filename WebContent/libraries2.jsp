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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
<th>Branch Name</th><th>Address</th><th>Hours of Operation</th>
</tr>
<%
String library = request.getParameter("location");
try {
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:jl3953/LeighanneAndJennifer@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	Statement stmt = conn.createStatement();
	rset = stmt.executeQuery("select * from library where branchname='"+library+"'");
	rset.next();
	out.print("<tr>");
	out.print("<td>" + rset.getString("branchname") + "</td>" +
	"<td>" + rset.getString("location") + "</td>" +
			"<td>" + rset.getString("hoursofoperation") + "</td>");
	out.print("</tr>");
	
} 
catch (SQLException e) {
	error_msg = e.getMessage();
	if( conn != null ) {
		conn.close();
		}
	}

%>
</table>
<p> Go back to <a href="Libraries.jsp">searching libraries</a></p>
</body>
</html>