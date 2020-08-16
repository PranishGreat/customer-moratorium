<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%

String driver = "com.mysql.jdbc.Driver";

try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"  href="display1.css">
<script language="javascript">
function approvedRecord(id){
    var f=document.form;
    f.method="post";
    f.action='Approved.jsp?id='+id;
    f.submit();
}
function notapprovedRecord(id){
    var f=document.form;
    f.method="post";
    f.action='NotApproved.jsp?id='+id;
    f.submit();
}
</script>
</head>
<body>

<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>
<script>
function alert()
{	
	swal ('Logout Suceesfully!!!','','success').then(() => {	
		var delayInMilliseconds = 1000; //1 second
		setTimeout(function() {
			
			location='AdminLogin.jsp';
			
		}, delayInMilliseconds);
	});
	
}

</script>
<div class="d1"><Button  class="button" type="button"  onclick="alert()">Logout</Button>
<div>
	<h1 style="text-align: center;">Customer's Data</h1>
</div>
</div>
<div class="tab">
  <button class="tablink" onclick="openPage('Pending', this,'green')" id="defaultOpen">Pending</button>
  <button class="tablink" onclick="openPage('Approved', this,'green')">Approved</button>
  <button class="tablink" onclick="openPage('NotApproved', this,'green')">Not Approved</button>
</div>
<div id="Pending" class="tabcontent">
<form method="post" name="form">
<table border="1">
<tr>
<th>Query No.</th>
<th>Time</th>
<th>Name</th>
<th>Adhar</th>
<th>Account No</th>
<th>Mobile</th>
<th>Loan</th>
<th>Income-Src</th>
<th>Monthly-Src</th>
<th>EMI</th>
<th>Wage-Cut</th>
<th>Affect</th>
<th>Covid-Zone</th>
<th>Rent</th>
<th>Terms</th>
<th>Repay-Month</th>
<th>Reason</th>
<th>Change Status</th>
</tr>
<tr>
	<%
	try{
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");
	statement=connection.createStatement();
	String sql ="select * from details where status='Pending'";
	resultSet = statement.executeQuery(sql);
	%>
	<%
	while(resultSet.next()){
	%>
	<tr>
	<td><%=resultSet.getString("id") %></td>
	<td><%=resultSet.getString("time") %></td>
	<td><%=resultSet.getString("name") %></td>
	<td><%=resultSet.getString("adhar") %></td>
	<td><%=resultSet.getString("account_no") %></td>
	<td><%=resultSet.getString("mobile") %></td>
	<td><%=resultSet.getString("loan") %></td>
	<td><%=resultSet.getString("income_source") %></td>
	<td><%=resultSet.getString("month_income") %></td>
	<td><%=resultSet.getString("month_emi") %></td>
	<td><%=resultSet.getString("wagecut") %></td>
	<td><%=resultSet.getString("affect") %></td>
	<td><%=resultSet.getString("zone") %></td>
	<td><%=resultSet.getString("rent") %></td>
	<td><%=resultSet.getString("terms") %></td>
	<td><%=resultSet.getString("repay") %></td>
	<td><%=resultSet.getString("reason") %></td>
	<td>
	<input type="button" name="approved" value="Approved" style="background-color:green;font-weight:bold;color:white;" onclick="approvedRecord(<%=resultSet.getString("id")%>);" >
	<input type="button" name="notapproved" value="Not Approved" style="background-color:red;font-weight:bold;color:white;" onclick="notapprovedRecord(<%=resultSet.getString("id")%>);" >
	</td>
	</tr>
	<% }
	}
	catch (Exception e) 
	{
	e.printStackTrace();
	}
	%>
</table>

</form>
</div>

