<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html><head><title>ȸ�� ���̺� ���� ��ȸ   </title>
<style>
table{
border-collapse:collapse;
margin-top:20px;
}
td{
border:2px solid black;
padding:5px 12px;}
</style>
</head>
<body>

<%
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall"; 
     String DB_ID="multi";  
     String DB_PASSWORD="abcd"; 
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

     String jsql = "select * from user";   
	 PreparedStatement pstmt = con.prepareStatement(jsql);
	 ResultSet  rs = pstmt.executeQuery();
%>
			<div style="width:1280px; margin:0 auto">
<div style="font-size:30px; font-weight:bold; text-align:center; margin-top:50px;">[��ü ȸ�� ��ȸ] 
<table style="width:1280px;">
	<tr>
		<td>ID</td><td>��й�ȣ</td><td>����</td><td>�������</td><td>�̸���</td><td>�޴���ȭ</td><td>�г���</td><td><b>��������</b></td><td><b>ȸ�� ����</b></td>
	</tr>	

<%
		while(rs.next()){
			String id = rs.getString("login_id");   
    		String passwd =  rs.getString("user_pw");	
			String name = rs.getString("user_name");
    		String birth =  rs.getString("user_birth");
			String email =  rs.getString("user_email");
			String tel =  rs.getString("user_tel");
    		String nickname =  rs.getString("user_nickname");	
%>

   <tr>                     
 	  <td> <a href="selectDetailMember.jsp?id=<%=id%>"><%=id%></a></td>
      <td><%=passwd%></td>
	  <td><%=name%></td>
	  <td><%=birth%></td>
	  <td><%=email%></td> 
 	  <td><%=tel%></td> 
	  <td><%=nickname%></td> 
	  <td align=center><a href="updateMemberAdmin.jsp?id=<%=id%>">Yes</a></td>
  	  <td align=center><a href="deleteMemberAdmin.jsp?id=<%=id%>">Yes</a></td>
  </tr>
<%
		}
%>
</table>
<br>
 <div style="text-algin:center; font-size:15px;"><a href="manager_index.jsp">�����ڸ�� ����������</a></div>
<%
    } catch (Exception e) {
      out.println(e);	
}
%>
	</div>
</body>
</html>