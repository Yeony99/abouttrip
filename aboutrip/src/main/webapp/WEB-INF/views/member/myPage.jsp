<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<br><br><br><br><br>
<div class="body-container">
	<div class="body-main">
       <ul class="navbar-nav ms-auto">
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/update">정보수정</a>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/payment">결제수단등록</a>		
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/loginLog">로그인 기록</a>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/following">팔로잉 목록</a>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/follower">팔로워 목록</a>
		</ul>
	</div>
</div>