<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<html>
<head>
<title>결제</title>
<link rel="stylesheet" href="./CSS/payment.css" />
</head>
	<script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
<script language="javascript" src="./JS/payment.js">
</script>

<body>
<form name ="cartList" method=post action=paymentResult.jsp>
<br><br>
<Center><h1> 결제 </h1></Center>

<div class="title">결제내역 <i class="fa-solid fa-bars-staggered"></i></div>
<div>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<div width=1200px >
<div class="container" style="display: flex; justify-content: center;">
 <div class="info">상품 정보</div>
 <div class="price">가격</div>
 <div class="number"> 개수 </div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<%
	String uId = (String)session.getAttribute("sid");

	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String DB_ID = "multi";
	String DB_PW = "abcd";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
	
	String sql = "select * from cart_product where user_id = ?";		// 회원 정보로 장바구니 상품 찾기

	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, uId);
	ResultSet rs = pstmt.executeQuery();
	
	int total = 0;

	while(rs.next()){
		int item_id = rs.getInt("item_id");
		int cart_quantity = rs.getInt("cart_quantity");
		
		String itemSql = "select * from item where item_id = ?";
		PreparedStatement pstmt2 = con.prepareStatement(itemSql);
		pstmt2.setInt(1, item_id);
		ResultSet rs2 = pstmt2.executeQuery();
		rs2.next();
		String name = rs2.getString("item_name");	// 상품명

		int item_price = rs2.getInt("item_price");

		int item_total_price = cart_quantity * item_price;
		total += item_total_price;
		
		String category = rs2.getString("item_category");
		String item_name = "";
		String item_picture = "";
		if(category.startsWith("personal_")){
						String jsqlOption = "SELECT * FROM " + category + " WHERE item_id = ?";
						PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
						pstmtOption.setInt(1, item_id);
						ResultSet optionRs = pstmtOption.executeQuery();
						optionRs.next();
						if(category.equals("personal_perfume")){
							item_name = name + "(" +
										optionRs.getString("case") +"/"+
										optionRs.getString("color") +"/"+
										optionRs.getString("engrave") +"/"+
										optionRs.getString("scent") + ")";
							item_picture = "personalPerfume";
						}else{
							item_name = rs2.getString("item_name") + "(" +
										optionRs.getString("case") +"/"+
										optionRs.getString("color") +"/"+
										optionRs.getString("engrave") + ")";
							if(category.equals("personal_lip")){
								item_picture = "personalLip";
							}else{
								item_picture = "personalCheck";
							}
						}
		}else{
				String jsqlOption = "SELECT * FROM " + category + " WHERE item_id = ?";
				PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
				pstmtOption.setInt(1, item_id);
				ResultSet optionRs = pstmtOption.executeQuery();

				if (optionRs.next()) {
							item_name = name + "(" + 
										optionRs.getString("options") + ")";
				}
				String jsqlItemId = "SELECT MIN(item_id) AS min_id FROM item WHERE item_name = ?";
				PreparedStatement pstmtItemId = con.prepareStatement(jsqlItemId);
				pstmtItemId.setString(1, name);
				ResultSet itemIdRs = pstmtItemId.executeQuery();
				if (itemIdRs.next()) {
					String smallest_item_id = itemIdRs.getString("min_id");
					// Get item_picture based on the smallest item_id
					String jsqlPicture = "SELECT * FROM item_picture WHERE item_id = ?";
					PreparedStatement pstmtPicture = con.prepareStatement(jsqlPicture);
					pstmtPicture.setString(1, smallest_item_id);
					ResultSet pictureRs = pstmtPicture.executeQuery();
					if (pictureRs.next()) {
						item_picture = pictureRs.getString("picture_address");
					}
				}
		}
%>
<div style="display: flex; justify-content: center;">
<div class="list">
		<div class="infodetail">
		<div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px;"></div>
		<div class="item_name" style="margin-left:30px;"><%=item_name%></div>
		</div>
		<div class="item_price"> <%=item_price%> 원</div>
		<div class="num"><%=cart_quantity%> 개</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
<%
	}	
%>

<table style="display: flex; justify-content: center;">
<tr>
 <td class="total" style="display:flex">총 금액&nbsp;&nbsp;&nbsp;<p>배송비 3000원<p></td> 
 <td class="hap"><%=total%>+3000원</td>  
 <td class="hap"><%=total + 3000%>원</td>
 </tr>
</table>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
</div>
<input type ="hidden" name="total" value="<%=total%>">
<br><br><br>
<div class="title">결제내역 <i class="fa-solid fa-truck"></i></div>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
<br>
<div style="margin-left:110px;">
<table>
<tr><td class="text" width="150px">수령자명</td> <td width="500px"><input type="text" name="recipient" class="box"></td></tr>
<tr><td class="text">연락처 </td> <td><input type="text" name="tel" class="box"></td></tr>
</table>
<p class="text">배송지</p>
<input type="text" name="zipcode" size="7" readonly class="box"> 
<input type="button" value="우편번호검색" onClick="zipCheck()" class="button"><br>     
<input type="text" name="address1" size="40"  readonly class="box"><br>
<input type="text" name="address2" size="40" class="box">&nbsp<font size =2>(상세주소입력)
<div style="display:flex">
<div class="text">요청사항</div><input type="text" name="request" class="box">
</div>
<br><br><br>
<div class="title" style="margin-left:-0px" >결제  <i class="fa-regular fa-credit-card"></i></div>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none; margin-left:-110px;">
<br>
<table>
<tr><td width=150px class="text" style="margin-top:12px;">은행</td> <td width=300px width=200px ><select name="bank">
		<option selected>국민은행</option>
		<option>우리은행</option>
		<option>농협은행</option>
		<option>신한은행</option>
	</select></td></tr>
<tr><td class="text" style="margin-top:12px;">입금계좌번호</td><td><input type = "hidden" name = "bankNum" value="국민 1111-111-1111" class="text">국민 1111-111-1111</td></tr>
<tr><td class="text" style="margin-top:12px;">입금자명</td><td>	<input type="text" name="bankName" class="box"></td></tr>
<%
  // 현재 날짜 가져오기
  LocalDate currentDate = LocalDate.now();

  // 7일을 더한 날짜 계산
  LocalDate dueDate = currentDate.plusDays(7);

  // 날짜 포맷 지정 (예: "yyyy-MM-dd")
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

  // 입금기한 출력
  String formattedDueDate = dueDate.format(formatter);
%>
<tr><td class="text"><input type="hidden" name ="deadline"  value=<%=formattedDueDate%>> 입금기한</td><td><%= formattedDueDate %></td></tr>
</table>
<br>
<input type="button" value="결제하기" onclick="payment()" class="buttonpay">
</div>
</form>
</body>
</html>