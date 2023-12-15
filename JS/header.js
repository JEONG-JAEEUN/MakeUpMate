//검색
const headerEl = document.querySelector("header");
const searchWrapEl = headerEl.querySelector(".search-wrap");
const searchStarterEl = headerEl.querySelector(".search-starter"); //검색버튼
const searchCloserEl = searchWrapEl.querySelector(".search-closer");
const headerMenuEls = [...headerEl.querySelectorAll("ul.menu > li")];
//얕은 복사 -> querySelector를 통해서 반환되는 내용이 전개연산자(...)를 통해서 해체됨 + []로 묶어줌(배열)
const searchDelayEls = [...searchWrapEl.querySelectorAll("li")];
const searchInputEl = searchWrapEl.querySelector("input");

searchStarterEl.addEventListener("click", showSearch); //showSearch() 아님 중괄호 없음
searchCloserEl.addEventListener("click", hideSearch);

function showSearch() {
  headerEl.classList.add("searching"); //검색버튼 누르면 뒤에 메뉴 숨기는 기능
  document.documentElement.classList.add("fixed");
  //documentElement:html문서의 최상위 요소 : html태그
  //scroll 막기
  headerMenuEls.reverse().forEach(function (el, index) {
    el.style.transitionDelay = (index * 0.4) / headerMenuEls.length + "s";
    //0.4초 안에 순차적으로 사라지는게 끝나도록
    //header ul.menu > li 에 transition:.4s가 있어야함
  });
  searchDelayEls.forEach(function (el, index) {
    el.style.transitionDelay = (index * 0.4) / searchDelayEls.length + "s";
  });
  setTimeout(function () {
    searchInputEl.focus(); //focus는 애니메이션이 완료 된 후 가능(화면에 완전히 나타난 후)
  }, 600);
}
function hideSearch() {
  headerEl.classList.remove("searching");
  document.documentElement.classList.remove("fixed");
  headerMenuEls.reverse().forEach(function (el, index) {
    el.style.transitionDelay = (index * 0.4) / headerMenuEls.length + "s";
  }); //위에서 뒤집은걸 다시 뒤집으니까 위랑 방향이 반대
  searchDelayEls.reverse().forEach(function (el, index) {
    el.style.transitionDelay = (index * 0.4) / searchDelayEls.length + "s";
  });
  searchDelayEls.reverse(); //다시 원래 상태로 뒤집기
  searchInputEl.value = ""; //검색창이 사라질 때 input 초기화
}

//검색 기능
document.addEventListener("DOMContentLoaded", function () {
  // DOM이 완전히 로드 된 이후 실행
  const searchInput = document.querySelector(".textfield input");

  // 엔터 클릭시 검색
  searchInput.addEventListener("keydown", function (event) {
    console.log(event.key);
    if (event.key === "Enter") {
      event.preventDefault();
      performSearch();
    }
  });
function performSearch() {
  // 검색어 가져오기 (대소문자 구분 없이)
  const searchValue = searchInput.value.toLowerCase();

  // 검색어에 따라 적절한 페이지로 이동
  if (searchValue === "personal lip") {
    window.open("PERSONALLIP.jsp","main");
  } else if (searchValue === "personal cheek") {
    window.open("PERSONALCHEEK.jsp","main");
  } else if (searchValue === "personal perfume") {
    window.open("PERSONALPERFUME.jsp","main");
  } else if (searchValue === "") {
    alert("검색어를 입력해주세요.");
  } else {
    search.submit();
  }
}
});