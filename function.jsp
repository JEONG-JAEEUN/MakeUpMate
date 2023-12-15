<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>관리자 로그인 결과</title>
<style>
table{
border-collapse:collapse;
margin-top:20px;
}
td{
border:2px solid black;
padding:5px;
text-align:center;}
</style>
</head>

<body>
<div style="width:1280px; margin:0 auto">
<div style="font-size:30px; font-weight:bold; text-align:center; margin-top:50px;">[전체 주문 조회] 
<table style="width:1280px; margin-bottom:50px;">
<tr>
	<td style="width:100px">사진</td><td>상품 및 옵션</td><td>수량</td><td>휴대전화</td><td>배송지</td><td>요청사항</td>
</tr>
<%

	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String DB_ID = "multi";
	String DB_PW = "abcd";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);
	

	String sql = "select * from orders";

	PreparedStatement pstmt = con.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()){
		String order_name = rs.getString("order_name");
		String order_address = rs.getString("order_address");
		String order_tel = rs.getString("order_tel");
		String order_comment = rs.getString("order_comment");
		int order_id = rs.getInt("order_id");

		String sql2 = "select * from order_item where order_id = ?";
		PreparedStatement pstmt2 = con.prepareStatement(sql2);
		pstmt2.setInt(1, order_id);
		ResultSet rs2 = pstmt2.executeQuery();
		
		while(rs2.next()){
			int item_id = rs2.getInt("item_id");
			int order_quantity = rs2.getInt("order_quantity");
			
			String sql3 = "select * from item where item_id = ?";
			PreparedStatement pstmt3 = con.prepareStatement(sql3);
			pstmt3.setInt(1, item_id);
			ResultSet rs3 = pstmt3.executeQuery();
			rs3.next();
			String name = rs3.getString("item_name");
			/*사진 꺼내기*/
			String category = rs3.getString("item_category");
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
								item_name = name + "(" +
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
<tr>
<td><img src="IMG/<%=item_picture%>.jpg"  style="width:100px"></td>
<td><%=item_name%></td>
<td><%=order_quantity%></td>
<td><%=order_tel%></td>
<td><%=order_address%></td>
<td><%=order_comment%></td>
</tr>



<%
		}
	}
		
		
%>
</table>
</div>
</body>
</html>