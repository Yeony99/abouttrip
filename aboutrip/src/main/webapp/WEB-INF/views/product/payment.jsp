<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	function inisis() {

		var email = document.getElementById('userId').value;
		var user_name = document.getElementById('userName').value;
		var tel = document.getElementById('tel').value;
		var addr = document.getElementById('address1').value;
		var zip = document.getElementById('zip').value;
		var payment_name = document.getElementById('payment_name').value;
		var final_price = document.getElementById('final_price').value;

		var IMP = window.IMP; // 생략가능
		IMP.init('imp06688185'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

		IMP.request_pay({
			pg : 'inicis', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : payment_name,
			amount : final_price,
			buyer_email : email,
			buyer_name : user_name,
			buyer_tel : tel,
			buyer_addr : addr,
			buyer_postcode : zip,
			m_redirect_url : 'http://localhost:9090/app/product/complete'
		}, function(rsp) {
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num;
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
		});
		location: href = "${pageContext.request.contextPath}/product/complete";
	}
</script>
<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<div>
			<form method="post" action="${pageContext.request.contextPath}/product/complete">
				<table>
					<tr>
						<th>상품명</th>
						<th>상품옵션</th>
						<th>상품금액</th>
						<th>수량</th>
						<th>주문금액</th>
					</tr>
					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.product_name}</td>
							<td>${dto.option_name}</td>
							<td>${dto.price}</td>
							<td>${dto.quantity}</td>
							<td>${dto.price * dto.quantity}</td>
						</tr>
					</c:forEach>
				</table>
				<div>배송지 정보</div>
				<input type="hidden" id="final_price" name="final_price"
					value="${final_price}"> <input type="hidden"
					id="payment_name" name="payment_name" value="${payment_name}">
				<table>
					<tr>
						<td>구매자 이름</td>
						<td><input type="text" id="userName" name="userName"
							value="${member.userName}"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="userId" name="userId"
							value="${member.userId}"></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" id="tel" name="tel"
							value="${member.tel}"></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" id="address1" name="address1"
							value="${member.address1}" readonly="readonly"></td>
					</tr>
					<tr>
						<td>우편번호</td>
						<td><input type="text" id="zip" name="zip"
							value="${member.zip}" readonly="readonly"></td>
					</tr>

				</table>
				<c:forEach var="cart" items="${carts}">
					<input type="hidden" name="carts" value="${cart}">
				</c:forEach>
				<button type="button" onclick="inisis()">결제하기(이니시스)</button>
				<button type="submit">결제하기</button>
			</form>
		</div>
	</section>
</div>