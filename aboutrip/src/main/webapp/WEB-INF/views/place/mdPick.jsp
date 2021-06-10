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
	margin-left: 1040px;
	margin-bottom: 30px;
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
		var f = document.listSearchForm;
		f.submit();
	}
</script>


<div class="body-container">
	<div class="body-main" style="margin-top: 8rem;">
		<div style="display: flex; justify-content: center">
			<h3>어바웃 트립 MD 추천 🛫</h3>
			<input type="hidden" name="mdPick" value="${mdPick }">
			<input type="hidden" name="pick" value="${pick }">
		</div>
		<div id="main-container">
			<div class="img-container">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<div class="bximg"
						style="width: 300px; height: 300px; background-color: pink; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/seongsan.jpg"
							alt="성산 일출봉" title="img1"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
					</div>

					<div class="bximg"
						style="width: 300px; height: 300px; background-color: red; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/baekyak.jpg"
							alt="백약이오름" title="img2"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
					</div>

					<div class="bximg"
						style="width: 300px; height: 300px; background-color: blue; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/udo.jpg"
							alt="우도" title="img3"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
					</div>
				</div>
			</div>
		</div>
		<!-- img box -->
		<!-- 게시판 -->
		<table
			style="width: 100%; height: 120px; margin: 30px auto; border-spacing: 0px;">
			<tr>
				<td align="center" style="width: 100%; border-top: 2px solid #111;">
					<form name="listSearchForm"
						action="${pageContext.request.contextPath}/place/${pick}" method="post">
						<select name="condition" class="selectField">
							<option value="placeName">제목</option>
							<option value="placeContent">내용</option>
							<option value="all">제목+내용</option>
						</select>
						<div class="boxTFdiv">
							<input type="text" name="keyword" class="boxTF"
								value="${keyword}">
							<button type="button" class="btnSearch" onclick="searchList()">
								<img alt=""
									src="${pageContext.request.contextPath}/resource/images/notice_search.png"
									style="padding-top: 5px;">
							</button>
						</div>
					</form>
				</td>
			</tr>
		</table>

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
						<th width="200">등록일</th>
						<th width="107">조회수</th>
					</tr>

					<c:forEach var="dto" items="${list}">
						<tr align="center" height="55"
							style="border-bottom: 1px solid #ddd;">
							<td width="60">${dto.listNum}</td>
							<td align="left" style="padding-left: 10px; text-align: center;">
								<a href="${articleUrl}&placeNum=${dto.placeNum}&pick=${pick}">${dto.placeName}</a>
							</td>
							<td width="200">${dto.created_date}</td>
							<td width="107">${dto.hitCount}</td>
					</c:forEach>
				</table>

			</form>

			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				<tr height="55">
					<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
				</tr>
			</table>

			<span> <c:if test="${sessionScope.member.userId=='admin'}">
					<button type="button" class="btnCreate"
						onclick="javascript:location.href='${pageContext.request.contextPath}/place/createMd';">등록</button>
				</c:if>
			</span>
		</div>


	</div>
</div>