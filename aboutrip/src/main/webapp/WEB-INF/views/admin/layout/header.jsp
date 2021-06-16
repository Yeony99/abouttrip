<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="container">
	<nav
		class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar" style="position: static;">
		<div class="container">
			<a href="${pageContext.request.contextPath}/admin/main"><img
				src="${pageContext.request.contextPath}/resources/img/img/logo.svg"></a>
			<button data-bs-toggle="collapse" data-target="#navcol-1" class="navbar-toggler">
				<span class="visually-hidden"></span><span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navcol-1">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item dropdown" style="text-align: right;"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">회원관리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/memManage/list">회원리스트</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/memManage/analysis">회원분석</a>
						</div></li>
				
					<li class="nav-item dropdown"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">여행명소 관리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/place/mdPick">AboutTrip pick 관리</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/place/list">한국관광공사 pick 관리</a>
						</div></li>
					<li class="nav-item dropdown"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">페이지 관리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/diaryManage/list">다이어리</a>
							<a class="dropdown-item" href="#">스케줄</a>
						</div></li>
					<li class="nav-item dropdown" style="text-align: right;"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">여행상품 관리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/productmanage/productmanagement">여행상품 관리</a>
							<a class="dropdown-item" href="#">회원구매 및 취소내역관리</a>
							<a class="dropdown-item" href="#">매출현황 분석</a>	
							<a class="dropdown-item" href="#">상품별 QNA 관리</a>	
						</div></li>
					<li class="nav-item dropdown" style="text-align: right;"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">고객센터 관리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/notice/list">공지사항 작성</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/faq/main">FAQ 작성</a>
						    <a class="dropdown-item" href="${pageContext.request.contextPath}/inquiry/list">문의 답변</a>
							<a class="dropdown-item" href="#">이벤트 작성</a>
							<a class="dropdown-item" href="#">시스템 개선/제안 답변</a>
						</div></li>
				</ul>
			</div>
			<div class="collapse navbar-collapse" id="navcol-1">
				<ul class="navbar-nav ms-auto">
					<c:if test="${not empty sessionScope.member}">
						<li class="nav-item"><a class="nav-link" style="color: blue">${sessionScope.member.nickName}님
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
</div>