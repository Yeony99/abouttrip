<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.table-list {
	width: 100%;
}
.table-list tr {
	text-align: center;
}
.table-list tr:first-child {
	background: #eee;
}
.table-list tr > th {
	color: #777;
}
.table-list tr > td:nth-child(2) {
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

.btnupdate {
	border: none;
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}

.btnList {
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
			<h2>제안하기</h2>
		</div>
    
	<div class="body-main">
		<table class="table table-header">
			<tr>
				<td align="left" width="50%"></td>
				<td align="right">	${dataCount}개(${page}/${total_page} 페이지) </td>
			</tr>
		</table>
		
		<table class="table table-list">
			<tr> 
				<th width="60">번호</th>
				<th>제목</th>
				<th width="100">작성자</th>
				<th width="200">작성일</th>
				<th width="50">첨부</th>
			</tr>
		 
			<c:forEach var="dto" items="${list}">
			<tr> 
				<td>${dto.listNum}</td>
				<td>
					<c:url var="url" value="/sug/article">
						<c:param name="num" value="${dto.num}"/>
						<c:param name="page" value="${page}"/>
						<c:if test="${not empty keyword}">
							<c:param name="condition" value="${condition}"/>
							<c:param name="keyword" value="${keyword}"/>
						</c:if>
					</c:url>
					<a href="${url}">${dto.title} </a>
				</td>
				<td>${dto.nickName}</td>
				<td>${dto.reg_date}</td>
				<td>
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/sug/download?num=${dto.num}">📃</a>
					</c:if>		      
				</td>
			</tr>
			</c:forEach>
		</table>
		 
		<table class="table table-paging">
			<tr>
				<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td align="left" width="100">
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/sug/list';">새로고침</button>
				</td>
				<td align="center">
					<form name="searchForm" action="${pageContext.request.contextPath}/sug/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>제목+내용</option>
							<option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
							<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
							<c:if test="${sessionScore.member.userId=='admin'}">
								<option value="nickName" ${condition=="nickName"?"selected='selected'":""}>작성자</option>
							</c:if>
							<option value="reg_date" ${condition=="reg_date"?"selected='selected'":""}>등록일</option>
						</select>
						<input type="text" name="keyword" value="${keyword}" class="boxTF">
						<button type="button" class="btnSearch" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="100">
					<button type="button" class="btnupdate" onclick="javascript:location.href='${pageContext.request.contextPath}/sug/created';">글올리기</button>
				</td>
			</tr>
		</table>
	</div>
	</div>
</div>