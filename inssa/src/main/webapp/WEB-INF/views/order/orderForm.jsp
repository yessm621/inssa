<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Order</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/head.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
/* 배송지정보 */
$(function(){
	var phone = $("#shippingInfo #phone").text();

	var result = autoHypenPhone(phone);
	var html = "<span id='phone'>"+result+"</span>";
	$("#shippingInfo #phone").remove();
	$("#shippingInfo .phone").append(html);
});
/* 전화번호 '-' */
function autoHypenPhone(phone){
	var phone_len = phone.length;
	var result = "";
	if(phone_len == 11){
		result += phone.substr(0,3);
		result += "-";
		result += phone.substr(3,4);
		result += "-";
		result += phone.substr(7,4);
	}else if(phone_len == 10){
		result += phone.substr(0,3);
		result += "-";
		result += phone.substr(3,3);
		result += "-";
		result += phone.substr(6,4);
	}
	return result;
}

/* 배송지선택 */
function shipping_select(){
	$("#alias option[value='new_addr']").remove();
	
	$(".new_recipient").hide();
	$(".new_phone").hide();
	$(".new_address").hide();
	
	var alias_list = document.getElementById("alias");
	var alias = alias_list.options[alias_list.selectedIndex].text;
	var shipping_idx = alias_list.options[alias_list.selectedIndex].value;
	var data = {"shipping_idx" : shipping_idx, "alias" : alias};
	
	$.ajax({
		type: "post",
		url: "${path}/shop/order/aliasFind.do",
		data: data,
		dataType: "json",
		success: function(result){
			var html1 = "<span id='recipient'>"+result.recipient+"</span>";
			var html2 = "<span id='phone'>"+autoHypenPhone(result.phone)+"</span>";
			var html3 = "<span id='address'>(<span id='shipping_postcode'>"+result.shipping_postcode+"</span>) ";
			html3 += "<span id='shipping_addr'>"+result.shipping_addr+"</span> <span id='shipping_detail_addr'>"+result.shipping_detail_addr+"</span></span>";
			
			$("#recipient").remove();
			$("#phone").remove();
			$("#address").remove();
			
			$(".new_recipient").before(html1);
			$(".new_phone").before(html2);
			$(".new_address").before(html3);
		}
	});
}

