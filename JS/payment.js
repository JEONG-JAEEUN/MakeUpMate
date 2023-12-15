function payment()
{
	if(cartList.recipient.value == "")
	{
		alert("수령자명을 입력해주세요.");
		cartList.recipient.focus();
		return;
	}
	if(cartList.tel.value == "")
	{
		alert("연락처를 입력해주세요.");
		cartList.tel.focus();
		return;
	}
	if(cartList.zipcode.value == "")
	{
		alert("배송지를 입력해주세요.");
		cartList.zipcode.focus();
		return;
	}
	if(cartList.address1.value == "")
	{
		alert("배송지를 입력해주세요.");
		cartList.address1.focus();
		return;
	}
	if(cartList.address2.value == "")
	{
		alert("배송지를 입력해주세요.");
		cartList.address2.focus();
		return;
	}
	if(cartList.request.value == "")
	{
		alert("요청사항을 입력해주세요.");
		cartList.request.focus();
		return;
	}
	if(cartList.bankName.value == "")
	{
		alert("입금자명을 입력해주세요.");
		cartList.bankName.focus();
		return;
	}
	cartList.submit();
}

function zipCheck()
{
	window.open("zipCheck.jsp", "win", "width=600, height=200, scrollbars=yes, status=yes");
}