const $inputId = document.querySelector("#id");
const $classId = document.querySelector(".id");
const userIcon = document.querySelector(".fa-user");

const $inputPass = document.querySelector("#pass");
const $classPass = document.querySelector(".pass");
const userLockIcon = document.querySelector(".fa-user-lock");

const $inputPass2 = document.querySelector("#pass2");
const $classPass2 = document.querySelector(".pass2");
const lockIcon = document.querySelector(".fa-lock");

const $inputName = document.querySelector("#name");
const $className = document.querySelector(".name");

const $inputYear = document.querySelector("#birth");
const $classBirth = document.querySelector(".birth");
const $inputMonth = document.querySelector(".month");
const $inputDay = document.querySelector(".day");
const $classDate = document.querySelector(".date");

const $inputEmail = document.querySelector("#email");
const $classEmail = document.querySelector(".email");

const $inputPhone = document.querySelector("#phone");
const $classPhone = document.querySelector(".num");

const $inputNickname = document.querySelector("#Nickname");
const $classNickname = document.querySelector(".Nickname");

const text0 = document.createElement("p");
const text1 = document.createElement("p");
const text2 = document.createElement("p");
const text3 = document.createElement("p");
const text4 = document.createElement("p");
const text5 = document.createElement("p");
const text6 = document.createElement("p");
const text7 = document.createElement("p");

const block_0 = document.querySelector(".flexId");
const block_1 = document.querySelector(".flexPass");
const block_2 = document.querySelector(".flexPass2");
const block_3 = document.querySelector(".flexName");
const block_4 = document.querySelector(".flexBirth");
const block_5 = document.querySelector(".flexEmail");
const block_6 = document.querySelector(".flexPhone");
const block_7 = document.querySelector(".flexNickName");

function ID_CHECK(event) {
  var regID = /^[a-z0-9_-]{6,12}$/;
  if (regID.test(event.target.value) === false) {
    text0.textContent =
      "6~12자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
    text0.style.color = "red";
    block_0.appendChild(text0);
    userIcon.classList.add("fail");
    $classId.classList.add("inputFail");
  } else {
    text0.remove();
    userIcon.classList.remove("fail");
    userIcon.classList.add("success");
    $classId.classList.remove("inputFail");
    $classId.classList.add("inputSuccess");
  }
}
function PWD_CHECK(event) {
  var regPass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
  if (regPass.test(event.target.value) === false) {
    text1.textContent = "8~16자의 영문, 숫자 조합으로 만들어주세요. ";
    text1.style.color = "red";
    block_1.appendChild(text1);
    userLockIcon.classList.add("fail");
    $classPass.classList.add("inputFail");
  } else {
    text1.remove();
    userLockIcon.classList.remove("fail");
    userLockIcon.classList.add("success");
    $classPass.classList.remove("inputFail");
    $classPass.classList.add("inputSuccess");
  }

  if ($inputPass2.value.trim() !== "") {
    PWD_RECHECK(); // PWD_RECHECK 함수 호출
  }
}

function PWD_RECHECK() {
  const recheck = $inputPass2.value;
  const pwd_check = $inputPass.value; // pwd_check 값을 저장

  if (recheck !== pwd_check) {
    text2.textContent = "비밀번호가 일치하지 않습니다.";
    text2.style.color = "red";
    block_2.appendChild(text2);
    lockIcon.classList.add("fail");
    $classPass2.classList.add("inputFail");
  } else {
    text2.remove();
    lockIcon.classList.remove("fail");
    lockIcon.classList.add("success");
    $classPass2.classList.remove("inputFail");
    $classPass2.classList.add("inputSuccess");
  }
}
function NAME_CHECK(event) {
  var regName = /^[a-zA-Z가-힣]+$/;
  if (regName.test(event.target.value) === false) {
    text3.textContent =
      "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
    text3.style.color = "red";
    block_3.appendChild(text3);
    $className.classList.add("inputFail");
  } else {
    text3.remove();
    $className.classList.remove("inputFail");
    $className.classList.add("inputSuccess");
  }
}
function YEAR_CHECK(event){
    var regYear = /^\d{4}$/;
    if(regYear.test(event.target.value)===false){
        text4.textContent='태어난 년도 4자리를 정확하게 입력하세요.'
        text4.style.color = 'red'
        block_4.appendChild(text4)
		$classBirth.classList.add("inputFail");
    }
    else{
        text4.remove()
		$classBirth.classList.remove("inputFail");
		$classBirth.classList.add("inputSuccess");
		MONTH_CHECK()
    }
}
function MONTH_CHECK(event){
    const monthValue=$inputMonth.value;
    if(monthValue==='월'){
        text4.textContent='태어난 월을 선택하세요.'
        text4.style.color = 'red'
        block_4.appendChild(text4)
		$inputMonth.classList.add("inputFail");
    }
    else{
        text4.remove()
		$inputMonth.classList.remove("inputFail");
		$inputMonth.classList.add("inputSuccess");
		DAY_CHECK()
    }
}
function DAY_CHECK(event){
    const dayValue = $inputDay.value;
    var regDay = /^(0[1-9]|[1-9]|1\d|2[0-9]|3[0-1])$/;
    if(dayValue===''){
        text4.textContent='태어난 일(날짜)을 정확하게 입력하세요.'
        text4.style.color = 'red'
        block_4.appendChild(text4)
		$classDate.classList.add("inputFail");
    }
    else if(regDay.test(event.target.value)===false){
        text4.textContent='생년월일을 다시 확인해주세요.'
        text4.style.color = 'red'
        block_4.appendChild(text4)
		$classDate.classList.add("inputFail");
    }
    else{
        text4.remove()
		$classDate.classList.remove("inputFail");
		$classDate.classList.add("inputSuccess");
    }
}

