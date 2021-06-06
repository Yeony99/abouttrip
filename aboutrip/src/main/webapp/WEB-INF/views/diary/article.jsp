<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="body-container">
	<div class="body-title">
		<h3>다이어리</h3>
	</div>
	
	<!-- diaryTitle, diaryContent, diaryCreated, originalFilename,  -->
	
	<div class="body-main">
		<table>
			<tr>
				<td align="left">${dto.diaryTitle}</td>
				<td align="right">${dto.diaryCreated}</td>
			</tr>
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;">
					<div>
			      		<img src="${pageContext.request.contextPath}/uploads/diary/${dto.originalFilename}" style="max-width: 100%; height: auto; resize: both;">
			      	</div>
				</td>
			</tr>
			<tr>
				<td>${dto.diaryContent}</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendDiaryLike" title="좋아요"><i class="fas fa-thumbs-up" style="color:${isDiaryLikeUser?'red;':'black;'}"></i>&nbsp;&nbsp;<span id="diaryLikeCount">${dto.diaryLikeCount}</span></button>
				</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId==dto.userId}">
			    			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/update?num=${dto.diaryNum}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteDiary();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
    </div>
</div>

</body>
</html>