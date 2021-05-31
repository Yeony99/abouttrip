<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>main</title>
	<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>
</head>

<body>
	<header class="header">
		<tiles:insertAttribute name="header"/>
	</header>
	
   <main class="body">
        <section class="clean-block clean-hero" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/bg.jpg&quot;);color: rgba(9, 162, 255, 0.3);">
            <div class="text">
            	 <h2 style="font-size: 60px;text-shadow: 0px 0px;font-family: Actor, sans-serif;"><img src="${pageContext.request.contextPath}/resources/img/img/logo.svg"></h2>
                <p style="font-size: 20px;"><br><strong>여행을 여행답게</strong><br><br>국내 여행 일정부터 예약까지 <br>간편하게 어바웃트립으로 시작하세요.<br><br></p><button class="btn btn-outline-light btn-lg" type="button" style="font-size: 30px;">여행 떠나기 🛫<br></button>
            </div>
        </section>
    </main>
    
    <footer>
    	<tiles:insertAttribute name="footer"/>
    </footer>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>    
</body>
</html>