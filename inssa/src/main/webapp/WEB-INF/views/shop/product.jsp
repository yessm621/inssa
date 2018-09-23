<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Product</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="../include/head.jsp" %>
	<script>
		$(document).on('click', 'li.p-t-4 a', function(){
			var idx = $(this).index('li.p-t-4 a');
			console.log(idx);
			console.log($("li.p-t-4 a:eq("+idx+")").text());
			//$("li.p-t-4 a").removeClass("s-text13 active1");
			$("li.p-t-4 a:eq("+idx+")").removeClass("s-text13");
			$("li.p-t-4 a:eq("+idx+")").addClass("s-text13 active1");
		});
		$(function(){
			$("#btnSearch").click(function(){
				var subcate = $("#subcate").val();
			    if(subcate === undefined){
			    	subcate = "";
			    }
			    document.form1.action="${path}/shop/product/product.do?cate=${cate}&subcate="+subcate;
			    document.form1.submit();
			});
			
			$(document).on('click', 'button#btnAddCart.flex-c-m.size1.bg4.bo-rad-23.hov1.s-text1.trans-0-4', function(){
				var idx = $(this).index('button#btnAddCart.flex-c-m.size1.bg4.bo-rad-23.hov1.s-text1.trans-0-4');
				console.log("idx::"+idx);
				var pro_code = $("input#pro_code:eq("+idx+")").val();
				console.log("pro_code::"+pro_code);
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
		function select_sorting(){
		    var subcate = $("#subcate").val();
		    if(subcate === undefined){
		    	subcate = "";
		    }
		    document.form1.action="${path}/shop/product/product.do?cate=${cate}&subcate="+subcate;
		    document.form1.submit();
		}
	</script>
	<style>
		.price {
			color: gray;
			font-size: 0.8em;
			text-decoration: line-through;
		}
		h1 {
			text-shadow: -1px 0 blue, 0 1px blue, 1px 0 blue, 0 -1px blue;
		}
	</style>
<script>
$(function(){
	var cate = $("#cate").val();
	if(cate == "GS"){
		jQuery('#bg_img').css({"background-image":"url(${path}/image/11.png)"});
		jQuery('#main_title').css({"color":"black"});
		jQuery('#sub_title').css({"color":"black"});
	}else if(cate == "AF"){
		jQuery('#bg_img').css({"background-image":"url(${path}/image/22.png)"});
		jQuery('#main_title').css({"color":"black"});
		jQuery('#sub_title').css({"color":"black"});
	}else if(cate == "AP"){
		jQuery('#bg_img').css({"background-image":"url(${path}/image/33.png)"});
		jQuery('#main_title').css({"color":"black"});
		jQuery('#sub_title').css({"color":"black"});
	}
});
</script>
</head>
<body class="animsition">
<%@ include file="../include/header_menu.jsp" %>
	
<!-- Title Page -->
<section id="bg_img" class="bg-title-page p-t-50 p-b-40 flex-col-c-m">
	<h2 id="main_title" class="l-text2 t-center">
	<input type="hidden" id="cate" name="cate" value="${cate}">
		<c:choose>
			<c:when test="${cate == 'GS'}">
				Graphic Sticker
			</c:when>
			<c:when test="${cate == 'AF'}">
				Art Frame
			</c:when>
			<c:when test="${cate == 'AP'}">
				Art Poster
			</c:when>
		</c:choose>
	</h2>
	<!-- <p class="m-text13 t-center"> -->
	<p id="sub_title" style="text-align: center; font-size: 1em; font-weight: bold;">
		<c:choose>
			<c:when test="${cate == 'GS'}">
				감각적인 디자인으로 분위기에 따른 멋스러운 인테리어 연출
			</c:when>
			<c:when test="${cate == 'AF'}">
				다양한 프레임을 통한 멋스러운 인테리어 연출
			</c:when>
			<c:when test="${cate == 'AP'}">
				벽에 세워놓기만 해도 멋스러운 인테리어 소품
			</c:when>
		</c:choose>
	</p>
</section>

<!-- Content page -->
<section class="bgwhite p-t-55 p-b-65">
	<div class="container">
		<div class="row">
		
			<!-- 하위 카테고리 -->
			<div class="col-sm-6 col-md-4 col-lg-3 p-b-50">
				<div class="leftbar p-r-20 p-r-0-sm">
					<h3 class="m-text14 p-b-7">카테고리</h3>

					<ul class="p-b-54">
						<c:choose>
							<c:when test="${empty subcate}">
								<li class="p-t-4">
									<a href="${path}/shop/product/product.do?cate=${cate}" class="s-text13 active1">
										All
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="p-t-4">
									<a href="${path}/shop/product/product.do?cate=${cate}" class="s-text13">
										All
									</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="row" items="${category}">
							<c:choose>
								<c:when test="${row.middle_code == subcate}">
									<li class="p-t-4">
										<input type="hidden" id="subcate" name="subcate" value="${row.middle_code}">
										<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${row.middle_code}"  class="s-text13 active1">${row.middle_name}</a>
									<li>
								</c:when>
								<c:otherwise>
									<li class="p-t-4">
										<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${row.middle_code}"  class="s-text13">${row.middle_name}</a>
									<li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="col-sm-6 col-md-8 col-lg-9 p-b-50">
				<div class="flex-sb-m flex-w p-b-35">
				
					<form name="form1" method="post">
						<div class="flex-w">
							<!-- 정렬 -->
							<div class="rs2-select2 bo4 of-hidden w-size12 m-t-5 m-b-5 m-r-10">
								<select class="selection-2" id="sorting" name="sorting" onchange="select_sorting()">
									<c:choose>
										<c:when test="${sorting == 'saleOrder'}">
											<option value="all">신상품순</option>
											<option value="saleOrder" selected>판매순</option>
											<option value="highPriceOrder">높은가격순</option>
											<option value="lowPriceOrder">낮은가격순</option>
										</c:when>
										<c:when test="${sorting == 'highPriceOrder'}">
											<option value="all">신상품순</option>
											<option value="saleOrder">판매순</option>
											<option value="highPriceOrder" selected>높은가격순</option>
											<option value="lowPriceOrder">낮은가격순</option>
										</c:when>
										<c:when test="${sorting == 'lowPriceOrder'}">
											<option value="all">신상품순</option>
											<option value="saleOrder">판매순</option>
											<option value="highPriceOrder">높은가격순</option>
											<option value="lowPriceOrder" selected>낮은가격순</option>
										</c:when>
										<c:otherwise>
											<option value="all" selected>신상품순</option>
											<option value="saleOrder">판매순</option>
											<option value="highPriceOrder">높은가격순</option>
											<option value="lowPriceOrder">낮은가격순</option>
										</c:otherwise>
									</c:choose>
								</select>
							</div>
							<!-- 상품검색 -->
							<div class="search-product pos-relative bo4 of-hidden w-size12 m-t-5 m-b-5 m-r-10">
								<input class="s-text6 size2 p-l-23 p-r-50" type="text" id="search_product" name="search_product" placeholder="검색어를 입력하세요." value="${search_product}">
								<button id="btnSearch" class="flex-c-m size5 ab-r-m color2 color0-hov trans-0-4">
									<i class="fs-12 fa fa-search" aria-hidden="true"></i>
								</button>
							</div>
						</div>
					</form>
								
					<!-- 상품개수 -->
					<span class="s-text8 p-t-5 p-b-5">
						<c:choose>
							<c:when test="${currentPage == totalPage}">
								${startRow} – ${listCnt} / ${listCnt} 건
							</c:when>
							<c:otherwise>
								${startRow} – ${endRow} / ${listCnt} 건
							</c:otherwise>
						</c:choose>
					</span>
				</div>

				<!-- 상품리스트 -->
				<div class="row">
					<c:forEach var="row" items="${list}">
						<div class="col-sm-12 col-md-6 col-lg-4 p-b-50">
							<!-- Block2 -->
							<div class="block2">
								<div class="block2-img wrap-pic-w of-hidden pos-relative">
									<img src="${row.thumb_img}" alt="IMG-PRODUCT">
									
									<div class="block2-overlay trans-0-4">
										<!-- 장바구니에 담기 -->
										<div class="block2-btn-addcart w-size1 trans-0-4">
											<!-- Button -->
											<button id="btnAddCart" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
												장바구니에 담기
											</button>
										</div>
									</div>
								</div>
								
								<!-- 상품기본정보 -->
								<div class="block2-txt p-t-20">
									<input type="hidden" id="pid" name="pid" value="${row.idx}">
									<input type="hidden" id="pro_code" name="pro_code" value="${row.code}">
									<input type="hidden" id="detail_img" name="detail_img" value="${row.detail_img}">
									<input type="hidden" id="arr" name="arr" value="">
									
									<div style="text-align: center;">
										<a href="${path}/shop/product/product_detail.do?pro_code=${row.code}" class="block2-name dis-block s-text3 p-b-5">
											${row.name}
										</a>
									</div>
									<div style="text-align: right;">
										<span class="block2-price m-text6 p-r-5 m-r-20">
											<span class="price"><fmt:formatNumber value="${row.price}" pattern="#,###" />원</span>&nbsp;->&nbsp;
											<span class="sale_price"><fmt:formatNumber value="${row.sale_price}" pattern="#,###" />원</span>
										</span>
									</div>
									
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				
				<!-- 페이징처리 -->
				<div class="pagination flex-m flex-w p-t-26">
					<c:choose>
						<c:when test="${currentPage == 1}">
							<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}&currentPage=${currentPage}&sorting=${sorting}&search_product=${search_product}" class="item-pagination flex-c-m trans-0-4">&laquo;</a>
						</c:when>
						<c:otherwise>
							<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}&currentPage=${currentPage-1}&sorting=${sorting}&search_product=${search_product}" class="item-pagination flex-c-m trans-0-4">&laquo;</a>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${startBlock}" end="${endBlock}" var="i">
						<c:choose>
							<c:when test="${currentPage == i}">
								<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}&currentPage=${i}&sorting=${sorting}&search_product=${search_product}" class="item-pagination flex-c-m trans-0-4 active-pagination">${i}</a>
							</c:when>
							<c:otherwise>
								<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}&currentPage=${i}&sorting=${sorting}&search_product=${search_product}" class="item-pagination flex-c-m trans-0-4">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${currentPage == totalPage}">
							<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}&currentPage=${currentPage}&sorting=${sorting}&search_product=${search_product}" class="item-pagination flex-c-m trans-0-4">&raquo;</a>
						</c:when>
						<c:otherwise>
							<a href="${path}/shop/product/product.do?cate=${cate}&subcate=${subcate}&currentPage=${currentPage+1}&sorting=${sorting}&search_product=${search_product}" class="item-pagination flex-c-m trans-0-4">&raquo;</a>
						</c:otherwise>
					</c:choose>
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
<!--===============================================================================================-->
	<script type="text/javascript" src="${path}/vendor/daterangepicker/moment.min.js"></script>
	<script type="text/javascript" src="${path}/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->

	
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

<!--===============================================================================================-->
	<script type="text/javascript" src="${path}/vendor/noui/nouislider.min.js"></script>
	<script type="text/javascript">
		/*[ No ui ]
	    ===========================================================*/
	    var filterBar = document.getElementById('filter-bar');

	    noUiSlider.create(filterBar, {
	        start: [ 50, 200 ],
	        connect: true,
	        range: {
	            'min': 50,
	            'max': 200
	        }
	    });

	    var skipValues = [
	    document.getElementById('value-lower'),
	    document.getElementById('value-upper')
	    ];

	    filterBar.noUiSlider.on('update', function( values, handle ) {
	        skipValues[handle].innerHTML = Math.round(values[handle]) ;
	    });
	</script>
<!--===============================================================================================-->
	

</body>
</html>
