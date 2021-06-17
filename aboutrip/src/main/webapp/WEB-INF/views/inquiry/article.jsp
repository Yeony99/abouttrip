<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.answer{
	width: 100%;
	min-height: 300px;
}

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
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}


a {
	text-decoration: none;
}

 
 
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userNum==dto.userNum }">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status===410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	} else if(jqXHR.status===402) {
	    		alert("권한이 없습니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
	
	
	function deleteSend() {
		var query = "num=${dto.num}&${query}";
		var url = "${pageContext.request.contextPath}/inquiry/delete?" + query;
	
		if(confirm("문의를 삭제 하시겠습니까 ? ")) {
			location.href=url;
		}
	}
	
	function deleteInquiryAnswer(num, page) {
		var url="${pageContext.request.contextPath}/inquiry/deleteAnswer";
		var query="num="+num;
		
		if(confirm("답변을 삭제 하시겠습니까 ? ")) {
			return;
		}
		
		var fn = function(data){
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	}
	
	function sendInquiryReplyOk() {
		 var f = document.inquiryReplyForm;
		    var str;
		    
			str = f.answer.value;
		    if(!str) {
		        alert("답변을 입력하세요. ");
		        f.answer.focus();
		        return;
		    }
		    
		    var url="${pageContext.request.contextPath}/inquiry/reply";
		    var query = $("form[name=inquiryReplyForm]").serialize();
		    
			var fn = function(data){
				var state=data.state;
		        if(state=="false") {
		            alert("답변을 추가하지 못했습니다. !!!");
		        }
		        
		    	if(page==undefined || page=="") {
		    		page="1";
		    	}
		    	
			};
			
			ajaxFun(url, "post", query, "json", fn);		
		}
	
	function replyForm(num, page) {
		var $tab = $(".tabs .active");
		var tab = $tab.attr("data-tab");
		
		var url="${pageContext.request.contextPath}/inquiry/"+tab+"/answer";
		var query="num="+num+"&pageNo="+page
		var selector = "#tab-content";
		
		var fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
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
				<tr style="font-weight: 600; background: #EAEAEA">
					<td colspan="2">
						[RE] ${dto.title}
					</td>	
				</tr>
				<tr style="font-weight: 600; background: #EAEAEA">
					<td width="50%" align="left">
						담당자 : 관리자
					</td>
					<td width="50%" align="right">
						답변일자: ${dto.answer_date}
					</td>
				</tr>
				
				<tr style="background: #EAEAEA">
					<td colspan="2" valign="top" height="90">
						<div style="min-height: 75px;">${dto.answer}</div>
						<c:if test="${sessionScope.member.userId=='admin'}">
							<div style="margin-top: 5px; margin-bottom: 5px; text-align: right;">
								<a href="javascript:deleteInquiryAnswer('${dto.num}', '${pageNo}')">답변삭제</a>
							</div>
						</c:if>
					</td>
				</tr>
				
			</c:if>
			
			<tr style="background: #EAEAEA">
				<td align="left">
					<button type="button" onclick="deleteSend();" class="btndelete">문의삭제</button>
				</td>
				<td align="right">
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/inquiry/list?${query}';">리스트</button>
				</td>
			</tr>
			
		</table>
		
		<c:if test="${empty dto.answer && sessionScope.member.userId=='admin'}">
			<form name="inquiryReplyForm" method="post" enctype="multipart/form-data">
				<table class="table table-reply" style="background: #EAEAEA">
					<tr>
						<td>
							<span style="font-weight: bold;" >관리자 - 답변 달기 </span>
						</td>
					</tr>
					<tr>
						<td>
							<textarea name="answer" class="answer" placeholder="답변내용을 입력해주세요."></textarea>
						</td>
					</tr>
					<tr>
						<td align="right">
							<button type="button" class="btnupdate" style="padding: 7px 20px" onclick="sendInquiryReplyOk('${pageNo}');">답변등록</button>
						</td>
					</tr>
				</table>
				
				<input type="hidden" name="num" value="${dto.num}">
			</form>
		</c:if>
			
		
    </div>
    
</div>