<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="java.sql.*" %>

<%
boolean isExist = false;

try {
			request.setCharacterEncoding("euc-kr");
    	String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";  
        String DB_ID="multi"; 
        String DB_PASSWORD="abcd"; 


 	 
	    Class.forName("org.gjt.mm.mysql.Driver");  
 	    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
	    String Nickname = request.getParameter("Nickname");
	    
		String jsql = "select * from user where user_nickname = ?";   
        PreparedStatement  pstmt  = con.prepareStatement(jsql);
	    pstmt.setString(1, Nickname);

	    ResultSet rs = pstmt.executeQuery();  	
        
        if(rs.next())              
              isExist = true;
        else                        
             isExist = false;
    } catch (Exception e) {
        	out.println(e);
}
%>

<html>
<head>
<title>�г��� �ߺ� �˻�</title>

</head>

<body bgcolor="#ffffff">
<br>
<table width="228" border="0" cellspacing="1" cellpadding="3" height="50" style="font-size:10pt;font-family:���� ����">
    <tr>
        <td height="25" align=center >
          �г��� : <%=request.getParameter("Nickname")%>
        </td>
    </tr>
    
    <tr>
        <td height="25" align=center>
  <%  
		   if(isExist)  
                 out.println("�̹� �����ϴ� �г����Դϴ�.");
	       else 
                 out.println("��� ������ �г����Դϴ�. ");
  %>
        </td>
    </tr>

    <tr>
        <td align=center>
            <a href="javascript:window.close()">�ݱ�</a>
        </td>
    </tr>
</table>
</body>
</html>