/* 배송지추가버튼 */
function btnNewAddr(){
	/* 새로운주소 */
	$("#alias").prepend("<option value='new_addr'>새로운 배송지</option>");
	$("#alias").val('new_addr');
	
	/* 받는사람 */
	$("#recipient").hide();
	$(".new_recipient").show();
	
	/* 전화번호 */
	$("#phone").hide();
	$(".new_phone").show();
	
	/* 주소 */
	$("#address").hide();
	$(".new_address").show();
	
	$("button#btnPostCode").click(function() {
		new daum.Postcode({
			oncomplete : function(data) {
				if (data.buildingName == "") {
					$("input[name=shipping_addr]").attr('value', data.address);
				} else {
					$("input[name=shipping_addr]").attr('value', data.address + " (" + data.buildingName + ")");
				}
				$("input[name=shipping_postcode]").attr('value', data.zonecode);
				$("input[name=shipping_detail_addr]").focus();
			}
		}).open();
	});
}
/* ================================================================= */
/* 주문상품정보 */
$(function(){
	var list_count = $("#list_count").val();

	if(list_count > 1){
		var temp;
		var product_code;
		for(var i=0; i<list_count; i++){
			product_code = $("#product_code").val();
		}
	}
	var product_code = $("#product_code").val();
	
	/* 상품갯수(버튼) */
	$(document).on('click', 'button.amountMinus.bg8', function(){
		var idx = $(this).index('button.amountMinus.bg8');
		var cart_idx = $("input#cart_idx:eq("+idx+")").val();
		cart_idx = parseInt(cart_idx);
		var amount = $("input#product_amount.t-center:eq("+idx+")").val();
		if(amount == "1"){
			alert("상품의 구매 가능한 최소수량은 1개 입니다.");
			return;
		}
		var sale_price = $("span#sale_price:eq("+idx+")").text();
		sale_price = sale_price.replace(",", "");
		sale_price = parseInt(sale_price);
		amount = parseInt(amount);
		amount = amount - 1;
		$("input#product_amount.t-center:eq("+idx+")").val(amount);
		sale_price = sale_price * amount;
		$("span#price:eq("+idx+")").text(numberWithCommas(sale_price));
		
		var money = 0;
		var len = $("span#sale_price").length;
		for(var i=0; i<len ; i++){
			var t_sale_price = $("span#sale_price:eq("+i+")").text();
			t_sale_price = t_sale_price.replace(",", "");
			t_sale_price = parseInt(t_sale_price);
			var t_amount = $("input#product_amount.t-center:eq("+i+")").val();
			t_amount = parseInt(t_amount);
			money += t_sale_price * t_amount;
		}
		var fee = 0;
		if(money < 50000){
			fee = 2500;
		}
		var total_money = money + fee;
		$("div#money").text(numberWithCommas(money)+"원");
		$("div#fee").text(numberWithCommas(fee)+"원");
		$("div#total_money").text(numberWithCommas(total_money)+"원");
		$("span#payment_total").text(numberWithCommas(total_money)+"원");
	});
	$(document).on('click', 'button.amountPlus.bg8', function(){
		var idx = $(this).index('button.amountPlus.bg8');
		var cart_idx = $("input#cart_idx:eq("+idx+")").val();
		cart_idx = parseInt(cart_idx);
		var amount = $("input#product_amount.t-center:eq("+idx+")").val();
		var sale_price = $("span#sale_price:eq("+idx+")").text();
		sale_price = sale_price.replace(",", "");
		sale_price = parseInt(sale_price);
		amount = parseInt(amount);
		amount = amount + 1;
		$("input#product_amount.t-center:eq("+idx+")").val(amount);
		sale_price = sale_price * amount;
		$("span#price:eq("+idx+")").text(numberWithCommas(sale_price));
		
		var money = 0;
		var len = $("span#sale_price").length;
		for(var i=0; i<len ; i++){
			var t_sale_price = $("span#sale_price:eq("+i+")").text();
			t_sale_price = t_sale_price.replace(",", "");
			t_sale_price = parseInt(t_sale_price);
			var t_amount = $("input#product_amount.t-center:eq("+i+")").val();
			t_amount = parseInt(t_amount);
			money += t_sale_price * t_amount;
		}
		var fee = 0;
		if(money < 50000){
			fee = 2500;
		}
		var total_money = money + fee;
		$("div#money").text(numberWithCommas(money)+"원");
		$("div#fee").text(numberWithCommas(fee)+"원");
		$("div#total_money").text(numberWithCommas(total_money)+"원");
		$("span#payment_total").text(numberWithCommas(total_money)+"원");
	});

	/* 상품수량(숫자) */
	$(document).on('change', 'input#product_amount.t-center', function(){
		var idx = $(this).index('input#product_amount.t-center');
		var cart_idx = $("input#cart_idx:eq("+idx+")").val();
		cart_idx = parseInt(cart_idx);
		var amount = $("input#product_amount.t-center:eq("+idx+")").val();
		var sale_price = $("span#sale_price:eq("+idx+")").text();
		sale_price = sale_price.replace(",", "");
		sale_price = parseInt(sale_price);
		amount = parseInt(amount);
		sale_price = sale_price * amount;
		$("span#price:eq("+idx+")").text(numberWithCommas(sale_price));
		var money = 0;
		var len = $("span#sale_price").length;
		for(var i=0; i<len ; i++){
			var t_sale_price = $("span#sale_price:eq("+i+")").text();
			t_sale_price = t_sale_price.replace(",", "");
			t_sale_price = parseInt(t_sale_price);
			var t_amount = $("input#product_amount.t-center:eq("+i+")").val();
			t_amount = parseInt(t_amount);
			money += t_sale_price * t_amount;
		}
		var fee = 0;
		if(money < 50000){
			fee = 2500;
		}
		var total_money = money + fee;
		$("div#money").text(numberWithCommas(money)+"원");
		$("div#fee").text(numberWithCommas(fee)+"원");
		$("div#total_money").text(numberWithCommas(total_money)+"원");
		$("span#payment_total").text(numberWithCommas(total_money)+"원");
	});
});
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
/* ================================================================= */

