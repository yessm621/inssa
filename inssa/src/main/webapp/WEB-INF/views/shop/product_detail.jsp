<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Product Detail</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="../include/head.jsp" %>
	<script>
		function select_option(){
			var option = document.getElementById("option");
			var pro_option = option.options[option.selectedIndex].value;
			var pro_name = "${list.name}";
			var sale_price = "${list.sale_price}";
			sale_price = parseInt(sale_price);

			var all_option = $("span.pro_option").text();
			if(all_option.indexOf(pro_option) >= 0){
				alert("이미 선택되어 있는 옵션입니다.");
				return;
			}
			
			var html = "<div class='bo6 p-t-15 p-b-14'><h5 class='flex-sb-m cs-pointer m-text19 color0-hov trans-0-4'>";
			html += "<span class='p-l-20 pro_name'>"+pro_name+"</span><button class='btnDel'>";
			html += "<i class='fs-12 color1 fa fa-times' aria-hidden='true'></i></button></h5>"

			html += "<div class='p-l-30 p-t-15'><p class='s-text8'>옵션 | <span class='pro_option'>"+pro_option+"</span></p>"
			html += "<h5><span class='price'>"+numberWithCommas(sale_price)+"</span>원</h5></div>"

			html += "<div class='flex-r-m flex-w'><div class='w-size10 flex-m flex-w'>"
			html += "<div class='flex-w bo5 of-hidden m-r-22 m-t-10 m-b-10'><button class='amountMinus bg8' style='width: 30px; height:30px;'>"
			html += "<i class='fs-12 fa fa-minus' aria-hidden='true'></i></button>"
		
			html += "<input id='amount' class='t-center' type='number' value='1' style='width: 40px; height:30px;'>"
		
			html += "<button class='amountPlus bg8' style='width: 30px; height:30px;'><i class='fs-12 fa fa-plus' aria-hidden='true'></i>"
			html += "</button></div></div></div></div>"

			$(".option_list").append(html);
		}
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		$(function(){
			$(document).on('click', 'button.btnDel', function(){
				var idx = $(this).index('button.btnDel');
				$("div.bo6.p-t-15.p-b-14:eq("+idx+")").remove();
			});
			$(document).on('click', 'button.amountMinus.bg8', function(){
				var idx = $(this).index('button.amountMinus.bg8');
				var amount = $("input#amount:eq("+idx+")").val();
				if(amount == "1"){
					alert("상품의 구매 가능한 최소수량은 1개 입니다.");
					return;
				}
				var sale_price = "${list.sale_price}";
				sale_price = parseInt(sale_price)
				
				amount = parseInt(amount);
				amount = amount - 1;
				$("input#amount:eq("+idx+")").val(amount);
				
				sale_price = sale_price * amount;

				$("span.price:eq("+idx+")").text(numberWithCommas(sale_price));
			});
			$(document).on('click', 'button.amountPlus.bg8', function(){
				var idx = $(this).index('button.amountPlus.bg8');
				var amount = $("input#amount:eq("+idx+")").val();
				var sale_price = "${list.sale_price}";
				sale_price = parseInt(sale_price)
				
				amount = parseInt(amount);
				amount = amount + 1;
				$("input#amount:eq("+idx+")").val(amount);
				
				sale_price = sale_price * amount;

				$("span.price:eq("+idx+")").text(numberWithCommas(sale_price));
			});
		});

		$(function(){
			$("#btnCart").click(function(){
				
				var len = $("span.pro_option").length;
				if(len == 0){
					alert("옵션을 선택하세요.");
					return;
				}
				var pcode = $("#pcode").val();
		
				var arr = new Array();
				var obj = new Object();
				for(var i=0; i<len; i++){
					if(i != 0){
						obj = new Object();
					}
					obj.code = pcode;
					obj.color = $("span.pro_option:eq("+i+")").text();
					obj.cnt = $("input#amount:eq("+i+")").val();
					arr.push(obj);
				}
				
				$.ajax({
					type: "post",
					url: "${path}/shop/cart/cart_insert.do",
					data: {formData : JSON.stringify(arr)},
					dataType: "json",
					success: function(){
						console.log("insert success");
					}
				});
				
				
				$('.btn-addcart-product-detail').each(function(){
					var nameProduct = $('.product-detail-name').html();
					$(this).on('click', function(){
						swal(nameProduct, "선택하신 상품을 장바구니에 담았습니다.", "success");
					});
				});
				
				$("div.option_list").empty();
			});
		});
		$(document).ready(function(){
			var link = document.location.href;
			var tab = link.split('#').pop();
			$('a[href$='+tab+']').trigger("click");
		});
		function detailImg(){
			console.log("detailImg");
			$("#detailImg").show();
			$("#proReview").hide();
			$("#proQna").hide();
		}
		function proReview(){
			console.log("proReview");
			$("#detailImg").hide();
			$("#proReview").show();
			$("#proQna").hide();
		}
		function proQna(){
			console.log("proQna");
			$("#detailImg").hide();
			$("#proReview").hide();
			$("#proQna").show();
		}
		$(function(){
			$("div.proReviewDetail").hide();
			$(document).on('click', "button#proReview_detail.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4", function(){
				var idx = $(this).index("button#proReview_detail.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4");
				var btnName = $("button#proReview_detail.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4:eq("+idx+") span.m-t-3.m-b-3.m-l-8.m-r-8").text();

				if(btnName == "내용더보기"){
					var pro_code = $("input#re_code:eq("+idx+")").val();
					var pro_idx = $("input#board_idx:eq("+idx+")").val();
					var data = {"pro_code" : pro_code, "pro_idx" : pro_idx};

					$.ajax({
						type: "post",
						url: "${path}/shop/product/file_list.do",
						data: data,
						dataType: "json",
						success: function(result){
							$("div.proReviewDetail:eq("+idx+")").show();
							$("div.proReviewDetail:eq("+idx+") div#pro_file").remove();
							var html = "<div id='pro_file' class='row'>";
							for(var i=0; i<result.length; i++){
								html += "<div><img src='/inssa/upload/displayFile?fileName="+result[i].original_name+"' class='m-r-5'></div>";
							}
							html += "</div>";
							$("div.pro_file:eq("+idx+")").append(html);
							
							$("button#proReview_detail.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4:eq("+idx+") span.m-t-3.m-b-3.m-l-8.m-r-8").text("내용접기");
						}
					});
				}else if(btnName == "내용접기"){
					$("div.proReviewDetail:eq("+idx+")").hide();
					$("button#proReview_detail.flex-c-m.bg1.bo-rad-23.hov1.s-text1.trans-0-4:eq("+idx+") span.m-t-3.m-b-3.m-l-8.m-r-8").text("내용더보기");
				}
				
			});
			$(document).on('click', "input#proReview_folding", function(){
				var idx = $(this).index("input#proReview_folding");
				$(".proInfo2:eq("+idx+")").show();
				$("div.proReviewDetail:eq("+idx+")").hide();
			});
		});
	</script>
	<style>
		#price{
			color: gray;
			text-decoration: line-through;
		}
		input[type="number"]::-webkit-outer-spin-button,
		input[type="number"]::-webkit-inner-spin-button {
		    -webkit-appearance: none;
		    margin: 0;
		}
		.slick-list .price {
			color: gray;
			font-size: 0.8em;
			text-decoration: line-through;
		}
	</style>
