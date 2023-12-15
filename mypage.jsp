<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>mypage</title>
    <link rel="stylesheet" href="./CSS/mypage.css" />
	<script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
</head>

<%
try {

    String rank = "Welcome";
    String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String id = (String)session.getAttribute("sid");

    String jsql = "select * from user where user_id = ? "; 
    PreparedStatement pstmtUser = con.prepareStatement(jsql);
    pstmtUser.setString(1, id);
    ResultSet userRs = pstmtUser.executeQuery();
    userRs.next();
	String loginId=userRs.getString("login_id");
	if ("admin".equals(loginId)) {
        response.sendRedirect("manager_index.jsp");
    }
%>

<!-- html로 user -->
<body>
    <div style="display: flex; margin-left: 110px; margin-top: 40px">
        <div><img src="IMG/user.png"></div>
        <div style="margin-left: 80px;">
            <div class="name" style="margin-top: 50px;"><%=userRs.getString("user_name")%></div>
            <div class="level" style="margin-top: 10px;"><%=userRs.getString("user_rank")%></div>
			<div class="logout" style="margin-top:10px"><a href="logout.jsp" class="logouttext" style="text-decoration-line: none; color:white;">로그아웃</a></div>
        </div>
    </div>
	<br><br><br><br>
    <b class="title"> 개인정보 수정 <i class="fa-solid fa-pen-to-square"></i></b>
	<br><br>
    <hr style="height: 3px; background-color: #D9D9D9; border: none">
	<br><br>
	<form name="updateform" method="post" action="mypageUpdate.jsp">
        <table style="margin: 0 auto;">
            <tr>
                <td width="200" align="center" class="passwd">비밀번호 인증</td>
                <td>
                    <input type="password" name="password" style="text-align: left;height:40px;width: 400px;" onkeydown="onEnterSubmit()" >
                </td>
            </tr>
        <tr><td style="padding: 10px;"></td><td></td></tr>
       
		<tr><td colspan=2 style="">
		<center>
		 <%
        String mypagePass = (String) request.getAttribute("mypagePass");
        if (mypagePass != null) {
            out.println("<p style='color:red'>" + mypagePass + "</p>");
        }
        %>
        <input type="submit" onclick="checkPasswd()" value="수정" class="edit">
		</center>
		</td></tr>
		</table>
    </form>
	<div style="padding:20px"></div>
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
    String jsql2 = "SELECT * FROM orders WHERE user_id = ?";
    PreparedStatement pstmtOrder = con.prepareStatement(jsql2);
    pstmtOrder.setString(1, id);
    ResultSet orderRs = pstmtOrder.executeQuery();

    while (orderRs.next()) {
        String order_id = orderRs.getString("order_id");

        // 주문 상품 정보 가져오기
        String jsql3 = "SELECT * FROM order_item WHERE order_id = ?";
        PreparedStatement pstmtOrderItem = con.prepareStatement(jsql3);
        pstmtOrderItem.setString(1, order_id);
        ResultSet orderItemRs = pstmtOrderItem.executeQuery();

        while (orderItemRs.next()) {
            String item_id = orderItemRs.getString("item_id");
            int order_quantity = orderItemRs.getInt("order_quantity");

            // 상품 정보 가져오기
            String jsql4 = "SELECT * FROM item WHERE item_id = ?";
            PreparedStatement pstmtItem = con.prepareStatement(jsql4);
            pstmtItem.setString(1, item_id);
            ResultSet itemRs = pstmtItem.executeQuery();

            while (itemRs.next()) {
				String item_picture = "";
                String item_name = itemRs.getString("item_name");
                int item_price = itemRs.getInt("item_price");
                String category_name = itemRs.getString("item_category");
				
                String jspOption = "";  // jspOption 변수 선언
					
					/*if문이 true라면 personal 상품
					  즉, if문 안에는 personal 관련 코드
					  else문으로 빠지면 일반 상품들*/
					if (category_name.startsWith("personal_")){
						String jsqlOption = "SELECT * FROM " + category_name + " WHERE item_id = ?";
						PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
						pstmtOption.setString(1, item_id);
						ResultSet optionRs = pstmtOption.executeQuery();
						optionRs.next();
						if(category_name.equals("personal_perfume")){
							jspOption = optionRs.getString("case") +"/"+
										optionRs.getString("color") +"/"+
										optionRs.getString("engrave") +"/"+
										optionRs.getString("scent");
							item_picture = "personalPerfume";
						}else{
							jspOption = optionRs.getString("case") +"/"+
										optionRs.getString("color") +"/"+
										optionRs.getString("engrave");
							if(category_name.equals("personal_lip")){
								item_picture = "personalLip";
							}else{
								item_picture = "personalCheck";
							}
						}
								%>
								<div style="display: flex; justify-content: center;">
<div class="list">
		<div class="infodetail">
		<div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px;"></div>
		<div>
		<div style="margin-right:30px;"></div>
		<div class="item_name" ><%=item_name%></div>
		<div class="jspOption" ><i class="fa-solid fa-turn-up fa-rotate-90"></i><%=jspOption%></div>
		</div>
		</div>
		<div class="item_price"> <%=item_price%> 원</div>
		<div class="num"><%=order_quantity%> 개</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
								<%
                    }
					else{	
						// 옵션 가져오기
						String jsqlOption = "SELECT * FROM " + category_name + " WHERE item_id = ?";
						PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
						pstmtOption.setString(1, item_id);
						ResultSet optionRs = pstmtOption.executeQuery();

						if (optionRs.next()) {
							jspOption = optionRs.getString("options");
						}
						// Get the smallest item_id based on item_name
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
								%>
<div style="display: flex; justify-content: center;">
<div class="list">
		<div class="infodetail">
		<div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px;"></div>
		<div style="display: flex; flex-direction: column;">
		<div class="item_name" style="margin-left:30px;"><%=item_name%></div>
		<div class="jspOption" ><i class="fa-solid fa-turn-up fa-rotate-90"></i><%=jspOption%></div>
		</div>
		</div>
		<div class="item_price"> <%=item_price%> 원</div>
		<div class="num"><%=order_quantity%> 개</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
								<%
							}
						}
					}                
            }
        }
    }
} catch(Exception e) {
        out.println(e);
}
%>
<br>
<br>
<br>
    <div class="delete">
	<center><a href="userDelete.jsp" style="text-decoration: none; color:black;">탈퇴하기</a></center></div>
	<br>
<br>
</body>
</html>
