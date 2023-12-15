<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>로그인 처리</title>
</head>

<body>

<%
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";   
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

    String id = request.getParameter("id");            
    String pass = request.getParameter("pass");

    String jsql = "select * from user where login_id = ? "; 
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, id);

    ResultSet rs = pstmt.executeQuery(); 

    if( rs.next() )  
    {
		String user_id = rs.getString("user_id");
        if (pass.equals(rs.getString("user_pw")))  
        {
             session.setAttribute("sid", user_id);
			 %>
 	        <script type="text/javascript">
				window.parent.location.href='index.jsp';
            </script>
			<%
		 } else {
            request.setAttribute("loginMessage", "비밀번호가 잘못되었습니다.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } else {
        request.setAttribute("loginMessage", "존재하지 않는 ID 입니다.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>

</body>
</html>