$(function(){
	$("#payment_date").append(payment_date());
});
function payment_date(){
	var d = new Date();
	
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var day = d.getDate()+1;
	year = year.toString();
	month = month.toString();
	day = day.toString();
	
	if(month.length == 1){
		month = "0"+month;
	}
	if(day.length == 1){
		day = "0"+day;
	}
	var payment_date = year+"년 "+month+"월 "+day+"일 23:59:59까지";
	
	return payment_date;
}
function payment_method(){
	var payment_method = $(':radio[name="payment_method"]:checked').val();

	$(".table-responsive.m-t-15.payment").remove();
	
	var html = "";
	if(payment_method == "payment_account"){
		$(".table-responsive.m-t-15.account").show();
		$("span.payment_method").remove();
		var html2 = "<span class='payment_method'><input type='radio' id='payment_account' name='payment_method' value='payment_account' checked>무통장 입금";
		html2 += "<input type='radio' id='payment_phone' name='payment_method' value='payment_phone' style='margin-left: 10px;'>휴대폰 결제</span>";
		$("div.payment_method").append(html2);
	}else if(payment_method == "payment_phone"){
		$(".table-responsive.m-t-15.account").hide();
		html = "<div class='table-responsive m-t-15 payment'><table class='table table-bordered phone'><tr>";
		html += "<td style='width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;'>결제방법</td>";
		html += "<td style='width: 80%; padding-left: 25px;'><div class='payment_method' onclick='payment_method()'>";
		html += "<input type='radio' id='payment_account' name='payment_method' value='payment_account'>무통장 입금";
		html += "<input type='radio' id='payment_phone' name='payment_method' value='payment_phone' style='margin-left: 10px;' checked>휴대폰 결제";
		html += "</div></td></tr><tr><td style='width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;'>총 결제금액</td>";
		html += "<td style='width: 80%; padding-left: 25px;'><div class='payment_total'>";
		html += "<span id='payment_total'><fmt:formatNumber value='${total_money}' pattern='#,###' />원</span></div></td></tr></table>";
	}
	$("#paymentInfo").append(html);
}
</script>
<style>
		input[type="number"]::-webkit-outer-spin-button,
		input[type="number"]::-webkit-inner-spin-button {
		    -webkit-appearance: none;
		    margin: 0;
		}
	</style>
</head>
<body class="animsition">
<%@ include file="../include/header_menu.jsp" %>

<!-- Title Page -->
<section class="bg-title-page p-t-40 p-b-50 flex-col-c-m" style="background-image: url(${path}/image/order.png);">
	<h2 class="l-text2 t-center">
		Order
	</h2>
</section>


