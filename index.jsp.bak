<%@ page contentType="text/html;charset=euc-kr" %>
<html>
<head>
    <title>MakeUpMate</title>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=Roboto:wght@300;400;500;700&display=swap"
      rel="stylesheet"
    />
    <script
      src="https://kit.fontawesome.com/5286d2d6db.js"
      crossorigin="anonymous"
    ></script>
	

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic&family=Nanum+Myeongjo&family=Nanum+Pen+Script&family=Righteous&family=Roboto:wght@100&family=Single+Day&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="./CSS/header.css" />
	<style>
	footer {
  padding-top: 50px;
  padding-bottom: 50px;
  background-color: black;
  width:100vw;
}
.contact {
	width:1280px;
	margin:0 auto;
  color: white;
  text-align:center;
}
.contact p {
  margin-top: 10px;
  font-weight: normal;
}
	#contentFrame{
	width:100%;}
	body{
		display: flex; 
        flex-direction: column; 
	}
	</style>
  </head>


<body>
    <%
String id = (String)session.getAttribute("sid"); 
if (id == null || session.getAttribute("sid") == null) {
        response.sendRedirect("index.html");
    }
%>
	<header>
      <div class="inner">
        <div class="wrapper">
          <nav id="nav">
            <ul id="menu__list" class="menu">
              <li>
                <a href="main.html" target=main><div id="logo">MakeUpMate</div></a>
              </li>
              <div class="Menu-Middle">
                <li id="menu__menu">
                  PERSONAL
                  <div id="subwrapper">
                    <nav id="subnav">
                      <ul id="submenu__list">
                        <li id="submenu__menu" style="text-align:left;">
                          <a href="PERSONALLIP.jsp" target=main>PERSONAL LIP</a>
                        </li>
                        <li id="submenu__menu" style="text-align:center;">
                          <a href="PERSONALCHEEK.jsp" target=main>PERSONAL CHEEK</a>
                        </li>
                        <li id="submenu__menu" style="text-align:right;">
                          <a href="PERSONALPERFUME.jsp" target=main>PERSONAL PERFUME</a>
                        </li>
                      </ul>
                    </nav>
                  </div>
                </li>
                <li id="menu__menu"><a href="viewProduct.jsp?category=LIP" target=main>LIP</a></li>
                <li id="menu__menu"><a href="viewProduct.jsp?category=CHEEK" target=main>CHEEK</a></li>
                <li id="menu__menu"><a href="viewProduct.jsp?category=PERFUME" target=main>PERFUME</a></li>
              </div>
              <div class="menu-Right">
                <li class="search-starter" style="cursor:pointer">
                  <i class="fa-solid fa-magnifying-glass"></i>
                </li>
				<li>
                  <a href="mypage.jsp" target=main><i class="fa-solid fa-user"></i></a>
                </li>
                <li>
                  <a href="userCart.jsp" target=main
                    ><i class="fa-solid fa-cart-shopping"></i
                  ></a>
                </li>
                <li>
                  <a href="userHeart.jsp" target=main><i class="fa-solid fa-heart"></i></a>
                </li>
                
              </div>
            </ul>
          </nav>
        </div>

        <div class="search-wrap">
  <form id="searchForm" method="post" action="searchValue.jsp" name="search" target="main">
    <div class="search">
      <div class="textfield">
        <input type="text" name="searchValue" placeholder="검색어를 입력하세요." />
        <div class="search-icon">
          <i class="fa-solid fa-magnifying-glass"></i>
        </div>
        <div class="search-closer"><i class="fa-solid fa-xmark"></i></div>
      </div>
    </div>
  </form>
</div>
    </header>

	<script language="javascript" src="./JS/header.js"> </script> <!-- 해더 js -->
     <main>
        <iframe src="main.html" frameborder="0" name=main id="contentFrame" frameborder="0" scrolling="no"></iframe>
    </main>
	 <script>
        let iframe = document.querySelector("#contentFrame");

        function resizeIframe() {
            iframe.style.height = "auto";
            iframe.style.height = iframe.contentWindow.document.body.scrollHeight + 'px';

            // 헤더, 콘텐츠, 푸터의 높이 합
            const headerHeight = document.querySelector("header").offsetHeight;
            const contentHeight = iframe.contentWindow.document.body.scrollHeight;
            const footerHeight = document.querySelector(".footer").offsetHeight;
            const totalHeight = headerHeight + contentHeight + footerHeight;

            // 사용자의 화면 세로 높이
            const windowHeight = window.innerHeight;

            // 토탈 높이가 창 높이보다 작으면 푸터를 아래에 고정
            if (totalHeight < windowHeight) {
                document.querySelector(".footer").style.position = "fixed";
				document.querySelector(".footer").style.bottom=0;
            } else {
                document.querySelector(".footer").style.position = "static";
            }
        }

        iframe.onload = resizeIframe;
        window.onresize = resizeIframe;
    </script>
    <footer>
      <div class="wrapper">
          <div class="contact">
            <p>고객상담팀(수신자요금부담) 080-000-0000 (상담시간 월~금 : AM 10:00 ~ PM 06:00)</p>
            <p>Copyright . 권영태/김민주/정재은 Inc. All Rights Reserved</p>
          </div>
      </div>
    </footer>
</body>
</html>
