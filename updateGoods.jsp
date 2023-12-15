<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="euc-kr">
    <title>������ ��ǰ ����(��ü ��� ��ǰ ��ȸ)</title>
</head>

<body>
    <center>
        <br><br><br><br>
        <h2>�����ϱ�</h2>
        <table border=1>
            <tr>
                <td>�̸�</td><td>����</td><td>����</td><td>������ư</td>
            </tr>
            <%
                Connection con = null;
                try {
                    String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
                    String DB_ID = "multi";
                    String DB_PW = "abcd";
                    Class.forName("org.gjt.mm.mysql.Driver");
                    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

                    int item_id = Integer.parseInt(request.getParameter("item_id"));

                    String sql = "select * from item where item_id=?";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, item_id);
                    ResultSet rs = pstmt.executeQuery();

                    while(rs.next()){
                        String item_name = rs.getString("item_name");
                        int item_quantity = rs.getInt("item_quantity");
                        int item_price = rs.getInt("item_price");
            %>
                        <tr>
                            <form method="post" action="updateGoodsResult.jsp">
                                <td><input type="text" name="item_name" placeholder="�� �̸�" value="<%= item_name %>"></td>
                                <td><input type="number" name="item_quantity" placeholder="�� ����" value="<%= item_quantity %>"></td>
                                <td><input type="number" name="item_price" placeholder="�� ����" value="<%= item_price %>"></td>
                                <td>
                                    <input type="hidden" name="item_id" value="<%= item_id %>">
                                    <input type="submit" value="����">
                                </td>
                            </form>
                        </tr>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (con != null) {
                            con.close(); // ���� ����
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </table>
    </center>
</body>
</html>