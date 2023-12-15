<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>��ٱ��� ���</title>
<br><br>


<link href="./CSS/userCart.css" rel="stylesheet" type="text/css" />
<script src="https://kit.fontawesome.com/4f42de4c59.js" crossorigin="anonymous"></script>
</head>

<script language="javascript" src="./JS/userCart.js">
</script>


<body>

<Center><h1> ��ٱ��� </h1></Center>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<div width=1200px style="display: flex; justify-content: center;">
<div class="container">
 <div class="info">��ǰ ����</div>
 <div class="price">����</div>
 <div class="number">����</div>
 <div class="delete">���</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<%
		request.setCharacterEncoding("euc-kr");
		String uId = (String)session.getAttribute("sid");

		String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
		String DB_ID = "multi";
		String DB_PASSWORD = "abcd";
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

		String sql = "select * from cart_product where user_id = ?";		// ȸ�� ������ ���ǰ ã��

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, uId);
		ResultSet rs = pstmt.executeQuery();

		int total = 0;
		if(!rs.next())    // ��ȸ ����� �������� ������,  rs.next()�� false�� ������. 
		{                       //  ����,  !rs.next()�� ���� true�� �� 
%>
		��ٱ��ϰ� ������ϴ�.
<%
		}
		else
		{
			rs.beforeFirst();
			while(rs.next()){
				int item_id = rs.getInt("item_id");
				int cart_quantity = rs.getInt("cart_quantity");
				/*�ش� ��ǰ ���� ã��*/
				String sql2 = "select * from item where item_id = ?";
				PreparedStatement pstmt2 = con.prepareStatement(sql2);
				pstmt2.setInt(1, item_id);
				ResultSet rs2 = pstmt2.executeQuery();
				rs2.next();
				int item_price = rs2.getInt("item_price");
				String name = rs2.getString("item_name");	// ��ǰ��
				String item_name = "";
				String item_picture = "";
				total += item_price * cart_quantity;
				String category = rs2.getString("item_category");
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
						// �ɼ� ��������
						String jsqlOption = "SELECT * FROM " + category + " WHERE item_id = ?";
						PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
						pstmtOption.setInt(1, item_id);
						ResultSet optionRs = pstmtOption.executeQuery();

						if (optionRs.next()) {
							item_name = name + "(" + 
										optionRs.getString("options") + ")";
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
					}
%>

								
	<div>
 <div class="list" style="display: flex; justify-content: center;">
		<div class="infodetail">
		<div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px;"></div>
		<div class="item_name"><%=item_name%></div>
		</div>
		<div class="item_price"> <%=item_price%> ��</div>
		<div class="num"><%=cart_quantity%></div>
  <div class="cart">
  <form name="cart" method="post" action="cartCancel.jsp">
      <input type="hidden" name="item_id" value="<%=item_id%>">
      <div id="heartWrap">
          <button type="submit" class="cart-button"  style="cursor:pointer">
            <i class="fa-solid fa-cart-shopping fa-2xl"></i>
          </button>
      </div>
  </div>
  </form>
  </div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
</div>
<%
			}
%>
	<div style="display: flex; justify-content: center;">
<table>
<tr>
 <td class="total" style="display:flex">�� �ݾ�&nbsp;&nbsp;&nbsp;<p>��ۺ� 3000��<p></td> 
 <td class="hap"><%=total%>+3000��</td>  
 <td class="hap"><%=total + 3000%>��</td>
</table>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;margin-left: -110px;">
<br>
<center><button onclick="redirectToPayment()" class="payment" style="cursor:pointer">�����ϱ�</button></center>
<br><br><br>
<%
			}
%>
</body>
</html>