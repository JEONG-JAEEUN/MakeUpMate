<%@ page contentType="text/html;charset=euc-kr" %> 
<%@ page import="java.sql.*"%>

<html>
  <head>
    <title>검색 결과</title>
    <link href="CSS/product.css" rel="stylesheet" type="text/css" />
    <script src="https://kit.fontawesome.com/5286d2d6db.js" crossorigin="anonymous"></script>
  </head>

  <body>
    <%
    String myid = (String)session.getAttribute("sid");
    boolean isUserLoggedIn = (myid != null);

    request.setCharacterEncoding("euc-kr");
    String searchValue = request.getParameter("searchValue");

    String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";  
    String DB_ID="multi"; 
    String DB_PASSWORD="abcd";
	           try {
                Class.forName("org.gjt.mm.mysql.Driver");  
                Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

                String sql = "SELECT item_id, item_name, item_quantity, item_price, item_heart FROM (SELECT item_id, item_name, item_quantity, item_price, item_heart,       ROW_NUMBER() OVER (PARTITION BY item_name ORDER BY item_id) AS row_num       FROM item WHERE item_name LIKE ?) AS subquery WHERE row_num = 1;";
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, "%" + searchValue + "%");

                ResultSet rs = pstmt.executeQuery();
    %>
    
    <div id="productWrapper">
        <div>
            <a href="main.html"><i class="fa-solid fa-house"></i> 홈</a> > 상품검색
        </div>
        
        <div id="columns">
            <%
 
                 if (rs.next()) {
            do {
                        String id = rs.getString("item_id");
                        String name = rs.getString("item_name");
                        String price = rs.getString("item_price");

                        String sql2 = "SELECT * FROM item_picture WHERE item_id = ?";
                        PreparedStatement pstmt2 = con.prepareStatement(sql2);
                        pstmt2.setString(1, id);
                        ResultSet rs2 = pstmt2.executeQuery();
                        rs2.next();
                        String img = rs2.getString("picture_address");

                        String sql3 = "SELECT COUNT(*) AS reviewTotal FROM review WHERE item_id = ?";
                        PreparedStatement pstmt3 = con.prepareStatement(sql3);
                        pstmt3.setString(1, id);
                        ResultSet rs3 = pstmt3.executeQuery();
                        rs3.next();
                        int reviewTotal = rs3.getInt("reviewTotal");

                        boolean isHearted = false;
                        if (isUserLoggedIn) {
                            String checkHeartSql = "SELECT * FROM heart WHERE user_id = ? AND item_id = ?";
                            PreparedStatement checkHeartStmt = con.prepareStatement(checkHeartSql);
                            checkHeartStmt.setString(1, myid);
                            checkHeartStmt.setString(2, id);
                            ResultSet checkHeartRs = checkHeartStmt.executeQuery();
                            isHearted = checkHeartRs.next();
                            checkHeartRs.close();
                            checkHeartStmt.close();
                        }
            %>
            <div class="card">
                <a href="viewDetailProduct.jsp?item_id=<%=id%>">
                    <div class="iconAndImg">
                        <% if (isHearted) { %>
                            <i class="fa-solid fa-heart heart-icon"></i>
                        <% } else { %>
                            <i class="fa-regular fa-heart heart-icon"></i>
                        <% } %>
                        <img src="IMG/<%=img%>.jpg">
                    </div>
                    <div class="name">
                        <div class="title">
                            <div><%=name%></div>
                        </div>
                        <div class="won"><%=price%>원</div>
                        <div class="rev">
                            <i class="fa-regular fa-comments"></i> 리뷰 <%=reviewTotal%>
                        </div>
                    </div>
                </a>
            </div>
               <%
            } while (rs.next());
        }else {
                %>
                <div class="noResult">일치하는 결과가 없습니다.</div>
            <%
            }
        rs.close();
        pstmt.close();
        con.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } %>
        </div>
    </div>
  </body>
</html>
