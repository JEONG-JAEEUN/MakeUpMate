<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<html>
<head>
<title>��� ����</title>
<link rel="stylesheet" href="./CSS/personlDirectOrd.css" />
<script language="javascript" src="./JS/directOrder.js">
</script>
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
      <div id="login">��ǰ �ֹ��� ���ؼ��� �α����� �ʿ��մϴ�.</div>
         <div id="submit"><a href="login.jsp"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">�α������� �̵�</a></div>
           </center>
<%
}
else  
{
   %>
<form name ="cartList" method=post action=directOrderResult.jsp>
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

   
   int total = 0;

   int item_total_price = Integer.parseInt(qty) * Integer.parseInt(item_price);
   total += item_total_price;

   String name = "";
   String item_picture = "";
   String jsqlOption = "SELECT * FROM " + item_category + " WHERE item_id = ?";
   PreparedStatement pstmtOption = con.prepareStatement(jsqlOption);
   pstmtOption.setInt(1, item_id);
   ResultSet optionRs = pstmtOption.executeQuery();
   optionRs.next();
   if(item_category.equals("personal_perfume")){
      name = item_name + "(" +
      cases +"/"+
      color +"/"+
      text +"/"+
      scent + ")";
      item_picture = "personalPerfume";
   }else{
      name = item_name + "(" +
      cases +"/"+
      color +"/"+
      text + ")";
      if(item_category.equals("personal_lip")){
         item_picture = "personalLip";
      }else{
         item_picture = "personalCheck";
      }
   }
%>
<input type="hidden" name = "qty" value="<%=qty%>">
<input type="hidden" name = "item_id" value="<%=item_id%>">
<input type="hidden" name = "user_id" value="<%=uId%>">
<br><br>
<Center><h1> ���� </h1></Center>

<div class="title">�������� <i class="fa-solid fa-bars-staggered"></i></div>
<div>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<div width=1200px >
<div class="container" style="display: flex; justify-content: center;">
 <div class="info">��ǰ ����</div>
 <div class="price">����</div>
 <div class="number"> ���� </div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none">
<div style="display: flex; justify-content: center;">
<div class="list">
      <div class="infodetail">
      <div><img src="IMG/<%=item_picture%>.jpg" style="border-radius: 100%; width: 200px; maring-left:90px;"></div>
      <div class="item_name" style="margin-left:30px;"><%=name%></div>
      </div>
      <div class="item_price"> <%=item_total_price%> ��</div>
      <div class="num"><%=qty%> ��</div>
</div>
</div>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
<table style="display: flex; justify-content: center;">
<tr>
 <td class="total" style="display:flex">�� �ݾ�&nbsp;&nbsp;&nbsp;<p>��ۺ� 3000��<p></td> 
 <td class="hap"><%=total%>+3000��</td>  
 <td class="hap"><%=total + 3000%>��</td>
 </tr>
</table>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
</div>
<input type ="hidden" name="total" value="<%=total%>">

<br><br><br>
<div class="title">�������� <i class="fa-solid fa-truck"></i></div>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none;">
<br>
<div style="margin-left:110px;">
<table>
<tr><td class="text" width="150px">�����ڸ�</td> <td width="500px"><input type="text" name="recipient" class="box"></td></tr>
<tr><td class="text">����ó </td> <td><input type="text" name="tel" class="box"></td></tr>
</table>
<p class="text">�����</p>
<input type="text" name="zipcode" size="7" readonly class="box"> 
<input type="button" value="�����ȣ�˻�" onClick="zipCheck()" class="button"><br>     
<input type="text" name="address1" size="40"  readonly class="box"><br>
<input type="text" name="address2" size="40" class="box">&nbsp<font size =2>(���ּ��Է�)
<div style="display:flex">
<div class="text">��û����</div><input type="text" name="request" class="box">
</div>
<br><br><br>
<div class="title" style="margin-left:-0px" >����  <i class="fa-regular fa-credit-card"></i></div>
<br>
<hr style="height: 3px; background-color: #D9D9D9; border: none; margin-left:-110px;">
<br>
<table>
<tr><td width=150px class="text" style="margin-top:12px;">����</td> <td width=300px width=200px ><select name="bank">
      <option selected>��������</option>
      <option>�츮����</option>
      <option>��������</option>
      <option>��������</option>
   </select></td></tr>
<tr><td class="text" style="margin-top:12px;">�Աݰ��¹�ȣ</td><td><input type = "hidden" name = "bankNum" value="���� 1111-111-1111" class="text">���� 1111-111-1111</td></tr>
<tr><td class="text" style="margin-top:12px;">�Ա��ڸ�</td><td>   <input type="text" name="bankName" class="box"></td></tr>

<%
  // ���� ��¥ ��������
  LocalDate currentDate = LocalDate.now();

  // 7���� ���� ��¥ ���
  LocalDate dueDate = currentDate.plusDays(7);

  // ��¥ ���� ���� (��: "yyyy-MM-dd")
  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

  // �Աݱ��� ���
  String formattedDueDate = dueDate.format(formatter);
%>
<tr><td class="text"><input type="hidden" name ="deadline"  value=<%=formattedDueDate%>> �Աݱ���</td><td><%= formattedDueDate %></td></tr>
</table>
<br>
<input type="button" value="�����ϱ�" onclick="payment()" class="buttonpay">
</div>
</form>
<%
}
%>
</body>
</html>