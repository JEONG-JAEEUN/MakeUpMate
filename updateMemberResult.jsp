<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
	<head><title>회원 정보 수정 완료</title></head>
	<body>

<%
	 request.setCharacterEncoding("euc-kr");

	String id = request.getParameter("id");   
	String password = request.getParameter("password");
	String	name = request.getParameter("name");
	String	birthYear = request.getParameter("year");
	String	birthMonth = request.getParameter("month");
	String	birthDay = request.getParameter("date");
	if (birthDay.length() == 1) {
    birthDay = "0" + birthDay;
	}
	String	birth = birthYear+birthMonth+birthDay;
	String	email = request.getParameter("email");
	String	phone = request.getParameter("phone");
	String	nickname = request.getParameter("Nickname");
	
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";
     String DB_ID="multi";  
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	 if(password==""){
	 String pwdSql = "select user_pw from user where login_id=?";
	 PreparedStatement pwdPstmt = con.prepareStatement(pwdSql);
	 pwdPstmt.setString(1,id);
	 ResultSet rs = pwdPstmt.executeQuery();
	 rs.next();
	 String pwd = rs.getString("user_pw");
	 password=pwd;
	 }
	 String jsql = "update user set user_pw=?, user_birth=?, user_email=?, user_tel=? where login_id=? ";	
	 PreparedStatement pstmt = con.prepareStatement(jsql);
	 pstmt.setString(1,password);
	 pstmt.setString(2,birth);
	 pstmt.setString(3,email);
	 pstmt.setString(4,phone);
	 pstmt.setString(5,id);

	 pstmt.executeUpdate();
	 response.sendRedirect("mypage.jsp");
    } catch (Exception e) {
    	out.println(e);
}
%>
</body>
</html>