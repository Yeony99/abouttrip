<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style type="text/css">
.allDataCount {
	width: 100%;
	margin: 20px auto 0px;
	border-spacing: 0px;
	border-bottom: 1.5px solid #111;
	font-size: small;
	padding-bottom: 5px;
}

.selectField {
	height: 45px;
	padding-left: 20px;
	padding-right: 50px;
	border: 1px solid #ddd;
	color: #888888;
	font-size: 15px;
	float: left;
	margin-right: 5px;
	margin-left: 250px;
	margin-top: 53px;
}

.boxTFdiv {
	float: left;
	margin-top: 53px;
	height: 47px;
}

.boxTF {
	width: 425px;
	height: 43px;
	padding-left: 15px;
	border: 1px solid #ddd;
	color: #888888;
	float: left;
	margin-right: 5px;
}

.btnSearch {
	width: 43px;
	height: 43px;
	background-color: white;
	border: 1px solid #ddd;
	cursor: pointer;
}

.btnCreate {
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-left: 1040px;
	margin-bottom: 30px;
}

.btnDelete {
	width: 50px;
	height: 30px;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 10px;
	cursor: pointer;
}

.tabmenu {
	padding: 30px;
	font-size: large;
	width: 25%;
	text-align: center;
}
</style>

<script>

</script>
<div class="body-container">
	<div class="body-main">
		<table style="width: 100%">
			<tr>
				<td style="width: 50%; height: 500px;" rowspan="2"><img
					class="box-img"
					src="${pageContext.request.contextPath}/resources/img/img/${dto.img_name}"
					alt="${dto.product_name}" title="${dto.product_name}"
					style="width: 100%; height: 100%; object-fit: cover;"></td>
				<td>
					<div style="font-size: 35px; text-align: center;">${dto.product_name}</div>
					<div
						style="margin-top: 2rem; margin-right: 30px; text-align: right; font-size: 30px; color: skyblue; font-weight: 600;">${dto.price}원</div>
				</td>
			</tr>
			<tr>
				<td style="background-color: aliceblue; padding: 20px;">
					<div style="font-size: 1.0rem; margin-bottom: 10px;">꼭 읽어보세요
						!</div>
					<div>
						<ul>
							<li style="font-size: 0.8rem;">일반 입장권의 경우 유효기간 : 구매후 30일</li>
							<li style="font-size: 0.8rem;">렌터카 및 자가운전자만 가능합니다.</li>
							<li style="font-size: 0.8rem;">(단체 관광 및 운전기사, 가이드등반, 렌터카
								기사대여,<br> 택시 가이드 이용시 사용이 불가합니다.)
							</li>
						</ul>
					</div>
				</td>
			</tr>
		</table>

		<table style="width: 100%; background-color: skyblue;">
			<tr class="tab">
				<td data-tab="tab1" class="tabmenu" id="defaultMenu"><a
					style="text-decoration: none; color: black;" href="#detail">상세정보</a></td>
				<td data-tab="tab2" class="tabmenu"><a
					style="text-decoration: none; color: black;" href="#review">리뷰</a></td>
				<td data-tab="tab3" class="tabmenu"><a
					style="text-decoration: none; color: black;" href="#qna">Q&A</a></td>
				<td data-tab="tab4" class="tabmenu"><a
					style="text-decoration: none; color: black;" href="#refund">반품/교환정보</a></td>
			</tr>
		</table>

		<div id="tabcontent"></div>
		<div style="background-color: aliceblue;">

			<div id="detail">상품정보</div>
			${dto.product_detail}
			<div id="review">리뷰</div>
<%-- 			<jsp:include page="/WEB-INF/views/booking/review.jsp" />
 --%>
			<div id="qna">Q&A</div>
<%-- 			<jsp:include page="/WEB-INF/views/booking/qna.jsp" />
 --%>
			<div id="refund">반품/교환정보</div>

		</div>
	</div>
	<form name="code" method="post">
		<input type="hidden" name="code" value="${dto.code}">
	</form>
</div>
