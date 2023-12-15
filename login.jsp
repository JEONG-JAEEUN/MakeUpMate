<%@ page contentType="text/html;charset=euc-kr" %>
<html>
  <head>
    <title>MakeUpMate : �α���</title>
    <link rel="stylesheet" href="CSS/login.css" />
     <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=Roboto:wght@300;400;500;700&display=swap"
      rel="stylesheet"
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

  <script language="javascript" src="./JS/login.js"></script>

  <body onLoad="login_focus()">
    <form name="login" method="post" action="loginOK.jsp" class="login">
      <div id="center">
        <div><a href="main.html"><div id="logo">MakeUpMate</div></a></div>
        <div id="flexId">
            <div class="id">
                <i class="fa-solid fa-user"></i>
              <input
                type="text"
                class="idtext"
                id="id"
                name="id"
                placeholder="���̵�"
                required
              />
            </div>
        </div>
        <div id="flexPass">
            <div class="pass">
                <i class="fa-solid fa-lock"></i>
              <input
                type="password"
                class="passtext"
                id="pass"
                name="pass"
                placeholder="��й�ȣ"
                required
                onkeydown="onEnterSubmit()"
              />
            </div>
          </div>
		      <% 
                    String loginMessage = (String) request.getAttribute("loginMessage");
                    if (loginMessage != null) {
                        out.println("<p class='error'>" + loginMessage + "</p>");
                    }
                %>
        <div id="submit"><a href="javascript:login_check()"  style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">�α���</a></div>
        <div id="flex">
          <div><a href="findId.jsp" target=main>���̵� ã��</a></div>
          <div><a href="findPwd.jsp" target=main>��й�ȣ ã��</a></div>
          <div><a href="newMember.jsp" target=main>ȸ������</a></div>
        </div>
    </form>
  </body>
</html>
