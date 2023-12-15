<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html><head><title>회원 상세 정보 조회   </title></head>
<body>

<%
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";  
     String DB_ID="multi";  
     String DB_PASSWORD="abcd"; 
 	 
	 Class.forName("org.gjt.mm.mysql.Driver"); 
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

  	 String key = request.getParameter("id");  
	 String jsql = "select * from user where login_id = ?";   
     PreparedStatement  pstmt  = con.prepareStatement(jsql);
	 pstmt.setString(1, key);

	 ResultSet rs = pstmt.executeQuery();  
	 rs.next();

	 String id = rs.getString("login_id");  
	 String passwd =  rs.getString("user_pw");	
	 String name = rs.getString("user_name");
	 String birth = rs.getString("user_birth");
	 String email =  rs.getString("user_email");
	 String tel =  rs.getString("user_tel");
	 String nick =  rs.getString("user_nickname");
%>
[회원 상세정보 조회]
<table>
		<tr><td width=100>ID</td><td width=200><%=id%></td></tr>
		<tr><td>비밀번호</td><td><%=passwd%></td></tr>
		<tr><td>성명</td><td><%=name%></td></tr>
		<tr><td>생년월일</td><td><%=birth%></td></tr>
		<tr><td>이메일</td><td><%=email%></td></tr>
		<tr><td>휴대폰번호</td><td><%=tel%></td></tr>
		<tr><td>닉네임</td><td><%=nick%></td></tr>
    </table><p>

<a href="updateMemberAdmin.jsp?id=<%=id%>">수정</a>&nbsp;&nbsp;
<a href="deleteMemberAdmin.jsp?id=<%=id%>">삭제</a>
</center>

<%
    } catch (Exception e) {
    	out.println(e);
}
%>
</body>
</html>