<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<html>
<head>
<link
      rel="stylesheet"
      href="./CSS/userDelete.css"
    />
<script language="javascript">
 function begin() {
  document.deleteform.password.focus();
 }
 function checkIt() {
  if (!document.deleteform.password.value) {
   alert("비밀번호를 입력해주세요");
   document.deleteform.password.focus();
   return false;
  }
 }
</script>
<title> 회원 탈퇴 </title>
</head>
<center>
 <body onload="begin()">
<%
 String id = (String)session.getAttribute("sid");
 if (id == null || id.equals("")) {
      out.println("<script>");
	out.println("window.parent.location.href='index.html';");
	out.println("</script>");
 } else {
%>


  <h1>회원탈퇴</h1>
  <br>
  <br>
  <h3>서비스 이용 해지 안내사항</h3>
  <p>탈퇴 시 기존 아이디로 재가입이 불가능 합니다.<br>
회원 탈퇴를 신청하시면 해당 아이디는 즉시 탈퇴 처리되며, <br>
이후 영구적으로 사용이 중지되므로 새로운 아이디로만 재가입이 가능합니다.<br>
또한, 결제내역 및 회원 등급은 삭제, 초기화되며<br>
재가입 시 연동되지 않습니다.</p>
<br>
<p>그동안 MAKEUPMATE를 사랑해주셔서 감사합니다.</p>
  <form name="deleteform" action="userDeleteResult.jsp" method="post" onSubmit="return checkIt()">
      <input type="password" name="password" placeholder="비밀번호를 입력해주세요." class="input">
   <br>
   <input type="submit" value="탈퇴" class="button">
  </form>
 </body>
</center>
<%
 }
%>
</html> 

