<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/head.jsp" %>
</head>
<body>
<%@ include file="../include/header_menu.jsp" %>

<section class="order bgwhite p-t-70 p-b-100">
	<div class="container">
		<h2>주문완료</h2>
		<div class="m-b-15">
			<span class="col-md-9" style="margin-right: 700px;"></span>
			<span class="col-md-3" style="font-size: 1.4em;">
				<span style="color: gray;">
					01 카트 &gt; 02 주문/결제 &gt; 
				</span>
				<span style="color: OrangeRed;">
					03 주문완료
				</span>
			</span>
		</div>
		
		<!-- 대표상품 -->
		<div class="bo9 p-l-40 p-r-40 p-t-10 p-b-10 m-t-30 m-r-0 p-lr-15-sm" style="border-top-width: 2px; border-bottom-width: 2px; border-left-width: 0px; border-right-width: 0px;">
			<c:forEach var="row" items="${order_list}">
				<c:choose>
					<c:when test="${row.payment_method == 'ACCOUNT' }">
						<h5 class="text-center m-t-20" style="color: OrangeRed; font-weight:bold;">주문이 정상적으로 접수되었습니다.</h5>
						<table class="table table-bordered m-t-30">
							<tr>
								<td rowspan="3" style="width: 20%; text-align: center; padding-top: 50px; background-color: #EEEEEE;">주문번호<br>(${order_idx})</td>
								<td style="width: 20%;">주문상품</td>
								<td style="width: 60%;">
									<c:choose>
										<c:when test="${count == 1}">
											${order_form[0].product_name}
										</c:when>
										<c:otherwise>
											${order_form[0].product_name} 외 ${count -1}개 상품
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<td>총 결제 금액</td>
								<td><fmt:formatNumber value="${row.payment_price}" pattern="#,###" />원</td>
							</tr>
							<tr>
								<td>무통장입금</td>
								<td><fmt:formatNumber value="${row.payment_price}" pattern="#,###" />원</td>
							</tr>
						</table>
						
						<table class="table table-bordered m-t-10">
							<tr>
								<td style="width: 20%;">입금하실 금액</td>
								<td style="width: 80%;">
									<span style="color: OrangeRed; font-weight:bold;"><fmt:formatNumber value="${row.payment_price}" pattern="#,###" />원</span>
									(<fmt:formatDate value="${row.created_time}" pattern="yyyy-MM-dd HH:mm:ss"/> 까지)
								</td>
							</tr>
							<tr>
								<td style="width: 20%;">입금은행</td>
								<td style="width: 80%;">
									<c:if test="${row.payment_bank == 'kb'}">국민은행</c:if>
									<c:if test="${row.payment_bank == 'woori'}">우리은행</c:if>
									<c:if test="${row.payment_bank == 'nonghyup'}">농협</c:if>
									<c:if test="${row.payment_bank == 'shinhan'}">신한은행</c:if>
								</td>
							</tr>
							<tr>
								<td style="width: 20%;">입금계좌</td>
								<td style="width: 80%;">***(예금주: inssa(인싸))</td>
							</tr>
						</table>
					</c:when>
					<c:otherwise>
						<h5 class="text-center m-t-20" style="color: OrangeRed; font-weight:bold;">구매가 정상적으로 완료되었습니다.</h5>
						<table class="table table-bordered m-t-30">
							<tr>
								<td rowspan="3" style="width: 20%; text-align: center; padding-top: 50px; background-color: #EEEEEE;">주문번호<br>(${order_idx})</td>
								<td style="width: 20%;">주문상품</td>
								<td style="width: 60%;">
									<c:choose>
										<c:when test="${count == 1}">
											${order_form[0].product_name}
										</c:when>
										<c:otherwise>
											${order_form[0].product_name} 외 ${count -1}개 상품
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<td>총 결제 금액</td>
								<td><fmt:formatNumber value="${row.payment_price}" pattern="#,###" />원</td>
							</tr>
							<tr>
								<td>휴대폰 결제</td>
								<td><fmt:formatNumber value="${row.payment_price}" pattern="#,###" />원</td>
							</tr>
						</table>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
		</div>
		<div class="row m-t-30">
				<div class="col-md-2 p-l-0 p-r-0 m-l-15" style="margin-left: 380px;">
					<button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4" onclick="location.href='${path}/shop/order/buyList'" style="background-color:#E65540; height:40px; margin-top:4px;">
						구매내역 확인
					</button>
				</div>
				<div class="col-md-2 p-l-0 p-r-0 m-l-15">
					<button class="flex-c-m sizefull bg1 bo-rad-23 hov1 s-text1 trans-0-4"  onclick="location.href='${path}/'" style="background-color:#000000; height:40px; margin-top:4px;">
						쇼핑 계속하기
					</button>
				</div>
			</div>
	</div>
</section>	
<%@ include file="../include/footer.jsp" %>
<%@ include file="../include/body_footer.jsp" %>
</body>
</html>