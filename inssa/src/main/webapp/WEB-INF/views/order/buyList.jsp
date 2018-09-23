<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/head.jsp" %>
<script>
$(function(){
	$(document).on('click', 'button#btnDelete.flex-c-m.sizefull.bg1.bo-rad-23.hov1.s-text1.trans-0-4', function(){
		if(confirm("구매를 취소하시겠습니까?")){
			var index = $(this).index('button#btnDelete.flex-c-m.sizefull.bg1.bo-rad-23.hov1.s-text1.trans-0-4');
			var idx = $("input#idx:eq("+index+")").val();
			$.ajax({
				type: "get",
				url: "${path}/shop/order/buyDel.do?idx="+idx,
				success: function(){
					alert("구매를 취소하였습니다.");
					location.reload();
				}
			});
		}
	});
});
function btnReview(product_code){
	if(confirm("구매후기를 작성하시겠습니까?")){
		document.location.href="${path}/shop/product/pro_review_write.do?pro_code="+product_code;
	}else{
		return;
	}
};
</script>
</head>
<body>
<%@ include file="../include/header_menu.jsp" %>
	
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-8">
		<div class="row m-b-20">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<div class="row p-l-20">
					<div>
						<button type="button" onclick="location.href='${path}/shop/order/buyList'" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="width:80px; height:35px;">
							구매내역
						</button>
					</div>
					<div class="m-l-30">
						<button type="button" onclick="location.href='${path}/shop/product/reviewQna'" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="width:80px; height:35px;">
							문의
						</button>
					</div>
					<div class="m-l-30">
						<button type="button" onclick="location.href='${path}/member/mypage'" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="width:80px; height:35px;">
							개인정보
						</button>
					</div>
				</div>
			</div>
			<div class="col-md-4"></div>
		</div>
		<div id="buyList">
			<h2 class="text-center">구매내역</h2>
			
			<hr style="border-top-width: 2px; padding-top: 10px;">
			
			<table class="table-shopping-cart">
				<tr class="table-head row">
					<th class="col-md-2" style="text-align: center;">주문정보</th>
					<th class="col-md-5" style="text-align: center;">구매내역</th>
					<th class="col-md-3" style="text-align: center;">유효기간/배송상태</th>
					<th class="col-md-2" style="text-align: center;">관리</th>
				</tr>
				<c:forEach var="row" items="${buy_list}">
					<c:choose>
						<c:when test="${row.del == 'Y'}">
							<tr class="table-row row del">
								<td class="col-md-2" style="text-align: center;">
									<input type="hidden" id="idx" value="${row.idx}">
									<input type="hidden" id="product_code" value="${row.product_code}">
									<div class="created_time" style="font-size: 0.8em;">
										<strong><fmt:formatDate value="${row.created_time}" pattern="yyyy-MM-dd"/></strong>
										<br>
										<span style="font-size: 0.9em;">(<fmt:formatDate value="${row.created_time}" pattern="hh:mm:ss"/>)</span>
									</div>
									<div class="idx m-t-10" style="font-size: 0.8em;">
										주문번호
										<br>
										<strong>${row.idx}</strong>
									</div>
									<hr>
									<div class="payment_price" style="font-size: 0.8em;">
										총 주문 금액
										<br>
										<span style="font-size: 1.3em; color: OrangeRed;">
											<strong><fmt:formatNumber value="${row.payment_price}" pattern="#,###" /></strong>원
										</span>
									</div>
								</td>
								<td class="col-md-5">
									<c:forEach var="row_detail" items="${buy_detail_list}">
										<c:if test="${row.idx == row_detail.order_idx}">
											<div class="row p-l-20">
												<div class="thumb_img">
													<img src="${row_detail.thumb_img}" height="70px">
												</div>
												<div class="product p-l-20">
													<div class="product_name">
														<a href="${path}/shop/product/product_detail.do?pro_code=${row_detail.product_code}">
															<strong>${row_detail.product_name}</strong>
														</a>
													</div>
													<div class="product_price">
														<span style="color: OrangeRed;">
															<strong><fmt:formatNumber value="${row_detail.product_price}" pattern="#,###" /></strong>원
														</span>
														<span style="font-size: 0.8em;">
															(구매취소)
														</span>
													</div>
												</div>
											</div>
											<div class="m-t-10 p-l-20" style="background-color: #ebedef; font-size: 0.9em;">
												<div class="product_option">
													<strong>${row_detail.product_color}</strong>
												</div>
												<div class="product_amount" style="font-size: 0.8em;">
													(구매수량 <span style="color: OrangeRed;">${row_detail.product_amount}</span> 개     
													취소환불 <span style="color: OrangeRed;">${row_detail.product_amount}</span> 개)
												</div>
											</div>
											<hr>
										</c:if>
									</c:forEach>
									<div class="row p-l-20">
										<div class="shipping" style="font-size: 0.8em;">
											<strong>배송지 정보: </strong>
											${row.recipient},
											${row.shipping_addr} ${row.shipping_detail_addr}
										</div>
									</div>
								</td>
								<td class="col-md-3" style="text-align: center;"></td>
								<td class="col-md-2" style="text-align: center; font-size: 0.8em;">
									환불완료
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr class="table-row row">
								<td class="col-md-2" style="text-align: center;">
									<input type="hidden" id="idx" value="${row.idx}">
									<div class="created_time" style="font-size: 0.8em;">
										<strong><fmt:formatDate value="${row.created_time}" pattern="yyyy-MM-dd"/></strong>
										<br>
										<span style="font-size: 0.9em;">(<fmt:formatDate value="${row.created_time}" pattern="hh:mm:ss"/>)</span>
									</div>
									<div class="idx m-t-10" style="font-size: 0.8em;">
										주문번호
										<br>
										<strong>${row.idx}</strong>
									</div>
									<hr>
									<div class="payment_price" style="font-size: 0.8em;">
										총 주문 금액
										<br>
										<span style="font-size: 1.3em; color: OrangeRed;">
											<strong><fmt:formatNumber value="${row.payment_price}" pattern="#,###" /></strong>원
										</span>
									</div>
								</td>
								<td class="col-md-5">
									<c:forEach var="row_detail" items="${buy_detail_list}">
										<c:if test="${row.idx == row_detail.order_idx}">
											<div class="row p-l-20">
												<div class="thumb_img">
													<img src="${row_detail.thumb_img}" height="70px">
												</div>
												<div class="product p-l-20">
													<div class="product_name">
														<a href="${path}/shop/product/product_detail.do?pro_code=${row_detail.product_code}">
															<strong>${row_detail.product_name}</strong>
														</a>
													</div>
													<div class="product_price">
														<span style="color: OrangeRed;">
															<strong><fmt:formatNumber value="${row_detail.product_price}" pattern="#,###" /></strong>원
														</span>
														<span style="font-size: 0.8em;">
															<c:choose>
																<c:when test="${row.payment_method == 'ACCOUNT'}">
																	(입금대기)
																</c:when>
																<c:otherwise>
																	(결제완료)
																</c:otherwise>
															</c:choose>
														</span>
													</div>
													<div>
														<input type="hidden" id="product_code" value="${row_detail.product_code}">
														<button id="btnReview" class="flex-c-m bg1 bo-rad-23 hov1 s-text1 trans-0-4" onclick="btnReview(${row_detail.product_code});">
															<span class="m-t-3 m-b-3 m-l-8 m-r-8" style="font-size: 0.8em;">구매후기 작성</span>
														</button>
													</div>
												</div>
												
											</div>
											<div class="m-t-10 p-l-20" style="background-color: #ebedef; font-size: 0.9em;">
												<div class="product_option">
													<strong>${row_detail.product_color}</strong>
												</div>
												<div class="product_amount" style="font-size: 0.8em;">
													(구매수량 <span style="color: OrangeRed;">${row_detail.product_amount}</span> 개)
												</div>
											</div>
											<hr>
										</c:if>
									</c:forEach>
									
									<div class="row p-l-20">
										<div class="shipping" style="font-size: 0.8em;">
											<strong>배송지 정보: </strong>
											${row.recipient},
											${row.shipping_addr} ${row.shipping_detail_addr}
										</div>
									</div>
								</td>
								<td class="col-md-3" style="text-align: center;">
									<c:choose>
										<c:when test="${row.payment_method == 'ACCOUNT'}">
											<span style="font-size: 0.8em; color: gray;">무통장입금 후<br>[입금완료]반영까지<br>10분정도 소요</span>
										</c:when>
										<c:otherwise>
											<span style="color: OrangeRed;"><strong>구매완료</strong></span>
										</c:otherwise>
									</c:choose>
								</td>
								<td class="col-md-2">
									<c:choose>
										<c:when test="${row.payment_method == 'ACCOUNT'}">
											<button type="button" id="btnDelete" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color: #8192ca; height:45px;">
												구매취소
											</button>
											<button type="button" id="btnReview" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color: #E65540; height:45px; display: none;">
												구매후기 쓰기
											</button>
										</c:when>
										<c:otherwise>
											<button type="button" id="btnDelete" class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" style="background-color: #8192ca; height:45px; display: none;">
												구매취소
											</button>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="col-md-2"></div>
</div>
<%@ include file="../include/footer.jsp" %>
<%@ include file="../include/body_footer.jsp" %>
</body>

<style>
.table-row.row.del{
	-webkit-filter: grayscale(100%);
	filter: gray;
}
</style>
</html>

