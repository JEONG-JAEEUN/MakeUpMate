<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>하트 취소</title>
<script language="javascript" src="./JS/.js">
</script>
</head>
<body>

<%
	String uId = (String)session.getAttribute("sid");
	String item_id = request.getParameter("item_id");

	 String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
     String DB_ID = "multi";
     String DB_PASSWORD = "abcd";

     Class.forName("org.gjt.mm.mysql.Driver");
     Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

	 String jsql = "delete FROM heart WHERE item_id = ? and user_id = ?";
     PreparedStatement pstmt = con.prepareStatement(jsql);
     pstmt.setString(1, item_id);
	 pstmt.setString(2, uId);
     pstmt.executeUpdate();
	 response.sendRedirect("userHeart.jsp");
%>
</body>
</html>
