<%@ page contentType="text/html; charset=UTF-8" %>
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
                <h5 class="visually-hidden">sign up</h5>
                <br>
                <div class="mb-3"><input class="form-control" type="text" name="userId" placeholder="아이디"></div>
                <div class="mb-3"><input class="form-control" type="password" name="userPwd" placeholder="패스워드"></div>
                <div class="mb-3"><input class="form-control" type="text" name="userName" placeholder="성명"></div>
                <div class="mb-3"><input class="form-control" type="text" name="nickName" placeholder="닉네임"></div>
                <div class="mb-3"><input class="form-control" type="text" name="address1" placeholder="주소"></div>
                <div class="mb-3"><input class="form-control" type="text" name="address2" placeholder="상세주소"></div>
                <div class="mb-3"><input class="form-control" type="text" name="tel" placeholder="전화번호"></div>
                <div class="mb-3"><input class="form-control" type="date" name="birth" placeholder="생년월일"></div>
                <div class="mb-3">
                <input type="radio" id="male" name="gender" value="male">
  				<label for="male">Male</label>
  				<input type="radio" id="female" name="gender" value="female">
  				<label for="female">Female</label>
                </div>
                <div class="mb-3"><button class="btn btn-primary d-block w-100" type="submit">회원가입</button></div>
            </form>
        </section>
    </main>
    
    <div class="footer">
    	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
    </div>
<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>  
</body>

</html>
