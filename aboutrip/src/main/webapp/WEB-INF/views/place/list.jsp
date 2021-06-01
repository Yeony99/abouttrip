<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}
</script>
<script
	src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<div>
	<h3>한국 관광공사의 추천 🛫</h3>
</div>
<div id="container">
	<div class="main-container">
		<ul class="bxslider">
			<li><a href="#"><img
					src="${pageContext.request.contextPath}/resources/img/img/seongsan.jpg"
					alt="감천 문화마을" title="img1"
					style="min-height: 400px; min-width: 1300px; overflow: hidden"></a></li>
			<li><a href="#"><img
					src="${pageContext.request.contextPath}/resources/img/img/baekyak.jpg"
					alt="수원 화성" title="img2"
					style="min-height: 400px; min-width: 1300px; overflow: hidden"></a></li>
			<li><a href="#"><img
					src="${pageContext.request.contextPath}/resources/img/img/udo.jpg"
					alt="북촌 한옥마을" title="img3"
					style="min-height: 400px; min-width: 1300px; overflow: hidden"></a></li>

		</ul>
	</div>
</div>

<table>
	<tr>
		<td>
			<form name="searchForm"
				action="${pageContext.request.contextPath}/place/list.jsp"
				method="post">
				<input type="text" name="placeName" value="${placeName}"
					placeholder="검색할 장소를 입력하세요.">
				<button type="button" onclick="searchList()">검색</button>
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
						<a href="${articleUrl}&qBoardNum=${dto.qBoardNum}">${dto.subject}</a>
					</td>
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

	<span> <c:if test="${sessionScope.member.userId=='admin'}">
			<button type="button" class="btnCreate"
				onclick="javascript:location.href='${pageContext.request.contextPath}'">등록</button>
		</c:if>
	</span>
</div>


<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/jquery/bxslider.js"></script>
