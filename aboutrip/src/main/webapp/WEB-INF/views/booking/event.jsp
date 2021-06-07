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
		var f = document.searchForm;
		f.submit();
	}
</script>

<div class="body-container">
	<div class="body-main">
		<section class="clean-block clean-hero"
			style="margin-top:80px; min-height:400px; background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju_tour1.jpg&quot;);color: rgba(100, 100, 255, 0.1);">
			<div class="text">
				<h2 style="font-size: 55px; color: skyblue; font-weight: bold">ABOUTRIP
					초특가상품</h2>
				<br>
				<h6 style="font-size: 26px; color: white; font-weight: 600">어바웃트립의
					초특가 이벤트 상품들을 소개합니다.</h6>
			</div>
		</section>
	</div>
	<div class="body-main" style="background: rgb(194, 231, 245);">
		<table style="margin: auto;">
			<tr>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					href="#package">패키지 여행</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					href="#ticket">티켓 / 투어</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					href="#mobile">모바일 상품</a></td>
			</tr>
		</table>
	</div>

	<div class="body-main">
		<div id="main-container" style="background-color: rgb(240, 240, 240);">
			<div>
				<span id="package"> </span>
			</div>
			<div class="img-container" style="margin-top: 100px">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<div class="bximg"
						style="width: 300px; height: 310px; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<div style="width: 100%; height: 100%; padding-top: 100px;">
							<h5 style="color: darkblue; font-size: 1.0rem; font-weight: 700;">[aboutrip
								event]</h5>
							<h3 style="font-weight: revert;">초특가 패키지 여행</h3>
						</div>
					</div>

					<div class="bximg"
						style="width: 300px; height: 310px; background-color: white; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/kalhotel.jpg"
							alt="감천 문화마을" title="img1"
							style="width: 100%; height: 200px; object-fit: cover;"> </a>
						<div style="margin: 20px 10px 0px; height: 55px">
							<span
								style="vertical-align: top; font-weight: bold; font-size: large;">[서귀포]
								서귀포 KAL 호텔 문화마을 투어</span>
						</div>
						<div style="margin: 0px 10px;">
							130,000원 <a href="#" style="float: right;">자세히보기</a>
						</div>
					</div>

					<div class="bximg"
						style="width: 300px; height: 310px; background-color: white; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/winery.jpg"
							alt="감천 문화마을" title="img1"
							style="width: 100%; height: 200px; object-fit: cover;"> </a>
						<div style="margin: 20px 10px 0px; height: 55px">
							<span
								style="vertical-align: top; font-weight: bold; font-size: large;">[제주]
								제주도 올레길 와이너리 투어</span>
						</div>
						<div style="margin: 0px 10px;">
							20,000원 <a href="#" style="float: right;">자세히보기</a>
						</div>
					</div>

					<div class="bximg"
						style="width: 300px; height: 310px; background-color: white; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/snapshot.jpg"
							alt="감천 문화마을" title="img1"
							style="width: 100%; height: 200px; object-fit: cover;"> </a>
						<div style="margin: 20px 10px 0px; height: 55px">
							<span
								style="vertical-align: top; font-weight: bold; font-size: large;">[제주]
								제주밤 야간 포토 스냅 투어</span>
						</div>
						<div style="margin: 0px 10px;">
							40,000원 <a href="#" style="float: right;">자세히보기</a>
						</div>
					</div>
				</div>
			</div>
			<div>
				<span id="ticket"> </span>
			</div>
			<div class="img-container" style="margin-top: 100px">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<div class="bximg"
						style="width: 300px; height: 310px; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<div style="width: 100%; height: 100%; padding-top: 100px;">
							<h5 style="color: darkblue; font-size: 1.0rem; font-weight: 700;">[aboutrip
								event]</h5>
							<h3 style="font-weight: revert;">초특가 티켓 / 투어</h3>
						</div>
					</div>
				</div>
			</div>

			<div>
				<span id="mobile"> </span>
			</div>
			<div class="img-container" style="margin-top: 100px">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<div class="bximg"
						style="width: 300px; height: 310px; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<div style="width: 100%; height: 100%; padding-top: 100px;">
							<h5 style="color: darkblue; font-size: 1.0rem; font-weight: 700;">[aboutrip
								event]</h5>
							<h3 style="font-weight: revert;">초특가 모바일 상품</h3>
						</div>
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
						action="${pageContext.request.contextPath}/" method="post">
						<select name="condition" class="selectField">
							<option value="subject">제목</option>
							<option value="content">내용</option>
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
								<a href="">${dto.subject}</a>
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
		</div>
	</div>
</div>

<!--<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/jquery/bxslider.js"></script>-->