function id_focus()  
{											
   	document.findPwd.id.focus();
   	return;
}
function findPwd_check()     
{
	if(document.findPwd.id.value=="")
	{
    	alert("���̵� �Է��� �ּ���.");
    	document.findPwd.id.focus();
    	return;	
    }

    if(document.findPwd.num.value=="")
	{
    	alert("�޴���ȭ ��ȣ�� �Է��� �ּ���.");
    	document.findPwd.num.focus();			
    	return;
    }
	if(document.findPwd.email.value=="")
	{
    	alert("�̸����� �Է��� �ּ���.");
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
	
