<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<div class="body-container">
	<div class="body-main">
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
			<form name="emailFind" method="post" action="${pageContext.request.contextPath}/member/emailfind">
				<h4 class="visually-hidden"> </h4>
	            <div class="illustration"><img src="${pageContext.request.contextPath}/resources/img/img/favicon.svg" style="width: 100px;height: 100px;"></div>
                <div class="mb-3"><input class="form-control" type="text" name="userName" id="userName" placeholder="이름"></div>
                <div class="mb-3"><input class="form-control" type="text" name="tel" id="tel" placeholder="전화번호"></div>
	            <div class="mb-3"><button type="submit" class="btn btn-primary d-block w-100">이메일 찾기</button></div>
			</form>
        </section>
    </div>
</div>
