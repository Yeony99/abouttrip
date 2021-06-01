<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- <script src="${pageContext.request.contextPath}/resources/js/valid.js"></script> --%>
<script>
function memberValid(){
	var f = document.memberForm;
	var str;
	str = f.userId.value;
	str = str.trim();
	if (!str) {
		alert("아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}
	if (!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	f.userId.value = str;
	str = f.userPwd.value;
	str = str.trim();
	if (!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}
	if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,30}$/i.test(str)) {
		alert("패스워드는 5~30자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.userPwd.focus();
		return;
	}

	str = f.userName.value;
	str = str.trim();
	if (!str) {
		alert("이름을 입력하세요. ");
		f.userName.focus();
		return;
	}
	f.userName.value = str;
	
	str = f.nickName.value;
	str = str.trim();
	if (!str) {
		alert("닉네임을 입력하세요. ");
		f.nickName.focus();
		return;
	}
	str = f.birth.value;
	str = str.trim();
	if (!str || !isValidDateFormat(str)) {
		alert("생년월일를 입력하세요. ");
		f.birth.focus();
		return;
	}
	str = f.tel.value;
	str = str.trim();
	if (!str) {
		alert("전화번호를 입력하세요. ");
		f.tel.focus();
		return;
	}
	if (!/^(\d+)$/.test(str)) {
		alert("숫자만 가능합니다. ");
		f.tel.focus();
		return;
	}
	
	f.action = "${pageContext.request.contextPath}/member/${mode}";
	f.submit();
}
function isValidDateFormat(data){
	  var regexp = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;
	    if(! regexp.test(data))
	        return false;

	    regexp=/(\.)|(\-)|(\/)/g;
	    data=data.replace(regexp, "");
	    
		var y=parseInt(data.substr(0, 4));
	    var m=parseInt(data.substr(4, 2));
	    if(m<1||m>12) 
	    	return false;
	    var d=parseInt(data.substr(6));
	    var lastDay = (new Date(y, m, 0)).getDate();
	    if(d<1||d>lastDay)
	    	return false;
			
		return true;
}
</script>
<div class="body-container">        
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post" name="memberForm">
                <h5 class="visually-hidden">sign up</h5>
                <br>
                <div class="mb-3"><input class="form-control" type="text" name="userId" placeholder="aboutrip@aboutrip.com"></div>
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
                	<input style="color:white; background:none; border:none; border-bottom: 1px solid #434a52; width: 64%;" type="text" name="zip" id="zip" value="${dto.zip}" readonly="readonly">
					<button style="border-radius: 5px; color: white; background: #214a80; float: right; padding: 6px; font-size: 13px; border: none;" type="button" onclick="daumPostcode();">우편번호</button>
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