function EMAIL_CHECK(event) {
  var regEmail = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$/;
  if (regEmail.test(event.target.value) === false) {
    text5.textContent = "이메일 주소를 다시 확인해주세요.";
    text5.style.color = "red";
    block_5.appendChild(text5);
    $classEmail.classList.add("inputFail");
  } else {
    text5.remove();
    $classEmail.classList.remove("inputFail");
    $classEmail.classList.add("inputSuccess");
  }
}
function PHONE_CHECK(event) {
  var regPhone = /^01(0|1|6|7|8|9)-\d{3,4}-\d{4}$/;
  if (regPhone.test(event.target.value) === false) {
    text6.textContent = "휴대 전화 번호( - 하이픈 포함)를 다시 확인해주세요.";
    text6.style.color = "red";
    block_6.appendChild(text6);
    $classPhone.classList.add("inputFail");
  } else {
    text6.remove();
    $classPhone.classList.remove("inputFail");
    $classPhone.classList.add("inputSuccess");
  }
}
function Nickname_CHECK(event) {
  var regNickname = /^[A-Za-z0-9_가-힣]{2,20}$/;
  if (regNickname.test(event.target.value) === false) {
    text7.textContent =
      "한글, 알파벳, 숫자, 밑줄로 이루어진 2자~20자로 만들어주세요.";
    text7.style.color = "red";
    block_7.appendChild(text7);
    $classNickname.classList.add("inputFail");
  } else {
    text7.remove();
    $classNickname.classList.remove("inputFail");
    $classNickname.classList.add("inputSuccess");
  }
}

$inputId.addEventListener("change", ID_CHECK);
$inputPass.addEventListener("change", PWD_CHECK);
$inputPass2.addEventListener("change", PWD_RECHECK);
$inputName.addEventListener("change", NAME_CHECK);
$inputYear.addEventListener("change",YEAR_CHECK)
$inputMonth.addEventListener("change", MONTH_CHECK);
$inputDay.addEventListener("change", DAY_CHECK);
$inputEmail.addEventListener("change", EMAIL_CHECK);
$inputPhone.addEventListener("change", PHONE_CHECK);
$inputNickname.addEventListener("change", Nickname_CHECK);
let isIdChecked = false;
let isNicknameChecked = false;
function checkID()     
{ 
    if (newMem.id.value  == "")   
    {
		alert("ID를 입력해 주세요!"); 
		newMem.id.focus(); 
		return; 
    }
	if($classId.classList.contains("inputFail")){
		alert("양식을 맞추어주세요!"); 
		newMem.id.focus(); 
		return; 
	}
	isIdChecked = true;
	window.open("checkID.jsp?id="+newMem.id.value,"win", "width=255, height=145, scrollbars=no, resizable=no");
}                                                  

function checkNickName()     
{ 
    if (newMem.Nickname.value  == "")   
    {
		alert("닉네임을 입력해 주세요!"); 
		newMem.id.focus(); 
		return; 
    }
	if($classNickname.classList.contains("inputFail")){
		alert("양식을 맞추어주세요!"); 
		newMem.Nickname.focus(); 
		return; 
	}
	isNicknameChecked = true;
	window.open("checkNickname.jsp?Nickname="+newMem.Nickname.value,"win", "width=255, height=145, scrollbars=no, resizable=no");
}         


function checkValue()      
{                                           
	if(newMem.id.value == "")      
	{
		alert("ID를 입력해 주세요!"); 
		newMem.id.focus();  
		return;                      
	}

	if(newMem.password.value == "") 
	{
		alert("비밀번호를 입력해 주세요!");
		newMem.password.focus();
		return;
    	}
		if(newMem.repassword.value == "") 
	{
		alert("비밀번호 확인을 입력해 주세요!");
		newMem.repassword.focus();
		return;
    	}

	if(newMem.name.value == "") 
	{
		alert("성명을 입력해 주세요!");
		newMem.name.focus();
		return;
	}

	if(newMem.year.value == "") 
	{
		alert("태어난 년도 4자리를 입력해 주세요!");
		newMem.year.focus();
		return;
	}
	if(newMem.month.value == "월") 
	{
		alert("태어난 월을 선택해 주세요!");
		newMem.month.focus();
		return;
	}
	if(newMem.date.value == "") 
	{
		alert("태어난 일을 입력해 주세요!");
		newMem.date.focus();
		return;
	}
	if(newMem.email.value == "") 
	{
		alert("이메일을 입력해 주세요!");
		newMem.email.focus();
		return;
	}

	if(newMem.phone.value == "") 
	{
		alert("휴대전화 번호를 입력해 주세요!");
		newMem.phone.focus();
		return;
	}

if(newMem.Nickname.value == "") 
	{
		alert("닉네임을 입력해 주세요!");
		newMem.Nickname.focus();
		return;
	}
	if ($classId.classList.contains("inputFail") ||
      $classPass.classList.contains("inputFail") ||
      $classPass2.classList.contains("inputFail") ||
      $className.classList.contains("inputFail") ||
      $classBirth.classList.contains("inputFail") ||
      $classEmail.classList.contains("inputFail") ||
      $classPhone.classList.contains("inputFail") ||
      $classNickname.classList.contains("inputFail")) {
    
    alert("회원가입 양식을 올바르게 작성해 주세요!");
    return;
  }
if (!isIdChecked) {
    alert("ID 중복확인을 해주세요!");
    newMem.id.focus();
    return;
  }

  if (!isNicknameChecked) {
    alert("닉네임 중복확인을 해주세요!");
    newMem.Nickname.focus();
    return;
  }
	newMem.submit();  
}


function idFocus()  
{                                 
	newMem.id.focus();
	return;
}

