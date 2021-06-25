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
				<span>여행 루트 공유!</span>
			</div>
	
			<div>
				<form name="shareForm" method="post">
					<table
						style="width: 100%; margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #111;">
						<tr align="left" height=100px;
							style="border-bottom: 1px solid #ddd;">
							<td style="text-align: center;">제목</td>
							<td style="padding-left: 10px;"><input type="text"
								name="subject" maxlength="50" class="boxTF"
								value="${dto.subject }" readonly="readonly"></td>
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
							<td><span>제목 : ${dto.scheduler_subject }</span><br>
							<span>일정분류 : ${dto.scheduler_color }</span><br>
							<span>날짜 : ${dto.check_in } ~ ${dto.check_out }</span><br>
							<span>일정 만든날 : ${dto.scheduler_created }</span><br>
							<span> 메모 : ${dto.memo } </span></td>
							<td valign="top">
																					<!-- dto.shareImgName 등... -->
								<img src="${pageContext.request.contextPath}/uploads/share/${dto.imageFileName}" style="max-width:100%; height:auto; resize:both;">
								<textarea name="content" class="boxTA">${dto.content }</textarea>
							</td>
						</tr>
					</table>

					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="60">
							<td align="center" style="padding-bottom: 30px;">
									<input type="hidden" name="condition" value="${condition}">
									<input type="hidden" name="keyword" value="${keyword}">
							<c:if test="${sessionScope.member.userId=='admin'||sessionScope.member.nickName==dto.nickName}">
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/scheduler/updateShare?num=${dto.num}&search=${dto.search}&page=${page}';">글 수정</button>
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/scheduler/deleteshare">글삭제</button>
							</c:if>
							</td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>