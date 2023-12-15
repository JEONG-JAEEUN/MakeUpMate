function name_focus()    
{											
   	document.findId.name.focus();
   	return;
}
function findID_check()     
{
	if(document.findId.name.value=="")
	{
    	alert("이름을 입력해 주세요.");
    	document.findId.name.focus();
    	return;	
    }

    if(document.findId.num.value=="")
	{
    	alert("휴대전화 번호를 입력해 주세요.");
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
	
