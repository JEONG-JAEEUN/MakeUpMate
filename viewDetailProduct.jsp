<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>

<head>
  <title>상세 정보</title>
  <link rel="stylesheet" href="./CSS/DetailProduct.css" />
  <script src="https://kit.fontawesome.com/5286d2d6db.js" crossorigin="anonymous"></script>
  <script language="javascript" src="./JS/detailProduct.js"></script>
</head>

<body>
  <%
    try {
      String myid = (String)session.getAttribute("sid");
      boolean isUserLoggedIn = (myid != null);

      String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
      String DB_ID = "multi";
      String DB_PASSWORD = "abcd";

      Class.forName("org.gjt.mm.mysql.Driver");
      Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

      String item_id = request.getParameter("item_id");

      String jsql = "SELECT * FROM item WHERE item_id = ?";
      PreparedStatement pstmt = con.prepareStatement(jsql);
      pstmt.setString(1, item_id);
      ResultSet rs = pstmt.executeQuery();
      rs.next();

      String name = rs.getString("item_name");
      int price = rs.getInt("item_price");
      String category = rs.getString("item_category");
      int heartNum = rs.getInt("item_heart");
      int salePrice = (int) (price * 1.1);

      String sql2 = "SELECT * FROM item_picture WHERE item_id = ?";
      PreparedStatement pstmt2 = con.prepareStatement(sql2);
      pstmt2.setString(1, item_id);
      ResultSet rs2 = pstmt2.executeQuery();
      rs2.next();
      String img = rs2.getString("picture_address");
	 rs2.next();
      String detailimg = rs2.getString("picture_address");

      boolean isHearted = false;
      if (isUserLoggedIn) {
        String checkHeartSql = "SELECT * FROM heart WHERE user_id = ? AND item_id = ?";
        PreparedStatement checkHeartStmt = con.prepareStatement(checkHeartSql);
        checkHeartStmt.setString(1, myid);
        checkHeartStmt.setString(2, item_id);
        ResultSet checkHeartRs = checkHeartStmt.executeQuery();
        isHearted = checkHeartRs.next();
        checkHeartRs.close();
        checkHeartStmt.close();
      }

      String itemIdSql = "SELECT item_id FROM item WHERE item_name = ?";
      PreparedStatement idPstmt = con.prepareStatement(itemIdSql);
      idPstmt.setString(1, name);
      ResultSet itemidRs = idPstmt.executeQuery();
%>

<div id="productWrapper">
  <div id="category"><a href="main.html"><i class="fa-solid fa-house"></i> 홈</a> > <%=category%></div>
  <form name=product method="post">
    <div id="imgflex">
      <img src="IMG/<%=img%>.jpg" class="mainImg">
      <div id="detailContent">
        <input type="hidden" name="item_id" value="<%= item_id %>">
		<input type="hidden" name="category" value="<%= category %>">
        <input type="hidden" name="user_id" value="<%= myid %>">
        <input type="hidden" name="isHearted" value="<%= isHearted %>">
        <div id="titleFlex">
          <div id="productName"><%=name%></div>
          <form name=heart method="post">
            <div id="heartWrap">
              <%
                if (isUserLoggedIn) {
                  if (isHearted) { %>
                    <a href="javascript:heartOk()"><i class="fa-solid fa-heart heart-icon heart"></i></a>
                  <% } else { %>
                    <a href="javascript:heartOk()"><i class="fa-regular fa-heart heart-icon heart"></i></a>
                  <% }
                } else { %>
                  <a href="login.jsp"><i class="fa-regular fa-heart heart-icon heart"></i></a>
              <% } %>
              <div id="heartNum"><%=heartNum	%></div>
            </div>
          </form>
        </div>
        <div id="priceFlex">
          <div id="price"><%=price%>원</div>
          <del id="sale"><%=salePrice%>원</del>
        </div>
        <div>본 상품은 국내배송만 가능합니다.</div>
        <div>
          <div>배송비 주문시 결제</div>
          <div>3000원</div>
        </div>
        <div>
          <div>수량</div>
          <div class="qtyAndUpDown">
            <input type=button value="-" onClick="amountMinus();">
            <input type=text name=qty size=7 value="1" onblur="javascript:amountCheck();" class="qty">
            <input type=button value="+" onClick="amountPlus();">
          </div>
        </div>

        <div id="colorStockSelect">
            <div>옵션 선택</div>
            <select id="itemSelect" name="option">
            <%
              while (itemidRs.next()) {
                String currentItemId = itemidRs.getString("item_id");

                String itemSql = "SELECT item_quantity FROM item WHERE item_id = ?";
                PreparedStatement itemStmt = con.prepareStatement(itemSql);
                itemStmt.setString(1, currentItemId);
                ResultSet itemRs = itemStmt.executeQuery();
                itemRs.next();
                int stock = itemRs.getInt("item_quantity");

                //String optionSql = "SELECT option FROM lip WHERE item_id = ?";
				String optionSql = "SELECT options FROM " + category + " WHERE item_id = ?";

                PreparedStatement optionPstmt = con.prepareStatement(optionSql);
                optionPstmt.setString(1, currentItemId);
                ResultSet optionRs = optionPstmt.executeQuery();
				optionRs.next();
				String option=optionRs.getString("options");
            %>
            <option value="<%=option%>,<%=stock%>">
              <%= option %> &nbsp;&nbsp;&nbsp;남은 수량: <%= stock %>개
            </option>
            <%
                optionRs.close();
                optionPstmt.close();
                itemRs.close();
                itemStmt.close();
              }
            %>
          </select>
        </div>

        <div id="btnFlex">
          <div class="incart"><a href="javascript:inCart()"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">장바구니</a>
          </div>
          <div class="direct"><a href="javascript:directOrd()"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">바로구매</a>
          </div>
        </div>
      </div>
    </div>
  </form>
</div>


<div id="btnFlex2">
        <button id="detailBtn" onclick="scrollToSection('content1')">상품 상세</button>
        <button class="contentBtn" onclick="scrollToSection('content2')">리뷰</button>
        <button class="contentBtn" onclick="scrollToSection('content3')">상품 문의</button>
      </div>

<div id="content1" class="content">
    <div class="detailImg">
<img src="IMG/<%=detailimg%>.jpg">
</div>
</div>


<div id="content2">
<form name="reviewForm" action="insertReviewResult.jsp" method="post">
<input type="hidden" name="item_id" value="<%= item_id %>">
<input type="hidden" name="myid" value="<%=myid%>">
<h2>리뷰</h2>
<div id="reviewFlex">
            <input type="text" name="review" placeholder="리뷰를 입력하세요" id="reviewInput" onkeydown="onEnterSubmit()">
            <div class="insert"><a href="javascript:review()"
                style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">등록</a>
            </div>
          </div>
<table>
<tr>
              <td style="width:250px; font-weight: bold; font-size: 17px; height:50px;"> 닉네임 </td>
              <td style="width:1030px; font-weight: bold; font-size: 17px; text-align: center;"> 내용 </td>
            </tr>
<%
	
	String reviewsql = "select * from review where item_id = ?";
	PreparedStatement reviewPstmt = con.prepareStatement(reviewsql);
	reviewPstmt.setString(1, item_id);
	ResultSet reviewRs = reviewPstmt.executeQuery();

	while(reviewRs.next()){
		int user_id = reviewRs.getInt("user_id");
		String review_content = reviewRs.getString("review_content");
		String userSql = "select user_nickname from user where user_id = ?";

		PreparedStatement userPstmt = con.prepareStatement(userSql);
		userPstmt.setInt(1, user_id);
		ResultSet userRs = userPstmt.executeQuery();
		userRs.next();
		String user_nickname = userRs.getString("user_nickname");
%>

	<tr>
		<td style="height:50px;"><%=user_nickname%></td>
		<td><%=review_content%></td>
	</tr>
<%
	}
%>
</table>
</form>
</div>
      <div id="content3">
        <div>
          <h2>상품 문의</h2>
          <div id="content3Content">
            일반판매 문의<br><br>
            1588 - 1234 (평일 09:00 ~ 18:00)<br><br>
            MakeMate@Make.com
          </div>
        </div>
      </div>
  <%
    } catch(Exception e) {
      out.println(e);
    }
  %>

</body>

</html>
