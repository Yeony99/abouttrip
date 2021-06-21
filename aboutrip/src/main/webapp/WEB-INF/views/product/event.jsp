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
			style="min-height:400px; background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju_tour1.jpg&quot;);color: rgba(100, 100, 255, 0.1);">
			<div class="text">
				<h2 style="font-size: 55px; color: skyblue; font-weight: bold">ABOUTRIP
					초특가상품</h2>
				<br>
				<h6 style="font-size: 26px; color: white; font-weight: 600">어바웃트립의
					초특가 이벤트 상품들을 소개합니다.</h6>
			</div>
		</section>
	</div>
	<div class="body-main" style="background: rgb(194, 231, 245); box-shadow: 0px 0px 15px rgb(0 0 0 / 40%);">
		<table style="margin: auto; ">
			<tr>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a style="text-decoration: none;"
					href="#package">패키지 여행</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a style="text-decoration: none;"
					href="#ticket">티켓 / 투어</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a style="text-decoration: none;"
					href="#mobile">모바일 상품</a></td>
			</tr>
		</table>
	</div>
	<div class="body-main">
		<div id="main-container" style="background-color: rgb(240, 240, 240);">
			<div class="img-container" style="margin-top: 5px">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<table id="package" style="margin-bottom: 50px; margin-top: 50px;">
						<tr>
							<td
								style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
								<div class="bximg"
									style="height: 100%; overflow: hidden; border-radius: 1rem;">
									<div style="width: 100%; height: 100%; padding-top: 100px;">
										<h5	style="color: darkblue; font-size: 1.0rem; font-weight: 700;">[aboutripevent]</h5>
										<h3 style="font-weight: revert;">초특가 패키지 여행</h3>
									</div>
								</div>
							</td>

							<c:forEach var="dto" items="${package_list}" varStatus="status">
								<c:if
									test="${status.index !=0 && status.index !=1 && (status.index-1)%3 == 0}">
									<c:out value="</tr><tr>" escapeXml="false" />
								</c:if>
								<td
									style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
									<div class="bximg"
										style="border-radius: 1rem; background-color: white; overflow: hidden;">
										<a href="#"><img class="box-img"
											src="${pageContext.request.contextPath}/resources/img/img/${dto.img_name}"
											alt="${dto.product_name}" title="${dto.product_name}"
											style="width: 100%; height: 200px; object-fit: cover;">
										</a>
										<div style="margin: 20px 10px 0px; height: 55px">
											<span style="vertical-align: top; font-weight: bold; font-size: large;">${dto.product_name}</span>
										</div>
										<div style="margin: 0px 10px;">${dto.price}원
										<c:url var="url" value="/booking/article">
											<c:param name="code" value="${dto.code}"/>
										</c:url>
											<a href="${pageContext.request.contextPath}/product/article?code=${dto.code}" style="float: right;">자세히보기</a>
										</div>
									</div>
								</td>
							</c:forEach>
							<c:set var="n" value="${package_list.size()}" />
							<c:if test="${n == 0 || n < 4 && n%3 != 0}">
								<c:forEach var="i" begin="${n%3+1}" end="3">
									<td
										style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
										<div class="bximg"
											style="height: 100%; background-color: white; overflow: hidden; border-radius: 1rem;">
											&nbsp;</div>
									</td>
								</c:forEach>
							</c:if>
							<c:if test="${n > 4 && n%3 != 0}">
								<c:forEach var="i" begin="${n%3+1}" end="3">
									<td
										style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
										<div class="bximg"
											style="height: 100%; background-color: white; overflow: hidden; border-radius: 1rem;">
											&nbsp;</div>
									</td>
								</c:forEach>
							</c:if>
						</tr>
					</table>

					<table id="ticket" style="margin-bottom: 50px; margin-top: 50px;">
						<tr>
							<td
								style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
								<div class="bximg"
									style="height: 100%; overflow: hidden; border-radius: 1rem;">
									<div style="width: 100%; height: 100%; padding-top: 100px;">
										<h5
											style="color: darkblue; font-size: 1.0rem; font-weight: 700;">[aboutripevent]</h5>
										<h3 style="font-weight: revert;">초특가 티켓 / 투어</h3>
									</div>
								</div>
							</td>

							<c:forEach var="dto" items="${ticket_list}" varStatus="status">
								<c:if
									test="${status.index !=0 && status.index !=1 && (status.index-1)%3 == 0}">
									<c:out value="</tr><tr>" escapeXml="false" />
								</c:if>
								<td
									style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
									<div class="bximg"
										style="border-radius: 1rem; background-color: white; overflow: hidden;">
										<a href="#"><img class="box-img"
											src="${pageContext.request.contextPath}/resources/img/img/${dto.img_name}"
											alt="${dto.product_name}" title="${dto.product_name}"
											style="width: 100%; height: 200px; object-fit: cover;">
										</a>
										<div style="margin: 20px 10px 0px; height: 55px">
											<span
												style="vertical-align: top; font-weight: bold; font-size: large;">${dto.product_name}</span>
										</div>
										<div style="margin: 0px 10px;">${dto.price}원
											<a href="${pageContext.request.contextPath}/product/article?code=${dto.code}" style="float: right;">자세히보기</a>
										</div>
									</div>
								</td>
							</c:forEach>
							<c:set var="n" value="${ticket_list.size()}" />
							<c:if test="${n == 0 || n < 4 && n%3 != 0}">
								<c:forEach var="i" begin="${n%3+1}" end="3">
									<td
										style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
										<div class="bximg"
											style="height: 100%; background-color: white; overflow: hidden; border-radius: 1rem;">
											&nbsp;</div>
									</td>
								</c:forEach>
							</c:if>
							<c:if test="${n > 4 && n%3 != 0}">
								<c:forEach var="i" begin="${n%3+1}" end="3">
									<td
										style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
										<div class="bximg"
											style="height: 100%; background-color: white; overflow: hidden; border-radius: 1rem;">
											&nbsp;</div>
									</td>
								</c:forEach>
							</c:if>
						</tr>
					</table>
					<table id="mobile" style="margin-bottom: 50px; margin-top: 50px;">
						<tr>
							<td
								style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
								<div class="bximg"
									style="height: 100%; overflow: hidden; border-radius: 1rem;">
									<div style="width: 100%; height: 100%; padding-top: 100px;">
										<h5
											style="color: darkblue; font-size: 1.0rem; font-weight: 700;">[aboutripevent]</h5>
										<h3 style="font-weight: revert;">초특가 모바일 상품</h3>
									</div>
								</div>
							</td>

							<c:forEach var="dto" items="${mobile_list}" varStatus="status">
								<c:if
									test="${status.index !=0 && status.index !=1 && (status.index-1)%3 == 0}">
									<c:out value="</tr><tr>" escapeXml="false" />
								</c:if>
								<td
									style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
									<div class="bximg"
										style="border-radius: 1rem; background-color: white; overflow: hidden;">
										<a href="#"><img class="box-img"
											src="${pageContext.request.contextPath}/resources/img/img/${dto.img_name}"
											alt="${dto.product_name}" title="${dto.product_name}"
											style="width: 100%; height: 200px; object-fit: cover;">
										</a>
										<div style="margin: 20px 10px 0px; height: 55px">
											<span
												style="vertical-align: top; font-weight: bold; font-size: large;">${dto.product_name}</span>
										</div>
										<div style="margin: 0px 10px;">${dto.price}원
											<a href="${pageContext.request.contextPath}/product/article?code=${dto.code}" style="float: right;">자세히보기</a>
										</div>
									</div>
								</td>
							</c:forEach>
							<c:set var="n" value="${mobile_list.size()}" />
							<c:if test="${n == 0 || n < 4 && n%3 != 0}">
								<c:forEach var="i" begin="${n%3+1}" end="3">
									<td
										style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
										<div class="bximg"
											style="height: 100%; background-color: white; overflow: hidden; border-radius: 1rem;">
											&nbsp;</div>
									</td>
								</c:forEach>
							</c:if>
							<c:if test="${n > 4 && n%3 != 0}">
								<c:forEach var="i" begin="${n%3+1}" end="3">
									<td
										style="width: 330px; height: 310px; margin-top: 10px; padding-left: 15px; padding-right: 15px;">
										<div class="bximg"
											style="height: 100%; background-color: white; overflow: hidden; border-radius: 1rem;">
											&nbsp;</div>
									</td>
								</c:forEach>
							</c:if>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
