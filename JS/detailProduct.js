function amountPlus() 
{
obj=document.product.qty;
obj.value=parseInt(obj.value) + 1;
}
function amountMinus() 
{
obj=document.product.qty;
if(parseInt(obj.value) > 1)
{
obj.value=parseInt(obj.value) - 1;
}
else
{
alert('���̻� ���ϼ��� �����ϴ�');
return;
}
}
function amountCheck()
{
obj=document.product.qty;
if(isNaN(obj.value)) 
{
obj.value="1";
alert('���ڸ� �Է����ּ���.');
return;
}
 if(obj.value < 1)
{
obj.value="1";
}
}

function heartOk() 
{
var frm = document.product;
frm.action = "heartOk.jsp";
frm.submit();
}

window.onload = function () {
    showContent('content1');
};

function showContent(contentId) {

    var selectedContent = document.getElementById(contentId);
    selectedContent.style.display = "block";

    var contents = document.getElementsByClassName("content");
    for (var i = 0; i < contents.length; i++) {
        if (contents[i].id !== contentId) {
            contents[i].style.display = "none";
        }
    }
}
function scrollToSection(sectionId) {
    var element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

function review(){
    if (document.reviewForm.review.value=="") {
        alert("���並 �Է��ϼ���.");
        document.reviewForm.review.focus();
        return;
    }
		document.reviewForm.submit();
}
function onEnterSubmit()                  
{
	var keyCode = window.event.keyCode;
   	if(keyCode==13){
		if (document.reviewForm.review.value=="") {
        alert("���並 �Է��ϼ���.");
        document.reviewForm.review.focus();
        return;
		}
		else{
		reviewForm.action = "insertReviewResult.jsp";
		reviewForm.submit();
	  }
	}
}

function directOrd()
{	
	var stock=product.option.value;
	var parts = stock.split(",");
	stock = parts[1].trim();
	var qty=product.qty.value;
	var item_id=product.item_id.value;
	var user_id=product.user_id.value;
	var frm = document.product;
	if(stock == 0) {
		alert('����� �����ϴ�.');
		return;
	}
	else if(stock-qty < 0) {
		alert('����� �����մϴ�.');
		return;
	}
	else{
		frm.action = "directOrder.jsp";
		frm.submit();
	}
}


function inCart() 
{
	var str=product.qty.value;
	var stock=product.option.value;
	var parts = stock.split(",");
	stock = parts[1].trim();
	var item_id=product.item_id.value;
	var user_id=product.user_id.value;
	var frm = document.product;
	if(stock == 0) {
		alert('����� �����ϴ�.');
		return;
	}
	else if(stock-str < 0) {
		alert('����� �����մϴ�.');
		return;
	}
	else{
		frm.action = "inCart.jsp";
		frm.submit();
	}
}