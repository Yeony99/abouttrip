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
		var f = document.qnaForm;
		var str;
		str = f.title.value;
		str = str.trim();
		if (!str) {
			alert("제목을 입력하세요. ");
			f.title.focus();
			return;
		}

		str = f.content.value;
		str = str.trim();
		if (!str) {
			alert("내용을 입력하세요. ");
			f.content.focus();
			return;
		}
		f.action = "${pageContext.request.contextPath}/product/qnasubmit";
		f.submit();
	}
</script>

<div class="body-container">
	<form name="productForm" method="post">
		<div class="body-main">
			<table style="width: 100%">
				<tr>
					<td style="width: 50%; height: 500px;" rowspan="3"><img
						class="box-img"
						src="${pageContext.request.contextPath}/uploads/product/${dto.img_name}"
						alt="${dto.product_name}" title="${dto.product_name}"
						style="width: 100%; height: 100%; object-fit: cover;"></td>
					<td>
						<div style="font-size: 35px; text-align: center;">${dto.product_name}</div>
						<div class="selectbox">
							<div
								style="margin-top: 2rem; margin-right: 30px; text-align: right; font-size: 30px; color: skyblue; font-weight: 600;">
								<input style="border:none; width: 150px;" type="text" id="price" readonly="readonly">원
							</div>
							<div style="margin: 30px;">
								<select name="options" id="options" onchange="printprice()"
									style="float: right;">
									<option value="">선택</option>
									<c:forEach var="item" items="${options}">
										<option id="${item.detail_num}" value="${item.price}">${item.option_name}
											[${item.price}원]</option>
									</c:forEach>
								</select> <span style="float: right; margin-right: 20px;">옵션 선택</span> <input type="hidden" id="detail_num" name="detail_num"
									value="${item.detail_num}"> <input type="hidden"
									name="choice" value="0"> <input type="hidden"
									name="code" value="${code}">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="float: right;"><input type="hidden" name="code"
						value="${dto.code}">
						<button type="button" onclick="mycart();">장바구니</button>
						<button type="button" onclick="">구매하기</button></td>
				</tr>
				<tr>
					<td
						style="background-color: aliceblue; padding: 20px;">
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
		<div>
			<div>리뷰 ${revCount}건</div>
			<div style="border: 1px solid rgb(240, 240, 240);">
				<c:forEach var="dto" items="${revlist}">
					<div
						style="border-bottom: 2px solid rgb(230, 230, 230); padding: 20px; margin-bottom: 10px;">
						<c:if test="${dto.profile_pic!=null}">
							<img id="preImageView"
								style="vertical-align: middle; width: 50px; border-radius: 25px; border: 1px solid #eee; float: left; margin-right: 30px;"
								width="50" height="50"
								src="${pageContext.request.contextPath}/uploads/member/${dto.profile_pic}">
						</c:if>
						<c:if test="${dto.profile_pic==null}">
							<img id="preImageView"
								style="vertical-align: middle; width: 50px; border-radius: 25px; border: 1px solid #eee; float: left; margin-right: 30px;"
								width="50" height="50"
								src="${pageContext.request.contextPath}/resources/img/img/profile_img_none.png">
						</c:if>
						<div>
							<div>평점 ${dto.rate}/5.0</div>
							<div style="font-size: 12px; color: gray;">${dto.nickName}&nbsp;&nbsp;${dto.order_date}</div>
							<div style="font-size: 12px; color: gray;">옵션 선택 :
								${dto.option_name}</div>
						</div>
						<div style="padding: 20px 80px; margin: 30px 0px;">${dto.reviewContent}</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div>
			<a style="float:right;"
				href="${pageContext.request.contextPath}/product/review?code=${dto.code}">리뷰
				더보기...</a>
		</div>




		<br> <br>
		<div id="qna" style="font-size: 2rem;">Q&A</div>

		<div>
			<div>QNA ${qnaCount}건</div>
			<div style="border: 1px solid rgb(240, 240, 240);">
				<c:forEach var="dto" items="${qnalist}">
					<div
						style="border-bottom: 2px solid rgb(220, 220, 220); padding: 20px; margin-bottom: 10px;">
						<c:if test="${dto.profile_pic!=null}">
							<img id="preImageView"
								style="vertical-align: middle; width: 50px; border-radius: 25px; border: 1px solid #eee; float: left; margin-right: 30px;"
								width="50" height="50"
								src="${pageContext.request.contextPath}/uploads/member/${dto.profile_pic}">
						</c:if>
						<c:if test="${dto.profile_pic==null}">
							<img id="preImageView"
								style="vertical-align: middle; width: 50px; border-radius: 25px; border: 1px solid #eee; float: left; margin-right: 30px;"
								width="50" height="50"
								src="${pageContext.request.contextPath}/resources/img/img/profile_img_none.png">
						</c:if>
						<div>
							<div>질문제목 : ${dto.title}</div>
							<div style="font-size: 12px; color: gray;">작성자 :
								${dto.nickName}&nbsp;&nbsp;|&nbsp;&nbsp;질문 유형 : ${dto.type}</div>
							<div style="font-size: 12px; color: gray;">질문 날짜 :
								${dto.c_date}</div>
						</div>
						<div style="padding: 20px 80px; margin: 30px 0px;">${dto.content}</div>
						<c:if test="${dto.answer!=null}">
							<div style="border: 1px solid rgb(235, 235, 235);">
								<div style="padding: 20px 80px;">답변</div>
								<div style="font-size: 12px; color: gray; padding: 0px 80px;">답변
									날짜 : ${dto.a_date}</div>
								<div style="padding: 20px 80px; margin: 30px 0px;">${dto.answer}</div>
							</div>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
		<form name="qnaForm" method="post">
			<div
				style="margin: 20px 20px; padding: 10px 100px; border: 1px solid rgb(220, 220, 220)">
				<div style="float: left; margin-right: 20px;">
					<select name="type" style="width: 150px; height: 30px;">
						<option value="1">상품질문</option>
						<option value="2">교환/환불</option>
						<option value="3">기타</option>
					</select>
				</div>
				<div>
					<input type="text" name="title" placeholder="제목을 입력하세요."
						style="width: 750px;">
				</div>
				<div>
					<textarea name="content" placeholder="질문을 입력하세요."
						style="margin-top: 20px; width: 800px; height: 100px; resize: none;"></textarea>
					<input type="hidden" name="nickName" value="${nickName}"> <input
						type="hidden" name="code" value="${code}">
					<button class="btn" type="button" onclick="inputqna();">질문하기</button>
				</div>
			</div>
		</form>
		<div>
			<a style="float: right;"
				href="${pageContext.request.contextPath}/product/qna?code=${dto.code}">질문
				더보기...</a>
		</div>
		<br> <br>
		<div id="refund" style="font-size: 2rem;">반품/교환정보</div>
		<jsp:include page="/WEB-INF/views/product/repund.jsp" />
	</div>
	<form name="code" method="post"></form>
</div>
