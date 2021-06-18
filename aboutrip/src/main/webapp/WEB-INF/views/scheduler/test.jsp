<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function sendtest(){
	var f = document.mateForm;
	f.action ="${pageContext.request.contextPath}/scheduler/insertMate";
	f.submit();
	check=true;
}

function testlist(){
	var f = document.testForm;
	
	f.action ="${pageContext.request.contextPath}/scheduler/matelist";
	f.submit();
}

function bringPlace() {
	var f = document.mateForm;
	
	var str = f.ctgNum.value;
	if(str!="") {
		f.ctgNum.value=str;
	}
}
</script>
<body>
<div class="container body-container">
    <div class="body-main wx-800 ml-30 pt-15" style="margin: 4rem 0;">
    	<div style="display: flex; justify-content: center">
			<h3>트립 메이트를 찾습니다 👋🏻</h3>
		</div>
		
<!-- <form name="mateForm" method="post">
		<div class="mate-header">
			<div>
				<label style="width: 80%"> 제목 <input type="text" id="subject"></label>
			</div>
			<div>
				<label> 출발 <input type="date" id="form-checkin"> </label> ~ <label> 도착 <input type="date" id="form-checkout"> </label>  
			</div>
			<div style="margin-top: 1rem;">
				<label> 장소
					<select name="ctg" onchange="bringPlace();" id="ctg">
						<option value="">선 택</option>
						<option value="1" ${dto.ctgNum=="1" ? "selected='selected'" : ""}>서울</option>
						<option value="2" ${dto.ctgNum=="2" ? "selected='selected'" : ""}>부산</option>
						<option value="3" ${dto.ctgNum=="3" ? "selected='selected'" : ""}>제주 제주시</option>
						<option value="4" ${dto.ctgNum=="4" ? "selected='selected'" : ""}>제주 서귀포</option>
						<option value="5" ${dto.ctgNum=="5" ? "selected='selected'" : ""}>제주 성산</option>
						<option value="6" ${dto.ctgNum=="6" ? "selected='selected'" : ""}>제주 기타</option>
					</select>
					<input type="hidden" value="${dto.ctgNum}" name="ctgNum">
				</label>
			</div>
			<div style="margin-top: 1rem;">
				<label> 메이트 인원 <input type="number" min="1" max="3" id="mate_num"> &nbsp;&nbsp;&nbsp; <span style="color: red">※ 코로나19 방역지침에 따라 5인 이상 모임은 불가능합니다.</span> </label>  
			</div>
			<div>
				<textarea name="content" id="content" placeholder="당신의 여행 계획을 알려주세요 .&#13;&#10;세부 일정 및 여행 스타일을 알리고 메이트를 찾아보세요." style="margin-top: 1rem;"></textarea>
			</div>
			<div>
				<button type="button" class="btn btnSendMate" onclick="sendMate();"> 등록하기 </button>
			</div>
		</div>
		</form>
-->
		
		<div class="mate" style="width: 70vw; margin:2rem auto">
			<form name="mateForm" method="post" accept-charset="utf-8">
			<table class="table table-mate">
				<tr> 
					<td align='left'>
						<span style='font-weight: bold;' >🧭 당신의 여행 계획을 알려주세요!</span>
					</td>
					<td colspan="2">
						<span style="color: red">※ 코로나19 방역지침에 따라 5인 이상 모임은 불가능합니다.</span> 
					</td>
				</tr>
				<tr>
					<td>
						<label> 장소
						<select name="ctgNum" onchange="bringPlace();" id="ctg" style="width: 200px;">
							<option value="">선 택</option>
							<option value="1" ${dto.ctgNum=="1" ? "selected='selected'" : ""}>서울</option>
							<option value="2" ${dto.ctgNum=="2" ? "selected='selected'" : ""}>부산</option>
							<option value="3" ${dto.ctgNum=="3" ? "selected='selected'" : ""}>제주 제주시</option>
							<option value="4" ${dto.ctgNum=="4" ? "selected='selected'" : ""}>제주 서귀포</option>
							<option value="5" ${dto.ctgNum=="5" ? "selected='selected'" : ""}>제주 성산</option>
							<option value="6" ${dto.ctgNum=="6" ? "selected='selected'" : ""}>제주 기타</option>
						</select><%-- 
						<input type="hidden" value="${dto.ctgNum}" name="ctgNum"> --%>
						</label>
					</td>
					<td>
						<label> 메이트 인원 <input type="number" min="1" max="3" id="people_num" name='peple_num' value="1"></label>
					</td>
					<td>
						<label> 출발 <input type="date" id="form-checkin" name="start_date"> </label> ~ <label> 도착 <input type="date" id="form-checkout" name="end_date"> </label> 
					</td>
					<td colspan="2">
						<input type="text" name="subject" placeholder="제목">
					</td>
				</tr>
				
				<tr>
					<td colspan="3">
						<textarea class='boxTA' style='width:100%; height: 300px;' id="content" name="content" placeholder="즐거운 여행이 될 수 있도록 자세한 계획을 알려주세요!"></textarea>
					</td>
				</tr>
				<tr>
				   <td align='right' colspan="3">
				        <button type='button' class='btn' style='padding:7px 20px;' onclick="sendtest();">등록</button>
				        
				    </td>
				 </tr>
			</table>
			</form>
						</div>			
		</div>
	</div>
	<form name="testForm" method="post">
				<button type="button" class="btn" onclick="testlist();">목록보기</button>
			</form>
<c:forEach var="dto" items="${list}">
						<tr align="center" height="55"
							style="border-bottom: 1px solid #ddd;">
							<td width="60">${dto.subject}</td></tr>
					</c:forEach>
</body>
</html>