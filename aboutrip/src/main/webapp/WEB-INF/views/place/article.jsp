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
<script type="text/javascript">
	function sendOk() {
		var f = document.listForm;
		var str = f.subject.value;
		if (!str) {
			alert("제목이 입력되지 않았습니다.");
			f.subject.focus();
			return;
		}
		str = f.content.value;
		if (!str) {
			alert("내용이 입력되지 않았습니다.");
			f.content.focus();
			return;
		}
		f.action = "${pageContext.request.contextPath}/place/";
		f.submit();
	}
	
</script>

</head>
<body>

	<div class="container">
		<div class="body_con" style="width: 1200px;">
			<div class="body_title">
				<span>관광공사의 추천</span>
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
								value="${dto.subject}"></td>
						</tr>
						<tr align="left" height=100px;
							style="border-bottom: 1px solid #ddd;">
							<td style="text-align: center;">작성자</td>
							<td style="padding-left: 10px;">
								${sessionScope.member.userName}</td>
						</tr>
						<tr align="left"
							style="border-bottom: 1px solid #ddd; height: 355px;">
							<td style="text-align: center; width: 250px;">내용</td>
							<td valign="top"><textarea name="content" class="boxTA">${dto.content}</textarea>
							</td>
						</tr>
					</table>

					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="60">
							<td align="center" style="padding-bottom: 30px;">
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="condition" value="${condition}">
									<input type="hidden" name="keyword" value="${keyword}">

								
								<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정':'등록'}</button>
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/place/list';">${mode=='update'?'수정취소':'등록취소'}</button>
								<button type="reset" class="btn">재입력</button>
									<input type="hidden" name="num" value="${dto.num}">
									<input type="hidden" name="page" value="${page}">
							</td>
						</tr>
					</table>
				</form>

			</div>
		</div>
	</div>