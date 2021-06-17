<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.table-content tr > td {
	padding-left: 5px; padding-right: 5px;
}

.reply {
	padding: 15px 0 10px;
}
.reply .table-reply tr td {
	padding-top: 0;
}

.reply .reply-list tbody tr td {
	padding: 7px 5px;
}
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userNum==dto.userNum}">
function deleteBoard() {
	var q = "num=${dto.num}&${query}";
	var url = "${pageContext.request.contextPath}/sug/delete?" + q;

	if(confirm("게시글을 삭제 하시 겠습니까 ? ")) {
			location.href=url;
	}
}
</c:if>
</script>

<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

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
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

// 개선/제안 공감 여부
$(function(){
	$(".btnSendSugLike").click(function(){
		if(! confirm("시스템 개선/제안에 공감하십니까 ? ")) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/bbs/insertBoardLike";
		var num="${dto.num}";
		var query="num="+num;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				var count = data.sugLikeCount;
				$("#sugLikeCount").text(count);
			} else if(state==="false") {
				alert("제안 공감은 한번만 가능합니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/sug/list";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#list";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}


</script>

<div class="container body-container">
    <div class="body-title">
        <h2>Suggestion </h2>
    </div>
    
    <div class="body-main wx-700 ml-30 pt-15">
		<table class="table table-border table-content">
			<tr>
				<td colspan="2" align="center">
					${dto.title}
				</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					이름 : ${dto.nickName}
				</td>
				<td width="50%" align="right">
					${dto.reg_date} 
				</td>
			</tr>
			
			<tr style="border: none;">
				<td colspan="2" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendSugLike" title="좋아요">&nbsp;👍&nbsp;<span id="sugLikeCount">${dto.sugLikeCount}</span></button>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					첨&nbsp;&nbsp;부 :
					<c:if test="${not empty dto.saveFilename}">
						<a href="${pageContext.request.contextPath}/sug/download?num=${dto.num}">${dto.originalFilename}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/sug/article?${query}&num=${preReadDto.num}">${preReadDto.title}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/sug/article?${query}&num=${nextReadDto.num}">${nextReadDto.title}</a>
					</c:if>
				</td>
			</tr>
		</table>
			
		<table class="table">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userNum==dto.userNum}">
			    			<button type="button" class="btnUpdate" onclick="javascript:location.href='${pageContext.request.contextPath}/sug/update?num=${dto.num}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btnUpdate" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userNum==dto.userNum || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btnDelete" onclick="deleteBoard();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btnDelete" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/sug/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
		
		
    </div>
    
</div>
