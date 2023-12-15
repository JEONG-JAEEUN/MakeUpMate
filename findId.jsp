<%@ page contentType="text/html;charset=euc-kr" %>
  <html>

  <head>
    <title>MakeUpMate : 아이디 찾기</title>
    <link rel="stylesheet" href="CSS/findId.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=Roboto:wght@300;400;500;700&display=swap"
      rel="stylesheet" />
    <link
      href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Righteous&family=Roboto:wght@100&family=Single+Day&display=swap"
      rel="stylesheet" />
    <script src="https://kit.fontawesome.com/5286d2d6db.js" crossorigin="anonymous"></script>
  </head>

  <script language="javascript" src="./JS/findId.js"></script>

  <body onLoad="name_focus()">
    <form name="findId" method="post" action="findIdOK.jsp" class="findId" target=main>
      <div id="center">
        <div><a href="main.html"><div id="logo">MakeUpMate</div></a></div>
        <div id="flexName">
          <div class="name">
            <input type="text" class="nametext" id="name" name="name" placeholder="이름을 입력해주세요." required />
          </div>
        </div>
        <div id="flexNum">
          <div class="num">
            <input type="text" class="numtext" id="num" name="num" placeholder="휴대전화 번호를 입력해주세요.( 하이픈 포함 )" required
              onkeydown="onEnterSubmit()" />
          </div>
        </div>
        <%
                    String findIdMessage = (String) request.getAttribute("findIdMessage");
                    if (findIdMessage != null) {
                        out.println("<p>" + findIdMessage + "</p>");
                    }
                %>
          <div id="submit"><a href="javascript:findID_check()"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">아이디
              찾기</a></div>
          <div id="flex">
            <div><a href="findPwd.jsp" target=main>비밀번호 찾기</a></div>
            <div><a href="login.jsp" target=main>로그인</a></div>
          </div>
    </form>
  </body>

  </html>