<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<html>
<head>
<title>결제 완료</title>
<script language="javascript" src="./JS/paymentResult.js">
</script>
<style>
    #container {
      width: 1280px;
      margin: 0 auto;
    }

    #fontSize {
      font-size: 25px;
      margin-top: 100px;
    }

    #fontSize div {
      margin-bottom: 10px;
    }

    #btn {
      margin-top: 30px;
      text-align: center;

    }

    #btn input {
      font-size: 20px;
      background-color: white;
      border: 2px solid black;
      border-radius: 10px;
      padding: 7px 15px;
      cursor: pointer;
    }
  </style>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");
	String uId = (String)session.getAttribute("sid");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String tel = request.getParameter("tel");
	String comment = request.getParameter("request");
	String recipient = request.getParameter("recipient");
	String bank = request.getParameter("bank");
	String bankNum = request.getParameter("bankNum");
	String bankName = request.getParameter("bankName");
	String address = zipcode + " " + address1 + " " + address2;

    String deadline = request.getParameter("deadline");
	int total = Integer.parseInt(request.getParameter("total"));

	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String DB_ID = "multi";
	String DB_PW = "abcd";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
	
	String sql = "INSERT INTO orders (user_id, order_address, order_tel, order_comment, order_bank, order_banknum, order_deadline, order_name, order_bankname) VALUES(?,?,?,?,?,?,?,?,?)";

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, uId);
	pstmt.setString(2, address);
	pstmt.setString(3, tel);
	pstmt.setString(4, comment);
	pstmt.setString(5, bank);
	pstmt.setString(6, bankNum);
	pstmt.setString(7, deadline);
	pstmt.setString(8, recipient);
	pstmt.setString(9, bankName);

	pstmt.executeUpdate();


	String sql2 = "SELECT * FROM orders ORDER BY order_id DESC LIMIT 1";		// 가장 마지막 주문 id 찾기
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	ResultSet rs2 = pstmt2.executeQuery();
	rs2.next();
	int order_id = rs2.getInt("order_id");

	String sql3 = "select * from cart_product where user_id = ?";		// 회원 정보로 장바구니 상품 찾기

	PreparedStatement pstmt3 = con.prepareStatement(sql3);
	pstmt3.setString(1, uId);
	ResultSet rs3 = pstmt3.executeQuery();

	while(rs3.next()){
		int item_id = rs3.getInt("item_id");
		int cart_quantity = rs3.getInt("cart_quantity");
		
		String sql4 = "INSERT INTO order_item (order_id, item_id, order_quantity) VALUES (?, ?, ?)";
		PreparedStatement pstmt4 = con.prepareStatement(sql4);
		pstmt4.setInt(1, order_id);
		pstmt4.setInt(2, item_id);
		pstmt4.setInt(3, cart_quantity);
		pstmt4.executeUpdate();

		//주문한 상품의 총 재고량을 찾아 주문 개수만큼 빼주기
		String Itemsql = "SELECT * FROM item where item_id =?";
		PreparedStatement Itempstmt = con.prepareStatement(Itemsql);
		Itempstmt.setInt(1, item_id);
		ResultSet itemrs = Itempstmt.executeQuery();
		itemrs.next();
		int item_quantity = itemrs.getInt("item_quantity");
		item_quantity = item_quantity - cart_quantity;
		
		String quantitysql = "UPDATE item set item_quantity = ? where item_id = ?";
		PreparedStatement quantitypstmt = con.prepareStatement(quantitysql);
		quantitypstmt.setInt(1, item_quantity);
		quantitypstmt.setInt(2, item_id);
		quantitypstmt.executeUpdate();
	}
	
	/*장바구니 비우기*/
	String sql5 = "DELETE FROM cart_product where user_id = ?";
	PreparedStatement pstmt5 = con.prepareStatement(sql5);
	pstmt5.setString(1, uId);
	pstmt5.executeUpdate();

	/*회원의 총 주문금액 업데이트 및 랭크 결정*/
	String sql6 = "select * from user where user_id = ?";
	PreparedStatement pstmt6 = con.prepareStatement(sql6);
	pstmt6.setString(1, uId);
	ResultSet rs6 = pstmt6.executeQuery();
	rs6.next();
	int totalOrderAmount = rs6.getInt("user_totalOrderAmount");
	totalOrderAmount += total;
	String rank = "";

	if(totalOrderAmount < 50000 )
        rank = "Welcome";
    else if(totalOrderAmount < 100000)
        rank = "Silver";
    else if(totalOrderAmount < 200000)
        rank = "Gold";
    else if(totalOrderAmount < 300000)
        rank = "Vip";
    else if(totalOrderAmount >= 300000)
        rank = "VVip";
	
	String sql7 = "update user set user_rank = ?, user_totalOrderAmount = ? where user_id = ?";
	PreparedStatement pstmt7 = con.prepareStatement(sql7);
	pstmt7.setString(1, rank);
	pstmt7.setInt(2, totalOrderAmount);
	pstmt7.setString(3, uId);
	pstmt7.executeUpdate();
	
%>
<div id="container">
<br><br><br>
<div>장바구니 > 결제 > 완료</div>
    <div id="fontSize">
      <div style="text-align: center; font-weight: bold; font-size: 30px;">결제 완료 </div>
	  <br>
      <div style="text-align: center;">결제가 완료되었습니다.</div>
      <div style="text-align: center;">감사합니다.</div>
    </div>
    <div id="btn"><input type="button" value="확인" onclick="paymentResultOk()"></div>
  </div>
  <br><br><br><br>
</body>
</html>