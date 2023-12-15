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
      "6~12ÀÚÀÇ ¿µ¹® ¼Ò¹®ÀÚ, ¼ýÀÚ¿Í Æ¯¼ö±âÈ£(_),(-)¸¸ »ç¿ë °¡´ÉÇÕ´Ï´Ù.";
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
    text1.textContent = "8~16ÀÚÀÇ ¿µ¹®, ¼ýÀÚ Á¶ÇÕÀ¸·Î ¸¸µé¾îÁÖ¼¼¿ä. ";
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
    PWD_RECHECK(); // PWD_RECHECK ÇÔ¼ö È£Ãâ
  }
}

function PWD_RECHECK() {
  const recheck = $inputPass2.value;
  const pwd_check = $inputPass.value; // pwd_check °ªÀ» ÀúÀå

  if (recheck !== pwd_check) {
    text2.textContent = "ºñ¹Ð¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù.";
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
  var regName = /^[a-zA-Z°¡-ÆR]+$/;
  if (regName.test(event.target.value) === false) {
    text3.textContent =
      "ÇÑ±Û°ú ¿µ¹® ´ë ¼Ò¹®ÀÚ¸¦ »ç¿ëÇÏ¼¼¿ä. (Æ¯¼ö±âÈ£, °ø¹é »ç¿ë ºÒ°¡)";
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
        text4.textContent='ÅÂ¾î³­ ³âµµ 4ÀÚ¸®¸¦ Á¤È®ÇÏ°Ô ÀÔ·ÂÇÏ¼¼¿ä.'
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
    if(monthValue==='¿ù'){
        text4.textContent='ÅÂ¾î³­ ¿ùÀ» ¼±ÅÃÇÏ¼¼¿ä.'
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
        text4.textContent='ÅÂ¾î³­ ÀÏ(³¯Â¥)À» Á¤È®ÇÏ°Ô ÀÔ·ÂÇÏ¼¼¿ä.'
        text4.style.color = 'red'
        block_4.appendChild(text4)
		$classDate.classList.add("inputFail");
    }
    else if(regDay.test(event.target.value)===false){
        text4.textContent='»ý³â¿ùÀÏÀ» ´Ù½Ã È®ÀÎÇØÁÖ¼¼¿ä.'
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
    text5.textContent = "ÀÌ¸ÞÀÏ ÁÖ¼Ò¸¦ ´Ù½Ã È®ÀÎÇØÁÖ¼¼¿ä.";
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
    text6.textContent = "ÈÞ´ë ÀüÈ­ ¹øÈ£( - ÇÏÀÌÇÂ Æ÷ÇÔ)¸¦ ´Ù½Ã È®ÀÎÇØÁÖ¼¼¿ä.";
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
  var regNickname = /^[A-Za-z0-9_°¡-ÆR]{2,20}$/;
  if (regNickname.test(event.target.value) === false) {
    text7.textContent =
      "ÇÑ±Û, ¾ËÆÄºª, ¼ýÀÚ, ¹ØÁÙ·Î ÀÌ·ç¾îÁø 2ÀÚ~20ÀÚ·Î ¸¸µé¾îÁÖ¼¼¿ä.";
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
		alert("ID¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä!"); 
		newMem.id.focus(); 
		return; 
    }
	if($classId.classList.contains("inputFail")){
		alert("¾ç½ÄÀ» ¸ÂÃß¾îÁÖ¼¼¿ä!"); 
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
		alert("´Ð³×ÀÓÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä!"); 
		newMem.id.focus(); 
		return; 
    }
	if($classNickname.classList.contains("inputFail")){
		alert("¾ç½ÄÀ» ¸ÂÃß¾îÁÖ¼¼¿ä!"); 
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
		alert("ID¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä!"); 
		newMem.id.focus();  
		return;                      
	}

	if(newMem.password.value == "") 
	{
		alert("ºñ¹Ð¹øÈ£¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.password.focus();
		return;
    	}
		if(newMem.repassword.value == "") 
	{
		alert("ºñ¹Ð¹øÈ£ È®ÀÎÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.repassword.focus();
		return;
    	}

	if(newMem.name.value == "") 
	{
		alert("¼º¸íÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.name.focus();
		return;
	}

	if(newMem.year.value == "") 
	{
		alert("ÅÂ¾î³­ ³âµµ 4ÀÚ¸®¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.year.focus();
		return;
	}
	if(newMem.month.value == "¿ù") 
	{
		alert("ÅÂ¾î³­ ¿ùÀ» ¼±ÅÃÇØ ÁÖ¼¼¿ä!");
		newMem.month.focus();
		return;
	}
	if(newMem.date.value == "") 
	{
		alert("ÅÂ¾î³­ ÀÏÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.date.focus();
		return;
	}
	if(newMem.email.value == "") 
	{
		alert("ÀÌ¸ÞÀÏÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.email.focus();
		return;
	}

	if(newMem.phone.value == "") 
	{
		alert("ÈÞ´ëÀüÈ­ ¹øÈ£¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
		newMem.phone.focus();
		return;
	}

if(newMem.Nickname.value == "") 
	{
		alert("´Ð³×ÀÓÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä!");
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
    
    alert("È¸¿ø°¡ÀÔ ¾ç½ÄÀ» ¿Ã¹Ù¸£°Ô ÀÛ¼ºÇØ ÁÖ¼¼¿ä!");
    return;
  }
if (!isIdChecked) {
    alert("ID Áßº¹È®ÀÎÀ» ÇØÁÖ¼¼¿ä!");
    newMem.id.focus();
    return;
  }

  if (!isNicknameChecked) {
    alert("´Ð³×ÀÓ Áßº¹È®ÀÎÀ» ÇØÁÖ¼¼¿ä!");
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

