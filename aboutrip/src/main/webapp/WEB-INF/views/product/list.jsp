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
				<h2 style="font-size: 55px; color: skyblue; font-weight: bold">${msg1}</h2>
				<br>
				<h6 style="font-size: 26px; color: white; font-weight: 600">${msg2}</h6>
			</div>
		</section>
	</div>
	<div class="body-main"
		style="background: rgb(194, 231, 245); box-shadow: 0px 0px 15px rgb(0 0 0/ 40%);">
		<table style="margin: auto;">
			<tr>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					style="text-decoration: none;"
					href="${pageContext.request.contextPath}/product/list?keyword=all">전체</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					style="text-decoration: none;"
					href="${pageContext.request.contextPath}/product/list?keyword=pakage">패키지
						여행</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					style="text-decoration: none;"
					href="${pageContext.request.contextPath}/product/list?keyword=ticket">티켓
						투어</a></td>
				<td style="padding: 30px; font-size: large; font-weight: 600;"><a
					style="text-decoration: none;"
					href="${pageContext.request.contextPath}/product/list?keyword=mobile">모바일
						상품</a></td>
			</tr>
		</table>
	</div>
	<div class="body-main">
		<div id="main-container" style="background-color: rgb(240, 240, 240);">

			<div>
				<table
					style="width: 100%; border-spacing: 0; border-bottom: 1px solid #ddd;">
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<c:if test="${status.index !=0 && status.index%3 ==0}">
								<c:out value="</tr><tr>" escapeXml="false" />
							</c:if>
							<td width="210" align="center" style="border-top: 1px solid #ddd">
								<div class="imgLayout"
									style="margin-top: 12px; margin-bottom: 9px;">
									<img
										src="${pageContext.request.contextPath}/uploads/photo/${dto.img_name}"
										width="230" height="230"><br>
								</div>
							</td>
							<td>
								<ul>
									<li><span>${dto.category_name}</span></li>
									<li><span>${dto.product_name}</span></li>
									<li><span>${dto.start_date} ~ ${dto.end_date})</span></li>
									<c:if test="${dto.price!=null}">
										<li><span>${dto.price}</span></li>
									</c:if>
								</ul>
								<ul>
									<li>&nbsp;</li>
									<li>
										<button type="button" style="float: right;"
											onclick="location.href='${articleUrl}&num=${dto.code}';">
											상세보기&nbsp;&nbsp;&nbsp; <i class="fas fa-caret-right"></i>
										</button>
									</li>
									<li>&nbsp;</li>
								</ul>
							</td>
					</c:forEach>

					<c:set var="n" value="${list.size()}" />
					<c:if test="${n>0 && n%3 !=0}">
						<c:forEach var="i" begin="${n%3+1}" end="3">
							<tr>
								<td width="210" align="center"
									style="border-top: 1px solid #ddd">
									<div style="margin: 10px 0; border: 1px solid #ccc;">
										<img
											src="${pageContext.request.contextPath}/resource/images/product_soon.png"
											width="229" height="229">
									</div>
								</td>
								<td style="border-top: 1px solid #ddd">
									<div style="padding-left: 35px;">
										<span>준비 중입니다</span>
									</div>
								</td>
						</c:forEach>
					</c:if>
					<c:if test="${n!=0}">
						<c:out value="</tr>" escapeXml="false" />
					</c:if>
				</table>


			</div>
		</div>
	</div>
</div>