<section class="order bgwhite p-t-70 p-b-100">
	<div class="container">
		<h2>주문/결제</h2>
		<div class="m-b-15">
			<span class="col-md-9" style="margin-right: 700px;"></span>
			<span class="col-md-3" style="font-size: 1.4em;">
				<span style="color: gray;">
					01 카트 &gt; 
				</span>
				<span style="color: OrangeRed;">
					02 주문/결제 &gt; 
				</span>
				<span style="color: gray;">
					03 주문완료
				</span>
				
			</span>
		</div>
		
		<!-- 대표상품 -->
		<div class="bo9 p-l-40 p-r-40 p-t-10 p-b-10 m-t-30 m-r-0 p-lr-15-sm" style="border-left-width: 0px; border-right-width: 0px; border-top-width: 2px;">
			<div class="pro_represent">
				<table>
					<tr>
						<td>
							<div class="p-l-10"><img src="${list[0].thumb_img}" width="150px"></div>
						</td>
						<td>
							<div class="p-l-50">
								<c:choose>
									<c:when test="${list_count == 1}">
										<span class="represent_name" style="color: OrangeRed;">${list[0].product_name}</span> 
										 상품을 주문합니다.
									</c:when>
									<c:otherwise>
										<span class="represent_name" style="color: OrangeRed;">${list[0].product_name}</span> 
										외 ${list_count - 1}개의 상품을 주문합니다.
									</c:otherwise>
								</c:choose>
								
								<br>
								<span class="s-text8">
									선택하신 상품의 가격과 옵션정보는 하단 주문상품 정보에서 확인하실 수 있습니다.
								</span>
								
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 배송지정보 -->
		<h5 class="m-t-60">배송지 정보</h5>
		<div id="shippingInfo">
			<div class="table-responsive m-t-15">
				<table class="table">
					<tr>
						<td style="width: 20%; text-align: left; padding-top: 24px; padding-left: 30px;">배송지 선택</td>
						<td style="width: 80%">
							<div class="row alias">
								<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="margin-left: 15px; width: 250px;">
									<span id="alias_list">
										<select id="alias" name="alias" class="selection-2 option" onchange="shipping_select()">
											<c:forEach var="row" items="${alias_list}">
												<c:choose>
													<c:when test="${row.alias ==  default_shipping.alias}">
														<option value="${row.shipping_idx}" selected>${row.alias}</option>
													</c:when>
													<c:otherwise>
														<option value="${row.shipping_idx}">${row.alias}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</span>
								</div>
								<div class="col-md-2 p-l-0 p-r-0 m-l-15">
									<button id="btnDelete" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4"  onclick="btnNewAddr()" style="background-color:#E65540; height:40px; margin-top:4px;">
										+새로운 주소
									</button>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">이름</td>
						<td style="width: 80%">
							<div class="recipient">
								<span id="recipient">${default_shipping.recipient}</span>
								
								<div class="new_recipient" style="display: none;">
									<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 250px; height: 45px;">
										<span id="recipient">
											<input type="text" id="recipient" name="recipient" value="" style="width: 250px; height: 45px;">
										</span>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">연락처</td>
						<td style="width: 80%">
							<div class="phone">
								<span id="phone">${default_shipping.phone}</span>
								
								<div class="new_phone" style="display: none;">
									<div class="row" style="padding-left:15px;">
										<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 80px;">
											<select id="phone1" name="phone1" class="selection-2 option">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
										</div>
										<div style="padding-top: 8px;">&nbsp;&nbsp;-&nbsp;&nbsp;</div>
										<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 60px;">
											<input id="phone2" name="phone2" value="" style="width:60px; height: 45px;">
										</div>
										<div style="padding-top: 8px;">&nbsp;&nbsp;-&nbsp;&nbsp;</div>
										<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 62px;">
											<input id="phone3" name="phone3" value="" style="width:62px; height: 45px;">
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">주소</td>
						<td style="width: 80%">
							<div class="address">
								<span id="address">
									(<span id="shipping_postcode">${default_shipping.shipping_postcode}</span>)
									<span id="shipping_addr">${default_shipping.shipping_addr}</span>
									<span id="shipping_detail_addr">${default_shipping.shipping_detail_addr}</span>
								</span>
								
								
								<div class="new_address" style="display: none;">
									<div class="row p-b-10 p-l-15">
										<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 80px; height: 45px;">
											<input type="text" id="shipping_postcode" name="shipping_postcode" value="" style="width: 80px; height: 45px;" readonly>
										</div>
										&nbsp;&nbsp;
										<div class="col-md-2 p-l-0 p-r-0 m-l-10">
											<button id="btnPostCode" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color: black; height:40px; margin-top:4px;">
												우편번호 찾기
											</button>
										</div>
									</div>
									<div class="row p-l-15">
										<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 350px; height: 45px;">
											<input type="text" id="shipping_addr" name="shipping_addr" value="" style="width: 350px; height: 45px;">
										</div>
										&nbsp;&nbsp;
										<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 250px; height: 45px;">
											<input type="text" id="shipping_detail_addr" name="shipping_detail_addr" value="" style="width: 250px; height: 45px;">
										</div>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- ================================================================= -->
		<!-- 주문상품정보 -->
		<h5 class="m-t-60">주문상품 정보</h5>
		<div id="productList">
			<div class="container-table-cart pos-relative">
				<div class="wrap-table-shopping-cart bgwhite">
					<table class="table-shopping-cart">
						<tr class="table-head">
							<th style="width: 50%; text-align: center;">상품정보</th>
							<th style="width: 15%; text-align: center;">상품금액</th>
							<th style="width: 20%; text-align: center;">수량</th>
							<th style="width: 15%; text-align: center;">주문금액</th>
						</tr>
						
						<c:forEach var="row" items="${list}">
							<input type="hidden" id="product_code" name="product_code" value="${row.product_code}">
							<input type="hidden" id="list_count" name="list_count" value="${list_count}">
							<input type="hidden" id="sale_price" name="sale_price" value="${row.sale_price}">
							<input type="hidden" id="product_color" name="product_color" value="${row.product_color}">
							<tr class="table-row">
								<td style="text-align: center;">
									<div class="row m-l-60">
										<div class="cart-img-product b-rad-4 o-f-hidden">
											<img src="${row.thumb_img}" alt="IMG-PRODUCT">
										</div>
										<div class="proInfo m-l-40 m-t-25">
											<div class="pro_name">
												${row.product_name}
											</div>
											<div class="pro_option" style="font-size: 0.8em;">
												${row.product_color}
											</div>
										</div>
									</div>
								</td>
								<td style="text-align: center;">
									<span id="sale_price"><fmt:formatNumber value="${row.sale_price}" pattern="#,###" /></span>원
								</td>
								<td class="p-l-55">
									<div class='flex-w bo5 of-hidden m-r-22 m-t-10 m-b-10' style="width: 104px;">
										<button class='amountMinus bg8' style='width: 30px; height:30px;'>
											<i class='fs-12 fa fa-minus' aria-hidden='true'></i>
										</button>
												
										<input id='product_amount' class='t-center' type='number' value='${row.product_amount}' style='width: 40px; height:30px;'>
												
										<button class='amountPlus bg8' style='width: 30px; height:30px;'>
											<i class='fs-12 fa fa-plus' aria-hidden='true'></i>
										</button>
									</div>
								</td>
								<td style="text-align: center;">
									<span id="price"><fmt:formatNumber value="${row.sale_price * row.product_amount}" pattern="#,###"/></span>원
								</td>
							</tr>
						</c:forEach>
						<tr class="table-row">
							<td></td>
							<td></td>
							<td>
								<div class="row">
									<div class="col-md-4"></div>
									<div class="col-md-8">
										<div class="money_name" style="text-align: left;">상품금액</div>
										<hr>
										<div class="fee_name" style="text-align: left;">배송비</div>
									</div>
								</div>
							</td>
							<td>
								<div class="row">
									<div class="col-md-9">
										<div id="money" style="text-align: right;">
											<fmt:formatNumber value="${money}" pattern="#,###" />원
										</div>
										<hr>
										<div id="fee" style="text-align: right;">
											<fmt:formatNumber value="${fee}" pattern="#,###" />원
										</div>
									</div>
									<div class="col-md-3"></div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="flex-w flex-sb-m p-t-25 p-b-25 bo8 p-l-35 p-r-35 p-lr-15-sm row" style="margin-left: 0px; margin-right: 0px;">

					<div class="col-md-2">
						<div class="total_money_name" style="font-size:1.2em; color: OrangeRed; font-weight:bold;">총 주문금액</div>
					</div>
					<div class="col-md-8"></div>
					<div class="col-md-2">
						<div id="total_money" style="color: OrangeRed; font-weight:bold; text-align: right;">
							<fmt:formatNumber value="${total_money}" pattern="#,###" />원
						</div>
					</div>

				<%-- <div class="row total_money">
					<div class="total_money_name col-md-4" style="font-size:1.2em; color: OrangeRed; font-weight:bold;">총 주문금액</div>
					<div class="col-md-2"></div>
					<div id="total_money" class="col-md-2" style="color: OrangeRed; font-weight:bold;">
						<fmt:formatNumber value="${total_money}" pattern="#,###" />원
					</div>
				</div> --%>
			</div>
		</div>
		
		<!-- ================================================================= -->

		<h5 class="m-t-60">결제수단</h5>
		<div id="paymentInfo">
			<div class="table-responsive m-t-15 account" style="display: block;">
				<table class="table table-bordered account">
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">결제방법</td>
						<td style="width: 80%; padding-left: 25px;">
							<div class="payment_method" onclick="payment_method()">
								<span class="payment_method">
									<input type="radio" id="payment_account" name="payment_method" value="payment_account" checked>무통장 입금
									<input type="radio" id="payment_phone" name="payment_method" value="payment_phone" style="margin-left: 10px;">휴대폰 결제
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">입금은행</td>
						<td style="width: 80%; padding-left: 25px;">
							<div class="bank_select">
								<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size8" style="width: 200px;">
									<select id="bank_select" name="bank_select" class="selection-2 option">
										<option value="" selected>은행 선택</option>
										<option value="kb">국민</option>
										<option value="woori">우리</option>
										<option value="nonghyup">농협</option>
										<option value="shinhan">신한</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">입금자</td>
						<td style="width: 80%; padding-left: 25px;">
							<div class="payment_name">
								<span id="payment_name"><input type="text" value="${default_shipping.recipient}"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">입금기한</td>
						<td style="width: 80%; padding-left: 25px;">
							<div class="payment_date">
								<span id="payment_date"></span>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 20%; text-align: left; padding-left: 30px; vertical-align: middle;">총 결제금액</td>
						<td style="width: 80%; padding-left: 25px;">
							<div class="payment_total">
								<span id="payment_total"><fmt:formatNumber value="${total_money}" pattern="#,###" />원</span>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
