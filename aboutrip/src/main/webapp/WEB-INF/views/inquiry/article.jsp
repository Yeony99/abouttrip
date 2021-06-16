<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.table-content {
	margin-top: 25px;
}
.table-content tr {
	border-bottom: 1px solid #ccc;
	height: 35px;
}
.table-content tr:first-child {
	border-top: 2px solid #ccc;
}
.table-content tr:last-child {
	border-bottom: 1px solid #ccc;
}
.table-content tr > td {
	padding: 7px 5px;
}

.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height:45px;
}

.btnupdate {
	border: none;
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}

.btndelete {
	border: none;
	background-color: #87CEFA;
	color: black;
	border-radius: 7px;
	
}

.btnList{
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}


a {
	text-decoration: none;
}

 
 
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin' }">
	function deleteSend() {
		var query = "num=${dto.num}&${query}";
		var url = "${pageContext.request.contextPath}/inquiry/delete?" + query;
	
		if(confirm("위 문의를 삭제 하시겠습니까 ? ")) {
			location.href=url;
		}
	}
</c:if>
</script>

<div class="body-container">
	<div class="body-title" style="padding-top: 50px;">
			<h2>INQUIRY</h2>
	</div>
    
	<div class="body-main" style="padding-bottom: 50px;">
		<table class="table table-content">
			<tr>
				<td colspan="2" align="center" style="color: blue; font-weight: 600;">
				 <span class="questionQ">Q</span><span class="questionSubject"> ${dto.num} &nbsp; | &nbsp; ${dto.type} &nbsp; | &nbsp;  ${dto.title} &nbsp; </span>
				</td>
			</tr>
			
			<tr style="font-weight: 600;">
				<td width="50%" align="left">
					작성자 : ${dto.userName}
					<c:if test="${sessionScope.member.userId=='admin'}">(${dto.userNum})</c:if>
				</td>
				<td width="50%" align="right">
					문의일자: ${dto.reg_date} 
				</td>
			</tr>
			
			<tr>
				<td colspan="2" valign="top" height="200" style="padding-left: 10px;">
					${dto.content}
				</td>
			</tr>
			
			<c:if test="${not empty dto.answer}">
				<tr>
					<td colspan="2">
						[RE] ${dto.title}
					</td>	
				</tr>
				<tr>
					<td width="50%">
						담당자 : ${dto.adminName}
					</td>
					<td width="50%">
						답변일자: ${dto.answer_date}
					</td>
				</tr>
				
				<tr>
					<td colspan="2" valign="top" height="90">
						<div style="min-height: 75px;">${dto.answer}</div>
						<c:if test="${sessionScope.member.userId=='admin'}">
							<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
								<a href="">답변삭제</a>
							</div>
						</c:if>
					</td>
				</tr>
				
			</c:if>
			
			<tr>
				<td align="left">
					<button onclick="deleteSend();" class="btndelete">문의삭제</button>
				</td>
				<td align="right">
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/inquiry/list?${query}';">리스트</button>
				</td>
			</tr>
			
		</table>
		
		<c:if test="${empty dto.answer && sessionScope.member.userId=='admin'}">
			<form name="inquiryReplyForm" method="post" enctype="multipart/form-data">
				<table class="table table-reply">
					<tr>
						<td>
							<span style="font-weight: bold;" >답변 달기 - </span><span> 문의에 대한 답변을 입력 하세요</span>
						</td>
					</tr>
					<tr>
						<td>
							<textarea name="answer" class="boxTA"></textarea>
						</td>
					</tr>
					<tr>
						<td align="right">
							<button type="button" class="btn" style="padding: 7px 20px" onclick="">답변등록</button>
						</td>
					</tr>
				</table>
				
				<input type="hidden" name="num" value="${dto.num}">
			</form>
		</c:if>
			
		
    </div>
    
</div>