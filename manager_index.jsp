<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>������ �α��� ���</title>
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
     <div style="font-size:30px; font-weight:bold; margin-top:100px;"> [ MakeUpMate : ������ ��� ] </div>
      <table>
	  <tr>
 			<td>���Ӱ����� ID : </td>
	  	    <td><%=userRs.getString("login_id")%></td>
	  </tr>
      <tr>
 			<td>���� �ð�: </td>
	  	    <td><%=curDate %></td>
	  </tr>
	  </table>

<a href="member.html">[ȸ�� ����]</a><br><br>
<a href="selectAllGoods.jsp">[��ǰ ����]</a><br><br>
<a href="function.jsp">[�ֹ� ����]</a><br><br>
<a href="logout.jsp" target=_parent>[������ �α׾ƿ�]</a>

</center>
</body>
</html>