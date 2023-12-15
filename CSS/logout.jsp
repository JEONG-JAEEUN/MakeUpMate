<%@ page contentType="text/html; charset=euc-kr" %>
<%
    session.invalidate();   
    out.println("<script>");
out.println("window.parent.location.href='index.html';");
out.println("</script>");
%>