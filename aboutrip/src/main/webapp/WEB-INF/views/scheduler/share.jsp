<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style type="text/css">
.allDataCount {
	width: 100%;
	margin: 20px auto 0px;
	border-spacing: 0px;
	border-bottom: 1.5px solid #111;
	font-size: small;
	padding-bottom: 5px;
}

.selectField {
	height: 45px;
	padding-left: 20px;
	padding-right: 50px;
	border: 1px solid #ddd;
	color: #888888;
	font-size: 15px;
	float: left;
	margin-right: 5px;
	margin-left: 250px;
	margin-top: 53px;
}

.boxTFdiv {
	float: left;
	margin-top: 53px;
	height: 47px;
}

.boxTF {
	width: 425px;
	height: 43px;
	padding-left: 15px;
	border: 1px solid #ddd;
	color: #888888;
	float: left;
	margin-right: 5px;
}

.btnSearch {
	width: 43px;
	height: 43px;
	background-color: white;
	border: 1px solid #ddd;
	cursor: pointer;
}

.btnCreate {
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	
}

.btnDelete {
	width: 50px;
	height: 30px;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 10px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}
</script>

<div class="body-container">
	<div class="body-main" style="margin: 8rem 0;">
		<div style="display: flex; justify-content: center">
			<h3>🏆Best 스케줄 ✨</h3>
		</div>
		<div id="main-container">
			<div class="img-container">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<c:forEach var="best" items="${listmain }">
						<div class="bximg"
						style="width: 300px; height: 300px; background-color: pink; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<c:if test="${best.listNum==1 }">
							<div class="rank" style="position: absolute; font-size: 4rem;">🥇</div>
						</c:if>
						<c:if test="${best.listNum==2 }">
							<div class="rank" style="position: absolute; font-size: 4rem;">🥈</div>
						</c:if>
						<c:if test="${best.listNum==3 }">
							<div class="rank" style="position: absolute; font-size: 4rem;">🥉</div>
						</c:if>
						<a href="${articleUrl }&num=${best.num}&search=${best.search}"><img class="box-img"
							src="${pageContext.request.contextPath}/uploads/share/${best.imageFileName }"
							title="img${best.listNum }"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
						</div>					
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 게시판 -->
		<div>
			<form>
				<table class="allDataCount">
					<tr height="20">
						<td align="left" width="50%">총 ${dataCount}건</td>
					</tr>
				</table>

				<table
					style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
					<tr align="center" height="55">
						<th width="60">번호</th>
						<th>제목</th>
						<th width="100">작성자</th>
						<th width="200">등록일</th>
						<th width="107">조회수</th>
					</tr>

					<c:forEach var="dto" items="${list}">
						<tr align="center" height="55"
							style="border-bottom: 1px solid #ddd;">
							<td width="60">${dto.listNum}</td>
							<td align="left" style="padding-left: 10px; text-align: center;">
								<a href="${articleUrl }&num=${dto.num}&search=${dto.search}">${dto.subject}</a>
							</td>
							<td width="100">${dto.nickName}</td>
							<td width="200">${dto.created}</td>
							<td width="107">${dto.hitCount}</td>
					</c:forEach>
				</table>

			</form>

			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				<tr height="55">
					<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
				</tr>
			</table>

			<span style="display: flex; justify-content: flex-end;"> <c:if test="${sessionScope.member.userId!=null||sessionScope.member.userId!='admin'}">
					<button type="button" class="btnCreate"
						onclick="javascript:location.href='${pageContext.request.contextPath}/scheduler/create';">등록</button>
				</c:if>
			</span>
		</div>

	</div>
</div>