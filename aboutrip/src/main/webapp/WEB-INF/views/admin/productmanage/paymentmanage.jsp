<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="body-container">
	<div class="body-main">
		<section class="login-dark"
			style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<form>
		
			<div>
				<div>구매 내역</div>
				<div>
					<table>
						<tr>
							<th>구매자</th>
							<th>주문총금액</th>
							<th>주문날짜</th>
							<th>결제상태</th>
							<th>비고</th>
						</tr>
						<tr>
							<td>주문상품</td>
							<td>주문옵션</td>
							<td>옵션금액</td>
							<td>결제상태</td>
							<td>비고</td>
						</tr>
						<c:forEach var="dto" items="${list}">
							<tr>
								<td>${dto.nickName}</td>
								<td>${dto.order_price}</td>
								<td>${dto.order_date}</td>
								<td>${dto.payment_key!=0?"결제완료":""}</td>
								<td></td>
							</tr>
							<c:forEach var="option" items="${options}">
								<c:if test="${option.order_num == dto.order_num}">
									<tr>
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
				</div>
			</div>
			</form>
		</section>
	</div>
</div>