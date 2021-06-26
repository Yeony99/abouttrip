<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="body-container">
	<div class="body-main">
		<section class="clean-block clean-hero"
			style="min-height:400px; background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju_tour1.jpg&quot;);color: rgba(100, 100, 255, 0.1);">
			<div class="text">
				<h2 style="font-size: 55px; color: skyblue; font-weight: bold">ABOUTRIP</h2>
				<br>
				<h6 style="font-size: 26px; color: white; font-weight: 600">구매내역관리
					페이지 입니다.</h6>
			</div>
		</section>
		<div class="body-main"
			style="background: rgb(194, 231, 245); box-shadow: 0px 0px 15px rgb(0 0 0/ 40%);">
		</div>
		<div class="body-main">
			<div id="main-container"
				style="background-color: rgb(240, 240, 240); padding: 30px 50px">
				<div class="body-title">
					<h2>구매내역 관리</h2>
					<div>
						<table class="table table-list">
							<tr
								style="font-size: 23px; background-color: rgb(220, 220, 220);">
								<th>구매자</th>
								<th>주문총금액</th>
								<th>주문날짜</th>
								<th>결제상태</th>
								<th>비고</th>
							</tr>
							<tr
								style="font-size: 17px; color: gray; background-color: rgb(220, 220, 220);">
								<th>주문상품</th>
								<th>주문옵션</th>
								<th>옵션금액</th>
								<th>결제상태</th>
								<th>비고</th>
							</tr>
							<c:forEach var="dto" items="${list}">
								<tr style="font-size: 23px">
									<td>${dto.nickName}</td>
									<td>${dto.order_price}</td>
									<td>${dto.order_date}</td>
									<td>${dto.payment_key!=0?"결제완료":""}</td>
									<td></td>
								</tr>
								<c:forEach var="option" items="${options}">
									<c:if test="${option.order_num == dto.order_num}">
										<tr style="font-size: 17px; color: gray;">
											<td>${option.product_name}</td>
											<td>${option.option_name}</td>
											<td>${option.price}</td>
											<td>${option.repund_Key!=0?"취소완료":""}</td>
											<td><c:if test="${option.repund_Key!=0}">취소일자 : ${option.repund_date}</c:if></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:forEach>
						</table>
						<table class="table">
							<tr>
								<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>