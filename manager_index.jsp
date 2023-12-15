<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>包府磊 肺弊牢 搬苞</title>
</head>
<style>
*{
font-size:20px;
margin: 20px 0;}
a{
text-decoration:none;
color:black;
cursor:pointer;
}
</style>

 <body>
 <center>

<% 

 	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String id = (String)session.getAttribute("sid");

    String jsql = "select * from user where user_id = ? "; 
    PreparedStatement pstmtUser = con.prepareStatement(jsql);
    pstmtUser.setString(1, id);
    ResultSet userRs = pstmtUser.executeQuery();
    userRs.next();
	java.util.Date date = new java.util.Date();  
   String curDate = date.toLocaleString();   
 %>
     <div style="font-size:30px; font-weight:bold; margin-top:100px;"> [ MakeUpMate : 包府磊 葛靛 ] </div>
      <table>
	  <tr>
 			<td>立加包府磊 ID : </td>
	  	    <td><%=userRs.getString("login_id")%></td>
	  </tr>
      <tr>
 			<td>立加 矫阿: </td>
	  	    <td><%=curDate %></td>
	  </tr>
	  </table>

<a href="member.html">[雀盔 包府]</a><br><br>
<a href="selectAllGoods.jsp">[惑前 包府]</a><br><br>
<a href="function.jsp">[林巩 包府]</a><br><br>
<a href="logout.jsp" target=_parent>[包府磊 肺弊酒眶]</a>

</center>
</body>
</html>