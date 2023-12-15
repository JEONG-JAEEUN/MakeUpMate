<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
    <html>

    <head>
		<link rel="stylesheet" href="./CSS/DetailProduct.css" />
        <link rel="stylesheet" href="./CSS/personalPerfume.css">
		<script language="javascript" src="./JS/detailProduct.js"></script>
		    <script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
		<title>PERSONAL PERFUME</title>
		<style>
            #btnFlex {
                display: flex;
                justify-content: space-between;
            }

            .incart {
                width: 300px;
                height: 45px;
                font-weight: bold;
                font-size: 18px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                border: 2px solid black;
                margin: 7px 0;
                box-sizing: border-box;
            }

            .direct {
                width: 300px;
                height: 45px;
                font-weight: bold;
                font-size: 18px;
                border: none;
                border-radius: 5px;
                background-color: black;
                cursor: pointer;
                margin: 7px 0;
            }

            .incart a {
                color: black;
            }

            .direct a {
                color: white;
            }

            .qty {
                font-size: 25px;
            }

            .qtyAndUpDown {
                display: flex;
                margin-top: 10px;
            }

            .qtyAndUpDown input {
                height: 35px;
                text-align: center;
                font-size: 25px;
                padding: 0 10px;
            }
        </style>
        <script>
            function amountPlus() {
                obj = document.personalPerfume.qty;
                obj.value = parseInt(obj.value) + 1;
            }
            function amountMinus() {
                obj = document.personalPerfume.qty;
                if (parseInt(obj.value) > 1) {
                    obj.value = parseInt(obj.value) - 1;
                }
                else {
                    alert('더이상 줄일수가 없습니다');
                    return;
                }
            }
            function amountCheck() {
                obj = document.personalPerfume.qty;
                if (isNaN(obj.value)) {
                    obj.value = "1";
                    alert('숫자만 입력해주세요.');
                    return;
                }
                if (obj.value < 1) {
                    obj.value = "1";
                }
            }
            function directOrd()
			{
				var qty=personalPerfume.qty.value;
				var frm = document.personalPerfume;
				var item_name = personalPerfume.item_name.value;
				var item_price = personalPerfume.item_price.value;
				var color = personalPerfume.color.value;
				var cases = personalPerfume.cases.value;
				var text = personalPerfume.text.value;
				var scent = personalPerfume.scent.value;
				frm.action = "personalDirectOrder.jsp";
				frm.submit();
			}
			function inCart() 
			{
				var qty=personalPerfume.qty.value;
				var frm = document.personalPerfume;
				var item_name = personalPerfume.item_name.value;
				var item_price = personalPerfume.item_price.value;
				var color = personalPerfume.color.value;
				var cases = personalPerfume.cases.value;
				var text = personalPerfume.text.value;


				var selectedScent = [];
				var scentCheckboxes = frm.querySelectorAll('input[name="scent"]:checked');

				scentCheckboxes.forEach(function(checkbox) {
					selectedScent.push(checkbox.value);
				});

				console.log(selectedScent);

				frm.scent.value = selectedScent.join('');
				frm.action = "personalCart.jsp";
				frm.submit();
			}
            function heartOk() {
                var frm = document.personalPerfume;
                frm.action = "heartOk.jsp";
                frm.submit();
            }
        </script>
    </head>

    <body>

	 <%
			String item_id = "18";
			String myid = (String)session.getAttribute("sid");

			String DB_URL = "jdbc:mysql://localhost:3306/shoppingmall";
			String DB_ID = "multi";
			String DB_PASSWORD = "abcd";

			Class.forName("org.gjt.mm.mysql.Driver");
			Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	%>
        <br>
        <br>
        <div style="display: flex; justify-content: center;">
            <div style="margin-right: 50px;">
                <p><a href="main.html"><i class="fa-solid fa-house"></i> 홈</a> > PERSONAL > PERSONALPERFUME</p>
				<img src="IMG/personalPerfume.jpg">
            </div>
            <div>
                <br><br><br>
                <form name=personalPerfume method="post">
				<input type = "hidden" name = "item_name" value = "personalPerfume">
				<input type = "hidden" name = "item_price" value = "99000">
                    <table>
                        <tr>
                            <td colspan="3" class="name">Personal Perfume (My own perfume)</td>
                        </tr>
                        <tr>
                            <td class="price">99,000원</td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr style="height: 20px;"></tr>
                        <tr>
                            <td class="option">Color</td>
                            <td width="60px"></td>
                            <td><input type="color" name="color" class="color"></td>
                        </tr>
                        <tr>
                            <td class="option">Case design</td>
                            <td width="30px"></td>
                            <td><select name="cases" class="cases">
                                    <option value="1">1(하트무늬)</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td class="option" style="text-align:top">Scent</td>
                            <td></td>
                            <td>
                                <input type="checkbox" value="blackberry" name="scent">blackberry
                                <input type="checkbox" value="litchi" name="scent">litchi
                                <input type="checkbox" value="cherry" name="scent">cherry
                                <br>
                                <input type="checkbox" value="lily" name="scent">llily
                                <input type="checkbox" value="freesia" name="scent">freesia
                                <input type="checkbox" value="mint" name="scent">mint
                                <br>
                                <input type="checkbox" value="cinnamon" name="scent">cinnamon
                                <input type="checkbox" value="coffee" name="scent">coffee
                                <input type="checkbox" value="herb" name="scent">herb
                                <br>
                                <input type="checkbox" value="pinewood" name="scent">pinewood
                            </td>
							<input type="hidden" name="scent" id="scent">
                        </tr>
                        <tr>
                            <td class="option">Text</td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3"><input type="text" name="text"
                                    placeholder="영문 대문자 , 숫자 , 띄어쓰기만 입력 가능 (최대 10자)" class="text"></td>
                        </tr>
                        <tr>
                            <td class="small">각인을 원하지 않으신다면 칸을 비워주세요.</td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                    <br>
                    <div>
                        <div>수량</div>
                        <div class="qtyAndUpDown">
                            <input type=button value="-" onClick="amountMinus();">
                            <input type=text name=qty size=7 value="1" onblur="javascript:amountCheck();" class="qty">
                            <input type=button value="+" onClick="amountPlus();">
                        </div>
                    </div>
                    <br>
                    <div id="btnFlex">
                        <div class="incart"><a href="javascript:inCart()"
                                style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoratio	n: none;">장바구니</a>
                        </div>
                        <div class="direct"><a href="javascript:directOrd()"
                                style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">바로구매</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

