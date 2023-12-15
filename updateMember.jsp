<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head><title>회원 정보 수정 </title>
<link rel="stylesheet" href="CSS/update.css" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=Roboto:wght@300;400;500;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Righteous&family=Roboto:wght@100&family=Single+Day&display=swap"
      rel="stylesheet"
    />
    <script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
</head>
<body>

<%	 
try {
 	 String DB_URL="jdbc:mysql://localhost:3306/shoppingmall";  
     String DB_ID="multi";  
     String DB_PASSWORD="abcd";
 	 
	 Class.forName("org.gjt.mm.mysql.Driver"); 
 	 Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
	
	 String key = request.getParameter("id");   
	 String jsql = "select * from user where login_id = ?";
	 PreparedStatement pstmt = con.prepareStatement(jsql);
	 pstmt.setString(1,key);

	 ResultSet rs = pstmt.executeQuery();
	 rs.next();
			
	 String id = rs.getString("login_id");
   	 String passwd = rs.getString("user_pw");
	 String name = rs.getString("user_name");
	 String birth = rs.getString("user_birth");
	 String year = birth.substring(0, 4);
	 String month = birth.substring(4, 6);
	 String day = birth.substring(6, 8);
	 String email = rs.getString("user_email");
	 String tel = rs.getString("user_tel");
	 String nickname = rs.getString("user_nickname");
%>
	<div class="container">
      <form id="joinForm" name="upMem" method="post" action="updateMemberResult.jsp">
        <div id="joinInner">
          <h1 id="joinTitle">회원정보 수정</h1>
          <div class="flexId">
            <div id="flexId">
              아이디
              <div id="idFlex">
                <div class="id">
                  <input
                    type="hidden"
                    class="idtext"
                    id="id"
					name="id"
					value="<%=id%>"><%=id%>
                </div>
              </div>
            </div>
          </div>
          <div class="flexPass">
            <div id="flexPass">
              새 비밀번호
              <div class="pass">
                <input
                  type="password"
                  class="passtext"
                  id="pass"
                  placeholder="새 비밀번호를 입력해주세요"
				  name="password"
                  required
                />
                <i class="fa-solid fa-user-lock"></i>
              </div>
            </div>
          </div>

        <!--  <div class="flexPass2">
            <div id="flexPass2">
              <label for="pass2">새 비밀번호 확인</label>
              <div class="pass2">
                <input
                  type="password"
                  class="passtext"
                  id="pass2"
				  name="repassword"
                  placeholder="새 비밀번호를 다시 한번 입력해주세요."
                  required
                />
                <i class="fa-solid fa-lock"></i>
              </div>
            </div>
          </div>-->

          <div class="flexName">
            <div id="flexName">
              이름
			  <div id="nameFlex">
              <div class="name">
                <input
                  type="hidden"
                  class="nametext"
                  id="name"
				  name="name"
				  value="<%=name%>"
                ><%=name%>
              </div>
			  </div>
            </div>
          </div>
          
            <div class="flexBirth">
            <div id="flexBirth">
              <label for="birth">생년월일</label>
			  <div class="birthContainer">
                    <div class="birth">
                        <input type="text" placeholder="년(4자)" class="year" id="birth" maxlength="4" name="year" value="<%=year%>">
                    </div>
                    <select class="month" name="month">
                        <option>월</option>
                        <option <%= (month.equals("01") ? "selected" : "") %> value="01">1</option>
                        <option <%= (month.equals("02") ? "selected" : "") %> value="02">2</option>
                        <option <%= (month.equals("03") ? "selected" : "") %> value="03">3</option>
                        <option <%= (month.equals("04") ? "selected" : "") %> value="04">4</option>
                        <option <%= (month.equals("05") ? "selected" : "") %> value="05">5</option>
                        <option <%= (month.equals("06") ? "selected" : "") %> value="06">6</option>
                        <option <%= (month.equals("07") ? "selected" : "") %> value="07">7</option>
                        <option <%= (month.equals("08") ? "selected" : "") %> value="08">8</option>
                        <option <%= (month.equals("09") ? "selected" : "") %> value="09">9</option>
                        <option <%= (month.equals("10") ? "selected" : "") %> value="10">10</option>
                        <option <%= (month.equals("11") ? "selected" : "") %> value="11">11</option>
                        <option <%= (month.equals("12") ? "selected" : "") %> value="12">12</option>
                    </select>
                    <div class="date">
                        <input type="text" placeholder="일" class="day" maxlength="2" name="date" value="<%=day%>"><br>
                    </div>
                </div>
				</div>
				</div>

          <div class="flexEmail">
            <div id="flexEmail">
              <label for="email">이메일</label>
              <div class="email">
                <input
                  type="email"
                  placeholder="변경 이메일을 입력해주세요."
                  class="emailtext"
                  id="email"
				  name="email"
				  value="<%=email%>"
                  required
                /><br />
              </div>
            </div>
          </div>
          <div class="flexPhone">
            <div id="flexPhone">
              <label for="phone">휴대전화</label>
              <div class="num">
                <input
                  type="text"
                  class="numtext"
                  id="phone"
				  name="phone"
                  placeholder="변경 휴대전화번호를 입력해주세요.(-포함)"
				  value="<%=tel%>"
                  required
                />
              </div>
            </div>
          </div>
          <div class="flexNickName">
            <div id="flexNickName">
              닉네임
              <div id="NickNameFlex">
                <div class="Nickname">
                  <input
                    type="hidden"
                    class="Nicknametext"
                    id="Nickname"
					name="Nickname"
					value="<%=nickname%>"
					><%=nickname%>
                </div>
              </div>
            </div>
          </div>
		  <div id="btnFlex">
		  <div id="reset"><a href="mypage.jsp" style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none;">취소</a></div>
          <input type="button" value="회원 정보 수정" class="submit" onClick="uCheckValue()"/>
		  </div>
        </div>
      </form>
    </div>
<%
    } catch (Exception e) {
      out.println(e);	
}
%>
<script language="javascript" src="./JS/update.js"></script>
</body>
</html>