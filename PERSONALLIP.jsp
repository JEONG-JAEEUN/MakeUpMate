<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
    <html>

    <head>
		<link rel="stylesheet" href="./CSS/DetailProduct.css" />
        <link rel="stylesheet" href="./CSS/personalLip.css">
		<script language="javascript" src="./JS/detailProduct.js"></script>
		    <script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
		<title>PERSONAL LIP</title>
        <script>

function amountPlus() 
{
obj=document.personalLip.qty;
obj.value=parseInt(obj.value) + 1;
}
function amountMinus() 
{
obj=document.personalLip.qty;
if(parseInt(obj.value) > 1)
{
obj.value=parseInt(obj.value) - 1;
}
else
{
alert('더이상 줄일수가 없습니다');
return;
}
}
function amountCheck()
{
obj=document.personalLip.qty;
if(isNaN(obj.value)) 
{
obj.value="1";
alert('숫자만 입력해주세요.');
return;
}
 if(obj.value < 1)
{
obj.value="1";
}
}
function directOrd()
{
var qty=personalLip.qty.value;
var frm = document.personalLip;
var item_name = personalLip.item_name.value;
var item_price = personalLip.item_price.value;
var color = personalLip.color.value
var cases = personalLip.cases.value
var text = personalLip.text.value
frm.action = "personalDirectOrder.jsp";
frm.submit();
}
function inCart() 
{
var qty=personalLip.qty.value;
var frm = document.personalLip;
var item_name = personalLip.item_name.value;
var item_price = personalLip.item_price.value;
var color = personalLip.color.value
var cases = personalLip.cases.value
var text = personalLip.text.value
frm.action = "personalCart.jsp";
frm.submit();
}
function heartOk() 
{
var frm = document.personalLip;
frm.action = "heartOk.jsp";
frm.submit();
}
        </script>
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
    </head>

    <body>
	<%
			String item_id = "16";
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
            <div style="margin-right: 30px;">
                <p><a href="main.html"><i class="fa-solid fa-house"></i> 홈</a> > PERSONAL > PERSONALLIP</p>
                <img src="IMG/personalLip.jpg">
            </div>
            <div>
                <br><br><br>
                <form name=personalLip method="post">
				<input type = "hidden" name = "item_name" value = "personalLip">
				<input type = "hidden" name = "item_price" value = "39000">
                    <table>
                        <tr>
                            <td colspan="3" class="name">Personal Lip (My own lipstick)</td>
                        </tr>
                        <tr>
                            <td class="price">39,000 원</td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr style="height: 50px;"></tr>
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
                            <td class="option">Text</td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3"><input type="text" name="text"
                                    placeholder="영문 대문자 , 숫자 , 띄어쓰기만 입력 가능 (최대 10자)" class="text"></td>
                        </tr>
                        <tr>
                            <td colspan="3" class="small">각인을 원하지 않으신다면 칸을 비워주세요.</td>
                        </tr>
                    </table>
                    <br><br><br>
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
                                style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">장바구니</a>
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
<img src="IMG/DetailPersonalLip.png">
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