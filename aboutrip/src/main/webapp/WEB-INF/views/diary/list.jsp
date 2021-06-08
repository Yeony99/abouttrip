<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	margin-top: 100px;
	color: #f8f9fa;
	font-family: 나눔고딕;
}
.body-title {

}

.body-main {
	
	max-width: 500px;
  	width: 90%;
}

.createBtn {
	color: #46CCFF;
	margin: 5px;
	box-sizing: border-box; 
	float: left;
	cursor: pointer;
	width: 45px;
	height: 45px;
	line-height: 45px;
	border-radius:45px;
	border: none;
	font-weight: bold;
	text-align: center;
	font-size: 13px;
	background: #f8f9fa
}

.createBtn:hover {
	color: #f8f9fa;
	border: 1px solid #f8f9fa;
	background-color: transparent;
}
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
	
	<div>
		<c:if test="${list.size() > 0}">
			<ul class="slider" style="margin: 0;">
				<c:forEach var="dto" items="${list}">
					<c:choose>
						<c:when test="${not empty dto.saveImgName}">
							<li><a href="${articleUrl}&diaryNum=${dto.diaryNum}"><img src="${pageContext.request.contextPath}/uploads/diary/${dto.saveImgName}" title="${dto.diaryTitle}"></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${articleUrl}&diaryNum=${dto.diaryNum}"><img src="${pageContext.request.contextPath}/resources/images/noimage.png" title="${dto.diaryContent}"></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</c:if>
	</div>
		
	<div class="body-title">
		<h3 style="font: bold;">다이어리</h3>
	</div>
	<div class="body-main">
		<table>
			<tr>
				<td>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/list';">새로고침</button>
				</td>
				<td>
					<form name="searchForm" action="${pageContext.request.contextPath}/diary/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
							<option value="diaryTitle" ${condition=="diaryTitle"?"selected='selected'":""}>제목</option>
							<option value="diaryContent" ${condition=="diaryContent"?"selected='selected'":""}>내용</option>
						</select>
						<input type="text" name="keyword" value="${keyword}">
						<button type="button" onclick="searchList()">검색</button>
					</form>
				</td>
				<td>
					<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/create';">새글</button>
				</td>
			</tr>
		</table>
		
		<table>
		<c:forEach var="dto" items="${list}" varStatus="status">
			<c:if test="${status.index == 0}">
				<tr>
			</c:if>
			<c:if test="${status.index != 0 && status.index%3 == 0}">
				<c:out value="</tr><tr>" escapeXml="false"/>
			</c:if>
				
			<td>
				<a href="${articleUrl}&diaryNum=${dto.diaryNum}">
					<img src="${pageContext.request.contextPath}/uploads/diary/${dto.saveImgName}">
				</a>
				<span>${dto.diaryTitle}</span><br>
				<span>#</span><span>${dto.hashName}</span><br>
				<span>${dto.diaryCreated}</span><br>
			</td>
		</c:forEach>
		</table>
	</div>
</div>
