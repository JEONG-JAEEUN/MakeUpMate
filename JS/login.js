function login_focus()    
{											
   	document.login.id.focus();
   	return;
}
function login_check()     
{
	if(document.login.id.value=="")
	{
    	alert("아이디를 입력해 주세요.");
    	document.login.id.focus();
    	return;	
    }

    if(document.login.pass.value=="")
	{
    	alert("비밀번호를 입력해 주세요.");
    	document.login.pass.focus();			
    	return;
    }
		
    document.login.submit();
}



function onEnterSubmit()                  
{
  	var keyCode = window.event.keyCode;
   	if(keyCode==13)  login.submit();    
}
	