</head>
<body class="animsition">
<%@ include file="../include/header_menu.jsp" %>
<c:if test="${message == 'useAfterBuy'}">
	<input type="hidden" id="message" value="${message}">
	<script>
		var message = $("#message").val();
		alert("상품 구입 후 후기를 작성해주세요.");
	</script>
</c:if>

<!-- 상단진행네비 -->
<div class="bread-crumb bgwhite flex-w p-l-52 p-r-15 p-t-30 p-l-15-sm">
	<a href="${path}/" class="s-text16">
		Home
		<i class="fa fa-angle-right m-l-8 m-r-9" aria-hidden="true"></i>
	</a>
	<a href="${path}/shop/product/product.do?cate=${cate}" class="s-text16">
		${catename}
		<i class="fa fa-angle-right m-l-8 m-r-9" aria-hidden="true"></i>
	</a>
	<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}" class="s-text16">
		${subname}
		<i class="fa fa-angle-right m-l-8 m-r-9" aria-hidden="true"></i>
	</a>
	<span class="s-text17">
		${list.name}
	</span>
</div>

<!-- Product Detail -->
<div class="container bgwhite p-t-35 p-b-80">
	<div class="flex-w flex-sb">
		<div class="w-size13 p-t-30 respon5">
			<div class="wrap-slick3 flex-sb flex-w">
				<div class="wrap-slick1-dots"></div>
				<!-- 대표이미지 -->
				<div class="wrap-pic-w">
					<img src="${list.thumb_img}" alt="IMG-PRODUCT" style="width: 400px; height:400px;">
				</div>
			</div>
		</div>
		
		<div class="w-size14 p-t-30 respon5">
			<!-- 상품이름 -->
			<h4 class="product-detail-name m-text16 p-b-13">
				${list.name}
			</h4>
			<!-- 상품가격 -->
			<div class="priceInfo" style="display: flex;">
				<span class="s-text12 p-t-10">
					판매가격
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div class="priceInfo">
					<span id="price" class="m-text10">
						<fmt:formatNumber value="${list.price}" pattern="#,###" />원
					</span>
					<br>
					<span class="m-text17">
						<fmt:formatNumber value="${list.sale_price}" pattern="#,###" />원
					</span>
					&nbsp;&nbsp;&nbsp;
					<span class="m-text17" style="color: OrangeRed;">
						${sale_percent}%
					</span>
				</div>
			</div>
			<br>
			<!-- 상품배송정보 -->
			<span class="s-text12 p-t-10">
				배송정보
			</span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="s-text8 p-t-10">
				50,000원 이상 구매 시 무료배송
			</span>
			
			
			
			<div class="p-t-33 p-b-10">
				<!-- 상품옵션 -->
				<div class="flex-m flex-w">
					<div class="s-text15 w-size15 t-center">
						옵션
					</div>

					<div class="rs2-select2 rs3-select2 bo4 of-hidden w-size16">
						<select id="option" class="selection-2 option" name="color" onchange="select_option()">
							<option value=""> 옵션을 선택하세요. </option>
							<c:forEach items="${option2}" var="option2">
								<option value="${option2}">${option2}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<!-- 선택한옵션내용 -->
			<div class="option_list">
			
			</div>
			
			<!-- 장바구니담기 -->
			<div class="flex-r-m flex-w p-t-10">
				<div class="w-size16 flex-m flex-w">
					<div class="btn-addcart-product-detail size9 trans-0-4 m-t-10 m-b-10">
						<!-- Button -->
						<form name="form1" method="post">
							<input type="hidden" id="product_idx" name="product_idx" value="${list.idx}">
							<input type="hidden" id="detail_img" name="detail_img" value="${list.detail_img}">
							<input type="hidden" id="pcode" name="pcode" value="${list.code}">
							<input type="hidden" id="arr" name="arr" value="">
						</form>
						<button id="btnCart" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4">
							장바구니에 담기
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	$(document).on('click', 'button#btnAddCart.flex-c-m.size1.bg4.bo-rad-23.hov1.s-text1.trans-0-4', function(){
		var idx = $(this).index('button#btnAddCart.flex-c-m.size1.bg4.bo-rad-23.hov1.s-text1.trans-0-4');

		var pro_code = $("input#pro_code:eq("+idx+")").val();
		var data = {"pro_code" : pro_code};
		
		var member_id = "${sessionScope.member_id}";
		if(member_id != ""){
			$.ajax({
				type: "post",
				url: "${path}/shop/product/productColor.do",
				data: data,
				dataType: "json",
				success: function(result){
					var arr = new Array();
					var obj = new Object();
					
					obj.code = pro_code;
					obj.color = result;
					obj.cnt = "1";
					arr.push(obj);
					
					$.ajax({
						type: "post",
						url: "${path}/shop/cart/cart_insert.do",
						data: {formData : JSON.stringify(arr)},
						dataType: "json",
						success: function(){
							console.log("insert success");
						}
					});
				}
			});
		}else{
			return;
		}
	});
});

