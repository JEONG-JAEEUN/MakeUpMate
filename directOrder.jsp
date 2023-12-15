<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>


<html>
<head>
<title>즉시 구매</title>
<link rel="stylesheet" href="./CSS/directOrder.css" />
<script language="javascript" src="./JS/directOrder.js">
</script>
	<script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
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
		<div id="login">상품 주문을 위해서는 로그인이 필요합니다.</div>
			<div id="submit"><a href="login.jsp"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">로그인으로 이동</a></div>
			  </center>
<%
}
else  
{
	%>
<form name ="cartList" method=post action=directOrderResult.jsp>
<%
	request.setCharacterEncoding("euc-kr");
	String qty = request.getParameter("qty");
	String user_id = request.getParameter("user_id");

	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String DB_ID = "multi";
	String DB_PW = "abcd";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
	
	int total = 0;
	
		String option = request.getParameter("option"); // 상품번호
		String[] parts = option.split(",");
		option = parts[0].trim();
		String category = request.getParameter("category"); 

		String optionjsql = "select * from " + category + " where options = ?";
		PreparedStatement optionpstmt = con.prepareStatement(optionjsql);
		optionpstmt.setString(1, option);
		ResultSet optionrs = optionpstmt.executeQuery();
		optionrs.next();
		String item_id = optionrs.getString("item_id");


	String itemSql = "select * from item where item_id = ?";
	PreparedStatement pstmt = con.prepareStatement(itemSql);
	pstmt.setString(1, item_id);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	String item_name = rs.getString("item_name");
	int item_price = rs.getInt("item_price");

	int item_total_price = Integer.parseInt(qty) * item_price;
	total += item_total_price;

	String name = "";
	String item_picture = "";
	String jsqlOption = "SELECT * FROM " + category + " WHERE item_id = ?";
				PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
				pstmtOption.setString(1, item_id);
				ResultSet optionRs = pstmtOption.executeQuery();

				if (optionRs.next()) {
							name = item_name + "(" + 
										optionRs.getString("options") + ")";
				}
				String jsqlItemId = "SELECT MIN(item_id) AS min_id FROM item WHERE item_name = ?";
				PreparedStatement pstmtItemId = con.prepareStatement(jsqlItemId);
				pstmtItemId.setString(1, item_name);
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
%>
<input type="hidden" name = "qty" value="<%=qty%>">
<input type="hidden" name = "item_id" value="<%=item_id%>">
<input type="hidden" name = "user_id" value="<%=user_id%>">
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
<div style="display: flex; justify-content: center;">
<div class="list">
		<div class="infodetail">
		<div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px; maring-left:90px;"></div>
		<div class="item_name" style="margin-left:30px;"><%=name%></div>
		</div>
		<div class="item_price"> <%=item_total_price%> 원</div>
		<div class="num"><%=qty%> 개</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
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
<%
}
%>
</body>
</html>