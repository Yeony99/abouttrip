<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function sendOk() {
		var f = document.detailForm;

		var str = f.option_name.value;
		if (!str) {
			alert("옵션명을 입력하세요. ");
			f.product_name.focus();
			return;
		}

		str = f.price.value;
		if (!str) {
			alert("가격을 입력하세요. ");
			f.product_detail.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/admin/productmanage/${mode}";

		f.submit();
	}
</script>
<style>
td {
	color: white;
}
</style>
<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<div class="body-container" style="width: 700px;">
			<div class="body-title">
				<h3>
					<i class="fas fa-chalkboard"></i> 상품옵션 등록
				</h3>
			</div>

			<div class="body-main">
				<form name="detailForm" method="post" enctype="multipart/form-data">
					<table class="table table-content">
						<tr>
							<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
							<td>${dto.product_name}</td>
						</tr>
						<tr>
							<td valign="top">옵션명</td>
							<td valign="top"><input type="text" name="option_name" style="width:500px"class="boxTA" value="${dto.option_name}">
							</td>
						</tr>
						<tr>
							<td valign="top">시작날짜</td>
							<td valign="top"><input type="date" name="start_date"
								value="${dto.start_date}"></td>
						</tr>
						<tr>
							<td valign="top">종료날짜</td>
							<td valign="top"><input type="date" name="end_date"
								value="${dto.end_date}"></td>
						</tr>
						<tr>
							<td valign="top">가격</td>
							<td valign="top"><input type="number" name="price"
								value="${dto.price}"></td>
						</tr>
					</table>

					<table class="table table-footer">
						<tr>
							<td><c:if test="${mode=='updatedetail'}">
									<input type="hidden" value="${detail_num}" name="detail_num">
								</c:if> <input type="hidden" value="${dto.code}" name="code"></input> <input
								type="hidden" value="${option_value}" name="option_value">
								<button type="button" onclick="sendOk();">${mode=='updatedetail'?'수정완료':'등록하기'}</button>
								<button type="reset">다시입력</button>
								<button type="button"
									onclick="javascript:location.href='${pageContext.request.contextPath}/admin/productmanage/productmanagement';">${mode=='updatedetail'?'수정취소':'등록취소'}</button>
							</td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</section>
</div>