<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
	function inputqna() {
		var d = document.qnaForm;

		d.action = "${pageContext.request.contextPath}/product/qnasubmit";
		d.submit();
	}
</script>

<div>
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
		<c:forEach var="dto" items="${list}">
			<tr class="product">
				<td>${dto.nickName}</td>
				<td>${dto.type}</td>
				<td>${dto.title}</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3">${dto.content}</td>
				<td>${dto.c_date}</td>
			</tr>
			<tr>
				<td colspan="3">${dto.answer==null? '답변준비중입니다' : dto.answer}</td>
				<td>${dto.a_date}</td>
			</tr>
			<tr style="border-bottom: 1px solid gray"></tr>
		</c:forEach>
	</table>
	<table class="table">
		<tr>
			<td align="center">${qnaCount==0?"등록된 게시물이 없습니다.":qnapaging}</td>
		</tr>
	</table>
</div>