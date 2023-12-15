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
<title>닉네임 중복 검사</title>

</head>

<body bgcolor="#ffffff">
<br>
<table width="228" border="0" cellspacing="1" cellpadding="3" height="50" style="font-size:10pt;font-family:맑은 고딕">
    <tr>
        <td height="25" align=center >
          닉네임 : <%=request.getParameter("Nickname")%>
        </td>
    </tr>
    
    <tr>
        <td height="25" align=center>
  <%  
		   if(isExist)  
                 out.println("이미 존재하는 닉네임입니다.");
	       else 
                 out.println("사용 가능한 닉네임입니다. ");
  %>
        </td>
    </tr>

    <tr>
        <td align=center>
            <a href="javascript:window.close()">닫기</a>
        </td>
    </tr>
</table>
</body>
</html>