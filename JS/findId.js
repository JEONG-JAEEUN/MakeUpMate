function name_focus()    
{											
   	document.findId.name.focus();
   	return;
}
function findID_check()     
{
	if(document.findId.name.value=="")
	{
    	alert("�̸��� �Է��� �ּ���.");
    	document.findId.name.focus();
    	return;	
    }

    if(document.findId.num.value=="")
	{
    	alert("�޴���ȭ ��ȣ�� �Է��� �ּ���.");
    	document.findId.num.focus();			
    	return;
    }
		
    document.findId.submit();
}

function onEnterSubmit()                  
{
  	var keyCode = window.event.keyCode;
   	if(keyCode==13)  findId.submit();    
}
	
