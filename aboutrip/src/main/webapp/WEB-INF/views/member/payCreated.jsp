<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
function cardValid(){
	var f = document.memberForm;
	var str;
	str = f.cardName.value;
	str = str.trim();
	if (!str) {
		alert("카드이름을 입력하세요 ");
		f.cardName.focus();
		return;
	}
	str = f.paymentCode.value;
	str = str.trim();
	if (!str) {
		alert("카드 번호를 입력하세요");
		f.paymentCode.focus();
		return;
	}

	if (!/^[0-9]{12}$/i.test(str)) {
		alert("카드번호를 숫자만적어서 12자를 입력하세요");
		f.paymentCode.focus();
		return;
	}
	
	
	f.action = "${pageContext.request.contextPath}/member/${mode}";
	f.submit();
}
</script>
<div class="body-container">        
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post" name="memberForm" enctype="multipart/form-data">
                <div class="mb-3"><input class="form-control" type="text" name="cardName" placeholder="카드이름" value="${dto.cardName }"></div>
                <div class="mb-3"><input class="form-control" type="text" name="paymentCode" placeholder="카드번호" value="${dto.paymentCode }"></div>
				
                <div class="mb-3"><button class="btn btn-primary d-block w-100" type="button" onclick="cardValid();">카드등록</button></div>
            </form>
        </section>
</div>