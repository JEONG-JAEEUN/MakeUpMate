const $inputPass = document.querySelector("#pass");
const $classPass = document.querySelector(".pass");
const userLockIcon = document.querySelector(".fa-user-lock");

const $inputPass2 = document.querySelector("#pass2");
const $classPass2 = document.querySelector(".pass2");
const lockIcon = document.querySelector(".fa-lock");

const $inputYear = document.querySelector("#birth");
const $classBirth = document.querySelector(".birth");
const $inputMonth = document.querySelector(".month");
const $inputDay = document.querySelector(".day");
const $classDate = document.querySelector(".date");

const $inputEmail = document.querySelector("#email");
const $classEmail = document.querySelector(".email");

const $inputPhone = document.querySelector("#phone");
const $classPhone = document.querySelector(".num");

const text1 = document.createElement("p");
const text2 = document.createElement("p");
const text4 = document.createElement("p");
const text5 = document.createElement("p");
const text6 = document.createElement("p");

const block_1 = document.querySelector(".flexPass");
const block_2 = document.querySelector(".flexPass2");
const block_4 = document.querySelector(".flexBirth");
const block_5 = document.querySelector(".flexEmail");
const block_6 = document.querySelector(".flexPhone");

function PWD_CHECK(event) {
  var regPass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
  if (regPass.test(event.target.value) === false) {
    text1.textContent = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요";
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

function YEAR_CHECK(event){
    var regYear = /^\d{4}$/;
    if(regYear.test(event.target.value)===false){
        text4.textContent='태어난 년도 4자리를 정확하게 입력하세요.';
        text4.style.color = 'red';
        block_4.appendChild(text4);
		$classBirth.classList.add("inputFail");
    }
    else{
        text4.remove();
		$classBirth.classList.remove("inputFail");
		$classBirth.classList.add("inputSuccess");
		MONTH_CHECK();
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

$inputPass.addEventListener("change", PWD_CHECK);

$inputYear.addEventListener("change",YEAR_CHECK)
$inputMonth.addEventListener("change", MONTH_CHECK);
$inputDay.addEventListener("change", DAY_CHECK);
$inputEmail.addEventListener("change", EMAIL_CHECK);
$inputPhone.addEventListener("change", PHONE_CHECK);

function uCheckValue()      
{                                           
	if(upMem.year.value == "") 
	{
		alert("태어난 년도 4자리를 입력해 주세요!");
		upMem.year.focus();
		return;
	}
	if(upMem.month.value == "월") 
	{
		alert("태어난 월을 선택해 주세요!");
		upMem.month.focus();
		return;
	}
	if(upMem.date.value == "") 
	{
		alert("태어난 일을 입력해 주세요!");
		upMem.date.focus();
		return;
	}
	if(upMem.email.value == "") 
	{
		alert("이메일을 입력해 주세요!");
		upMem.email.focus();
		return;
	}

	if(upMem.phone.value == "") 
	{
		alert("휴대전화 번호를 입력해 주세요!");
		upMem.phone.focus();
		return;
	}
	if ($classPass.classList.contains("inputFail") ||
      $classBirth.classList.contains("inputFail") ||
      $classEmail.classList.contains("inputFail") ||
      $classPhone.classList.contains("inputFail")){
    alert("정보 수정을 위한 양식에 맞춰 올바르게 작성해 주세요!");
    return;
	}
	alert("회원 정보 수정이 완료되었습니다.")
	upMem.submit();  
	
}

