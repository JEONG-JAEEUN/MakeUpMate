function payment()
{
	if(cartList.recipient.value == "")
	{
		alert("�����ڸ��� �Է����ּ���.");
		cartList.recipient.focus();
		return;
	}
	if(cartList.tel.value == "")
	{
		alert("����ó�� �Է����ּ���.");
		cartList.tel.focus();
		return;
	}
	if(cartList.zipcode.value == "")
	{
		alert("������� �Է����ּ���.");
		cartList.zipcode.focus();
		return;
	}
	if(cartList.address1.value == "")
	{
		alert("������� �Է����ּ���.");
		cartList.address1.focus();
		return;
	}
	if(cartList.address2.value == "")
	{
		alert("������� �Է����ּ���.");
		cartList.address2.focus();
		return;
	}
	if(cartList.request.value == "")
	{
		alert("��û������ �Է����ּ���.");
		cartList.request.focus();
		return;
	}
	if(cartList.bankName.value == "")
	{
		alert("�Ա��ڸ��� �Է����ּ���.");
		cartList.bankName.focus();
		return;
	}
	cartList.submit();
}

function zipCheck()
{
	window.open("zipCheck.jsp", "win", "width=600, height=200, scrollbars=yes, status=yes");
}