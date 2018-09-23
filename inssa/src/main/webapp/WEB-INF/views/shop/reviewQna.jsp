<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/head.jsp" %>
<style>
td{
 text-align: center;
 vertical-align: middle;
}
li{display:inline-block;zoom:1;*display:inline;}

</style>
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
		<div id="qnaList">
			<h2 class="text-left p-l-30 m-b-20">상품문의(${qnaList_count})</h2>
			<div class="container">
				<table class="table-shopping-cart">
					<tr class="table-head">
						<th style="width: 40%; text-align: center;">상품정보</th>
						<th style="width: 30%; text-align: center;">제목</th>
						<th style="width: 10%; text-align: center;">아이디</th>
						<th style="width: 10%; text-align: center;">날짜</th>
						<th style="width: 8%; text-align: center;">조회수</th>
					</tr>
					<c:choose>
						<c:when test="${qnaList_count == 0}">
							<tr>
								<td colspan="5" align="center"style="text-align: center;">작성된 상품문의가 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="row" items="${qnaList}">
								<c:if test="${row.board_show == 'N'}">
									<tr class="table-row">
										<td class="p-l-40" style="width: 40%; text-align: center;">
											<div class="row">
												<div>
													<img src="${row.thumb_img}" width="100px;">
												</div>
												<div class="p-l-20 p-t-40">
													${row.name}
												</div>
											</div>
										</td>
										<td style="width: 30%; text-align: center;">
											<a href="${path}/shop/product/qna_detail.do?pro_code=${row.code}&board_idx=${row.board_idx}">${row.title}</a>
										</td>
										<td style="width: 10%; text-align: center;">
											${row.member_id}
										</td>
										<td style="width: 10%; text-align: center;">
											<fmt:formatDate value="${row.board_modified_time}" pattern="yyyy-MM-dd"/>
										</td>
										<td style="width: 8%; text-align: center;">
											${row.view_cnt}
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-2"></div>
</div>


<%@ include file="../include/body_footer.jsp" %>
</body>
</html>