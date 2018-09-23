<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Cart</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="../include/head.jsp" %>
	<style>
		input[type="number"]::-webkit-outer-spin-button,
		input[type="number"]::-webkit-inner-spin-button {
		    -webkit-appearance: none;
		    margin: 0;
		}
	</style>
	<script>
	$(function(){	
		/* 이미지클릭 시 삭제 */
		$(document).on('click', 'div.cart-img-product', function(){
			var idx = $(this).index('div.cart-img-product');
			if(confirm("선택하신 상품을 삭제하시겠습니까?")){
				var cart_idx = $("input#cart_idx:eq("+idx+")").val();
				var data = {"cart_idx" : cart_idx};
				$.ajax({
					type: "post",
					url: "${path}/shop/cart/cart_delete.do",
					data: data,
					dataType: "json",
					success: function(){
						window.location.reload();
					}
				});
			}
		});
		
		/* 선택된 상품 삭제 */
		$(document).on("click", "button#btnDelete", function(){
			if(confirm("선택하신 상품을 삭제하시겠습니까?") == true){
				$("input:checkbox[name=chk]:checked").each(function(i, elements){
					var idx = $(elements).index("input:checkbox[name=chk]");
					var cart_idx = $("input#cart_idx:eq("+idx+")").val();
					var data = {"cart_idx" : cart_idx};
					$.ajax({
						type: "post",
						url: "${path}/shop/cart/cart_delete.do",
						data: data,
						dataType: "json",
						success: function(){
							window.location.reload();
						}
					});
				});
			}else{
				return;
			}
		});
		
		/* 체크박스 */
		$(".checkall").click(function(){
			if($(".checkall").prop("checked")){
				$("input[name=chk]").prop("checked", true);
			}else{
				$("input[name=chk]").prop("checked", false);
			}
		});
		$(".chk").click(function(){
			var count = $("#count").val();
			if($("input[name=chk]:checked").length == count){
				$(".checkall").prop("checked", true);
			}else{
				$(".checkall").prop("checked", false);
			}
		});
		
		/* 상품갯수(버튼) */
		$(document).on('click', 'button.amountMinus.bg8', function(){
			var idx = $(this).index('button.amountMinus.bg8');
			var cart_idx = $("input#cart_idx:eq("+idx+")").val();
			cart_idx = parseInt(cart_idx);
			var amount = $("input#amount:eq("+idx+")").val();
			if(amount == "1"){
				alert("상품의 구매 가능한 최소수량은 1개 입니다.");
				return;
			}
			var sale_price = $("span#sale_price:eq("+idx+")").text();
			sale_price = sale_price.replace(",", "");
			sale_price = parseInt(sale_price);
			amount = parseInt(amount);
			amount = amount - 1;
			$("input#amount:eq("+idx+")").val(amount);
			sale_price = sale_price * amount;
			
			var data = {"cart_idx" : cart_idx, "amount" : amount};
			$.ajax({
				type: "post",
				url: "${path}/shop/cart/amount_change.do",
				data: data,
				dataType: "json",
				success: function(result){
					$("span#money:eq("+idx+")").text(numberWithCommas(sale_price));
					$("span#pro_money").text(numberWithCommas(result.money));
					$("span#fee").text(numberWithCommas(result.fee));
					$("span#total_money").text(numberWithCommas(result.total_money));
				}
			});
		});
		$(document).on('click', 'button.amountPlus.bg8', function(){
			var idx = $(this).index('button.amountPlus.bg8');
			var cart_idx = $("input#cart_idx:eq("+idx+")").val();
			cart_idx = parseInt(cart_idx);
			var amount = $("input#amount:eq("+idx+")").val();
			var sale_price = $("span#sale_price:eq("+idx+")").text();
			sale_price = sale_price.replace(",", "");
			sale_price = parseInt(sale_price);
			amount = parseInt(amount);
			amount = amount + 1;
			$("input#amount:eq("+idx+")").val(amount);
			sale_price = sale_price * amount;
			
			var data = {"cart_idx" : cart_idx, "amount" : amount};
			$.ajax({
				type: "post",
				url: "${path}/shop/cart/amount_change.do",
				data: data,
				dataType: "json",
				success: function(result){
					$("span#money:eq("+idx+")").text(numberWithCommas(sale_price));
					$("span#pro_money").text(numberWithCommas(result.money));
					$("span#fee").text(numberWithCommas(result.fee));
					$("span#total_money").text(numberWithCommas(result.total_money));
				}
			});			
		});
		/* 천단위마다 ',' */
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		/* 상품수량(숫자) */
		$(document).on('change', 'input#amount.t-center', function(){
			var idx = $(this).index('input#amount.t-center');
			var cart_idx = $("input#cart_idx:eq("+idx+")").val();
			cart_idx = parseInt(cart_idx);
			var amount = $("input#amount.t-center:eq("+idx+")").val();
			var sale_price = $("span#sale_price:eq("+idx+")").text();
			sale_price = sale_price.replace(",", "");
			sale_price = parseInt(sale_price);
			amount = parseInt(amount);
			sale_price = sale_price * amount;
			var data = {"cart_idx" : cart_idx, "amount" : amount};
			$.ajax({
				type: "post",
				url: "${path}/shop/cart/amount_change.do",
				data: data,
				dataType: "json",
				success: function(result){
					$("span#money:eq("+idx+")").text(numberWithCommas(sale_price));
					$("input#amount.t-center:eq("+idx+")").val(result.amount);
					$("span#pro_money").text(numberWithCommas(result.money));
					$("span#fee").text(numberWithCommas(result.fee));
					$("span#total_money").text(numberWithCommas(result.total_money));
					window.location.reload();
				}
			});
		});
		
		/* 옵션변경 */
		$(document).on('click', 'button#btnOption.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4', function(){
			var idx = $(this).index('button#btnOption.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4');
			var pro_name = $("div.pro_name:eq("+idx+")").text();
			var pro_code = $("input#pcode:eq("+idx+")").val();
			
			var data = {"pro_code" : pro_code};
			
			$.ajax({
				type: "post",
				url: "${path}/shop/cart/option_list.do",
				data: data,
				dataType: "json",
				success: function(result){
					var html = "<div class='modal-select'><select id='option' class='selection-2 option' name='color'><option value=''>Choose an option</option>";
					for(var i=0; i<result.length; i++){
						html += "<option value='"+result[i]+"'>"+result[i]+"</option>";
					}
					html += "</select></div>";
					
					var html2 = "<div class='modal-idx'><input type='hidden' id='idx' name='idx' value='"+idx+"'></div>";
					
					$("div.modal-idx").remove();
					$("div.modal-name").before(html2);
					
					$("div.modal-name").text(pro_name);
					
					$("div.modal-select").remove();
					$("div.modal-body").append(html);
				}
			});
		});
		$(document).on('click', 'button#modal-update', function(){
			var idx = $("#idx").val();
			var option = $("#option option:selected").val();
			var option_origin = $("div.pro_option:eq("+idx+")").text();
			if(option_origin.indexOf(option) >= 0){
				alert("이미 선택한 옵션입니다.");
				return;
			}
			var cart_idx = $("input#cart_idx:eq("+idx+")").val();
			
			var data = {"option" : option, "cart_idx" : cart_idx};
			$.ajax({
				type: "post",
				url: "${path}/shop/cart/option_change.do",
				data: data,
				dataType: "json",
				success: function(){
					$("div.pro_option:eq("+idx+")").remove();					
					var html = "<div class='pro_option' style='font-size: 0.8em;'>옵션 | "+option+"</div>";					
					$("div.pro_name:eq("+idx+")").after(html);
					$("#option").modal("hide");
				}
			});
		});
		
		/* 주문하기 */
		$("#btnBuy").click(function(){
			var count = $("#count").val();
			//console.log(count);
			var arr = new Array();
			var obj = new Object();
			for(var i=0; i<count; i++){
				if(i != 0){
					obj = new Object();
				}
				obj.code = $("input#pcode:eq("+i+")").val();
				obj.color = trim($("div.pro_option:eq("+i+")").text());
				obj.cnt = $("input#amount:eq("+i+")").val();
				arr.push(obj);
			}
			var product_info = JSON.stringify(arr);
			//console.log(product_info);
			
			$("input[name=arr]").val(product_info);
			
			
			document.form1.action="${path}/shop/order/order_list.do";
			document.form1.submit();
		});
	});
	/* 장바구니비우기 */
	function btnDeleteAll(){
		if(confirm("장바구니를 비우시겠습니까?")){
			document.location.href="${path}/shop/cart/cart_all_delete.do";
		}
	}
	/* trim기능 */
	function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
	}
	</script>
