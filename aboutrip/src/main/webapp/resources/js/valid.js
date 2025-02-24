function memberValid() {
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
	
/*	if (document.getElementById('tos').checked == false) {
		  alert('이용 약관에 동의해주세요.');
		return;
	}*/
	
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