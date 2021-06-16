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
.product{
	border-bottom: 2px solid gray;
	
	height: 70px
}

.option{
	height: 30px
}
</style>
<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}
</script>

<div class="body-container">
	<div class="body-main">
		<section class="clean-block clean-hero"
			style="min-height:400px; background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju_tour1.jpg&quot;);color: rgba(100, 100, 255, 0.1);">
			<div class="text">
				<h2 style="font-size: 55px; color: skyblue; font-weight: bold">ABOUTRIP</h2>
				<br>
				<h6 style="font-size: 26px; color: white; font-weight: 600">상품관리
					페이지 입니다.</h6>
			</div>
		</section>
	</div>
	<div class="body-main"
		style="background: rgb(194, 231, 245); box-shadow: 0px 0px 15px rgb(0 0 0/ 40%);">
	</div>
	<div class="body-main">
		<div id="main-container" style="background-color: rgb(240, 240, 240);">
			<div>
				<table style="margin:auto; width: 80%; border-spacing: 0; border-bottom: 1px solid #ddd;">
					<tr>
						<th>판매코드</th>
						<th>판매상품</th>
						<th>분류</th>
						<th>판매 시작일</th>
						<th>판매 마지막일</th>
						<th>공개여부</th>
						<th><button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/productmanage/inputproduct';">상품추가</button></th>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>옵션번호</td>
						<td colspan="3">옵션명</td>
						<td colspan="2">price</td>

					</tr>

					<c:forEach var="dto" items="${list}">
						<tr class="product">
							<td>${dto.code}</td>
							<td>${dto.product_name}</td>
							<td>${dto.category_name}</td>
							<td>${dto.sales_start}</td>
							<td>${dto.sales_end}</td>
							<td>${dto.isHidden==1? "공개":"비공개"}</td>
							<td>
							<button type="button" onclick="">상품수정</button>
							<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/productmanage/inputproductoption?code=${dto.code}';">옵션추가</button>
							</td>
						</tr>
						<c:forEach var="option" items="${options}">
							<c:if test="${option.code==dto.code}">
								<tr class="option">
									<td>&nbsp;</td>
									<td>${option.option_value}</td>
									<td colspan="3">${option.option_name}</td>
									<td colspan="2">${option.price}원</td>
								</tr>
							</c:if>	
						</c:forEach>
						<tr style="border-bottom: 1px solid gray"></tr>
					</c:forEach>
				</table>

				<table class="table">
					<tr>
						<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