</head>
<body class="animsition">
<%@ include file="../include/header_menu.jsp" %>


<div class="modal fade" id="option" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">옵션 변경</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<div class="modal-idx"></div>
				<div class="modal-name"></div>
				<div class="modal-select"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="button" id="modal-update" class="btn btn-primary">변경하기</button>
			</div>
		</div>
	</div>
</div>


<!-- Title Page -->
<section class="bg-title-page p-t-40 p-b-50 flex-col-c-m" style="background-image: url(${path}/image/cart.png);">
	<h2 class="l-text2 t-center">
		Cart
	</h2>
</section>

<!-- Cart -->
<section class="cart bgwhite p-t-70 p-b-100">
	<div class="container">
		<div class="m-b-15">
			<span class="col-md-1 s-text18 w-size19 w-full-sm m-l-10">
				<input type="hidden" id="count" name="count" value="${count}">
				총 ${count}개 상품
			</span>
			<span class="col-md-10" style="margin-right: 600px;"></span>
			<span class="col-md-1" style="font-size: 1.4em;">
				<span style="color: OrangeRed;">
					01 카트 &gt;
				</span>
				<span style="color: gray;">
					02 주문/결제 > 03 주문완료
				</span>
				
			</span>
		</div>
		
		<!-- Cart item -->
		<div class="container-table-cart pos-relative">
			<div class="wrap-table-shopping-cart bgwhite">
				<!-- 상품리스트 -->
				<table class="table-shopping-cart">
					<tr class="table-head">
						<th class="p-l-45" style="width: 4%; text-align: center;">
							<input type="checkbox" class="checkall" checked>
						</th>
						<th style="width: 16%; text-align: center;"></th>
						<th style="width: 36%; text-align: center;">상품정보</th>
						<th style="width: 12%; text-align: center;">가격</th>
						<th style="width: 16%; text-align: center;">수량</th>
						<th style="width: 12%; text-align: center;">Total</th>
					</tr>
					<c:choose>
						<c:when test="${count == 0}">
							<tr>
								<td colspan="6" align="center"style="text-align: center;">카트에 담긴 상품이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="row" items="${list}">
								<input type="hidden" id="pcode" name="pcode" value="${row.pcode}">
								<input type="hidden" id="cart_idx" name="cart_idx" value="${row.idx}">
								<input type="hidden" id="price" name="price" value="${row.sale_price}">
								<tr class="table-row">
									<td class="p-l-40" style="text-align: center;"><input type="checkbox" class="chk" name="chk" checked></td>
									<td class="p-l-40" style="text-align: center;">
										<div class="cart-img-product b-rad-4 o-f-hidden">
											<img src="${row.thumb_img}" alt="IMG-PRODUCT">
										</div>
									</td>
									<td style="text-align: center;">
										<div class="pro_name">
											${row.pname}
										</div>
										<div class="pro_option" style="font-size: 0.8em;">
											옵션 | ${row.pro_option}
										</div>
										<div class="row">
											<div class="col-md-5"></div>
											<div class="col-md-3">
												<div class="btnOption">
													<button id="btnOption" class="flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color:#E65540;" data-toggle="modal" data-target="#option">
														<span class="m-t-3 m-b-3 m-l-8 m-r-8" style="font-size: 0.8em;">옵션수정</span>
													</button>
												</div>
											</div>
											<div class="col-md-3"></div>
										</div>
										
									</td>
									<td style="text-align: center;">
										<span id="sale_price"><fmt:formatNumber value="${row.sale_price}" pattern="#,###" /></span>원
									</td>
									<td class="p-l-30">
										<div class='flex-w bo5 of-hidden m-r-22 m-t-10 m-b-10' style="width: 104px;">
											<button class='amountMinus bg8' style='width: 30px; height:30px;'>
												<i class='fs-12 fa fa-minus' aria-hidden='true'></i>
											</button>
											
											<input id='amount' class='t-center' type='number' value='${row.amount}' style='width: 40px; height:30px;'>
											
											<button class='amountPlus bg8' style='width: 30px; height:30px;'>
												<i class='fs-12 fa fa-plus' aria-hidden='true'></i>
											</button>
										</div>
									</td>
									<td style="text-align: center;">
										<span id="money"><fmt:formatNumber value="${row.money}" pattern="#,###"/></span>원
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
		<div class="flex-w flex-sb-m p-t-25 p-b-25 bo8 p-l-35 p-r-35 p-lr-15-sm">
			<div class="col-md-2 p-l-0 p-r-40" >
				<button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color:#000000; height:45px;" onclick="history.back();">
					쇼핑 계속하기
				</button>
			</div>
			<div class="col-md-7"></div>
			<div class="col-md-2">
				<button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4 m-r-10" style="background-color:#000000; height:45px;"  onclick="btnDeleteAll()">
					장바구니 비우기
				</button>
			</div>
			<div class="col-md-1 p-l-0 p-r-0">
				<button id="btnDelete" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color:#E65540; height:45px;">
					삭제
				</button>
			</div>
		</div>
			

		<!-- Total -->
		<c:if test="${count != 0}">
			<div class="bo9 w-size18 p-l-40 p-r-40 p-t-30 p-b-38 m-t-30 m-r-0 m-l-auto p-lr-15-sm">
				<h5 class="m-text20 p-b-24">
					총 주문금액
				</h5>
	
				<div class="flex-w flex-sb-m p-b-12">
					<span class="s-text18 w-size19 w-full-sm">
						총 상품금액
					</span>
	
					<span class="m-text21 w-size20 w-full-sm p-l-20">
						<span id="pro_money"><fmt:formatNumber value="${money}" pattern="#,###" /></span>원
					</span>
				</div>
				<div class="flex-w flex-sb-m p-b-12">
					<span class="s-text18 w-size19 w-full-sm">
						배송비
					</span>
	
					<span class="m-text21 w-size20 w-full-sm p-l-20">
						<span id="fee"><fmt:formatNumber value="${fee}" pattern="#,###" /></span>원
					</span>
				</div>
	
				<div class="flex-w flex-sb bo10"></div>
				
				<div class="flex-w flex-sb-m p-t-26 p-b-30">
					<span class="m-text22 w-size19 w-full-sm">
						결제 예상금액
					</span>
	
					<span class="m-text21 w-size20 w-full-sm p-l-20">
						<span id="total_money"><fmt:formatNumber value="${total_money}" pattern="#,###" /></span>원
					</span>
				</div>

				<div class="size15 trans-0-4">
					<!-- Button -->
					<form name="form1" method="post">
						<input type="hidden" id="arr" name="arr" value="">
					</form>
					<button id="btnBuy" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4">
						주문하기
					</button>
				</div>
			</div>
		</c:if>
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
