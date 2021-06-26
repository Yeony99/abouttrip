<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/vendor/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
	function searchType() {
		var f = document.keywordForm;
		f.submit();
	}
</script>

<style>
.btnlist {
	width: 150px;
	height: 100px;
	font-size: 25px;
	margin: 10px
}
</style>
<div class="body-container">
	<div class="body-main" style="padding-top: 50px; padding-bottom: 50px;">
		<div class="body-title">
			<h2>🛠 QNA 관리</h2>
			<div>
				<div>
					<button class="btnlist" type="button"
						onclick="location.href='${pageContext.request.contextPath}/admin/productmanage/qnamanage?condition=all';">전체</button>
					<button class="btnlist" type="button"
						onclick="location.href='${pageContext.request.contextPath}/admin/productmanage/qnamanage?condition=non-answer';">미답변</button>
					<button class="btnlist" type="button"
						onclick="location.href='${pageContext.request.contextPath}/admin/productmanage/qnamanage?condition=on-answer';">완료답변</button>
				</div>
				<form name="keywordForm" method="post"
					action="${pageContext.request.contextPath}/admin/productmanage/qnamanage">
					<select name="keyword" onchange="searchType()"
						style="float: right;">
						<option value="0" ${keyword=="0"?"selected='selected'":""}>전체</option>
						<option value="1" ${keyword=="1"?"selected='selected'":""}>상품질문</option>
						<option value="2" ${keyword=="2"?"selected='selected'":""}>교환/환불</option>
						<option value="3" ${keyword=="3"?"selected='selected'":""}>기타</option>
					</select> <input type="hidden" name="condition" value="${condition}">
				</form>
			</div>
		</div>

		<div style="padding: 50px;">
			<div>
				<table class="table table-list">
					<tr>
						<th width="60">번호</th>
						<th width="75">질문자</th>
						<th width="75">질문종류</th>
						<th width="110">상품명</th>
						<th width="110">질문제목</th>
						<th width="200">질문내용</th>
						<th width="80">질문날짜</th>
					</tr>
				</table>
				<c:forEach var="dto" items="${list}">
					<form name="${dto.num}" method="post"
						action="${pageContext.request.contextPath}/admin/productmanage/respanswer">
						<table class="table table-list">
							<tr>
								<td width="60">${dto.num}</td>
								<td width="75">${dto.nickName}</td>
								<td width="75">${dto.type}</td>
								<td width="110"><a
									href="${pageContext.request.contextPath}/product/article?code=${dto.code}">${dto.product_name}</a></td>
								<td width="110">${dto.title}</td>
								<td width="200">${dto.content}</td>
								<td width="80">${dto.c_date}</td>
							</tr>
							<tr>
								<td style="width: 5%;">답변</td>
								<td colspan="5"><textarea name="answer"
										style="width: 90%; resize: none;">${dto.answer}</textarea> <input
									type="hidden" name="num" value="${dto.num}"></td>
								<td style="width: 15%;">
									<button type="submit">${dto.answer!=null?"답변수정":"답변하기"}</button>
								</td>
							</tr>
						</table>
						<hr>
					</form>
				</c:forEach>
				<table class="table">
					<tr>
						<td align="center">${qnaCount==0?"등록된 게시물이 없습니다.":paging}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>