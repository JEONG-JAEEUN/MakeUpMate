<%@ page contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
    Connection con = null;
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
        String DB_ID = "multi";
        String DB_PW = "abcd";
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

        request.setCharacterEncoding("EUC-KR");

        int item_id = Integer.parseInt(request.getParameter("item_id"));
        String item_name = request.getParameter("item_name");
        int item_quantity = Integer.parseInt(request.getParameter("item_quantity"));
        int item_price = Integer.parseInt(request.getParameter("item_price"));

        String updateQuery = "UPDATE `item` SET item_name=?, item_quantity=?, item_price=? WHERE item_id=?";
        PreparedStatement pstmt = con.prepareStatement(updateQuery);
        pstmt.setString(1, item_name);
        pstmt.setInt(2, item_quantity); // setInt를 사용하여 정수로 설정
        pstmt.setInt(3, item_price); 
        pstmt.setInt(4, item_id);

        pstmt.executeUpdate();

        String selectQuery = "SELECT * FROM item WHERE item_id=?";
        PreparedStatement pstmt2 = con.prepareStatement(selectQuery);
        pstmt2.setInt(1, item_id);

        ResultSet rs = pstmt2.executeQuery();
        rs.next();
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<body>
    <br><br><br><br>
    <center>
        <h2>수정된 정보</h2>
        <table>
            <tr>
                <td>이름</td>
                <td><%= rs.getString("item_name") %></td>
            </tr>
            <tr>
                <td>수량</td>
                <td><%= rs.getInt("item_quantity") %></td>
            </tr>
            <tr>
                <td>가격</td>
                <td><%= rs.getInt("item_price") %></td>
            </tr>
        </table>
      <a href="selectAllGoods.jsp">상세</a>
    </center>
</body>
</html>
<%
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (con != null) {
                con.close(); // 연결 종료
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>