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
			<div class="container">
				<a class="navbar-brand logo"></a>
				<a href="${pageContext.request.contextPath}/member/main"><img 
					src="${pageContext.request.contextPath}/resources/img/img/logo.svg"></a>
				
				<button data-bs-toggle="collapse" class="navbar-toggler"
					data-bs-target="#navcol-1">
					<span class="visually-hidden">toggle</span><span
						class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navcol-1">
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link active"
							href="index.html">여행명소</a></li>
						<li class="nav-item"><a class="nav-link active" href="#">스케줄</a></li>
						<li class="nav-item"><a class="nav-link active" href="#">여행상품</a></li>
						<li class="nav-item"><a class="nav-link active" href="#">다이어리</a></li>
						<li class="nav-item"><a class="nav-link active" href="#">고객센터</a></li>
						<li class="nav-item"></li>
						<li class="nav-item"></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/login">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/member">회원가입</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>

</body>
</html>