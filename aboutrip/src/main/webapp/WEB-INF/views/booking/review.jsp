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

.btnSearch {
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}

.boxTF {
	height: 25.33px;
}
</style>

<script>


</script>

<div class="body-container">
	<div class="body-main" style="padding-top: 50px; padding-bottom: 50px;">
		<div class="body-main">
			<table class="table table-header">
				<tr>
					<td align="left" width="50%"></td>
					<td align="right" width="50%">${dataCount}개(${revNo}/${totalPage}
						페이지)</td>
				</tr>
			</table>

			<table class="table table-list">
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>내용</th>
					<th>작성일</th>
					<th>평점</th>
				</tr>

				<c:forEach var="dto" items="${list}">
					<tr>
						<td>1</td>
						<td>${dto.nickName}</td>
						<td>${dto.reviewContent}</td>
						<td>${dto.order_date}</td>
						<td>${dto.rate}</td>
					</tr>
				</c:forEach>
			</table>

			<table class="table table-paging">
				<tr>
					<td>${dataCount==0 ? "등록된 게시물이 없습니다.":paging}</td>
				</tr>
			</table>

		</div>
	</div>
</div>
