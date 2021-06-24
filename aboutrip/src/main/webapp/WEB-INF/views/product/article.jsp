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

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
	function printprice() {
		var opt = document.getElementById("options");
		var optVal = opt.options[opt.selectedIndex].value;
		var optId = opt.options[opt.selectedIndex].id;

		var price = document.getElementById("price");
		var detail_num = document.getElementById("detail_num");

		price.value = optVal;
		detail_num.value = optId;

	}

	function mycart() {
		var d = document.productForm;
		var choice = d.choice.value;
		if (confirm("장바구니로 이동하시겠습니까?") == true) {
			d.choice.value = 1;
		}
		d.action = "${pageContext.request.contextPath}/product/carting";
		d.submit();
	}
	function inputqna() {
		var d = document.qnaForm;

		d.action = "${pageContext.request.contextPath}/product/qnasubmit";
		d.submit();
	}
</script>

<div class="body-container">
	<form name="productForm" method="post">
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
						<div class="selectbox">
							<div
								style="margin-top: 2rem; margin-right: 30px; text-align: right; font-size: 30px; color: skyblue; font-weight: 600;">
								<input type="text" id="price" readonly="readonly">원
							</div>
							<select name="options" id="options" onchange="printprice()">
								<option value="">선택</option>
								<c:forEach var="item" items="${options}">
									<option id="${item.detail_num}" value="${item.price}">${item.option_name}
										[${item.price}원]</option>
								</c:forEach>
							</select> <input type="hidden" id="detail_num" name="detail_num"
								value="${item.detail_num}"> <input type="hidden"
								name="choice" value="0"> <input type="hidden"
								name="code" value="${code}">
						</div>
					</td>
				</tr>
				<tr>
					<td><input type="hidden" name="code" value="${dto.code}">
						<button type="button" onclick="mycart();">장바구니</button>
						<button type="button" onclick="">구매하기</button></td>
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
		</div>
	</form>
	<div style="background-color: aliceblue; padding: 40px;">

		<div id="detail" style="font-size: 2rem;">상세정보</div>
		${dto.product_detail} <br> <br>
		<div id="review" style="font-size: 2rem;">리뷰</div>
		<jsp:include page="/WEB-INF/views/product/review.jsp" />



		<br> <br>
		<div id="qna" style="font-size: 2rem;">Q&A</div>
		<form name="qnaForm" method="post">
			<table>
				<tr>
					<td>${nickName}</td>
					<td><select name="type">
							<option value="1">상품질문</option>
							<option value="2">교환/환불</option>
							<option value="3">기타</option>
					</select></td>
					<td><input type="text" name="title" placeholder="제목을 입력하세요."></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2"><input type="text" name="content"
						placeholder="질문을 입력하세요."></td>
					<td><input type="hidden" name="nickName" value="${nickName}">
						<input type="hidden" name="code" value="${code}">
						<button type="button" onclick="inputqna();">질문하기</button></td>
				</tr>
			</table>
		</form>
		<table
			style="margin: auto; width: 80%; border-spacing: 0; border-bottom: 1px solid #ddd;">
			<tr>
				<th>작성자</th>
				<th>질문유형</th>
				<th>질문 제목</th>
				<th>&nbsp;</th>
			</tr>
			<tr>
				<td colspan="3">질문내용</td>
				<td>질문 등록일</td>
			</tr>
			<tr>
				<td colspan="3">답변 내용</td>
				<td>답변 등록일</td>
			</tr>
			<c:forEach var="qna" items="${qnalist}">
				<tr class="product">
					<td>${qna.nickName}</td>
					<td>${qna.type}</td>
					<td>${qna.title}</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="3">${qna.content}</td>
					<td>${qna.c_date}</td>
				</tr>
				<tr>
					<td colspan="3">${qna.answer==null? '답변준비중입니다' : qna.answer}</td>
					<td>${qna.a_date == null ? '' : qna.a_date}</td>
				</tr>
				<tr style="border-bottom: 1px solid gray"></tr>
			</c:forEach>
			<c:if test="${qnalist==null}">
				<tr>
					<td colspan="4">등록된 질문이 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table>
		<div>
			<a
				href="${pageContext.request.contextPath}/product/qna?code=${dto.code}">더보기...</a>
		</div>
		<br> <br>
		<div id="refund" style="font-size: 2rem;">반품/교환정보</div>
		<jsp:include page="/WEB-INF/views/product/repund.jsp" />
	</div>
	<form name="code" method="post"></form>
</div>
