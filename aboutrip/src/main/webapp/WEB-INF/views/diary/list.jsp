<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	color: #f8f9fa;
	font-family: 나눔고딕;
	padding: 20px;
}
.body-title {

}

.body-main {
	margin: 10px auto;
	max-width: 500px;
  	width: 90%;
}

.btn {
	color: #f8f9fa;
	font-weight: bold;
}
.createBtn {
	margin: 8px;
	color: #46CCFF;
	margin: 5px;
	box-sizing: border-box; 
	cursor: pointer;
	width: 55px;
	height: 55px;
	line-height: 55px;
	border-radius:45px;
	border: none;
	font-weight: bold;
	text-align: center;
	font-size: 13px;
	background: #f8f9fa
}

.createBtn:hover {
	color: #f8f9fa;
	border: 1px solid #f8f9fa;
	background-color: transparent;
}
</style>

<script type="text/javascript">
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

$(function(){
	listPage(1);
});

function listPage(page) {
	var url="${pageContext.request.contextPath}/diary/list";
	var query="page="+page;
	
	var fn = function(data) {
		printGuest(data);
	}
	
	ajaxFun(url, "get", query, "json", fn);
}

function printGuest(data) {
	var uid="${sessionScope.member.userNum}";
	var dataCount = data.dataCount;
	var page = data.page;
	var totalPage = data.total_page;
	var paging = data.paging;
	
	var out="";
	if(dataCount==0) {
		out+="<tr class='paging'>";
		out+="    <td colspan='2'>등록된 게시물이 없습니다.</td>";
		out+="</tr>"
		$("#listDiaryBody").html(out);
		return;
	}
	
	for(var idx=0; idx<data.list.length; idx++) {
		var diaryNum=data.list[idx].diaryNum;
		var nickName=data.list[idx].nickName;
		//var userNum=data.list[idx].userNum;
		var diaryTitle=data.list[idx].diaryTitle
		var diaryCreated=data.list[idx].diaryCreated;
		var saveImgName=data.list[idx].saveImgName;
		var url="${pageContext.request.contextPath}/uploads/diary/"+saveImgName;
		var articleUrl=data.list[idx].articleUrl;
		
		out+="<tr>";
		out+="<td width='50px' rowspan='3'>";
		out+="    <a href="+articleUrl+"&diaryNum="+diaryNum+">";
		out+="    	<img src="+url+">";
		out+="    </a>";
		out+="</td></tr>";
		out+="<tr><td>"+diaryTitle+"</td></tr>";
		out+="<tr><td>"+diaryCreated+"</td></tr>";
	}
	out+="<tr class='paging'>";
	out+="    <td colspan='2'>"+paging+"</td>";
	out+="</tr>"
	$("#listDiaryBody").html(out);
}

function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
	
	<div>
		<c:if test="${list.size() > 0}">
			<ul class="slider" style="margin: 0;">
				<c:forEach var="dto" items="${list}">
					<c:choose>
						<c:when test="${not empty dto.saveImgName}">
							<li><a href="${articleUrl}&diaryNum=${dto.diaryNum}"><img src="${pageContext.request.contextPath}/uploads/diary/${dto.saveImgName}" title="${dto.diaryTitle}"></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${articleUrl}&diaryNum=${dto.diaryNum}"><img src="${pageContext.request.contextPath}/resources/images/noimage.png" title="${dto.diaryContent}"></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</c:if>
	</div>
		
	<div class="body-title">
		<h3 style="font: bold;">다이어리</h3>
	</div>
	<div class="body-main">
		<table style="border-bottom: 2px solid white;">
			<tr>
				<td>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/main';">새로고침</button>
				</td>
				<td>
					<form name="searchForm" action="${pageContext.request.contextPath}/diary/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
							<option value="diaryTitle" ${condition=="diaryTitle"?"selected='selected'":""}>제목</option>
							<option value="diaryContent" ${condition=="diaryContent"?"selected='selected'":""}>내용</option>
						</select>
						<input type="text" name="keyword" value="${keyword}">
						<button type="button" onclick="searchList()">검색</button>
					</form>
				</td>
				<td>
					<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/create';">새글</button>
				</td>
			</tr>
		</table>
         
		<div id="listDiary" class="diary-list">
			<table>
				<thead>
					<tr>
						<td width='50%'>
							<span class="list-title">다이어리</span>
							<span>[목록]</span>
						</td>
						<td width='50%'>&nbsp;</td>
					</tr>
				</thead>
				<tbody id="listDiaryBody" data-page="0" data-totalPage="0"></tbody>
			</table>
		</div>
	</div>
</div>
