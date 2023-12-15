<%@ page import="java.sql.*" %>

<%
try {
    String item_id = request.getParameter("item_id");
    String user_id = request.getParameter("user_id");
    boolean isHearted = Boolean.parseBoolean(request.getParameter("isHearted"));

    // �����ͺ��̽� ����
    String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // ��� ���� ����
    String checkHeartSql = "SELECT * FROM heart WHERE user_id = ? AND item_id = ?";
    try (PreparedStatement checkHeartStmt = con.prepareStatement(checkHeartSql)) {
        checkHeartStmt.setString(1, user_id);
        checkHeartStmt.setString(2, item_id);
        ResultSet checkHeartRs = checkHeartStmt.executeQuery();

        if (isHearted) {
            // �̹� ��Ʈ�� ������ ����
            if (checkHeartRs.next()) {
                String deleteHeartSql = "DELETE FROM heart WHERE user_id = ? AND item_id = ?";
                try (PreparedStatement deleteHeartStmt = con.prepareStatement(deleteHeartSql)) {
                    deleteHeartStmt.setString(1, user_id);
                    deleteHeartStmt.setString(2, item_id);
                    deleteHeartStmt.executeUpdate();
                }
            }
        } else {
            // ��Ʈ�� ������ �߰�
            if (!checkHeartRs.next()) {
                String insertHeartSql = "INSERT INTO heart (user_id, item_id) VALUES (?, ?)";
                try (PreparedStatement insertHeartStmt = con.prepareStatement(insertHeartSql)) {
                    insertHeartStmt.setString(1, user_id);
                    insertHeartStmt.setString(2, item_id);
                    insertHeartStmt.executeUpdate();
                }
            }
        }

        // item ���̺��� item_heart ������Ʈ
        String updateItemHeartSql = "UPDATE item SET item_heart = item_heart + ? WHERE item_id = ?";
        try (PreparedStatement updateItemHeartStmt = con.prepareStatement(updateItemHeartSql)) {
            int updateValue = isHearted ? -1 : 1; // ��Ʈ�� �����ϸ� ����, ������ ����
            updateItemHeartStmt.setInt(1, updateValue);
            updateItemHeartStmt.setString(2, item_id);
            updateItemHeartStmt.executeUpdate();
        }

        // ���� ����
        con.close();
    }
        // ��� ���� ���� �� �ٽ� ���� ��ǰ â���� �����̷�Ʈ
        response.sendRedirect("viewDetailProduct.jsp?item_id=" + item_id);

    } catch (Exception e) {
        e.printStackTrace();
        
    }
%>
