<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>���̵� ã��</title>
</head>

<body>

<%
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";   
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver");  
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
	request.setCharacterEncoding("euc-kr");
    String name = request.getParameter("name");            
    String num = request.getParameter("num");
	
    String jsql = "select * from user where user_name = ? and user_tel=? "; 
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, name);
	pstmt.setString(2, num);

    ResultSet rs = pstmt.executeQuery(); 

    if(rs.next())  
    {
				request.setAttribute("findIdMessage", "��û�Ͻ� ���̵�� " + rs.getString("login_id")+" �Դϴ�.");
				request.getRequestDispatcher("findId.jsp").forward(request, response);
    } else {
       			request.setAttribute("findIdMessage", "�Է��Ͻ� ������ ��ġ�ϴ� ���̵� �����ϴ�.");
				request.getRequestDispatcher("findId.jsp").forward(request, response);
				
    }
%>

</body>
</html>

