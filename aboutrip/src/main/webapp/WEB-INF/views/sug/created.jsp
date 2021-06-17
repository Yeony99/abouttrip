<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.table-content tr > td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}
.table-content tr > td:nth-child(2) {
	padding-left: 10px;
}
.table-content input[type=text], .table-content input[type=file], .table-content textarea {
	width: 97%;
}
</style>

<script type="text/javascript">
    function sendOk() {
        var f = document.sugForm;

    	var str = f.title.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.title.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }

    	f.action="${pageContext.request.contextPath}/sug/${mode}";

        f.submit();
    }
</script>

<div class="container body-container">
	<div class="body-title">
		<h2> 시스템 개선제안 </h2>
	</div>
    
	<div class="body-main wx-700 ml-30 pt-15">
		<form name="sugForm" method="post" enctype="multipart/form-data">
		<table class="table table-border table-content">
			<tr> 
				<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td> 
					<input type="text" name="title" maxlength="100" class="boxTF" value="${dto.title}">
				</td>
			</tr>
			
			<tr> 
				<td>작성자</td>
				<td> 
					${sessionScope.member.nickName}
				</td>
			</tr>
			
			<tr> 
				<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<textarea name="content" class="boxTA">${dto.content}</textarea>
				</td>
			</tr>
			  
			<tr>
				<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
				<td > 
					<input type="file" name="upload" class="boxTF">
				</td>
			</tr>
			  
			<c:if test="${mode=='update' }">
				<tr>
					<td>첨부된파일</td>
					<td>
						<c:if test="${not empty dto.saveFilename}">
							<a href="${pageContext.request.contextPath}/sug/deleteFile?num=${dto.num}&page=${page}">📃</a>
						</c:if>
						${dto.originalFilename}
					</td>
				</tr>
			</c:if>

		</table>
			
		<table class="table">
			<tr> 
				<td align="center">
					<button type="button" class="btn btn-dark" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/sug/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="saveFilename" value="${dto.saveFilename}">
							<input type="hidden" name="originalFilename" value="${dto.originalFilename}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
				</td>
			</tr>
		</table>
		</form>
	</div>
    
</div>