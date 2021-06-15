<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<form name="enableForm" method="post">
<table style="margin: 10px auto 20px; width: 100%; border-spacing: 1px;">
	<tr height="37" style="background: #fff;">
		<td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">글번호</label></td>
		<td align="left" width="35%" style="padding-left: 5px;"><span>${dto.diaryNum}</span></td>
		<td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">제목</label></td>
		<td align="left" width="35%" style="padding-left: 5px;"><span>${dto.diaryTitle}</span></td>
	</tr>
	<tr height="37" style="background: #fff;">
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">닉네임</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.nickName}</span></td>
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">내용</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.diaryContent}</span></td>
	</tr>
	<c:if test="${listImg.size() > 0}">
		<tr>
			<td colspan="2" style="height: 110px;">
				<div class="imgLayout">
					<c:forEach var="vo" items="${listImg}">
						<img src="${pageContext.request.contextPath}/uploads/diary/${vo.saveImgName}"
							onclick="imageViewer('${pageContext.request.contextPath}/uploads/diary/${vo.saveImgName}');">
					</c:forEach>
				</div>
			</td>
		</tr>
	</c:if>

	<tr height="37" style="background: #fff;">
		<td align="right" width="15%" style="padding-right: 9px;"><label style="font-weight: 900;">계정상태</label></td>
		<td style="padding-left: 5px;">
			<input type="radio" name="enable" value="0" checked="checked">활성
			<input type="radio" name="enable" value="1">잠금
		</td>
	</tr>
</table>
<input type="hidden" name="userNum" value="${dto.userNum}">
<input type="hidden" name="userId" value="${dto.userId}">
</form>

<div id="dialogDiary">
    <div id="imgDiaryLayout"></div>
</div>