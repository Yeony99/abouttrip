<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<form method="post" name="paymentForm">
			<div class="body-main">
				<table class="table table-list" style="color: white;">
					<tr>
						<th width="100">주문번호</th>
						<th width="100">상품번호</th>
						<th width="100">상품이름</th>
						<th width="100">옵션이름</th>
						<th width="100">결제금액</th>
						<th width="100">사용유무</th>
						<th width="100">주문날짜</th>
						<th width="100">리뷰작성</th>
						<th width="100">제품상태</th>
					</tr>

					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.listNum}</td>
							<td>${dto.order_num}</td>
							<td><a
								href="${pageContext.request.contextPath}${dto.articleUrl}">${dto.product_name}</a></td>
							<td>${dto.option_name}</td>
							<td>${dto.final_price}</td>
							<td>${dto.isUsed==1?"미사용":"사용"}</td>
							<td>${dto.order_date}</td>
							<td><button type="button"
									onclick="location.href='${pageContext.request.contextPath}/product/rev_write?code=${dto.code}&order_detail=${dto.order_detail}';"
									${dto.review_num!="0" ? "disabled" : ""}>${dto.review_num=="0" ? "리뷰작성" : "작성완료"}</button></td>
							<td>${dto.repundKey==""?"결제완료":"결제취소완료"}
							</td>
					</c:forEach>
					<c:if test="${list==null}">
						<td width="100">구매한 내용이 없습니다.</td>
					</c:if>
				</table>
			</div>
		</form>
	</section>
</div>

