<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>비밀번호 찾기</title>
</head>

<body>

<%
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";   
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
    String id = request.getParameter("id");            
    String num = request.getParameter("num");
	String email = request.getParameter("email");
	
    String jsql = "select * from user where login_id = ? and user_tel=? and user_email = ? "; 
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, id);
	pstmt.setString(2, num);
	pstmt.setString(3, email);

    ResultSet rs = pstmt.executeQuery(); 

    if(rs.next())  
    {
				request.setAttribute("findPwdMessage", "요청하신 비밀번호는 " + rs.getString("user_pw") + " 입니다.");
				request.getRequestDispatcher("findPwd.jsp").forward(request, response);
    } else {
       			request.setAttribute("findPwdMessage", "입력하신 정보와 일치하는 계정이 없습니다.");
				request.getRequestDispatcher("findPwd.jsp").forward(request, response);
				
    }
%>

</body>
</html>

