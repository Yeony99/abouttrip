<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
// 주소 및 날짜 valid 체크 
</script>

<script src="${pageContext.request.contextPath}/resources/js/valid.js"></script>

<div class="body-container">        
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post" name="memberForm">
                <h5 class="visually-hidden">sign up</h5>
                <br>
                <div class="mb-3"><input class="form-control" type="text" name="userId" placeholder="아이디"></div>
                <div class="mb-3"><input class="form-control" type="password" name="userPwd" placeholder="패스워드"></div>
                <div class="mb-3"><input class="form-control" type="text" name="userName" placeholder="성명"></div>
                <div class="mb-3"><input class="form-control" type="text" name="nickName" placeholder="닉네임"></div>
				<div class="mb-3"><input class="form-control" type="date" name="birth" placeholder="생년월일"></div>
				<div class="mb-3">
                <input type="radio" id="male" name="gender" value="male" checked="checked">
  				<label for="male">남성</label>
  				<input type="radio" id="female" name="gender" value="female">
  				<label for="female">여성</label>
                </div>
                <div class="mb-3">
                	<input style="width: 70%;" type="text" name="zip" id="zip" value="${dto.zip}" readonly="readonly">
					<button style="border-radius: 6px; color: white; background: #214a80; float: right; padding: 6px; border: none; font-size: 13px;" type="button" onclick="daumPostcode();">우편번호</button>
				</div>
				<div class="mb-3"><input class="form-control" type="text" name="address1" id="address1" placeholder="주소" readonly="readonly" value="${dto.address1}"></div>
				<div class="mb-3"><input class="form-control" type="text" name="address2" id="address2" placeholder="상세주소" value="${dto.address2}"></div>
                <div class="mb-3"><input class="form-control" type="text" name="tel" placeholder="전화번호"></div>
                <div class="mb-3"><button class="btn btn-primary d-block w-100" type="button" onclick="memberValid();">회원가입</button></div>
            </form>
        </section>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
    function daumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') { 
                    fullAddr = data.roadAddress;

                } else {
                    fullAddr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;
                document.getElementById('address2').focus();
            }
        }).open();
    }
	</script>
</div>