function re_delete(code, board_idx, board_type){
	if(confirm("상품후기를 삭제하시겠습니까?")){
		document.location.href="${path}/shop/product/review_delete.do?pro_code="+code+"&board_idx="+board_idx+"&board_type="+board_type;
	}
}
</script>
<!-- 관련제품 -->
<section class="relateproduct bgwhite p-t-45 p-b-45">
	<div class="container">
		<div class="sec-title p-b-60">
			<h3 class="m-text5 t-center">Related Products</h3>
			<h6 class="t-center">같은 카테고리의 인기 상품</h6>
		</div>

		<!-- Slide2 -->
		<div class="wrap-slick2">
			<div class="slick2">
				<c:forEach var="row" items="${related_list}">
					<div class="item-slick2 p-l-15 p-r-15">
						<!-- Block2 -->
						<div class="block2">
							<div class="block2-img wrap-pic-w of-hidden pos-relative">
								<img src="${row.thumb_img}" alt="IMG-PRODUCT">
	
								<div class="block2-overlay trans-0-4">
									<!-- <a href="#" class="block2-btn-addwishlist hov-pointer trans-0-4">
										<i class="icon-wishlist icon_heart_alt" aria-hidden="true"></i>
										<i class="icon-wishlist icon_heart dis-none" aria-hidden="true"></i>
									</a> -->
	
									<div class="block2-btn-addcart w-size1 trans-0-4">
										<button id="btnAddCart" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
											장바구니에 담기
										</button>
									</div>
								</div>
							</div>
	
							<div class="block2-txt p-t-20">
								<form name="form2" method="post">
									<input type="hidden" id="pid" name="pid" value="${row.idx}">
									<input type="hidden" id="pro_code" name="pro_code" value="${row.code}">
									<input type="hidden" id="arr2" name="arr2" value="">
								</form>
								<div style="text-align: center;">
									<a href="${path}/shop/product/product_detail.do?pro_code=${row.code}" class="block2-name dis-block s-text3 p-b-5">
										${row.name}
									</a>
								</div>
								<div style="text-align: right;">
									<span class="block2-price m-text6 p-r-5">
										<span class="price"><fmt:formatNumber value="${row.price}" pattern="#,###" />원</span>&nbsp;->&nbsp;
										<span class="sale_price"><fmt:formatNumber value="${row.sale_price}" pattern="#,###" />원</span>
									</span>
								</div>
								
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>


