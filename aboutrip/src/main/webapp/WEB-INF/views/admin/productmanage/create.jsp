<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function sendOk() {
		var f = document.productForm;

		var str = f.product_name.value;
		if (!str) {
			alert("제목을 입력하세요. ");
			f.product_name.focus();
			return;
		}

		str = f.product_detail.value;
		if (!str) {
			alert("내용을 입력하세요. ");
			f.product_detail.focus();
			return;
		}

		f.action = "${pageContext.request.contextPath}/admin/productmanage/${mode}";

		f.submit();
	}
</script>
<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<div class="body-container" style="width: 700px;">
			<div class="body-title">
				<h3>
					<i class="fas fa-chalkboard"></i> 상품등록
				</h3>
			</div>

			<div class="body-main">
				<form name="productForm" method="post" enctype="multipart/form-data">
					<table class="table table-content">
						<tr>
							<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
							<td><input type="text" name="product_name" maxlength="100"
								class="boxTF" value="${dto.product_name}"></td>
						</tr>
						<tr>
							<td valign="top">세부사항</td>
							<td valign="top"><textarea name="product_detail"
									class="boxTA">${dto.product_detail}</textarea></td>
						</tr>
						<tr>
							<td valign="top">카테고리</td>
							<td><select name="category_num">
									<option value="1">패키지</option>
									<option value="2">티켓</option>
									<option value="3">모바일</option>
									<option value="4">패키지 이벤트</option>
									<option value="5">티켓 이벤트</option>
									<option value="6">모바일 이벤트</option>
							</select></td>
						</tr>
						<tr>
							<td><input type="radio" name="isHidden" value="1"
								checked="checked">공개</td>
							<td><input type="radio" name="isHidden" value="0">비공개</td>
						</tr>
						<tr>
							<td valign="top">판매시작날짜</td>
							<td valign="top"><input type="date" name="sales_start"
								value="${dto.sales_start}"></td>
						</tr>
						<tr>
							<td valign="top">판매종료날짜</td>
							<td valign="top"><input type="date" name="sales_end"
								value="${dto.sales_end}"></td>
						</tr>
						<tr>
							<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td><input type="file" name="upload" class="boxTF"
								value="${dto.img_name}"></td>
						</tr>
					</table>

					<table class="table table-footer">
						<tr>
							<td><input type="hidden" name="img_name"
								value="${dto.img_name}"> <input type="hidden"
								name="code" value="${dto.code}">
								<button type="button" class="btn" onclick="sendOk();">${mode=='updateproduct'?'수정완료':'등록하기'}</button>
								<button type="reset" class="btn">다시입력</button>
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/admin/productmanage/productmanagement';">${mode=='updateproduct'?'수정취소':'등록취소'}</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</section>
</div>