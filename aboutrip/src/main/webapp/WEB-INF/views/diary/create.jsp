<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	margin-top: 80px;
	height: 1000px;
}

.body-title {
	color: #f8f9fa;
  	font-weight: bold;
  	text-align: center;
}

form {
  max-width: 600px;
  width: 90%;
  background-color: #f8f9fa;
  padding: 40px;
  border-radius: 4px;
  transform: translate(-50%, -50%);
  position: absolute;
  top: 55%;
  left: 50%;
  color: #b4b4b4;
  box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  margin: 90px auto;
}

.createBtn {
	color: #3CAEFF;
	border: 1px solid #3CAEFF;
	margin: 5px;
	box-sizing: border-box; 
	float: left;
	cursor: pointer;
	width: 55px;
	height: 55px;
	line-height: 55px;
	border-radius:45px;
	font-weight: bold;
	text-align: center;
	font-size: 13px;
	background: #f8f9fa;
}

.createBtn:hover {
	color: white;
	background-color: #46CCFF;
}

input {
	margin-bottom: 1rem !important;
	background: white;
  	border: none;
  	border-bottom: #bebebe;
  	border-radius: 0;
  	box-shadow: none;
  	outline: none;
  	color: inherit;
}

textarea {
	background: white;
	width: 300px;
	height: 150px;
	border: none;
}
</style>

<script type="text/javascript">
<c:if test="${mode=='update'}">
$(function(){
	$(".delete-img").click(function(){
		if(! confirm("이미지를 삭제 하시겠습니까 ?")) {
			return false;
		}
		var $img = $(this);
		var diaryImgNum = $img.attr("data-diaryImgNum");
		var url="${pageContext.request.contextPath}/diary/deleteImg";
		$.post(url, {diaryImgNum:diaryImgNum}, function(data){
			$img.remove();
		}, "json");
		
	});
});
</c:if>

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
		str = f.upload.value;
		if(!str) {
			alert("사진을 첨부하세요. ");
			f.upload.focus();
			return;
		}
	}

	f.action="${pageContext.request.contextPath}/diary/${mode}";

    f.submit();
}
</script>

<div class="body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
	<div>
		<div class="body-title">
			<h2>다이어리</h2>
		</div>
		
		<div class="body-main">
			<form name="diaryForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td style="width: 90px; padding: 10px;">제목</td>
					<td>
						<input type="text" name="diaryTitle" maxlength="50" value="${dto.diaryTitle}">
					</td>
					
				</tr>
				<tr>
					<td style="width: 90px; padding: 10px;">공개여부</td>
					<td>
						<input type="radio" name="diaryType" value="1" checked="checked">공개
						<input type="radio" name="diaryType" value="2">비공개
					</td>
				</tr>
				<tr>
					<td style="width: 90px; padding: 10px;">작성자</td>
					<td>
						${sessionScope.member.nickName}
					</td>
				</tr>
				<tr>
					<td style="width: 90px; padding: 10px;">내용</td>
					<td>
						<textarea name="diaryContent" placeholder="당신의 여행을 공유하세요!">${dto.diaryContent}</textarea>
					</td>
				</tr>
				<tr>
					<td style="width: 90px; padding: 10px; margin: 20px">사진</td>
					<td > 
						<input type="file" name="upload" accept="image/*" multiple="multiple">
					</td>
				</tr>
				
				<c:if test="${mode=='update'}">
					<tr id="${vo.diaryImgNum}"> 
						<td>등록이미지</td>
						<td> 
							<div>
								<c:forEach var="vo" items="${listImg}">
									<img class="delete-img" src="${pageContext.request.contextPath}/uploads/diary/${vo.saveImgName}"
										data-diaryImgNum = "${vo.diaryImgNum}">
								</c:forEach>
							</div>
						</td>
					</tr>
					<!--  
					<tr> 
						<td>등록이미지</td>
						<td> 
							<c:if test="${not empty dto.saveImgName}">
								<a href="${pageContext.request.contextPath}/diary/deleteImg?diaryNum=${dto.diaryNum}&page=${page}"><i class="icofont-bin"></i></a>
							</c:if>
							${dto.saveImgName}
						</td>
					</tr>
					-->
				</c:if>
			</table>
			<table>
				<tr> 
					<td>
						<button type="button" class="createBtn" onclick="sendOk();">${mode=='update'?'수정':'등록'}</button>
						<button type="reset" class="createBtn">리셋</button>
						<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/main';">${mode=='update'?'취소':'취소'}</button>
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
</div>