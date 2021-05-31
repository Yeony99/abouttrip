<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>main</title>
	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
</head>

<body>
    <header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>
	
    <main class="page landing-page">
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post">
                <h4 class="visually-hidden"> </h4>
                <div class="illustration"><img src="${pageContext.request.contextPath}/resources/img/img/favicon.svg" style="width: 100px;height: 100px;"></div>
                <div class="mb-3"><input class="form-control" type="text" name="id" placeholder="id"></div>
                <div class="mb-3"><input class="form-control" type="password" name="password" placeholder="password"></div>
                <div class="mb-3"><button class="btn btn-primary d-block w-100" type="submit">Log In</button></div><a class="forgot" href="#">Forgot your id or password?</a>
            </form>
        </section>
       
     
    </main>
    
    <div class="footer">
    	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </div>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>  
</body>

</html>