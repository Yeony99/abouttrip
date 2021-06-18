<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div>
	<form id="" method="post">
		<table>
			<tr>
				<th>상품명</th>
				<th>상품정보</th>
				<th>상품금액</th>
				<th>수량</th>
				<th>주문금액</th>
			</tr>
			<%-- 		<c:forEach var="dto" items="list">
			<tr>
				<td>${dto.product_name}</td>
				<td>${dto.option_name}</td>
				<td>${dto.price}</td>
				<td>${dto.quantity}</td>
				<td>${dto.price * dto.quantity}</td>
			</tr>
		</c:forEach> --%>
		</table>
		<div>배송지 정보</div>
		<table>
			<tr>
				<td>구매자 이름</td>
				<td><input type="text" name="user_name"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="userId"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="tel"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="address1"></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input type="text" name="zip"></td>
			</tr>
		</table>
		<button type="button" onclick="">결제하기</button>
	</form>
</div>