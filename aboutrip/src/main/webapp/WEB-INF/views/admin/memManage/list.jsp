<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
main {
	margin: 60px auto 0px;
}
.title-tr{
	box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
}
.hover-tr{
  	background-color: #f8f9fa;
  	border-radius: 4px;
  	color: #b4b4b4;
  	box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  	margin: 20px auto;
  	padding: 15px;
}
.hover-tr:hover {
	color: black;
	cursor: pointer;
	background: #fffdfd;
}

.table-content tr {
	text-align: center;
}
.table-content tr:first-child {
	background: #eee;
}
.table-content tr > th {
	color: #777;
}
</style>

<script type="text/javascript">
function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function searchList() {
	var f=document.searchForm;
	f.enable.value=$("#selectEnabled").val();
	f.action="${pageContext.request.contextPath}/admin/memManage/list";
	f.submit();
}
	
function detailedMember(userNum) {
	var dlg = $("#member-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   updateOk(); 
		       },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 520,
		  width: 800,
		  title: "회원상세정보",
		  close: function(event, ui) {
		  }
	});

	var url = "${pageContext.request.contextPath}/admin/memManage/detail";
	var query = "userNum="+userNum;
	
	var fn = function(data){
		$('#member-dialog').html(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}

function updateOk() {
	var f = document.enableForm;

	if(! f.enable.value) {
		f.enable.focus();
		return;
	}
	
	var url = "${pageContext.request.contextPath}/admin/memManage/updateEnable";
	var query=$("#enableForm").serialize();

	var fn = function(data){
		$("form input[name=page]").val("${page}");
		searchList();
	};
	ajaxFun(url, "post", query, "json", fn);
		
	$('#member-dialog').dialog("close");
}

</script>

<main>
	<h1>관리자 페이지입니다.</h1><br>
	
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-users"></i> 회원 관리 </h2>
	    </div>
	    
	    <div class="body-main wx-800 ml-30">
				
			<table class="table">
				<tr>
					<td align="left" width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
					<td align="right">
						<select id="selectEnabled" class="selectField" onchange="searchList();">
							<option value="" ${enabled=="" ? "selected='selected'":""}>::계정상태::</option>
							<option value="0" ${enabled=="0" ? "selected='selected'":""}>잠금 계정</option>
							<option value="1" ${enabled=="1" ? "selected='selected'":""}>활성 계정</option>
						</select>
					</td>
				</tr>
			</table>
				
			<table class="table table-border table-content">
				<tr class="title-tr"> 
					<th style="width: 60px; color: #787878;">번호</th>
					<th style="width: 100px; color: #787878;">아이디</th>
					<th style="width: 100px; color: #787878;">닉네임</th>
					<th style="width: 100px; color: #787878;">생년월일</th>
					<th style="width: 120px; color: #787878;">전화번호</th>
					<th style="width: 60px; color: #787878;">상태</th>
				</tr>
				 
				<c:forEach var="dto" items="${list}">
				<tr class="hover-tr" onclick="detailedMember('${dto.userNum}');"> 
					<td>${dto.listNum}</td>
					<td>${dto.userId}</td>
					<td>${dto.nickName}</td>
					<td>${dto.birth}</td>
					<td>${dto.tel}</td>
					<td>${dto.enable==1?"활성":"잠금"}</td>
				</tr>
				</c:forEach> 
			</table>
				 
			<table class="table">
				<tr>
					<td align="center">
						${dataCount==0?"등록된 자료가 없습니다.":paging}
					</td>
				</tr>
			</table>
				
			<table class="table">
				<tr>
					<td align="left" width="100">
						<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/memManage/list';">새로고침</button>
					</td>
					<td align="center">
						<form name="searchForm" action="${pageContext.request.contextPath}/admin/memManage/list" method="post">
							<select name="condition" class="selectField">
								<option value="userId"     ${condition=="userId" ? "selected='selected'":""}>아이디</option>
								<option value="nickName"   ${condition=="nickName" ? "selected='selected'":""}>이름</option>
								<option value="tel"        ${condition=="tel" ? "selected='selected'":""}>전화번호</option>
							</select>
							<input type="text" name="keyword" class="boxTF" value="${keyword}">
							<input type="hidden" name="enable" value="${enable}">
							<input type="hidden" name="page" value="1">
							<button type="button" class="btn" onclick="searchList()">검색</button>
						</form>
					</td>
					<td align="right" width="100">&nbsp;</td>
				</tr>
			</table>
			
	    </div>
	</div>
	<div id="member-dialog" style="display: none;"></div>
</main>
