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
   alert("��й�ȣ�� �Է����ּ���");
   document.deleteform.password.focus();
   return false;
  }
 }
</script>
<title> ȸ�� Ż�� </title>
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


  <h1>ȸ��Ż��</h1>
  <br>
  <br>
  <h3>���� �̿� ���� �ȳ�����</h3>
  <p>Ż�� �� ���� ���̵�� �簡���� �Ұ��� �մϴ�.<br>
ȸ�� Ż�� ��û�Ͻø� �ش� ���̵�� ��� Ż�� ó���Ǹ�, <br>
���� ���������� ����� �����ǹǷ� ���ο� ���̵�θ� �簡���� �����մϴ�.<br>
����, �������� �� ȸ�� ����� ����, �ʱ�ȭ�Ǹ�<br>
�簡�� �� �������� �ʽ��ϴ�.</p>
<br>
<p>�׵��� MAKEUPMATE�� ������ּż� �����մϴ�.</p>
  <form name="deleteform" action="userDeleteResult.jsp" method="post" onSubmit="return checkIt()">
      <input type="password" name="password" placeholder="��й�ȣ�� �Է����ּ���." class="input">
   <br>
   <input type="submit" value="Ż��" class="button">
  </form>
 </body>
</center>
<%
 }
%>
</html> 

