<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<html>
<head>
    <title>Item List</title>
</head>
<body>
<center>
    <br><br>
    <h2>전체 상품</h2>
   <table border=1>
    <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
            String DB_ID = "multi";
            String DB_PW = "abcd";
            Class.forName("org.gjt.mm.mysql.Driver");
            con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

            String query = "SELECT * FROM item WHERE item_name NOT LIKE '%personal%'";
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                int itemId = rs.getInt("item_id");
                String itemName = rs.getString("item_name");
                String itemQuantity = rs.getString("item_quantity");
                String itemPrice = rs.getString("item_price");
            String itemCategory = rs.getString("item_category");
                String name = itemName;
            // 상세 클릭시 id 작은 페이지로 넘기기위히해 id 작은값 변수로 저장
                String query2 = "SELECT MIN(item_id) AS min_id, item_name FROM item WHERE item_name = '" + itemName + "'";
                Statement stmt2 = con.createStatement();
                ResultSet rs2 = stmt2.executeQuery(query2);

                String itemPicture = "";
                String jsqlItemId = "SELECT MIN(item_id) AS min_id FROM item WHERE item_name = ?";
                PreparedStatement pstmtItemId = con.prepareStatement(jsqlItemId);
                pstmtItemId.setString(1, name);
                ResultSet itemIdRs = pstmtItemId.executeQuery();

            // option 값 가져옴
            String option = "";
                String queryOption = "";
                if (itemCategory.equals("cheek") || itemCategory.equals("lip")) {
                    queryOption = "SELECT options FROM " + itemCategory + " WHERE item_id = " + itemId;
                } else if (itemCategory.equals("perfume")) {
                    queryOption = "SELECT options FROM perfume WHERE item_id = " + itemId;
                }
            Statement stmtOption = con.createStatement();
                ResultSet rsOption = stmtOption.executeQuery(queryOption);
                if (rsOption.next()) {
                    option = rsOption.getString("options");
                }

            //사진 가져옴 ( id가 작은걸로)
                if (itemIdRs.next()) {
                    String smallestItemId = itemIdRs.getString("min_id");
                    String jsqlPicture = "SELECT * FROM item_picture WHERE item_id = ?";
                    PreparedStatement pstmtPicture = con.prepareStatement(jsqlPicture);
                    pstmtPicture.setString(1, smallestItemId);
                    ResultSet pictureRs = pstmtPicture.executeQuery();
                    if (pictureRs.next()) {
                        itemPicture = pictureRs.getString("picture_address");
                    }
                }

                while (rs2.next()) {
                    int minItemId = rs2.getInt("min_id");
    %>
                    <tr>
                        <td><img src="./IMG/<%= itemPicture %>.jpg" width="50"></td>
                        <td><%= itemName %> <p style="color:red">[ <%= option%> ]<p></td>
                        <td><%= itemQuantity %></td>
                        <td><%= itemPrice %></td>
                        <td><a href="updateGoods.jsp?item_id=<%= itemId %>">수정</a></td>
                        <td><a href="viewDetailProduct.jsp?item_id=<%= minItemId %>">상세</a></td>
                    </tr>
    <%
                }
                rs2.close();
                stmt2.close();
            }
            rs.close();
            stmt.close();
    %>
        </table>
        <br><br><br>
    <% } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 연결 해제
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    } %>
</center>
</body>
</html>