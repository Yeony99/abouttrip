<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>
<div class="body-container">
	<div class="body-main">
		<div>
			<h3 style="font: bold;">다이어리</h3>
		</div>
		<table>
			<tr>
				<td>
					<form name="searchForm" action="${pageContext.request.contextPath}/diary/list.jsp" method="post">
						<input type="text" name="keyword" value="${dto.hashName}" placeholder="해쉬태그">
						<button type="button" onclick="searchList()">검색</button>
					</form>
				</td>
			</tr>
		</table>
		
		<div>
			<table>
			<c:forEach var="dto" items="${list}">
				<c:if test="${status.index == 0}">
					<tr>
				</c:if>
				<c:if test="${status.index != 0 && status.index%3 == 0}">
					<c:out value="</tr><tr>" escapeXml="false"></c:out>
				</c:if>
				
				<td>
					<div onclick="location.href='${url}&diaryNum=${dto.diaryNum}';">
						<img src="${pageContext.request.contextPath}/uploads/diary/${dto.originalImgName}">
						<span>${dto.diaryTitle}</span><br>
						<span>${dto.hashName}</span><br>
						<span>${dto.diaryCreated}</span><br>
					</div>
				</td>
			</c:forEach>
			</table>
		</div>
	</div>
</div>
