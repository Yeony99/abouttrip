<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
.body_title span {
	font-size: 30px;
	color: #111;
	font-weight: 200;
}
.boxTA {
	resize: none;
	max-height: 30rem;
	overflow-y: scroll;
	width: 60rem;
	height: 30rem;
	border: solid 1px #ddd;
	border-radius: 0;
	appearance: none;
	line-height: 20px;
	margin-left: 10px;
	margin-top: 20px;
	padding-left: 15px;
	padding-top: 15px;
}
.boxTF {
	height: 42px;
	width: 650px;
	border: solid 1px #ddd;
	padding-left: 15px;
}
.btn {
	width: 150px;
	height: 50px;
	font-size: medium;
	border-radius: 0;
	background-color: #424242;
	color: white;
	cursor: pointer;
	border: none;
}
</style>
<script>
function sendQna(){
	var f = document.listForm;
	var str;
	
	str = f.placeName.value;
	str = str.trim();
	if (!str) {
		alert("제목을 입력하세요. ");
		f.placeName.focus();
		return;
	}
	
	str = f.placeContent.value;
	str = str.trim();
	if (!str) {
		alert("내용을 입력하세요. ");
		f.placeContent.focus();
		return;
	}	
	
	f.action = "${pageContext.request.contextPath}/place/${mode}";
	f.submit();
}
function bringName() {
	var f = document.listForm;
	
	var str = f.upload.value;
	if(str!="") {
		f.placeFileName.value=str;
	} else{
		f.placeFileName.value="fail";
	}
}
function bringPlace() {
	var f = document.listForm;
	
	var str = f.ctg.value;
	if(str!="") {
		f.ctgNum.value=str;
	}
}
</script>
	<div style="margin-top: 8rem">
		<div>
			<div class="body_title">
				<span>${pick=="mdPick" ? "MD의 추천":"한국 관광공사의 추천"}</span>
			</div>

			<div>
				<form name="listForm" method="post" enctype="multipart/form-data">
					<select name="ctg" onchange="bringPlace();">
						<option value="">선 택</option>
						<option value="1" ${dto.ctgNum=="1" ? "selected='selected'" : ""}>서울</option>
						<option value="2" ${dto.ctgNum=="2" ? "selected='selected'" : ""}>부산</option>
						<option value="3" ${dto.ctgNum=="3" ? "selected='selected'" : ""}>제주 제주시</option>
						<option value="4" ${dto.ctgNum=="4" ? "selected='selected'" : ""}>제주 서귀포</option>
						<option value="5" ${dto.ctgNum=="5" ? "selected='selected'" : ""}>제주 성산</option>
						<option value="6" ${dto.ctgNum=="6" ? "selected='selected'" : ""}>제주 기타</option>
					</select>
					<input type="hidden" value="${dto.ctgNum }" name="ctgNum">
					<table
						style="width: 100%; margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #111;">
						<tr align="left" height=100px;
							style="border-bottom: 1px solid #ddd;">
							<td style="text-align: center;">제목</td>
							<td style="padding-left: 10px;"><input type="text"
								name="placeName" maxlength="50" class="boxTF"
								value="${dto.placeName}" placeholder="제목을 입력하세요."></td>
						</tr>
						<tr align="left"
							style="border-bottom: 1px solid #ddd; height: 355px;">
							<td style="text-align: center; width: 250px;">내용</td>
							<td valign="top"><textarea name="placeContent" class="boxTA" placeholder="내용을 입력하세요.">${dto.placeContent }</textarea>
							</td>
						</tr>
						<tr>
							<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
							<td > 
								<input type="file" name="upload" class="boxTF" onchange="bringName();"  >
								<input type="hidden" name="placeFileName">
							</td>
						</tr>
					</table>
					<input type="hidden" name="pick" value="${pick }">
					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="60">
							<td align="center" style="padding-bottom: 30px;">
								<button type="button" class="btn" onclick="sendQna();">${mode=='update'?'수정':'등록'}</button>
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/place/${pick}';">${mode=='update'?'수정취소':'등록취소'}</button>
								<button type="reset" class="btn">재입력</button> 
								<c:if
									test="${mode=='update'}">
									<input type="hidden" name="placeNum">
								</c:if></td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>
