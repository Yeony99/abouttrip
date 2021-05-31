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
<script type="text/javascript">
function sendMember(){
	var f = document.loginForm;
	
	if(! f.userId.value){
		alert("아이디 입력하세요");
		f.userId.focus();
		return false;
	}
	
	if(! f.userPwd.value){
		alert("비밀번호 입력하세요");
		f.userId.focus();
		return false;
	}
	
	f.action = "${pageContext.request.contextPath}/member/login";
	f.submit();
	
}
</script>

<body>
    <header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</header>
	
    <main class="page landing-page">
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form name="loginForm" method="post">
                <h4 class="visually-hidden"> </h4>
                <div class="illustration"><img src="${pageContext.request.contextPath}/resources/img/img/favicon.svg" style="width: 100px;height: 100px;"></div>
                <div class="mb-3"><input class="form-control" type="text" name="userId" id="userId" placeholder="아이디"></div>
                <div class="mb-3"><input class="form-control" type="password" name="userPwd" id="userPwd" placeholder="패스워드"></div>
                <div class="mb-3"><button class="btn btn-primary d-block w-100" type="sendMember();">로그인</button></div><a class="forgot" href="#">아이디 또는 비밀번호 찾기</a>
            </form>
        </section>
       
     
    </main>
    
    <div class="footer">
    	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </div>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>  
</body>

</html>