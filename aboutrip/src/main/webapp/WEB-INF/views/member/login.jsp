<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


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

<div class="body-container">
	<div class="body-main">
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form name="loginForm" method="post">
                <h4 class="visually-hidden"> </h4>
                <div class="illustration"><img src="${pageContext.request.contextPath}/resources/img/img/favicon.svg" style="width: 100px;height: 100px;"></div>
                <div class="mb-3"><input class="form-control" type="text" name="userId" id="userId" placeholder="아이디"></div>
                <div class="mb-3"><input class="form-control" type="password" name="userPwd" id="userPwd" placeholder="패스워드"></div>
                <div class="mb-3"><button class="btn btn-primary d-block w-100" onclick="sendMember();">로그인</button></div>
                <a class="forgot" href="${pageContext.request.contextPath}/member/member" style="color: white">회원가입</a>           
                <a class="forgot" href="${pageContext.request.contextPath}/member/emailfind">아이디찾기</a> 
                <a class="forgot" href="${pageContext.request.contextPath}/member/pwdfind">비밀번호찾기</a>
            </form>
        </section>
    </div>
</div>
  