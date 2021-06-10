<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.body_title span {
	font-size: 30px;
	color: #111;
	font-weight: 200;
}

.container {
	padding: 30px 0px 0px 80px;
}

.btn {
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-bottom: 10px;
}

a {
	text-decoration: none;
}

a:hover {
	color: #f06292;
}

button[disabled] {
	background: #eee;
}
</style>

</head>
<body>

	<div class="container">
		<div class="body_con" style="width: 1200px;">
			<div class="body_title">
				<span>${pick=="mdPick" ? "MD의 추천":"한국 관광공사의 추천"}</span>
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
								value="${dto.placeName}" readonly="readonly"></td>
						</tr>
						<tr align="left" height=100px;
							style="border-bottom: 1px solid #ddd;">
							<td style="text-align: center;">작성자</td>
							<td style="padding-left: 10px;">
								${sessionScope.member.nickName}</td>
						</tr>
						
						
						<tr align="left"
							style="border-bottom: 1px solid #ddd; height: 355px;">
							<td style="text-align: center; width: 250px;">내용</td>
							<td valign="top">
								<img src="${pageContext.request.contextPath}/uploads/place/${dto.placeImgName}" style="max-width:100%; height:auto; resize:both;">
								<textarea name="content" class="boxTA">${dto.placeContent}</textarea>
							</td>
						</tr>
					</table>

					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="60">
							<td align="center" style="padding-bottom: 30px;">
									<input type="hidden" name="placeNum" value="${dto.placeNum}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="condition" value="${condition}">
									<input type="hidden" name="keyword" value="${keyword}">
									<input type="hidden" name="mdPick" value="${dto.mdPick}">
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/place/update?placeNum=${dto.placeNum}&page=${page }&pick=${pick }';">글수정</button>
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/place/delete';">글삭제</button>
									<input type="hidden" name="placeNum" value="${dto.placeNum}">
									<input type="hidden" name="page" value="${page}">
							</td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>