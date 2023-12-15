<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("euc-kr");

String userId = (String) session.getAttribute("sid");
String userPassword = request.getParameter("password");

String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String selectSQL = "SELECT * FROM user WHERE user_id=?";
    PreparedStatement selectStatement = connection.prepareStatement(selectSQL);
    selectStatement.setString(1, userId);
    ResultSet resultSet = selectStatement.executeQuery();

    if (resultSet.next()) {
        if (resultSet.getString("user_pw").equals(userPassword)) {

           String[] tablesToDelete = {"heart", "cart_product", "review", "orders"};

           for (String table : tablesToDelete) {
           String deleteSQL = "DELETE FROM " + table + " WHERE user_id=?";
           PreparedStatement deleteStatement = connection.prepareStatement(deleteSQL);
           deleteStatement.setString(1, userId);
           deleteStatement.executeUpdate();
}

// Now, delete the user record after dependent records have been removed
           String deleteSQLUser = "DELETE FROM user WHERE user_id=?";
           PreparedStatement deleteUserStatement = connection.prepareStatement(deleteSQLUser);
           deleteUserStatement.setString(1, userId);
           deleteUserStatement.executeUpdate();

            session.invalidate();
%>
            <script type="text/javascript">
                alert("회원 정보가 삭제되었습니다.");
				window.parent.location.href='index.html';
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("비밀번호가 틀렸습니다.");
                history.back();
            </script>
<%
        }
    } else {
%>
        <script type="text/javascript">
            alert("해당하는 사용자가 없습니다.");
            history.back();
        </script>
<%
    }

    connection.close();
} catch (Exception e) {
    out.println(e);
}
%>