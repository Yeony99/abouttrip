<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="container">
	<nav
		class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar" style="position: static">
		<div class="container">
			<a href="${pageContext.request.contextPath}/member/main"><img
				src="${pageContext.request.contextPath}/resources/img/img/logo.svg"></a>
			<button data-toggle="collapse" data-target="#navcol-1" class="navbar-toggler">
				<span class="visually-hidden"></span><span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navcol-1">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item dropdown"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">여행명소</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/place/mdPick">AboutTrip pick</a><a
								class="dropdown-item" href="${pageContext.request.contextPath}/place/list">한국관광공사 pick</a>
						</div></li>
					<li class="nav-item dropdown"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">다이어리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/diary/main">여행 다이어리</a>
						</div></li>
					<li class="nav-item dropdown" style="text-align: right;"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">스케줄</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/scheduler/mycalendar">캘린더</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/scheduler/share">여행루트공유</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/scheduler/mate">트립메이트</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/scheduler/review">여행후기</a>
						</div></li>
					<li class="nav-item dropdown" style="text-align: right;"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">여행상품</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/product/event">초특가 여행상품</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/product/list">패키지/티켓/유심&amp;wifi</a>
						</div></li>
					<li class="nav-item dropdown" style="text-align: right;"><a
						class="dropdown-toggle nav-link" aria-expanded="false"
						data-toggle="dropdown" href="#"
						style="color: var(- -bs-dark); text-align: left;">고객센터</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/notice/list">공지사항</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/faq/main">자주묻는질문</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/inquiry/list">문의하기</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/event/list">이벤트</a>
							<a class="dropdown-item" href="${pageContext.request.contextPath}/sug/list">제안하기</a>
						</div></li>
				</ul>
			</div>
			<div class="collapse navbar-collapse" id="navcol-1">
				<ul class="navbar-nav ms-auto">
					<c:if test="${not empty sessionScope.member}">
						<li class="nav-item"><a class="nav-link" style="color: blue">${sessionScope.member.nickName}님
						</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						<c:if test= "${sessionScope.member.userId!='admin'}">
							<li class="nav-item dropdown" style="text-align: right;"><a
							class="dropdown-toggle nav-link" aria-expanded="false"
							data-toggle="dropdown" href="#"
							style="color: var(- -bs-dark); text-align: left;">마이페이지</a>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/update">정보수정</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/payment">구매내역</a> 
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/loginLog">로그인 기록</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/following">팔로잉 목록</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/member/follower">팔로워 목록</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/product/cart">장바구니</a>
								<a class="dropdown-item" href="${pageContext.request.contextPath}/dm/receive/list">DM</a>
							</div></li>
						</c:if>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
</div>