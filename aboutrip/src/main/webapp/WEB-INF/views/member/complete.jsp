<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
#login-dark {
    max-width: 320px;
    width: 90%;
    background-color: #1e2833;
    padding: 40px;
    border-radius: 4px;
    transform: translate(-50%, -50%);
    position: absolute;
    top: 50%;
    left: 50%;
    color: #fff;
    box-shadow: 3px 3px 4px rgb(0 0 0 / 20%);
}

</style>


<div class="body-container">
	<div class="body-main">
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
			<div id="login-dark">
				<h4 class="visually-hidden"> </h4>
	            <div class="illustration"><img src="${pageContext.request.contextPath}/resources/img/img/favicon.svg" style="width: 100px;height: 100px;"></div>
	            <div class="mb-3">${message}</div>
	            <div class="mb-3"><button type="button" class="btn btn-primary d-block w-100" onclick="location.href='${pageContext.request.contextPath}/member/login}';">로그인하기</button></div>
			</div>	       
        </section>
    </div>
</div>
