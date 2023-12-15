<%@ page contentType="text/html;charset=euc-kr" %>
<html>
  <head>
    <title>MakeUpMate : 회원가입</title>

    <link href="CSS/newMember.css" rel="stylesheet" type="text/css" />
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

  <body onLoad="idFocus()">
    <div id="newMemcontainer">
      <form id="joinForm" name="newMem" method=post action=newMemberResult.jsp>
        <div id="joinInner">
          <h1 id="joinTitle">회원가입</h1>
          <div class="flexId">
            <div id="flexId">
              <label for="id">아이디</label>
              <div id="idFlex">
                <div class="id">
                  <input
                    type="text"
                    class="idtext"
                    id="id"
                    placeholder="ID를 입력해주세요."
					name="id"
                    required
                  />
                  <i class="fa-solid fa-user"></i>
                </div>
                <input type="button" value="중복확인" class="check" onClick="checkID()"/>
              </div>
            </div>
          </div>
          <div class="flexPass">
            <div id="flexPass">
              <label for="pass">비밀번호</label>
              <div class="pass">
                <input
                  type="password"
                  class="passtext"
                  id="pass"
                  placeholder="비밀번호를 입력해주세요"
				  name="password"
                  required
                />
                <i class="fa-solid fa-user-lock"></i>
              </div>
            </div>
          </div>

          <div class="flexPass2">
            <div id="flexPass2">
              <label for="pass2">비밀번호 재확인</label>
              <div class="pass2">
                <input
                  type="password"
                  class="passtext"
                  id="pass2"
				  name="repassword"
                  placeholder="비밀번호를 다시 한번 입력해주세요."
                  required
                />
                <i class="fa-solid fa-lock"></i>
              </div>
            </div>
          </div>

          <div class="flexName">
            <div id="flexName">
              <label for="name">이름</label>
              <div class="name">
                <input
                  type="text"
                  class="nametext"
                  id="name"
				  name="name"
                  placeholder="이름을 입력해주세요."
                  required
                />
              </div>
            </div>
          </div>
          
                <div class="flexBirth">
            <div id="flexBirth">
              <label for="birth">생년월일</label>
			  <div class="birthContainer">
                    <div class="birth">
                        <input type="text" placeholder="년(4자)" class="year" id="birth" maxlength="4" name="year">
                    </div>
                    <select class="month" name="month">
                        <option selected>월</option>
                        <option value="01">1</option>
                        <option value="02">2</option>
                        <option value="03">3</option>
                        <option value="04">4</option>
                        <option value="05">5</option>
                        <option value="06">6</option>
                        <option value="07">7</option>
                        <option value="08">8</option>
                        <option value="09">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select>
                    <div class="date">
                        <input type="text" placeholder="일" class="day" maxlength="2" name="date"><br>
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
                  placeholder="이메일을 입력해주세요."
                  class="emailtext"
                  id="email"
				  name="email"
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
                  placeholder="휴대전화번호를 입력해주세요."
                  required
                />
              </div>
            </div>
          </div>
          <div class="flexNickName">
            <div id="flexNickName">
              <label for="Nickname">닉네임</label>
              <div id="NickNameFlex">
                <div class="Nickname">
                  <input
                    type="text"
                    class="Nicknametext"
                    id="Nickname"
					name="Nickname"
                    placeholder="닉네임을 입력해주세요."
                    required
                  />
                </div>
                <input type="button" value="중복확인" class="check" onClick="checkNickName()" />
              </div>
            </div>
          </div>
          <input type="button" value="회원가입" class="submit" onClick="checkValue()"/>
        </div>
      </form>
    </div>
	<script language="javascript" src="./JS/join.js"> </script>
  </body>
</html>
