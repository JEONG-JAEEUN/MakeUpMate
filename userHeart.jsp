<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>마음 목록</title>
<link rel="stylesheet" href="./CSS/userHeart.css" />
<script src="https://kit.fontawesome.com/5286d2d6db.js" crossorigin="anonymous"></script>
</head>

<script language="javascript" src="userHeart.js">
</script>

<body>
<br><br>
<Center><h1> 마음 목록 </h1></Center>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<div width=1200px style="display: flex; justify-content: center;">
<div class="container">
 <div class="info">상품 정보</div>
 <div class="price">가격</div>
 <div class="delete">취소</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<%
		String uId = (String)session.getAttribute("sid");


 		String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	
		String sql = "select * from heart where user_id = ?";		// 회원 정보로 찜상품 찾기

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, uId);
		ResultSet rs = pstmt.executeQuery();

		while(rs.next()){
			int item_id = rs.getInt("item_id");
			String sql2 = "select * from item where item_id = ?";		// 회원 정보로 찜상품 찾기
			PreparedStatement pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1, item_id);
			ResultSet rs2 = pstmt2.executeQuery();
			rs2.next();
			int item_price = rs2.getInt("item_price");
			String name = rs2.getString("item_name");
			String item_name = "";
			String category = rs2.getString("item_category");
			String item_picture = "";

			// 옵션 가져오기
			String jsqlOption = "SELECT * FROM " + category + " WHERE item_id = ?";
			PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
			pstmtOption.setInt(1, item_id);
			ResultSet optionRs = pstmtOption.executeQuery();

			if (optionRs.next()) {
				item_name = name + "(" + optionRs.getString("options") + ")";
			}
			// Get the smallest item_id based on item_name
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
%>
	<div style="display: flex; justify-content: center;">
 <div class="list">
		<div class="infodetail">
		<div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px;"></div>
		<div class="item_name"><%=item_name%></div>
		</div>
		<div class="item_price"> <%=item_price%> 원</div>

  <div class="heart">
  <form name="heart" method="post" action="heartCancel.jsp">
      <input type="hidden" name="item_id" value="<%=item_id%>">
      <div id="heartWrap">
          <button type="submit" class="heart-button"  style="cursor:pointer">
             <i class="fa-solid fa-heart fa-2xl"></i>
          </button>
      </div>
  </div>
  </form>
  </div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;margin-left: -110px;">
<div style="margin: 30px"></div>
<%
		}

%>
</body>
</html>