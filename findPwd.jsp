<%@ page contentType="text/html;charset=euc-kr" %>
  <html>

  <head>
    <title>MakeUpMate : ��й�ȣ ã��</title>
    <link rel="stylesheet" href="CSS/findPwd.css" />
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

  <script language="javascript" src="./JS/findPwd.js"></script>

  <body onLoad="id_focus()">
    <form name="findPwd" method="post" action="findPwdOK.jsp" class="findPwd" target=main>
      <div id="center">
        <div><a href="main.html"><div id="logo">MakeUpMate</div></a></div>
        <div id="flexid">
          <div class="id">
            <input type="text" class="idtext" id="id" name="id" placeholder="���̵� �Է����ּ���." required />
          </div>
        </div>
        <div id="flexNum">
          <div class="num">
            <input type="text" class="numtext" id="num" name="num" placeholder="�޴���ȭ ��ȣ�� �Է����ּ���.( -���� )" required />
          </div>
        </div>
        <div id="flexemail">
          <div class="email">
            <input type="text" class="emailtext" id="email" name="email" placeholder="�̸��� �ּҸ� �Է����ּ���." required
              onkeydown="onEnterSubmit()" />
          </div>
        </div>
        <% String findPwdMessage=(String) request.getAttribute("findPwdMessage"); if (findPwdMessage !=null) {
          out.println("<p>" + findPwdMessage + "</p>");
          }
          %>
          <div id="submit"><a href="javascript:findPwd_check()"
              style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; text-decoration: none; color: white;">��й�ȣ
              ã��</a></div>
          <div id="flex">
            <div><a href="findId.jsp" target=main>���̵� ã��</a></div>
            <div><a href="login.jsp" target=main>�α���</a></div>
          </div>
    </form>
  </body>

  </html>