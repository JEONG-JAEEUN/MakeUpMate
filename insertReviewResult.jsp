<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title></title>
<script language="javascript" src="./js">
</script>
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String review = request.getParameter("review");
	String item_id = request.getParameter("item_id");
	String uId = (String)session.getAttribute("sid");
if (uId == null)
{  
%>
	<script>
		alert("리뷰 등록을 위해서는 로그인이 필요합니다.");
	window.location.href = "login.jsp";
	</script>
<%
}
else{
	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String DB_ID = "multi";
	String DB_PW = "abcd";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

	String sql = "select * from user where user_id = ?";		// 회원 정보로 장바구니 상품 찾기

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, uId);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	int user_id = rs.getInt("user_id");
	
	String sql2 = "INSERT INTO review (user_id, item_id, review_content) VALUES(?,?,?)";
	
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setInt(1, user_id);
	pstmt2.setInt(2, Integer.parseInt(item_id));
	pstmt2.setString(3, review);
	pstmt2.executeUpdate();
	
	if(item_id.equals("16")){
		response.sendRedirect("PERSONALLIP.jsp");
	}else if(item_id.equals("17")){
		response.sendRedirect("PERSONALCHEEK.jsp");
	}else if(item_id.equals("18")){
		response.sendRedirect("PERSONALPERFUME.jsp");
	}else{
		response.sendRedirect("viewDetailProduct.jsp?item_id=" + item_id);
	}
}
%>
</body>
</html>