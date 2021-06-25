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
	padding-left: 5px; padding-right: 5px;
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


.btnSendpartEvent{
	background-color: black;
	color: #fff;
	border-radius: 7px;
}

.btnSendpartEvent:hover{
	background-color: black;
	color: #87CEFA;
	border-radius: 7px;
}

.btnSendwinEvent{
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}

.btnSenddeleteEvent{
	border: 1px solid #EAEAEA;
}

a {
	text-decoration: none;
}


</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin'}">
function deleteBoard() {
	var q = "num=${dto.num}&${query}";
	var url = "${pageContext.request.contextPath}/event/delete?" + q;

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

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "${pageContext.request.contextPath}/event/list";
	var query = "num=${dto.num}&page="+page;
	var selector = "#listPart";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

//이벤트 신청
$(function(){
	$(".btnSendpartEvent").click(function(){
		if(! confirm("이벤트 신청하시겠습니까?")){
			return false;
		}
		
		var url="${pageContext.request.contextPath}/event/partEvent";
		var num="${dto.num}";
		var query="num="+num;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				alert("이벤트에 참여했습니다.");
				location.reload();
			} else if(state==="false") {
				alert("이벤트 참여는 한번만 가능합니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//이벤트 취소
$(function(){
	$(".btnSenddeleteEvent").click(function(){
		if(! confirm("이벤트 신청을 취소하시겠습니까?")){
			return false;
		}
		
		var url="${pageContext.request.contextPath}/event/deletePart?";
		var num="${dto.num}";
		var partNum="${dto.partNum}";
		var query="num="+num+"&partNum="+partNum;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				alert("이벤트에 참여를 취소했습니다.");
				location.reload();
			} else if(state==="false") {
				alert("이벤트 취소에 실패했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});


//이벤트 당첨 버튼 
$(function(){
	$(".btnSendwinEvent").click(function(){		
		var url="${pageContext.request.contextPath}/event/winEvent";
		var num="${dto.num}";
		var query="num="+num;
		
		var fn = function(data){
			
			var state=data.state;
			if(state==="true") {
				alert("이벤트에 당첨 추출에 성공했습니다.");
				location.reload();
			} else if(state==="false") {
				alert("이벤트 당첨추출에 실패했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});



</script>

<div class="body-container">
    <div class="body-title" style="padding-top: 50px;">
        <h2>🎁 이벤트</h2>
    </div>
    
    <div class="body-main" style="padding-bottom: 50px;">
		<table class="table table-content">
			<tr>
				<td colspan="2" align="center" style="color: blue; font-weight: 600;">
					${dto.title}
				</td>
			</tr>
			
			<tr style="font-weight: 600;">
				<td width="10%" align="left">
					이름 : ${dto.nickName}
				</td>
				<td width="90%" align="right">
					이벤트 기간: ${dto.eventStart}  ~ ${dto.eventEnd} &nbsp; | &nbsp; 발표일: ${dto.winDate} &nbsp; | &nbsp; 이벤트 당첨 상품: ${dto.present}
				</td>
			</tr>
			
			
			
			<tr style="border-bottom: 1px solid white">
				<td colspan="2" valign="top" height="200" style="padding-left: 10px;">
					${dto.content}
				</td>
			</tr>
			
			
			<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/event/article?${query}&num=${preReadDto.num}">${preReadDto.title}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/event/article?${query}&num=${nextReadDto.num}">${nextReadDto.title}</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendpartEvent" title="이벤트 신청"> ❤ 이벤트 신청  버튼</button> 
					<button type="button" class="btn btnSenddeleteEvent" title="이벤스 신청 취소"> 🗑 이벤트 신청 취소 버튼</button>
				</td>
			</tr>
		</table>
			
		<c:if test="${not empty dto.partNum && sessionScope.member.userId=='admin'}">
			<table class="table table-content">
				<tr>
					<td align="center" style="background: #87CEFA  "> 
						<span id="partCount">참가자 수: ${dto.partCount}</span>
					</td>				
				</tr>
				<tr>		
					<td align="center" style="background: #EAEAEA "> 
						참가번호 | 회원 번호 | 회원 이름 | 참여일
					</td>
				</tr>		
						<c:forEach var="dto" items="${listPart}">
							<tr>
								<td align="center">
									${dto.partNum} | ${dto.userNum} | ${dto.nickName} | ${dto.partDate}
								</td>
							</tr>
						</c:forEach>
				
				<tr>
					<td align="center" style="padding-top: 30px; border-bottom: 1px solid white">
					<button type="button" class="btn btnSendwinEvent" title="당첨자 추출"> 📌 당첨차 주출 버튼</button>
					</td>
				</tr>
			</table>
		</c:if>	
		
		<c:if test="${not empty dto.winNum && sessionScope.member.userId=='admin'}">
			<table class="table table-content" style="width: 100%; padding-top: 5px;">
				<tr>
					<td align="center" style="background: #87CEFA  "> 
						<span id="winEvent">당첨자 수: ${dto.winCount}</span>
					</td>				
				</tr>
				<tr>
					<td align="center" style="background: #EAEAEA ">
						당첨번호 | 회원 번호 | 회원 이름
					</td>
						<c:forEach var="dto" items="${listWin}">
							<tr>
								<td align="center" >
									${dto.winNum} | ${dto.userNum} | ${dto.nickName}
								</td>
							</tr>
						</c:forEach>
				</tr>
			</table>
		</c:if>	
			
		<table class="table table-footer">
			<tr>
				<td width="50%" align="left">
					<c:choose>
						<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btnupdate" onclick="javascript:location.href='${pageContext.request.contextPath}/event/update?num=${dto.num}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btnupdate" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btndelete" onclick="deleteBoard();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btndelete" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/event/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
		
	
		
    </div>
    
</div>
