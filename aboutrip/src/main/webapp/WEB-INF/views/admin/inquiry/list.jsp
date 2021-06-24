<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
.table-list {
	width: 100%;
}

.table-list tr {
	height: 35px;
	border-bottom: 1px solid #ccc;
	text-align: center;
}
.table-list tr:first-child {
	background: #eee;
}
.table-list thead tr:first-child {
	border-top: 2px solid #ccc;
	background: #eee;
	height: 35px;
}

.table-list tr>th {
	color: #777;
}

.table-list tr>td:nth-child(2) {
	box-sizing: border-box;
	padding-left: 10px;
	text-align: left;
}

.table-paging tr>td {
	height: 40px;
	line-height: 40px;
	text-align: center;
	padding: 5px;
	box-sizing: border-box;
}

.table-footer {
	margin: 10px auto;
}

.table-footer tr {
	height: 45px;
}

.body-main a {
	text-decoration: none;
	color: black;
}

.btnCreate {
	border: none;
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}

.btnReset {
	border: none;
	background-color: #87CEFA;
	color: black;
	border-radius: 7px;
	
}

.btnSearch{
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}

.boxTF{
	height: 25.33px;
}

</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<div class="body-container">
	<div class="body-main" style="padding-top:50px; padding-bottom: 50px;">
		<div class="body-title">
			<h2>📞 1:1 문의하기</h2>
			<p>
				<br> 어바웃 트립에 문의사항을 남겨주세요. 
				<br> 관리자가 확인 후 문의사항에 대해 답변을 드립니다. 
			</p>
		</div>

			<div class="body-main">
				<table class="table table-header">
					<tr>
						<td align="left" width="50%"></td>
						<td align="right" width="50%">${dataCount}개(${page}/${total_page} 페이지)</td>
					</tr>
				</table>

				<table class="table table-list">
					<tr>
						<th width="150">분류</th>
						<th>제목</th>
						<th width="100">작성자</th>
						<th width="200">문의일자</th>
						<th width="100">처리결과</th>
					</tr>

					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.type}</td>
							<td class="title"><a href="${articleUrl}&num=${dto.num}">${dto.title}</a>
							</td>
							<td>${dto.userName}</td>
							<td>${dto.reg_date}</td>
							<td>${(empty dto.answer_date)?"답변대기":"답변완료"}</td>
						</tr>
					</c:forEach>
				</table>

				<table class="table table-paging">
					<tr>
						<td>${dataCount==0 ? "등록된 게시물이 없습니다.":paging}</td>
					</tr>
				</table>

				<table class="table table-footer">
					<tr>
						<td align="left" width="100">
							<button type="button" class="btnReset"
								onclick="javascript:location.href='${pageContext.request.contextPath}/inquiry/list';">새로고침</button>
						</td>
						<td align="center">
							<form name="searchForm" action="${pageContext.request.contextPath}/inquiry/list" method="post">
								<select id="condition" name="condition" class="selectField">
									<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
									<option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
									<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
									<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
									<c:if test="${sessionScore.member.userId=='admin'}">
										<option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>										
									</c:if>
								</select> 
								
								<input type="text" id="keyword" name="keyword" value="${keyword}" class="boxTF">
								<button type="button" class="btnSearch" onclick="searchList()">검색</button>
							</form>
						</td>
						<td align="right" width="100">
							<button type="button" class="btnCreate" onclick="javascript:location.href='${pageContext.request.contextPath}/inquiry/created';">글올리기</button>
						</td>
					</tr>
				</table>
			</div>

		</div>
	</div>