<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%

String driver = "com.mysql.jdbc.Driver";

try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;

ResultSet r1 = null;
%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
	<style type="text/css">
	#sec1{
    border: 1px solid limegreen;
    top:1px;
    margin-bottom: 20px;
}
.row{
    margin-left: 10px;
    top:0;
    position: static;
}

#tit1{
    font-family: 'Times New Roman', Times, serif;
    font-size: 22px;
    text-align: center;
    background-color: limegreen;
}
	</style>
		<title>Chat Bot</title>
		<script src="https://unpkg.com/brain.js@1.0.0-rc.3/browser.js"></script>
		<link rel="stylesheet" type="text/css" href="Moratorium.css">
	</head>
	<body onload="getdata()">
	
	<section class="msger">
  <header class="msger-header">
    <div class="msger-header-title">
      <i class="fas fa-comment-alt">
	  </i> Moratorium Chatbot	
    </div>
	<div class="msger-header-options">
      <span><i class="fas fa-cog"></i></span>
    </div>
  </header>
  <main class="msger-chat">
    <div class="msg left-msg">
      <div></div>
        <div class="msg-info">
          <div class="msg-info-name"></div>
          <div class="msg-info-time"></div>
        </div>
        <div class="msg-text">
        </div>
    </div>
    <div class="msg right-msg">
        <div class="msg-info">
        </div>
        <div class="msg-text">
        </div>
    </div>
  </main>
  <form class="msger-inputarea" >
    <input type="text"  class="msger-input" placeholder="Enter your message...">
    <button type="submit" class="msger-send-btn">Send</button>
	
	<button type="button" class="msger-send-btn" onClick="window.location.reload();">Reload</button>
	<button type="button"  class="msger-logout-btn" id="lo" onclick="alert()">Logout</button>
	 <script type="text/javascript" src="MoratorimChat.js" ></script>
	 </form>
	 <form class="msger-inputarea" action="<%= request.getContextPath() %>/save" method="post" onsubmit="return getd()">
	 	
	 	 <input type='text' id="t1"  name="name" style=" display:none;" >
		 <input type='text' id="t2"  name="mobile" style=" display:none;">
		 <input type='text' id="t3"  name="loan" style=" display:none;">
		 <input type='text' id="t4"  name="incomesource" style=" display:none;">
		 <input type='text' id="t5"  name="monthincome" style=" display:none;">
		 <input type='text' id="t6"  name="monthemi" style=" display:none;">
		 <input type='text' id="t7"  name="wagecut" style=" display:none;">
		 <input type='text' id="t8"  name="affect" style=" display:none;">
		 <input type='text' id="t9"  name="zone" style=" display:none;">
		 <input type='text' id="t10"  name="rent" style=" display:none;">
		 <input type='text' id="t11"  name="terms" style=" display:none;">
		 <input type='text' id="t12"  name="repay" style=" display:none;">
		 <input type='text' id="t13" name="time" style=" display:none;">
		 <input type='text' id="t14" name="adhar" style=" display:none;">
		 <input type='text' id="t15" name="reason" style=" display:none;">
		 <input type="Submit" id="submitbt" value="Submit" class="msger-send-btn"  disabled />
		 <textarea id="myTextarea" style=" display:none;" ></textarea>

	 </form>
</section>

<section id="sec1">
                <p id="tit1">Status</p>
                <p class="para" id="p1"></p>      
</section>
<script>
function alert()
{
	swal ('Logout Suceesfully!!!','','success')
	.then(() => {
		var delayInMilliseconds = 1000; 
		setTimeout(function() {
			location='CustomerLogin.jsp';
		}, delayInMilliseconds);
	});
	
}
function getd()
{
var a=document.getElementById("myTextarea").value;
localStorage.setItem('textdetail',a);
console.log(a);
}
function download(){
	
    var text = localStorage.getItem('textdetail');
    console.log(text);
    text = text.replace(/\n/g, "\r\n"); // To retain the Line breaks.
    var blob = new Blob([text], { type: "text/plain"});
    var anchor = document.createElement("a");
    anchor.download = "my-filename.txt";
    anchor.href = window.URL.createObjectURL(blob);
    anchor.target ="_blank";
    anchor.style.display = "none"; // just to be safe!
    document.body.appendChild(anchor);
    anchor.click();
    document.body.removeChild(anchor);
  
 }
function getdata()
{
	
	 setTimeout(function(){  }, 50000);
	 <% 
	 String text=request.getParameter("email");
	 if(text!=null)
	 {
	 try{
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");
	    PreparedStatement st1=connection.prepareStatement("select * from customer where email = ?");  
        st1.setString(1,text);  
        r1=st1.executeQuery();
		%>
		<%
		if(r1.next()){
		%>
		var j="<%=r1.getString("account_no") %>"
		<%
		PreparedStatement st2 = connection.prepareStatement("select * from details where account_no = ?");
  	  	st2.setString(1, r1.getString("account_no"));
  	  	ResultSet r2=st2.executeQuery();
  	  	while(r2.next()){%>
  	  	var s1="<%=r2.getString("loan") %>"
  	  	var s2="<%=r2.getString("status") %>"
  	  	var para = document.createElement("p");
		var node = document.createTextNode("Moratorium On "+s1+" Loan is "+s2);
		para.appendChild(node);
		var element = document.getElementById("sec1");
		element.appendChild(para);
  	  	<%}
		%>
		<% }
		}
	 catch (Exception e) 
		{
		e.printStackTrace();
		}
	 }
	 else
	 {
		 String text1=request.getParameter("adhar");
		 if(text1!=null)
		 {%>
		 
		 <%try{
			 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bankdb?useSSL=false&serverTimezone=UTC", "root", "");
	 PreparedStatement st3=connection.prepareStatement("select * from details where adhar = ?");  
     st3.setString(1,text1);  
     System.out.println(st3);
     ResultSet r3=st3.executeQuery();
     while(r3.next()){%>
	  	var s1="<%=r3.getString("loan") %>"
	  	var s2="<%=r3.getString("status") %>"
	  	var para = document.createElement("p");
		var node = document.createTextNode("Moratorium On "+s1+" Loan is "+s2);
		para.appendChild(node);
		var element = document.getElementById("sec1");
		element.appendChild(para);
	  	<%}
		%>
		
	 <%}
		 catch (Exception e) 
			{
			e.printStackTrace();
			}
			}%>
		<%}
	 
		
		%>
}
</script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js'></script>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
</body>
</html>