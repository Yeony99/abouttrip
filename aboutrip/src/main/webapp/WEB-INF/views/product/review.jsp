<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div>
	<span> <a
		href="${pageContext.request.contextPath}/product/article?code=${code}">게시글로 돌아가기</a></span>

	<table
		style="margin: auto; width: 80%; border-spacing: 0; border-bottom: 1px solid #ddd;">
		<tr>
			<th>작성자</th>
			<th>구매옵션</th>
			<th>내용</th>
			<th>구매 일자</th>
			<th>평점</th>
		</tr>

		<c:forEach var="dto" items="${list}">
			<tr>
				<th>${dto.nickName}</th>
				<th>${dto.option_name}</th>
				<th>${dto.reviewContent}</th>
				<th>${dto.order_date}</th>
				<th>${dto.rate}</th>
			</tr>
		</c:forEach>
	</table>
	<table class="table">
		<tr>
			<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
		</tr>
	</table>
</div>