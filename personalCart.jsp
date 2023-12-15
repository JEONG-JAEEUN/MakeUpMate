<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>결제</title>
</head>
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
<script language="javascript" src="./JS/.js">
</script>

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
<%
	request.setCharacterEncoding("euc-kr");
	String uId = (String)session.getAttribute("sid");
	String qty = request.getParameter("qty");
	String item_name = request.getParameter("item_name");
	String item_price = request.getParameter("item_price");
	String color = request.getParameter("color");
	String cases = request.getParameter("cases");
	String text = request.getParameter("text");
	String item_category = "";
	String[] scents = null;
	String scent = "";
	int item_heart = 0;

	if(item_name.equals("personalLip")){
		item_category = "personal_lip";
	}else if(item_name.equals("personalCheek")){
		item_category = "personal_cheek";
	}else if(item_name.equals("personalPerfume")){
		item_category = "personal_perfume";
		scents = request.getParameterValues("scent");
		for(int i = 0; i<scents.length; i++){
			scent += scents[i] + "+";
		}
		scent = scent.substring(0, scent.length() - 2);
	}

	String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
	String DB_ID = "multi";
	String DB_PW = "abcd";
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

	String sql = "insert into item (item_name, item_quantity, item_price, item_category, item_heart) values (?, ?, ?, ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, item_name);
	pstmt.setString(2, qty);
	pstmt.setString(3, item_price);
	pstmt.setString(4, item_category);
	pstmt.setInt(5, item_heart);

	pstmt.executeUpdate();
	
	String sql2 = "SELECT * FROM item WHERE item_category = ? ORDER BY item_id DESC LIMIT 1";
	PreparedStatement pstmt2 = con.prepareStatement(sql2);
	pstmt2.setString(1, item_category);
	ResultSet rs = pstmt2.executeQuery();
	rs.next();
	int item_id = rs.getInt("item_id");

	String sql3 ="";
	switch(item_category){
		case "personal_lip":
			sql3 = "insert into personal_lip (item_id, color, `case`, engrave) values (?, ?, ?, ?)";
			PreparedStatement lippstmt = con.prepareStatement(sql3);
			lippstmt.setInt(1, item_id);
			lippstmt.setString(2, color);
			lippstmt.setString(3, cases);
			lippstmt.setString(4, text);
			lippstmt.executeUpdate();
			break;
		case "personal_cheek":
			sql3 = "insert into personal_cheek (item_id, color, `case`, engrave) values (?, ?, ?, ?)";
			PreparedStatement cheekpstmt = con.prepareStatement(sql3);
			cheekpstmt.setInt(1, item_id);
			cheekpstmt.setString(2, color);
			cheekpstmt.setString(3, cases);
			cheekpstmt.setString(4, text);
			cheekpstmt.executeUpdate();
			break;
		case "personal_perfume":
			sql3 = "insert into personal_perfume (item_id, color, `case`, engrave, scent) values (?, ?, ?, ?, ?)";
			PreparedStatement perfumepstmt = con.prepareStatement(sql3);
			perfumepstmt.setInt(1, item_id);
			perfumepstmt.setString(2, color);
			perfumepstmt.setString(3, cases);
			perfumepstmt.setString(4, text);
			perfumepstmt.setString(5, scent);
			perfumepstmt.executeUpdate();
			break;
		default:
			break;
	}


	String sql4 = "insert into cart_product (user_id, item_id, cart_quantity) values (?, ?, ?)";
	PreparedStatement pstmt4 = con.prepareStatement(sql4);
	pstmt4.setString(1, uId);
	pstmt4.setInt(2, item_id);
	pstmt4.setString(3, qty);
	pstmt4.executeUpdate();

	response.sendRedirect("userCart.jsp");
}
%>
</body>
</html>