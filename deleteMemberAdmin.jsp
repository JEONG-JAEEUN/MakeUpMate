<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("euc-kr");


String id = request.getParameter("id");

String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";
Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

String selectSQL = "SELECT * FROM user WHERE login_id=?";
    PreparedStatement selectStatement = connection.prepareStatement(selectSQL);
    selectStatement.setString(1, id);
    ResultSet resultSet = selectStatement.executeQuery();
   resultSet.next();
   String user_id=resultSet.getString("user_id");

try {
    
         
           String[] tablesToDelete = {"heart", "cart_product", "review", "orders"};

           for (String table : tablesToDelete) {
           String deleteSQL = "DELETE FROM " + table + " WHERE user_id=?";
           PreparedStatement deleteStatement = connection.prepareStatement(deleteSQL);
           deleteStatement.setString(1, user_id);
           deleteStatement.executeUpdate();
}
           String deleteSQLUser = "DELETE FROM user WHERE user_id=?";
           PreparedStatement deleteUserStatement = connection.prepareStatement(deleteSQLUser);
           deleteUserStatement.setString(1, user_id);
           deleteUserStatement.executeUpdate();
%>
            <script type="text/javascript">
                alert("회원 정보가 삭제되었습니다.");
            window.location.href='manager_index.jsp';
            </script>
<%
    connection.close();
} catch (Exception e) {
    out.println(e);
}
%>