<div id="btnFlex2">
        <button id="detailBtn" onclick="scrollToSection('content1')">상품 상세</button>
        <button class="contentBtn" onclick="scrollToSection('content2')">리뷰</button>
        <button class="contentBtn" onclick="scrollToSection('content3')">상품 문의</button>
      </div>

<div id="content1" class="content">
    <div class="detailImg">
<img src="IMG/DetailPersonalPerfume.png">
</div>
</div>


<div id="content2">
<form name="reviewForm" action="insertReviewResult.jsp" method="post">
<input type="hidden" name="item_id" value="<%= item_id %>">
<input type="hidden" name="myid" value="<%=myid%>">
<h2>리뷰</h2>
<div id="reviewFlex">
            <input type="text" name="review" placeholder="리뷰를 입력하세요" id="reviewInput" onkeydown="onEnterSubmit()">
            <div class="insert"><a href="javascript:review()"
                style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">등록</a>
            </div>
          </div>
<table>
<tr>
              <td style="width:250px; font-weight: bold; font-size: 17px; height:50px;"> 닉네임 </td>
              <td style="width:1030px; font-weight: bold; font-size: 17px; text-align: center;"> 내용 </td>
            </tr>
<%

	String reviewsql = "select * from review where item_id = ?";
	PreparedStatement reviewPstmt = con.prepareStatement(reviewsql);
	reviewPstmt.setString(1, item_id);
	ResultSet reviewRs = reviewPstmt.executeQuery();

	while(reviewRs.next()){
		int user_id = reviewRs.getInt("user_id");
		String review_content = reviewRs.getString("review_content");
		String userSql = "select user_nickname from user where user_id = ?";

		PreparedStatement userPstmt = con.prepareStatement(userSql);
		userPstmt.setInt(1, user_id);
		ResultSet userRs = userPstmt.executeQuery();
		userRs.next();
		String user_nickname = userRs.getString("user_nickname");
%>

	<tr>
		<td style="height:50px;"><%=user_nickname%></td>
		<td><%=review_content%></td>
	</tr>
<%
	}
%>
</table>
</form>
</div>
      <div id="content3">
        <div>
          <h2>상품 문의</h2>
          <div id="content3Content">
            일반판매 문의<br><br>
            1588 - 1234 (평일 09:00 ~ 18:00)<br><br>
            MakeMate@Make.com
          </div>
        </div>
      </div>

    </body>

    </html>