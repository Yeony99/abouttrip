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
		<div class="header">
			<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
		</div>
	</header>
	
    <main class="page landing-page">
        <!-- 내용채우세요 -->
    </main>
    
    <footer>
	    <div class="footer">
	    	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	    </div>
    </footer>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>    
</body>
</html>