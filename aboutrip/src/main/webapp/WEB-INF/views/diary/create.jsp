<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">

</style>

<script type="text/javascript">

</script>

<div>
	<div>
		<h3>다이어리</h3>
	</div>
	
	<div>
		<form name="diaryForm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="diaryTitle" maxlength="50" value="${dto.diaryTitle}">
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" name="nickName" value="${dto.nickName}">
				</td>
			</tr>
			<tr>
				<td>
					<textarea name="diaryContent">${dto.content}</textarea>
				</td>
			</tr>
			<tr>
				<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
				<td > 
					<input type="file" name="upload" class="boxTF">
				</td>
			</tr>
			  
			<c:if test="${mode=='update'}">
				<tr>
					<td>이미지</td>
					<td>
						<c:if test="${not empty dto.diaryImgName}">
							<a href="${pageContext.request.contextPath}/bbs/deleteFile?num=${dto.diaryImgNum}&page=${page}"><i class="far fa-trash-alt"></i></a>
						</c:if>
						${dto.diaryImgName}
					</td>
				</tr>
			</c:if>
		</table>
		<table>
			<tr> 
				<td>
					<button type="button" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset">다시입력</button>
					<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="diaryNum" value="${dto.diaryNum}">
							<input type="hidden" name="diaryImgName" value="${dto.diaryImgName}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>