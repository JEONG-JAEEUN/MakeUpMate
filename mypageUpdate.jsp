<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>비밀번호 확인</title>
</head>

<body>

<%
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";   
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
          
    String pass = request.getParameter("password");
	
	String id = (String)session.getAttribute("sid"); 

    String jsql = "select * from user where user_id = ? "; 
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery(); 

    if( rs.next() )  
    {
        if (pass.equals(rs.getString("user_pw")))  
        {
 	        String login_Id = rs.getString("login_id"); 
			response.sendRedirect("updateMember.jsp?id=" + login_Id);
		 } else {
            request.setAttribute("mypagePass", "비밀번호가 잘못되었습니다.");
            request.getRequestDispatcher("mypage.jsp").forward(request, response);
        }
    }
%>

</body>
</html>

