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
	<div style="margin-top: 8rem">
		<div>
			<div class="body_title">
				<span>MD 추천 여행지 등록</span>
			</div>

			<div>
				<form name="listForm" method="post">
					<table
						style="width: 100%; margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #111;">
						<tr align="left" height=100px;
							style="border-bottom: 1px solid #ddd;">
							<td style="text-align: center;">제목</td>
							<td style="padding-left: 10px;"><input type="text"
								name="subject" maxlength="50" class="boxTF"
								value="${dto.subject}" placeholder="제목을 입력하세요."></td>
						</tr>
						<tr align="left"
							style="border-bottom: 1px solid #ddd; height: 355px;">
							<td style="text-align: center; width: 250px;">내용</td>
							<td valign="top"><textarea name="content" class="boxTA" placeholder="내용을 입력하세요."></textarea>
							</td>
						</tr>
					</table>

					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="60">
							<td align="center" style="padding-bottom: 30px;">
								<button type="button" class="btn" onclick="sendQna();">${mode=='update'?'수정':'등록'}</button>
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/place/mdPick';">${mode=='update'?'수정취소':'등록취소'}</button>
								<button type="reset" class="btn">재입력</button> 
								<c:if
									test="${mode=='update'}">
									<input type="hidden" name="qBoardNum" value="${dto.qBoardNum}">
									<input type="hidden" name="page" value="${page}">
								</c:if></td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>
