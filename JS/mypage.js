function onEnterSubmit()                  
{
  	var keyCode = window.event.keyCode;
   	if(keyCode==13)  updateform.submit();    
}
function checkPasswd()     
{
	if(document.updateform.password.value=="")
	{
    	alert("비밀번호를 입력해 주세요.");
    	document.updateform.password.focus();
    	return;	
    }
    document.updateform.submit();
}
