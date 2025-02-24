<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<style type="text/css">
.table-content tr > td {
	padding-left: 5px; padding-right: 5px;
}
.list-content{
	display: inline-block;
	max-width: 330px;
	white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
	vertical-align: middle;
}

.body-container {
	height: 780px;
	padding: 45px;
}
form {
  max-width: 650px;
  width: 90%;
  background-color: #f8f9fa;
  padding: 40px;
  border-radius: 4px;
  color: #b4b4b4;
  box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  margin: 0px auto;
}
.tabs {
	list-style: none;
}
</style>

<script type="text/javascript">
$(function(){
	var menu = "${menuItem}";
	$("#tab-"+menu).addClass("active");

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");

		var url = "${pageContext.request.contextPath}/dm/"+tab+"/list";
		location.href=url;
	});
});

$(function(){
	$(".btnReplyDm").click(function(){
		$("#reply-dialog").dialog({
			  modal: true,
			  height: 300,
			  width: 450,
			  title: '답변 달기',
			  close: function(event, ui) {
			  }
		});

	});


	$(".btnSendOk").click(function(){
		$("#reply-dialog").dialog("close");
		
		var f = document.replyForm;
		if(!f.content.value) {
			alert("내용을 입력하세요. ");
			f.content.focus();
			return false;
		}
		
		f.action="${pageContext.request.contextPath}/dm/write";
		f.submit();
	});
	
	$(".btnSendCancel").click(function(){
		$("#reply-dialog").dialog("close");
	});

});



function deleteDm() {
	var query = "dmNums=${dto.dmNum}&${query}";
	var url = "${pageContext.request.contextPath}/dm/${menuItem}/delete?" + query;

	if(confirm("쪽지를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
}


</script>

<div class="container body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
    <form>
    <div class="body-title">
		<h2><i class="icofont-ui-messaging"></i> 쪽지함 </h2>
    </div>
    
     <div class="body-main wx-800 ml-30 pt-15">
		<div>
			<ul class="tabs">
				<li id="tab-receive" data-tab="receive">받은 쪽지함</li>
				<li id="tab-send" data-tab="send">보낸 쪽지함</li>
			</ul>
		</div>
		<div id="tab-content" style="clear:both; padding: 20px 10px 0;">	
			<table class="table">
				<tr>
					<td align="left" width="50%">
						<c:if test="${menuItem=='receive'}">
							<button type="button" class="btn btnReplyDm" >답변</button>
						</c:if>
					</td>
				</tr>
			</table>
			
			<table class="table table-border table-content">
				<tr>
					<td colspan="2" align="left">
						<c:choose>
							<c:when test="${menuItem=='receive'}">
								보낸사람 : ${dto.senderNickName}님
							</c:when>
							<c:when test="${menuItem=='send'}">
								받는사람 : ${dto.receiverNickName}님
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td width="50%" align="left">
						<c:choose>
							<c:when test="${menuItem=='receive'}">
								받은날짜 : ${dto.sendDay}
							</c:when>
							<c:when test="${menuItem=='send'}">
								보낸날짜 : ${dto.sendDay}
							</c:when>
						</c:choose>
					</td>
					<td width="50%" align="left">
						읽은날짜 : ${empty dto.identifyDay ? "읽지 않음": dto.identifyDay}
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top" height="170">
						${dto.content}
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						이전쪽지 :
						<c:if test="${not empty preDto}">
							<div class="list-content"><a href="${pageContext.request.contextPath}/dm/${menuItem}/article?${query}&dmNum=${preDto.dmNum}">${preDto.content}</a></div>
						</c:if>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						다음쪽지 :
						<c:if test="${not empty nextDto}">
							<div class="list-content"><a href="${pageContext.request.contextPath}/dm/${menuItem}/article?${query}&dmNum=${nextDto.dmNum}">${nextDto.content}</a></div>
						</c:if>
					</td>
				</tr>
			</table>

			<table class="table">
				<tr>
					<td width="50%">
						<button type="button" class="btn" onclick="deleteDm();">삭제</button>
					</td>
				
					<td align="right">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/dm/${menuItem}/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>
		
		</div>
	</div>
	</form>
	
	<div id="reply-dialog" style="display: none;">
		<form name="replyForm" method="post">
		<table class="table">
			<tr> 
				<td valign="top" style="padding-left: 10px;"> 
					<textarea name="content" class="boxTA" style="width: 97%;"></textarea>
				</td>
			</tr>
			<tr>
				<td align="right" style="padding-top: 0;">
					<button type="button" class="btn btn-dark btnSendOk">보내기</button>
					<button type="button" class="btn btnSendCancel">취소</button>
					<input type="hidden" name="receivers" value="${dto.senderNum}">
				</td>
			</tr>
		</table>
		</form>
	</div>
	
</div>
