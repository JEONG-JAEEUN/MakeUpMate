function id_focus()  
{											
   	document.findPwd.id.focus();
   	return;
}
function findPwd_check()     
{
	if(document.findPwd.id.value=="")
	{
    	alert("아이디를 입력해 주세요.");
    	document.findPwd.id.focus();
    	return;	
    }

    if(document.findPwd.num.value=="")
	{
    	alert("휴대전화 번호를 입력해 주세요.");
    	document.findPwd.num.focus();			
    	return;
    }
	if(document.findPwd.email.value=="")
	{
    	alert("이메일을 입력해 주세요.");
    	document.findPwd.email.focus();			
    	return;
    }
		
    document.findPwd.submit();
}

function onEnterSubmit()                  
{
  	var keyCode = window.event.keyCode;
   	if(keyCode==13)  findPwd.submit();    
}
	
