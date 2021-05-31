<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>AboutTrip</title>
</head>

<body>
	<header>
		<nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
	        <div class="container"><a href="${pageContext.request.contextPath}/member/main"><img src="${pageContext.request.contextPath}/resources/img/img/logo.svg"></a><button data-bs-toggle="collapse" data-bs-target="#navcol-1" class="navbar-toggler"><span class="visually-hidden"></span><span class="navbar-toggler-icon"></span></button>
	            <div class="collapse navbar-collapse" id="navcol-1">
	                <ul class="navbar-nav ms-auto">
	                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#" style="color: var(--bs-dark);text-align: left;">여행명소</a>
	                        <div class="dropdown-menu"><a class="dropdown-item" href="#">AboutTrip pick</a><a class="dropdown-item" href="#">한국관광공사 pick</a></div>
	                    </li>
	                    <li class="nav-item dropdown"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#" style="color: var(--bs-dark);text-align: left;">다이어리</a>
	                        <div class="dropdown-menu"><a class="dropdown-item" href="#">여행 다이어리</a></div>
	                    </li>
	                    <li class="nav-item dropdown" style="text-align: right;"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#" style="color: var(--bs-dark);text-align: left;">스케줄</a>
	                        <div class="dropdown-menu"><a class="dropdown-item" href="#">캘린더</a><a class="dropdown-item" href="#">동선관리</a><a class="dropdown-item" href="#">그룹정산</a></div>
	                    </li>
	                    <li class="nav-item dropdown" style="text-align: right;"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#" style="color: var(--bs-dark);text-align: left;">여행상품</a>
	                        <div class="dropdown-menu"><a class="dropdown-item" href="#">초특가 여행상품</a><a class="dropdown-item" href="#">BEST 인기상품</a><a class="dropdown-item" href="#">패키지/티켓/유심&amp;wifi</a></div>
	                    </li>
	                    <li class="nav-item dropdown" style="text-align: right;"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#" style="color: var(--bs-dark);text-align: left;">고객센터</a>
	                        <div class="dropdown-menu"><a class="dropdown-item" href="#">공지사항</a><a class="dropdown-item" href="#">FAQ</a><a class="dropdown-item" href="#">문의하기</a><a class="dropdown-item" href="#">이벤트</a><a class="dropdown-item" href="#">시스템 개선/제안</a></div>
	                    </li>
	                </ul>
	            </div>
	            <div class="collapse navbar-collapse" id="navcol-1">
	                <ul class="navbar-nav ms-auto">
	                	<c:if test="${not empty sessionScope.member}">
			                <li class="nav-item">${sessionScope.member.nickName}</li>님
			                <li class="nav-item">
			                <a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
			                &nbsp;|&nbsp;
			                <c:if test="${sessionScope.member.userId=='admin'}">
			                    &nbsp;|&nbsp;
			                    <a href="${pageContext.request.contextPath}/admin">관리자</a>
			                </c:if>
			            </c:if>
	                </ul>
	            </div>
	        </div>
	    </nav>
	</header>

</body>
</html>