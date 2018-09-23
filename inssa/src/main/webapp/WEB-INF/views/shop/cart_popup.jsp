<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function MovePage() {
	window.opener.top.location.href="${path}/inssa/shop/cart/cart_list.do";
	window.close();
}
function MoveBack() {
	history.back();
	window.close();
}
</script>
</head>
<body>
<h4>선택하신 상품이 장바구니에 담겼습니다.</h4>
<input type="button" value="쇼핑계속하기" onclick="javascript:MoveBack();">
<input type="button" value="카트보기" onclick="javascript:MovePage();">
</body>
</html>