<!-- 상세이미지/리뷰/문의 -->
<section>
	<div class="container">
		<div class="row m-t-60 m-b-80">
			<div class="col-md-3"></div>
			<div class="col-md-2">
				<div class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4">
					<a href="#detailImg" onclick="detailImg()" style="font-size: 1.2em; color: white;">상세보기</a>
				</div>
			</div>
			<div class="col-md-2">
				<div class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4">
					<a href="#review" onclick="proReview()" style="font-size: 1.2em; color: white;">상품후기</a>
				</div>
			</div>
			<div class="col-md-2">
				<div class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4">
					<a href="#qna" onclick="proQna()" style="font-size: 1.2em; color: white;">상품문의</a>
				</div>
			</div>
			<div class="col-md-3"></div>
		</div>

		<!-- 이미지, 리뷰, 문의 내용 -->
		<div class="detailInfo">
		
			<!-- 상세보기 -->
			<div id="detailImg" style="text-align: center;">
				<span class="detailImg"><img src="${list.detail_img}"></span>
			</div>
			
			
			<!-- 상품후기 -->
			<div id="proReview">
				<div class="proReview" style="text-align: center;">
					<div class="row p-t-66">
						<div class="col-md-2"></div>
						<div class="col-md-3 m-b-10"><h2 style="text-align: left;">상품후기(${listCnt})</h2></div>
						<div class="col-md-3"></div>                                                            
						<div class="col-md-2 ">
							<button class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4 m-r-30" style="background-color: black; height: 38px;" onclick="location.href='${path}/shop/product/pro_review_write.do?pro_code=${pro_code}'">상품후기 작성하기</button>
						</div>
						<div class="col-md-2"></div>
					</div>
					
					<section class="bgwhite p-b-38">
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-8">
								<c:choose>
									<c:when test="${review_count == 0}">
										<div class="container">
											<hr style="border-top-width: 2px;">
											작성된 상품후기가 없습니다.
											<hr class="p-b-30" style="border-top-width: 2px;">
										</div>
									</c:when>
									<c:otherwise>
										<div class="container">
									<hr class="m-t-10" style="border-top-width: 2px;">
									
									<c:forEach var="row" items="${review_list}">
										<c:if test="${row.board_show == 'N'}">
											<div class="row">
												<div class="col-md-12 p-b-10" style="text-align: left;">
													<h3 class="m-text18 p-t-10 p-b-5">
														<span class="pro_name">${row.name}</span>
														&nbsp;&nbsp;|&nbsp;&nbsp;
														<span class="pro_color">${row.color}</span>
													</h3>
													<div class="memberInfo" style="font-size: 0.8em;">
														<span class="member_name">${row.member_name}</span>
														(<span class="member_id">${row.member_id}</span>)
														&nbsp;&nbsp;|&nbsp;&nbsp;
														<span class="board_time"><fmt:formatDate value="${row.board_modified_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
													</div>
													<div class="bo13 p-l-20">
														<span class="pro_title"><strong>${row.title}</strong></span>
													</div>
													<div>
														<div class="proInfo2 m-t-5">
															<div class="row">
																<div class="proReview_detail m-l-10 m-t-10">
																	<button id="proReview_detail" class="flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color:#E65540;">
																		<span class="m-t-3 m-b-3 m-l-8 m-r-8" style="font-size: 0.8em;">내용더보기</span>
																	</button>
																</div>
																<input type="hidden" id="board_idx" name="board_idx" value="${row.board_idx}">
																<input type="hidden" id="re_code" name="re_code" value="${row.code}">
																<div class="m-t-10 m-l-15">
																	<c:if test="${sessionScope.member_id == row.member_id}">
																		<a href="#" onclick="location.href='${path}/shop/product/review_modify_list.do?pro_code=${row.code}&board_idx=${row.board_idx}'" style="font-size: 0.8em;">수정</a>
																		&nbsp;|&nbsp;
																		<a href="#" id="re_delete" onclick="re_delete(${row.code}, ${row.board_idx}, 'R')" style="font-size: 0.8em;">삭제</a>
																	</c:if>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
									
											<div class="proReviewDetail m-l-30">
												<div class="p-l-10 m-b-10" style="text-align: left;">
													<span id="pro_content">${row.content}</span>
												</div>
												<div class="pro_file m-l-20">
													<div id="pro_file" class="row"></div>
												</div>
											</div>
											<hr style="border-top-width: 2px;">
										</c:if>
									</c:forEach>
								</div>
								<nav>
									<div class="pagination flex-m flex-w p-t-26">
										<c:choose>
											<c:when test="${currentPage == 1}">
												<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${currentPage}#review" class="item-pagination flex-c-m trans-0-4">&laquo;</a>
											</c:when>
											<c:otherwise>
												<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${currentPage-1}#review" class="item-pagination flex-c-m trans-0-4">&laquo;</a>
											</c:otherwise>
										</c:choose>
										
										<c:forEach begin="${startBlock}" end="${endBlock}" var="i">
											<c:choose>
												<c:when test="${currentPage == i}">
													<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${i}#review" class="item-pagination flex-c-m trans-0-4 active-pagination">${i}</a>
												</c:when>
												<c:otherwise>
													<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${i}#review" class="item-pagination flex-c-m trans-0-4">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:choose>
											<c:when test="${currentPage == totalPage}">
												<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${currentPage}#review" class="item-pagination flex-c-m trans-0-4">&raquo;</a>
											</c:when>
											<c:otherwise>
												<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${currentPage+1}#review" class="item-pagination flex-c-m trans-0-4">&raquo;</a>
											</c:otherwise>
										</c:choose>
									</div>
								</nav>
									</c:otherwise>
								</c:choose>
								
							</div>
							<div class="col-md-2"></div>
						</div>
					</section>
				</div>
			</div>
			
			
			<!-- 상품문의 -->
			<div id="proQna">
				<div class="proQna" style="text-align: center;">
					<div class="row p-t-66">
						<div class="col-md-2"></div>
						<div class="col-md-3 m-b-10"><h2 style="text-align: left;">상품문의(${q_qnaListCnt})</h2></div>
						<div class="col-md-3"></div>                                                            
						<div class="col-md-2 ">
							<button class="flex-c-m size2 bg1 bo-rad-23 hov1 m-text3 trans-0-4 m-r-30" style="background-color: black; height: 38px;" onclick="location.href='${path}/shop/product/pro_qna_write.do?pro_code=${pro_code}'">상품문의 작성하기</button>
						</div>
						<div class="col-md-2"></div>
					</div>
					
					<section class="bgwhite p-b-38">
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-8">
								<div class="container">
									<c:choose>
										<c:when test="${qna_count == 0}">
											<hr style="border-top-width: 2px;">
												작성된 상품문의가 없습니다.
											<hr style="border-top-width: 2px; padding-bottom: 30px;">
										</c:when>
										<c:otherwise>
											<table class="table table-hover">
												<thead>
													<tr>
														<th style="width: 50%; text-align: center;">제목</th>
														<th style="width: 20%; text-align: center;">아이디</th>
														<th style="width: 20%; text-align: center;">날짜</th>
														<th style="width: 10%; text-align: center;">조회수</th>
													</tr>
												</thead>
												<c:forEach var="row" items="${qna_list}">
													<c:if test="${row.board_show == 'N'}">
														<tr>
															<td><a href="${path}/shop/product/qna_detail.do?pro_code=${row.code}&board_idx=${row.board_idx}">${row.title}</a></td>
															<td>${row.member_id}</td>
															<td><fmt:formatDate value="${row.board_created_time}" pattern="yyyy-MM-dd"/></td>
															<td>${row.view_cnt}</td>
														</tr>
													</c:if>
												</c:forEach>
											</table>
											<nav>
												<div class="pagination flex-m flex-w p-t-26">
													<c:choose>
														<c:when test="${q_currentPage == 1}">
															<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${q_currentPage}#qna" class="item-pagination flex-c-m trans-0-4">&laquo;</a>
														</c:when>
														<c:otherwise>
															<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${q_currentPage-1}#qna" class="item-pagination flex-c-m trans-0-4">&laquo;</a>
														</c:otherwise>
													</c:choose>
													<c:forEach begin="${q_startBlock}" end="${q_endBlock}" var="i">
														<c:choose>
															<c:when test="${q_currentPage == i}">
																<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${i}#qna" class="item-pagination flex-c-m trans-0-4 active-pagination">${i}</a>
															</c:when>
															<c:otherwise>
																<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${i}#qna" class="item-pagination flex-c-m trans-0-4">${i}</a>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													<c:choose>
														<c:when test="${q_currentPage == q_totalPage}">
															<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${q_currentPage}#qna" class="item-pagination flex-c-m trans-0-4">&raquo;</a>
														</c:when>
														<c:otherwise>
															<a href="${path}/shop/product/product_detail.do?pro_code=${pro_code}&currentPage=${q_currentPage+1}#qna" class="item-pagination flex-c-m trans-0-4">&raquo;</a>
														</c:otherwise>
													</c:choose>
												</div>
											</nav>
										</c:otherwise>
									</c:choose>
									
								</div>
							</div>
						</div>
					</section>
				</div>
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



<!--===============================================================================================-->
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

	<script type="text/javascript">
		$('.block2-btn-addcart').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.block2-name').html();
			$(this).on('click', function(){
				var member_id = "${sessionScope.member_id}";							
				if(member_id != ""){
					swal(nameProduct, "선택하신 상품을 카트에 담았습니다.", "success");
				}else{
					alert("로그인 후 사용하세요.");
					return;
				}
			});
		});
	</script>
</body>
</html>
