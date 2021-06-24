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
<table>
	<tr>
		<td><button type="button"
				onclick="location.href='${pageContext.request.contextPath}/admin/productmanage/qnamanage?condition=all';">전체</button></td>
		<td><button type="button"
				onclick="location.href='${pageContext.request.contextPath}/admin/productmanage/qnamanage?condition=non-answer';">미답변</button></td>
		<td><button type="button"
				onclick="location.href='${pageContext.request.contextPath}/admin/productmanage/qnamanage?condition=on-answer';">완료답변</button></td>
	</tr>
	<tr>
		<td>
			<form name="keywordForm" method="post" action="${pageContext.request.contextPath}/admin/productmanage/qnamanage">
				<select name="keyword" onchange="searchType()" >
					<option value="0" ${keyword=="0"?"selected='selected'":""}>전체</option>
					<option value="1" ${keyword=="1"?"selected='selected'":""}>상품질문</option>
					<option value="2" ${keyword=="2"?"selected='selected'":""}>교환/환불</option>
					<option value="3" ${keyword=="3"?"selected='selected'":""}>기타</option>
				</select>
				<input type="hidden" name="condition" value="${condition}">
			</form>
		</td>
	</tr>
</table>
<div>
	<table>
		<tr>
			<th>번호</th>
			<th>질문자</th>
			<th>질문종류</th>
			<th>상품명</th>
			<th>질문제목</th>
			<th>질문내용</th>
			<th>질문날짜</th>
		</tr>
	</table>
	<c:forEach var="dto" items="${list}">
		<form name="${dto.num}" method="post"
			action="${pageContext.request.contextPath}/admin/productmanage/respanswer">
			<table>
				<tr>
					<td>${dto.num}</td>
					<td>${dto.nickName}</td>
					<td>${dto.content}</td>
					<td><a href="${pageContext.request.contextPath}/product/article?code=${dto.code}">${dto.product_name}</a></td>
					<td>${dto.title}</td>
					<td>${dto.content}</td>
					<td>${dto.c_date}</td>
				</tr>
				<tr>
					<td>답변</td>
					<td colspan="5"><textarea name="answer">${dto.answer}</textarea>
						<input type="hidden" name="num" value="${dto.num}"></td>
					<td>
						<button type="submit">답변하기</button>
					</td>
				</tr>
			</table>
		</form>
	</c:forEach>
</div>