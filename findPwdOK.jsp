<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>��й�ȣ ã��</title>
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
				request.setAttribute("findPwdMessage", "��û�Ͻ� ��й�ȣ�� " + rs.getString("user_pw") + " �Դϴ�.");
				request.getRequestDispatcher("findPwd.jsp").forward(request, response);
    } else {
       			request.setAttribute("findPwdMessage", "�Է��Ͻ� ������ ��ġ�ϴ� ������ �����ϴ�.");
				request.getRequestDispatcher("findPwd.jsp").forward(request, response);
				
    }
%>

</body>
</html>

