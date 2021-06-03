<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
	<title>Aboutrip</title>
</head>
<body>
<h1>
	여행전문 웹사이트 Aboutrip 입니다!  
</h1>

<P>  현재시간 ${serverTime}. </P>
<p> <a href="${pageContext.request.contextPath}/member/login">홈페이지로 가기</a>
</body>
</html>
