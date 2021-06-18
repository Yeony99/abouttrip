<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

a {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}

.title {
	font-weight: bold;
	font-size: 15px;
	margin-bottom: 10px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.btn {
	color: #333;
	font-weight: 500;
	font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	border: 1px solid #ccc;
	background-color: #fff;
	text-align: center;
	cursor: pointer;
	padding: 3px 10px 5px;
	border-radius: 4px;
}

.btn:active, .btn:focus, .btn:hover {
	background-color: #e6e6e6;
	border-color: #adadad;
	color: #333;
}

.boxTF {
	border: 1px solid #999;
	padding: 3px 5px 5px;
	border-radius: 4px;
	background-color: #fff;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.selectField {
	border: 1px solid #999;
	padding: 3px 5px 3px;
	border-radius: 4px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
</style>

<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#chkAll").click(function() {
			if ($(this).is(":checked")) {
				$("input[name=carts]").prop("checked", true);
			} else {
				$("input[name=carts]").prop("checked", false);
			}
		});

		$("#btnDeleteList")
				.click(
						function() {
							// var cnt = $("input[name=haks]:checkbox:checked").length;
							var cnt = $("input[name=carts]:checked").length;

							if (cnt == 0) {
								alert("삭제할 상품을 먼저 선택 하세요 !!!");
								return false;
							}

							if (confirm("선택한 상품을 삭제하시겠습니까 ? ")) {
								var f = document.cartForm;
								f.action = "${pageContext.request.contextPath}/product/deletecarts";
								f.submit();
							}

						});
	});

	function searchList() {
		var f = document.searchForm;
		f.submit();
	}

	function deleteCart(num, name) {
		var url = "${pageContext.request.contextPath}/product/deletecart?cart_num="
				+ num + "}";
		if (confirm("장바구니에서 " + name + " 제품을 삭제 하시겠습니까?")) {
			location.href = url;
		}
	}
</script>

</head>
<body>

	<div style="width: 700px; margin: 30px auto;">
		<table style="width: 100%;">
			<tr height="50">
				<td align="center" colspan="2"><span
					style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">장바구니</span>
				</td>
			</tr>

			<tr height="35">
				<td width="50%">
					<button type="button" class="btn" id="btnDeleteList">선택상품
						삭제</button>
				</td>
				<td align="right">${dataCount}개품목</td>
			</tr>
		</table>

		<form name="cartForm" method="post">
			<table style="width: 100%; border-spacing: 1px; background: #cccccc;">
				<tr height="30" bgcolor="#eeeeee" align="center">
					<th width="40"><input type="checkbox" name="chkAll"
						id="chkAll" value="all"></th>
					<th>상품명</th>
					<th>상품금액</th>
					<th>수량</th>
					<th>주문금액</th>
					<th>삭제</th>
				</tr>
				<c:forEach var="dto" items="${list}">
					<tr height="35" bgcolor="#ffffff" align="center">
						<td><input type="checkbox" name="carts" value="1111">
						</td>
						<td>${dto.option_name}</td>
						<td>${dto.price}</td>
						<td>${dto.quantity}</td>
						<td>${dto.price * dto.quantity} 값을 넣어야함</td>
						<td><a
							href="javascript:deleteCart('${dto.cart_num}', '${dto.option_name}')">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		<c:if test="${dataCount==0}">
			<div>장바구니가 비었습니다.</div>
		</c:if>
		<div>
			<button class="btn">선택상품 주문하기</button>
			<button class="btn">전체상품 주문하기</button>
		</div>
	</div>

</body>
</html>