<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<title>��ٱ��� ���</title>
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
		<div id="login">��ٱ��� �̿��� ���ؼ��� �α����� �ʿ��մϴ�.</div>
			<div id="submit"><a href="login.jsp"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">�α������� �̵�</a></div>
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
		String option = request.getParameter("option"); // ��ǰ��ȣ
		String[] parts = option.split(",");
		option = parts[0].trim();
		String user_id = request.getParameter("user_id"); 
		String category = request.getParameter("category"); 
		int qty = Integer.parseInt(request.getParameter("qty")); //  �ֹ�����(��ٱ��Ͽ� ���� ��ǰ����)

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
			int sum = rs.getInt("cart_quantity") + qty;  //  �̹� ������ �ִ� �������� ���� �߰���ų ������ �ջ���.

			String jsql2 = "update cart_product set cart_quantity=? where item_id = ? and user_id=? and cart_quantity=?";
			PreparedStatement pstmt2 = con.prepareStatement(jsql2);
			pstmt2.setInt(1, sum);
			pstmt2.setString(2, item_id);
			pstmt2.setString(3, user_id);
			pstmt2.setInt(4, cart_quantity);
	

			pstmt2.executeUpdate();
		}
		else  // ���� ��ǰ�� ��ٱ��Ͽ� �������� �ʴ´ٸ�, ���ο� ��ǰ���ڵ带 ��ٱ��� ���̺� �߰���Ŵ
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
