<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>장바구니 담기</title>
<style>
	#login{
		font-weight:bold;
		font-size:25px;
		margin-top: 200px;
    margin-bottom: 50px;
	}
#submit {
  width: 370px;
  height: 45px;
  font-weight: bold;
  font-size: 18px;
  border: 2px solid black;
  border-radius: 5px;
  cursor: pointer;
  margin: 7px 0;
}
#submit a{
color:black;
}
</style>
</head>
<body>

<%
	String myid = (String)session.getAttribute("sid");  

if (myid == null)
{  
	%>
<center>
		<div id="login">장바구니 이용을 위해서는 로그인이 필요합니다.</div>
			<div id="submit"><a href="login.jsp"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">로그인으로 이동</a></div>
			  </center>
<%
}
else  
{
 try
	 {
 	    String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";   
        String DB_ID="multi"; 
        String DB_PASSWORD="abcd";
 	 
	    Class.forName("org.gjt.mm.mysql.Driver");  
 	    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

		request.setCharacterEncoding("euc-kr");
		String option = request.getParameter("option"); // 상품번호
		String[] parts = option.split(",");
		option = parts[0].trim();
		String user_id = request.getParameter("user_id"); 
		String category = request.getParameter("category"); 
		int qty = Integer.parseInt(request.getParameter("qty")); //  주문수량(장바구니에 담을 상품수량)

		String optionjsql = "select * from " + category + " where options = ?";
		PreparedStatement optionpstmt = con.prepareStatement(optionjsql);
		optionpstmt.setString(1, option);
		ResultSet optionrs = optionpstmt.executeQuery();
		optionrs.next();
		String item_id = optionrs.getString("item_id");

		String jsql = "select * from cart_product where item_id = ? and user_id=?";
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, item_id);
		pstmt.setString(2, user_id);
		ResultSet rs = pstmt.executeQuery(); 

	   	if(rs.next())   
		{		              
			int cart_quantity = rs.getInt("cart_quantity");
			int sum = rs.getInt("cart_quantity") + qty;  //  이미 기존에 있는 수량에다 새로 추가시킬 수량을 합산함.

			String jsql2 = "update cart_product set cart_quantity=? where item_id = ? and user_id=? and cart_quantity=?";
			PreparedStatement pstmt2 = con.prepareStatement(jsql2);
			pstmt2.setInt(1, sum);
			pstmt2.setString(2, item_id);
			pstmt2.setString(3, user_id);
			pstmt2.setInt(4, cart_quantity);
	

			pstmt2.executeUpdate();
		}
		else  // 동일 상품이 장바구니에 존재하지 않는다면, 새로운 상품레코드를 장바구니 테이블에 추가시킴
		{
			String jsql3 = "insert into cart_product (item_id, user_id, cart_quantity) values (?,?,?)";
			PreparedStatement pstmt3 = con.prepareStatement(jsql3);
			pstmt3.setString(1,item_id);
			pstmt3.setString(2,user_id);
			pstmt3.setInt(3, qty);	

			pstmt3.executeUpdate();
		} 
	 } 	catch(Exception e)  {
             out.println(e);
    }  
	    response.sendRedirect("userCart.jsp");   
}                                      
%>
</body>
</html>
