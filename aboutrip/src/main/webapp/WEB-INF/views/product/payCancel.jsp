<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<form action="${pageContext.request.contextPath}/product/repund"
			method="post">
			<table style="width: 90%; margin: auto">
				<tr>
					<td>결제취소상품</td>
					<td>금액</td>
					<td>구매일자</td>
				</tr>
				<tr>
					<!-- productDetail, orders -->
					<td>${dto.option_name}</td>
					<td>${dto.price}</td>
					<td>${dto.order_date}</td>
				</tr>
				<tr>
					<td>취소 사유</td>
					<td colspan="2"><textarea name="reason" style="width:90%"
							placeholder="취소 사유를 적어주세요."></textarea></td>
				</tr>
				<tr>
					<td>수령계좌</td>
					<td colspan="2"><select name="refund_bank">
							<option value="04">KB국민은행</option>
							<option value="23">SC제일은행</option>
							<option value="39">경남은행</option>
							<option value="34">광주은행</option>
							<option value="03">기업은행</option>
							<option value="11">농협</option>
							<option value="31">대구은행</option>
							<option value="32">부산은행</option>
							<option value="02">산업은행</option>
							<option value="45">새마을금고</option>
							<option value="07">수협</option>
							<option value="88">신한은행</option>
							<option value="48">신협</option>
							<option value="05">외한은행</option>
							<option value="20">우리은행</option>
							<option value="71">우체국</option>
							<option value="90">카카오뱅크</option>
							<option value="89">케이뱅크</option>
					</select></td>
				</tr>
				<tr>
					<td>계좌번호</td>
					<td><input type="text" name="refund_account"></td>
				</tr>
				<tr>
					<td><input type="hidden" name="order_detail"
						value="${dto.order_detail}"> <input type="hidden"
						name="cancel_request_amount" value="${dto.price}">
						<button type="submit">환불하기</button></td>
					<td></td>
					<td>
						<button onclick="cancelPay()">이니페이 환불하기</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
</div>


<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<!-- jQuery CDN --->
<script>
	function cancelPay() {
		jQuery.ajax({
			"url" : "http://www.myservice.com/payments/cancel",
			"type" : "POST",
			"contentType" : "application/json",
			"data" : JSON.stringify({
				"merchant_uid" : "mid_" + new Date().getTime(), // 주문번호
				"cancel_request_amount" : 2000, // 환불금액
				"reason" : "테스트 결제 환불", // 환불사유
				"refund_holder" : "홍길동", // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
				"refund_bank" : "88", // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(ex. KG이니시스의 경우 신한은행은 88번)
				"refund_account" : "56211105948400" // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
			}),
			"dataType" : "json"
		});
	}
</script>