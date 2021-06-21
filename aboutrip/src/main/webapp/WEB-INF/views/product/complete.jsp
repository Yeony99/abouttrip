<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="body-container">
	<div class="body-main">
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
			<div id="login-dark">
				<h4 class="visually-hidden"> </h4>
	            <div class="illustration"><img src="${pageContext.request.contextPath}/resources/img/img/favicon.svg" style="width: 100px;height: 100px;"></div>
	            <div class="mb-3">${message}</div>
	            <div class="mb-3"><button type="button" class="btn btn-primary d-block w-100" onclick="location.href='${pageContext.request.contextPath}/member/main}';">메인메뉴로 돌아가기</button></div>
			</div>	       
        </section>
    </div>
</div>