<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	margin-top: 100px;
}
</style>

<script type="text/javascript">
function sendOk() {
    var f = document.diaryForm;

    if(! f.diaryTitle.value) {
        alert("제목을 입력하세요. ");
        f.diaryTitle.focus();
        return;
    }
    
    if(! f.diaryType.value) {
        alert("공개여부를 입력하세요. ");
        f.diaryType.focus();
        return;
    }

    if(! f.diaryContent.value) {
        alert("내용을 입력하세요. ");
        f.diaryContent.focus();
        return;
    }
    
    var mode = "${mode}";
	if(mode=="created") {
		str = f.selectImg.value;
		if(!str) {
			alert("사진을 첨부하세요. ");
			f.selectImg.focus();
			return;
		}
	}

	f.action="${pageContext.request.contextPath}/diary/${mode}";

    f.submit();
}
</script>

<div class="body-container">
	<div class="body-title">
		<h3 style="font: bold;">다이어리</h3>
	</div>
	
	<div class="body-main">
		<form name="diaryForm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="diaryTitle" maxlength="50" value="${dto.diaryTitle}">
				</td>
				<td>공개여부</td>
				<td>
					<input type="radio" name="diaryType" value="1" checked="checked">공개
					<input type="radio" name="diaryType" value="2">비공개
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					${sessionScope.member.nickName}
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="diaryContent">${dto.diaryContent}</textarea>
				</td>
			</tr>
			<tr>
				<td>사진</td>
				<td > 
					<input type="file" name="selectImg" accept="image/*" multiple="multiple">
				</td>
			</tr>
			  
			<c:if test="${mode=='update'}">
				<tr id="f${vo.diaryImgNum}"> 
					<td>등록이미지</td>
					<td> 
						<c:if test="${not empty dto.saveImgName}">
							<a href="${pageContext.request.contextPath}/diary/deleteImg?diaryNum=${dto.diaryNum}&page=${page}"><i class="icofont-bin"></i></a>
						</c:if>
						${dto.saveImgName}
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
							<input type="hidden" name="saveImgName" value="${dto.saveImgName}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
				</td>
			</tr>
		</table>
		</form>
	</div>
</div>