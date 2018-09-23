<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/head.jsp" %>
<title>Inssa</title>
<style>
.price {
	color: gray;
	font-size: 0.8em;
	text-decoration: line-through;
}
</style>
<script>
$(function(){
	$("#graphic_sticker").click(function(){
		var type = "GS";
		$.ajax({
			type: "post",
			url: "${path}/",
			data: {"type" : type},
			dataType: "json",
			success: function(result){
				for(var i=0; i<result.length; i++){
					$("img#thumb_img:eq("+i+")").remove();
					$("div.block2-overlay.trans-0-4:eq("+i+")").before("<img id='thumb_img' src='"+result[i].thumb_img+"' alt='IMG-PRODUCT'>");
					$("input#pid").val(result[i].idx);
					$("input#pro_code").val(result[i].code);
					$("input#arr").val("");
					$("span#pro_name").text(result[i].name);
					$("span.price").text(result[i].price);
					$("span.sale_price").text(result[i].sale_price);
				}
			}
		});
	});
	$("#art_frame").click(function(){
		var type = "AF";
		$.ajax({
			type: "post",
			url: "${path}/",
			data: {"type" : type},
			dataType: "json",
			success: function(result){
				for(var i=0; i<result.length; i++){
					$("img#thumb_img:eq("+i+")").remove();
					$("div.block2-overlay.trans-0-4:eq("+i+")").before("<img id='thumb_img' src='"+result[i].thumb_img+"' alt='IMG-PRODUCT'>");
					$("input#pid:eq("+i+")").val(result[i].idx);
					$("input#pro_code:eq("+i+")").val(result[i].code);
					$("input#arr:eq("+i+")").val("");
					$("span#pro_name:eq("+i+")").text(result[i].name);
					$("span.price:eq("+i+")").text(result[i].price);
					$("span.sale_price:eq("+i+")").text(result[i].sale_price);
				}
			}
		});
	});
	$("#art_poster").click(function(){
		var type = "AP";
		$.ajax({
			type: "post",
			url: "${path}/",
			data: {"type" : type},
			dataType: "json",
			success: function(result){
				for(var i=0; i<result.length; i++){
					$("img#thumb_img:eq("+i+")").remove();
					$("div.block2-overlay.trans-0-4:eq("+i+")").before("<img id='thumb_img' src='"+result[i].thumb_img+"' alt='IMG-PRODUCT'>");
					$("input#pid:eq("+i+")").val(result[i].idx);
					$("input#pro_code:eq("+i+")").val(result[i].code);
					$("input#arr:eq("+i+")").val("");
					$("span#pro_name:eq("+i+")").text(result[i].name);
					$("span.price:eq("+i+")").text(result[i].price);
					$("span.sale_price:eq("+i+")").text(result[i].sale_price);
				}
			}
		});
	});
	
	
	
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
							//console.log("insert success");
						}
					});
				}
			});
		}else{
			return;
		}
	});
});
</script>
</head>
<body>
<%@ include file="include/header_menu.jsp" %>

<!-- Slide -->
<section class="slide1 m-t-20">
	<div class="wrap-slick1">
		<div class="slick1">
			<div class="item-slick1 item1-slick1" style="background-image: url(${path}/image/main1.png);">
				<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
					<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="fadeInDown">
						그래픽스티커
					</span>

					<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="fadeInUp">
						Graphic Sticker
					</h2>

					<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="zoomIn">
						<a href="${path}/shop/product/product_detail.do?pro_code=10003" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
							바로가기
						</a>
					</div>
				</div>
			</div>

			<div class="item-slick1 item2-slick1" style="background-image: url(${path}/image/main2.png);">
				<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
					<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="rollIn">
						아트프레임
					</span>

					<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="lightSpeedIn">
						Art Frame
					</h2>

					<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="slideInUp">
						<a href="${path}/shop/product/product_detail.do?pro_code=10263" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
							바로가기
						</a>
					</div>
				</div>
			</div>

			<div class="item-slick1 item3-slick1" style="background-image: url(${path}/image/main3.png);">
				<div class="wrap-content-slide1 sizefull flex-col-c-m p-l-15 p-r-15 p-t-150 p-b-170">
					<span class="caption1-slide1 m-text1 t-center animated visible-false m-b-15" data-appear="rotateInDownLeft">
						아트포스터
					</span>

					<h2 class="caption2-slide1 xl-text1 t-center animated visible-false m-b-37" data-appear="rotateInUpRight">
						Art Poster
					</h2>

					<div class="wrap-btn-slide1 w-size1 animated visible-false" data-appear="rotateIn">
						<a href="${path}/shop/product/product_detail.do?pro_code=10395" class="flex-c-m size2 bo-rad-23 s-text2 bgwhite hov1 trans-0-4">
							바로가기
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>



<!-- Our product -->
<section class="bgwhite p-t-45 p-b-58">
	<div class="container">
		<div class="sec-title p-b-22">
			<h3 class="m-text5 t-center">
				Our Products
			</h3>
		</div>
		
		<div class="tab01">
			<ul class="nav nav-tabs" role="tablist">
				<li class="nav-item">
					<a class="nav-link active" id="graphic_sticker" data-toggle="tab" href="#best-seller" role="tab">Graphic Sticker</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="art_frame" data-toggle="tab" href="#featured" role="tab">Art Frame</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="art_poster" data-toggle="tab" href="#sale" role="tab">Art Poster</a>
				</li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content p-t-35">
				<div class="tab-pane fade show active" id="best-seller" role="tabpanel">
					<div class="row">
						<c:forEach var="row" items="${main_best}">
							<div class="col-sm-6 col-md-4 col-lg-3 p-b-50">
								<div class="block2">
									<div class="block2-img wrap-pic-w of-hidden pos-relative">
										<img id="thumb_img" src="${row.thumb_img}" alt="IMG-PRODUCT">
	
										<div class="block2-overlay trans-0-4">
											<div class="block2-btn-addcart w-size1 trans-0-4">
												<button id="btnAddCart" class="flex-c-m size1 bg4 bo-rad-23 hov1 s-text1 trans-0-4">
													장바구니 담기
												</button>
											</div>
										</div>
									</div>
	
									<div class="block2-txt p-t-20">
										<input type="hidden" id="pid" name="pid" value="${row.idx}">
										<input type="hidden" id="pro_code" name="pro_code" value="${row.code}">
										<input type="hidden" id="arr" name="arr" value="">
										
										<div style="text-align: center;">
											<a href="${path}/shop/product/product_detail.do?pro_code=${row.code}" class="block2-name dis-block s-text3 p-b-5">
												<span id="pro_name">${row.name}</span>
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
				</div>
			</div>
		</div>
	</div>
</section>


<%@ include file="include/footer.jsp" %>

<!-- Back to top -->
<div class="btn-back-to-top bg0-hov" id="myBtn">
	<span class="symbol-btn-back-to-top">
		<i class="fa fa-angle-double-up" aria-hidden="true"></i>
	</span>
</div>

<!-- Container Selection -->
<div id="dropDownSelect1"></div>
<div id="dropDownSelect2"></div>


<%@ include file="include/body_footer.jsp" %>

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
	/* 로그인시 카트에 담을수있도록 */
	$('.block2-btn-addcart').each(function(){
		var nameProduct = $(this).parent().parent().parent().find('.block2-name span#pro_name').html();
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