<script>
$(function(){
	$("#btnPayment").click(function(){
		var alias_check = $('select[name="alias"]').val();
		var recipient = "";
		var phone1 = "";
		var phone2 = "";
		var phone3 = "";
		var shipping_postcode = "";
		var shipping_addr = "";
		var shipping_detail_addr = "";
		
		if(alias_check == "new_addr"){
			recipient = $("input#recipient").val();
			phone1 = $("#phone1").val();
			phone2 = $("#phone2").val();
			phone3 = $("#phone3").val();
			shipping_postcode = $("input#shipping_postcode").val();
			shipping_addr = $("input#shipping_addr").val();
			shipping_detail_addr = $("input#shipping_detail_addr").val();

			if(recipient == ""){
				alert("배송지 정보의 이름을 입력해 주세요.");
				$("input#recipient").focus();
				return;
			}
			if(phone2 == ""){
				alert("배송지 정보의 연락처를 입력해 주세요.");
				$("input#phone2").focus();
				return;
			}
			if(phone3 == ""){
				alert("배송지 정보의 연락처를 입력해 주세요.");
				$("input#phone3").focus();
				return;
			}

			if(shipping_postcode == ""){
				alert("배송지 정보의 우편번호를 입력해 주세요.");
				$("input#postcode").focus();
				return;
			}
			if(shipping_detail_addr == ""){
				alert("배송지 정보의 상세주소를 입력해 주세요.");
				$("input#detail_addr").focus();
				return;
			}
			
			var data = {"recipient" : recipient, "phone1" : phone1, "phone2" : phone2, "phone3" : phone3,
						"shipping_postcode" : shipping_postcode, "shipping_addr" : shipping_addr, "shipping_detail_addr" : shipping_detail_addr };

			$.ajax({
				type: "post",
				url: "${path}/shop/order/shipping_insert.do",
				async: false,
				data: data,
				dataType: "json",
				success: function(result){
					//console.log(result);
				}
			});
		}else{
			recipient = $("#recipient").text();
			phone = $("#phone").text();
			shipping_postcode = $("#shipping_postcode").text();
			shipping_addr = $("#shipping_addr").text();
			shipping_detail_addr = $("#shipping_detail_addr").text();
		}
		
		var payment_method = $(':radio[name="payment_method"]:checked').val();
		var payment_bank = "";
		var payment_name = "";
		var payment_date = "";
		var payment_phone = "";
		if(payment_method == "payment_account"){
			payment_method = "ACCOUNT";
			payment_bank = $("select#bank_select").val();
			if(payment_bank == ""){
				alert("입금하실 은행을 선택하세요.");
				$("select#bank_select").focus();
				return;
			}
			payment_name = $("#payment_name input").val();
			payment_date = $("#payment_date").text();
		}else if(payment_method == "payment_phone"){
			payment_method = "PHONE";
			payment_phone = phone;
		}
		var payment_price = $("#payment_total").text();
		
		var len = $("#list_count").val();
		var product_code = "";
		var product_amount = "";
		var product_color = "";
		var product_price = "";
		for(var i=0; i<len; i++){
			product_code = product_code + "_" + $("input#product_code:eq("+i+")").val();
			product_amount = product_amount + "_" + $("input#product_amount.t-center:eq("+i+")").val();
			product_color = product_color + "_" + $("input#product_color:eq("+i+")").val();
			product_price = product_price + "_" + $("input#sale_price:eq("+i+")").val();
		}
		var data = {"alias_check" : alias_check, 
					"payment_method" : payment_method,
					"payment_name" : payment_name,
					"payment_bank" : payment_bank,
					"payment_price" : payment_price,
					"product_code" : product_code,
					"product_amount" : product_amount,
					"product_color" : product_color,
					"product_price" : product_price,
					"recipient" : recipient, 
					"shipping_postcode" : shipping_postcode, 
					"shipping_addr" : shipping_addr, 
					"shipping_detail_addr" : shipping_detail_addr
					};
		$.ajax({
			type: "post",
			url: "${path}/shop/order/order_insert.do",
			data: data,
			dataType: "json",
			success: function(result){
				document.location.href="${path}/shop/order/orderComplete.do?order_idx="+result;
			}
		});
		
	});
});
</script>
		<div class="row" style="margin-left: 400px;">
			<div class="w-size2 p-t-20">
				<button class="flex-c-m size2 bg4 bo-rad-23 hov1 m-text3 trans-0-4" onclick="history.back();" style="background-color: #E65540;">
					취소
				</button>
			</div>
			<div class="w-size2 p-t-20" style="margin-left: 30px;">
				<button class="flex-c-m size2 bg4 bo-rad-23 hov1 m-text3 trans-0-4" id="btnPayment">
					결제하기
				</button>
			</div>
		</div>
	</div>
</section>

<%@ include file="../include/footer.jsp" %>

	<!-- Back to top -->
	<div class="btn-back-to-top bg0-hov" id="myBtn">
		<span class="symbol-btn-back-to-top">
			<i class="fa fa-angle-double-up" aria-hidden="true"></i>
		</span>
	</div>

	<!-- Container Selection -->
	<div id="dropDownSelect1"></div>
	<div id="dropDownSelect2"></div>

	<%@ include file="../include/body_footer.jsp" %>

	<script type="text/javascript">
		$(".selection-1").select2({
			minimumResultsForSearch: 20,
			dropdownParent: $('#dropDownSelect1')
		});

		$(".selection-2").select2({
			minimumResultsForSearch: 20,
			dropdownParent: $('#dropDownSelect2')
		});
	</script>

</body>
</html>
