<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>MakeUpMate : 회원가입</title>
<link rel="stylesheet" href="./CSS/newMemResult.css" />
<script>
	historyBack = () => {
      history.back();
      // history.go(-1); // 뒤로 한번 이동
    }
	  </script>

</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

	String id = request.getParameter("id");   
	String password = request.getParameter("password");
	String	name = request.getParameter("name");
	String	birthYear = request.getParameter("year");
	String	birthMonth = request.getParameter("month");
	String	birthDay = request.getParameter("date");
	if (birthDay.length() == 1) {
    birthDay = "0" + birthDay;
	}
	String	birth = birthYear+birthMonth+birthDay;
	String	email = request.getParameter("email");
	String	phone = request.getParameter("phone");
	String nickname = request.getParameter("Nickname");
	String rank="Welcome";
	String role="일반회원";
	int totalOrderAmount = 0;
	

try {
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";  
     String DB_ID="multi"; 
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver"); 
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	
	String checkIdSql = "SELECT * FROM user WHERE login_id=?";
    PreparedStatement IDpstmt = con.prepareStatement(checkIdSql);
    IDpstmt.setString(1, id);
    ResultSet IdRs = IDpstmt.executeQuery();
	
	String checkNickSql = "SELECT * FROM user WHERE user_nickname=?";
    PreparedStatement Nickpstmt = con.prepareStatement(checkNickSql);
    Nickpstmt.setString(1, nickname);
    ResultSet nicknameRs = Nickpstmt.executeQuery();
	
	boolean isIdDuplicated = IdRs.next();
	boolean isNicknameDuplicated = nicknameRs.next();
	if (isIdDuplicated && isNicknameDuplicated) {
	%>
		<div class="content">
		<div class="overlap"> 이미 사용 중인 아이디와 닉네임입니다.<br><br>중복 확인을 이용하여 다른 아이디와 닉네임을 사용해 다시 가입해주세요.</div>
		   <br><div id="submit"><a href="javascript:history.back()" style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">회원가입으로 이동</a></div></div>
	<% 
	}else if (isIdDuplicated) {
	%>
		<div class="content">
           <div class="overlap"> 이미 사용 중인 아이디입니다. <br><br>중복 확인을 이용하여 다른 아이디를 사용해 다시 가입해주세요.</div>
		   <br><div id="submit"><a href="javascript:history.back()" style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">회원가입으로 이동</a></div></div>
	<%

    } else if (isNicknameDuplicated) {
	%>
<div class="content">
          <div class="overlap"> 이미 사용 중인 닉네임입니다. <br><br>중복 확인을 이용하여 다른 닉네임을 사용해 다시 가입해주세요.</div>
		 <br> <div id="submit"><a href="javascript:history.back()" style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">회원가입으로 이동</a></div></div>
	<%
    } else 
	{
	String jsql = "select MAX(user_id) from user";
	PreparedStatement pstmt = con.prepareStatement(jsql);
	ResultSet rs = pstmt.executeQuery(); 
	int userNum;
	if(rs.next()) 
		userNum = rs.getInt(1) + 1;
	else
		userNum=1;

	 String jsql2 = "INSERT INTO user (user_id, login_id, user_pw, user_name, user_birth, user_email, user_tel, user_nickname,user_rank, user_role, user_totalOrderAmount) VALUES (?,?,?,?,?,?,?,?,?,?,?)";	

	 PreparedStatement pstmt2  = con.prepareStatement(jsql2);
	 pstmt2.setInt(1,userNum);
	 pstmt2.setString(2,id);
	 pstmt2.setString(3,password);
	 pstmt2.setString(4,name);
	 pstmt2.setString(5,birth);
	 pstmt2.setString(6,email);
	 pstmt2.setString(7,phone);
	 pstmt2.setString(8,nickname);
	 pstmt2.setString(9,rank);
	 pstmt2.setString(10,role);
	 pstmt2.setInt(11,totalOrderAmount);

	 pstmt2.executeUpdate();
	%>
		<div class="content">
	<div  class="overlap"> <%=name%>님 MakeUpMate에 오신걸 환영합니다. <br><br>ID : <%=id%></div><br>
	<div id="submit"><a href="login.jsp" style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">로그인으로 이동</a></div>
	</div>
 <%
	}
  } catch(Exception e) { 
		out.println(e);
}

%>
</body>
</html>