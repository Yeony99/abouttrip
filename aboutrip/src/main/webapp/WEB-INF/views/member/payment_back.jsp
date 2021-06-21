<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="body-container">        
        <section class="payment-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post" name="paymentForm">
               <div class="body-main">
		<table class="table table-list" style="color:white;">
			<tr> 
				<th width="100">번호</th>
				<th width="100">카드이름</th>
				<th width="200">카드넘버</th>
				<th width="100">등록일</th>
				<th width="100">삭제</th>
			</tr>
		 
			<c:forEach var="dto" items="${list}">
			<tr> 
				<td>${dto.cardNum}</td>
				<td>${dto.cardName}</td>
				<td>${dto.paymentCode}</td>
				<td>${dto.created_date}</td>
				<td><a class="nav-link" href="${pageContext.request.contextPath}/member/deletePayment?paymentCode=${dto.paymentCode}">카드삭제</a></td>
			</tr>
			</c:forEach>
			<c:if test="${list==null}">
				<td width="100">No card</td>
			</c:if>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td align="right" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/member/payCreated';" style="color:white; background-color: skyblue;">카드추가</button>
				</td>
			</tr>
		</table>
	</div>
              
            </form>
        </section>
</div>