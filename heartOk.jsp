<%@ page import="java.sql.*" %>

<%
try {
    String item_id = request.getParameter("item_id");
    String user_id = request.getParameter("user_id");
    boolean isHearted = Boolean.parseBoolean(request.getParameter("isHearted"));

    // 데이터베이스 연결
    String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // 토글 로직 수행
    String checkHeartSql = "SELECT * FROM heart WHERE user_id = ? AND item_id = ?";
    try (PreparedStatement checkHeartStmt = con.prepareStatement(checkHeartSql)) {
        checkHeartStmt.setString(1, user_id);
        checkHeartStmt.setString(2, item_id);
        ResultSet checkHeartRs = checkHeartStmt.executeQuery();

        if (isHearted) {
            // 이미 하트가 있으면 삭제
            if (checkHeartRs.next()) {
                String deleteHeartSql = "DELETE FROM heart WHERE user_id = ? AND item_id = ?";
                try (PreparedStatement deleteHeartStmt = con.prepareStatement(deleteHeartSql)) {
                    deleteHeartStmt.setString(1, user_id);
                    deleteHeartStmt.setString(2, item_id);
                    deleteHeartStmt.executeUpdate();
                }
            }
        } else {
            // 하트가 없으면 추가
            if (!checkHeartRs.next()) {
                String insertHeartSql = "INSERT INTO heart (user_id, item_id) VALUES (?, ?)";
                try (PreparedStatement insertHeartStmt = con.prepareStatement(insertHeartSql)) {
                    insertHeartStmt.setString(1, user_id);
                    insertHeartStmt.setString(2, item_id);
                    insertHeartStmt.executeUpdate();
                }
            }
        }

        // item 테이블의 item_heart 업데이트
        String updateItemHeartSql = "UPDATE item SET item_heart = item_heart + ? WHERE item_id = ?";
        try (PreparedStatement updateItemHeartStmt = con.prepareStatement(updateItemHeartSql)) {
            int updateValue = isHearted ? -1 : 1; // 하트가 존재하면 감소, 없으면 증가
            updateItemHeartStmt.setInt(1, updateValue);
            updateItemHeartStmt.setString(2, item_id);
            updateItemHeartStmt.executeUpdate();
        }

        // 연결 종료
        con.close();
    }
        // 토글 로직 실행 후 다시 원래 상품 창으로 리다이렉트
        response.sendRedirect("viewDetailProduct.jsp?item_id=" + item_id);

    } catch (Exception e) {
        e.printStackTrace();
        
    }
%>
