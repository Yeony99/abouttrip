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
					<td><input type="hidden" value="${dto.code}" name="code"></input>
						${dto.product_name}</td>
				</tr>
				<tr>
					<td valign="top">옵션명</td>
					<td valign="top"><textarea name="option_name" class="boxTA">${dto.option_name}</textarea>
					</td>
				</tr>
				<tr>
					<td valign="top">시작날짜</td>
					<td valign="top"><input type="date" name="start_date"></td>
				</tr>
				<tr>
					<td valign="top">종료날짜</td>
					<td valign="top"><input type="date" name="end_date"></td>
				</tr>
				<tr>
					<td valign="top">가격</td>
					<td valign="top"><input type="number" name="price"></td>
				</tr>
			</table>

			<table class="table table-footer">
				<tr>
					<td>
						<input type="hidden" value="${option_value}" name ="option_value">
						<button type="button" class="btn" onclick="sendOk();">${mode=='updatedetail'?'수정완료':'등록하기'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn"
							onclick="javascript:location.href='${pageContext.request.contextPath}/admin/productmanage/productmanagement';">${mode=='updatedetail'?'수정취소':'등록취소'}</button>
					</td>
				</tr>
			</table>
		</form>

	</div>
</div>