<div id="Approved" class="tabcontent">
<table border="1">
<tr>
<th>Query No.</th>
<th>Time</th>
<th>Name</th>
<th>Adhar</th>
<th>Account No</th>
<th>Mobile</th>
<th>Loan</th>
<th>Income-Src</th>
<th>Monthly-Src</th>
<th>EMI</th>
<th>Wage-Cut</th>
<th>Affect</th>
<th>Covid-Zone</th>
<th>Rent</th>
<th>Terms</th>
<th>Repay-Month</th>
<th>Reason</th>
</tr>
<tr>
	<%
	try{
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");
	statement=connection.createStatement();
	String sql ="select * from details where status='Approved'";
	resultSet = statement.executeQuery(sql);
	%>
	<%
	while(resultSet.next()){
	%>
	<tr>
	<td><%=resultSet.getString("id") %></td>
	<td><%=resultSet.getString("time") %></td>
	<td><%=resultSet.getString("name") %></td>
	<td><%=resultSet.getString("adhar") %></td>
	<td><%=resultSet.getString("account_no") %></td>
	<td><%=resultSet.getString("mobile") %></td>
	<td><%=resultSet.getString("loan") %></td>
	<td><%=resultSet.getString("income_source") %></td>
	<td><%=resultSet.getString("month_income") %></td>
	<td><%=resultSet.getString("month_emi") %></td>
	<td><%=resultSet.getString("wagecut") %></td>
	<td><%=resultSet.getString("affect") %></td>
	<td><%=resultSet.getString("zone") %></td>
	<td><%=resultSet.getString("rent") %></td>
	<td><%=resultSet.getString("terms") %></td>
	<td><%=resultSet.getString("repay") %></td>
	<td><%=resultSet.getString("reason") %></td>
	</tr>
	<% }
	}
	catch (Exception e) 
	{
	e.printStackTrace();
	}
	%>
</table>
</div>

<div id="NotApproved" class="tabcontent">
<table border="1">
<tr>
<th>Query No.</th>
<th>Time</th>
<th>Name</th>
<th>Adhar</th>
<th>Account No</th>
<th>Mobile</th>
<th>Loan</th>
<th>Income-Src</th>
<th>Monthly-Src</th>
<th>EMI</th>
<th>Wage-Cut</th>
<th>Affect</th>
<th>Covid-Zone</th>
<th>Rent</th>
<th>Terms</th>
<th>Repay-Month</th>
<th>Reason</th>
</tr>
<tr>
	<%
	try{
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");
	statement=connection.createStatement();
	String sql ="select * from details where status='Not Approved'";
	resultSet = statement.executeQuery(sql);
	%>
	<%
	while(resultSet.next()){
	%>
	<tr>
	<td><%=resultSet.getString("id") %></td>
	<td><%=resultSet.getString("time") %></td>
	<td><%=resultSet.getString("name") %></td>
	<td><%=resultSet.getString("adhar") %></td>
	<td><%=resultSet.getString("account_no") %></td>
	<td><%=resultSet.getString("mobile") %></td>
	<td><%=resultSet.getString("loan") %></td>
	<td><%=resultSet.getString("income_source") %></td>
	<td><%=resultSet.getString("month_income") %></td>
	<td><%=resultSet.getString("month_emi") %></td>
	<td><%=resultSet.getString("wagecut") %></td>
	<td><%=resultSet.getString("affect") %></td>
	<td><%=resultSet.getString("zone") %></td>
	<td><%=resultSet.getString("rent") %></td>
	<td><%=resultSet.getString("terms") %></td>
	<td><%=resultSet.getString("repay") %></td>
	<td><%=resultSet.getString("reason") %></td>
	</tr>
	<% }
	}
	catch (Exception e) 
	{
	e.printStackTrace();
	}
	%>
</table>
</div>

<script>
function openPage(pageName, elmnt,color) {
	  var i, tabcontent, tablinks;
	  tabcontent = document.getElementsByClassName("tabcontent");
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }

	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].style.backgroundColor = "";
	  }

	  // Show the specific tab content
	  document.getElementById(pageName).style.display = "block";

	  // Add the specific color to the button used to open the tab content
	  elmnt.style.backgroundColor = color;
	}

	// Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();
</script>

</body>
</html>