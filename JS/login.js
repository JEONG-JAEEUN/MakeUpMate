function login_focus()    
{											
   	document.login.id.focus();
   	return;
}
function login_check()     
{
	if(document.login.id.value=="")
	{
    	alert("���̵� �Է��� �ּ���.");
    	document.login.id.focus();
    	return;	
    }

    if(document.login.pass.value=="")
	{
    	alert("��й�ȣ�� �Է��� �ּ���.");
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
	
