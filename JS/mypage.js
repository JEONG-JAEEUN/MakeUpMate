function onEnterSubmit()                  
{
  	var keyCode = window.event.keyCode;
   	if(keyCode==13)  updateform.submit();    
}
function checkPasswd()     
{
	if(document.updateform.password.value=="")
	{
    	alert("��й�ȣ�� �Է��� �ּ���.");
    	document.updateform.password.focus();
    	return;	
    }
    document.updateform.submit();
}
