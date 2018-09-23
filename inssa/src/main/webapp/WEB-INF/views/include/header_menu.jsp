<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="${path}/images/icons/favicon.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/themify/themify-icons.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/fonts/elegant-font/html-css/style.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/slick/slick.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/vendor/lightbox2/css/lightbox.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/css/util.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/main.css">
<!--===============================================================================================-->
<!-- Header -->
	<header class="header1">
		<!-- Header desktop -->
		<div class="container-menu-header">
			<%-- <div class="row">
				<div class="col-md-10"></div>
				<div class="col-md-2 p-l-60 m-t-10" style="text-align: center;">
					<a href="${path}/member/loginForm.do" style="font-size: 0.8em; color: gray;">로그인</a>
					<span style="font-size: 0.8em; color: gray;">|</span>
					<a href="${path}/member/registerForm.do" style="font-size: 0.8em; color: gray;">회원가입</a>
				</div>
			</div> --%>
			<div class="wrap_header">
				<!-- Logo -->
				<a href="${path}/" class="logo">
					<img src="${path}/image/inssa.png" alt="IMG-LOGO">
				</a>

				<!-- Menu -->
				<div class="wrap_menu">
					<nav class="menu">
						<ul class="main_menu">
							<li>
								<a href="${path}/">Home</a>
							</li>
							<li>
								<a href="${path}/shop/product/product.do?cate=GS">Graphic Sticker</a>
							</li>
							<li>
								<a href="${path}/shop/product/product.do?cate=AF">Art Frame</a>
							</li>
							<li>
								<a href="${path}/shop/product/product.do?cate=AP">Art Poster</a>
							</li>
						</ul>
					</nav>
				</div>
				<div class="header-icons p-t-20 p-b-70">
					<c:choose>
						<c:when test="${sessionScope.member_id == null }">
							<a href="${path}/member/loginForm.do" style="font-size: 0.7em; color: #969696;">로그인</a>
							<span style="font-size: 0.7em; color: gray;">&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
							<a href="${path}/member/registerForm.do" style="font-size: 0.7em; color: #969696;">회원가입</a>
						</c:when>
						<c:otherwise>
							<a href="${path}/member/logout.do" style="font-size: 0.7em; color: #969696;">로그아웃</a>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- Header Icon -->
				<div class="header-icons">
					<a href="${path}/member/mypage" class="header-wrapicon1 dis-block">
						<img src="${path}/images/icons/icon-header-01.png" class="header-icon1" alt="ICON">
					</a>

					<span class="linedivide1"></span>

					<div class="header-wrapicon2">
						<a href="${path}/shop/cart/cart_list.do" class="header-wrapicon1 dis-block">
							<img src="${path}/images/icons/icon-header-02.png" class="header-icon1 js-show-header-dropdown" alt="ICON">
						</a>
						<c:choose>
							<c:when test="${sessionScope.member_id == null}">
								<span class="header-icons-noti">0</span>
							</c:when>
							<c:otherwise>
								<input type="hidden" id="member_id" name="member_id" value="${sessionScope.member_id}">
								<span class="header-icons-noti"></span>
							</c:otherwise>
						</c:choose>
						
					</div>
				</div>
			</div>
		</div>
<script>
$(function(){
	var member_id = $("#member_id").val();
	var data = {"member_id" : member_id};

	$.ajax({
		type: "post",
		url: "${path}/shop/cart/cartCnt.do",
		data: data,
		dataType: "json",
		success: function(result){
			$("span.header-icons-noti").text(result);
		}
	});
});
</script>
		<!-- Header Mobile -->
		<div class="wrap_header_mobile">
			<!-- Logo moblie -->
			<a href="${path}/" class="logo-mobile">
				<img src="${path}/image/inssa.png" alt="IMG-LOGO">
			</a>

			<!-- Button show menu -->
			<div class="btn-show-menu">
				<!-- Header Icon mobile -->
				<div class="header-icons-mobile">
					<a href="${path}/member/mypage" class="header-wrapicon1 dis-block">
						<img src="${path}/images/icons/icon-header-01.png" class="header-icon1" alt="ICON">
					</a>

					<span class="linedivide2"></span>

					<div class="header-wrapicon2">
						<a href="${path}/shop/cart/cart_list.do" class="header-wrapicon1 dis-block">
							<img src="${path}/images/icons/icon-header-02.png" class="header-icon1 js-show-header-dropdown" alt="ICON">
						</a>
						<span class="header-icons-noti">0</span>
					</div>
				</div>

				<div class="btn-show-menu-mobile hamburger hamburger--squeeze">
					<span class="hamburger-box">
						<span class="hamburger-inner"></span>
					</span>
				</div>
			</div>
		</div>

		<!-- Menu Mobile -->
		<div class="wrap-side-menu" >
			<nav class="side-menu">
				<ul class="main-menu">
					<li class="item-menu-mobile">
						<a href="${path}/">Home</a>
					</li>
					<li class="item-menu-mobile">
						<a href="${path}/shop/product/product.do?cate=GS">Graphic Sticker</a>
					</li>

					<li class="item-menu-mobile">
						<a href="${path}/shop/product/product.do?cate=AF">Art Frame</a>
					</li>

					<li class="item-menu-mobile">
						<a href="${path}/shop/product/product.do?cate=AP">Art Poster</a>
					</li>
				</ul>
			</nav>
		</div>
	</header>