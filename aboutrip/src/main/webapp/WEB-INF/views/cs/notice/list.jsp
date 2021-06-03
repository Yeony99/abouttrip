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
</style>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<div class="body-container">
	<div class="body-main">
		<div class="body-title">
			<div style="text-align: left; color: black">

				<h2>NOTICE</h2>
				<p>AboutTrip 공지사항</p>
				<hr>
				<br>
			</div>

			<div class="body-main">
				<table class="table table-header">
					<tr>
						<td align="left" width="50%">
							${dataCount}개(${page}/${total_page} 페이지)</td>
						<td align="right">&nbsp;</td>
					</tr>
				</table>

				<table class="table table-list">
					<tr>
						<th width="60">번호</th>
						<th>제목</th>
						<th width="100">작성자</th>
						<th width="80">작성일</th>
						<th width="50">첨부</th>
					</tr>

					<c:forEach var="dto" items="${noticeList}">
						<tr>
							<td><span><img src="${pageContext.request.contextPath}/resources/img/img/notice.gif"></span></td>
							<td><a href="${articleUrl}&num=${dto.NOTICEnum}">${dto.title}</a>
							</td>
							<td>${dto.nickName}</td>
							<td>${dto.created}</td>
							<td><c:if test="${dto.fileCount != 0}">
									<a
										href="${pageContext.request.contextPath}/notice/zipdownload?num=${dto.num}"><i
										class="far fa-file"></i></a>
								</c:if></td>
						</tr>
					</c:forEach>

					<c:forEach var="dto" items="${list}">
						<tr>
							<td>${dto.listNum}</td>
							<td><a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
								<c:if test="${dto.gap < 1}">
									<img
										src='${pageContext.request.contextPath}/resources/images/new.gif'>
								</c:if></td>
							<td>${dto.nickName}</td>
							<td>${dto.created}</td>
							<td><c:if test="${dto.fileCount != 0}">
									<a
										href="${pageContext.request.contextPath}/notice/zipdownload?num=${dto.num}"><i
										class="far fa-file"></i></a>
								</c:if></td>
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
							<button type="button" class="btn"
								onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list';">새로고침</button>
						</td>
						<td align="center">
							<form name="searchForm"
								action="${pageContext.request.contextPath}/notice/list"
								method="post">
								<select name="condition" class="selectField">
									<option value="all"
										${condition=="all"?"selected='selected'":""}>모두</option>
									<option value="subject"
										${condition=="subject"?"selected='selected'":""}>제목</option>
									<option value="content"
										${condition=="content"?"selected='selected'":""}>내용</option>
									<option value="userName"
										${condition=="userName"?"selected='selected'":""}>작성자</option>
									<option value="created"
										${condition=="created"?"selected='selected'":""}>등록일</option>
								</select> <input type="text" name="keyword" value="${keyword}"
									class="boxTF">
								<button type="button" class="btn" onclick="searchList()">검색</button>
							</form>
						</td>
						<td align="right" width="100"><c:if
								test="${sessionScope.member.userId=='admin'}">
								<button type="button" class="btn"
									onclick="javascript:location.href='${pageContext.request.contextPath}/notice/created';">글올리기</button>
							</c:if></td>
					</tr>
				</table>
			</div>

		</div>
	</div>
</div>