<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.guest-header {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 70px;
    max-width: 700px;
    margin: 3rem auto;
}
.guest-header > div:nth-child(2) {
	padding-top: 10px;
}
.guest-header > div:last-child {
	padding-top: 5px;
	text-align: right;
}
.guest-header .write-title {
	font-weight: 700;
}
.guest-header textarea {
	border:1px solid #999;
	height:70px;
	width:100%;
	padding:3px 5px;
	box-sizing:border-box;
	border-radius:4px;
	background-color:#fff;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	resize : none;
}
.guest-header button {
	padding: 8px 25px;
}

.guest-list table {
	width: 100%;
	margin: 15px auto 0;
	border-spacing: 0;
	border-collapse: collapse;
}

.guest-list table thead > tr {
	height: 35px;
}

.guest-list table tbody > tr:nth-child(2n+1) {
	border: 1px solid #ccc;
	background: #eee;
}
.guest-list table tbody > tr:nth-child(2n) {
	height: 35px;
}
.guest-list table tbody > tr:nth-child(2n+1) td {
	padding: 7px 5px;
}
.guest-list table tbody > tr:nth-child(2n) td {
	padding: 5px 5px 20px;
}

.guest-list .list-title {
	color: #3EA9CD;
	font-weight: 700;
}
.guest-list table tbody tr.paging {
	text-align: center;
	background: #fff;
	border: none;
}
.guest-list .delete, .guest-list .notify {
	cursor: pointer;
}
.guest-list .delete:hover, .guest-list .notify:hover {
	color: #0d58ba;
}
</style>

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

$(function(){
	listPage(1);
});

function listPage(page) {
	var url="${pageContext.request.contextPath}/guest/list";
	var query="pageNo="+page;
	
	var fn = function(data){
		printGuest(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
}

var pageNo=1;
var total_page=1;
// 무한 스크롤
$(function(){
	$(window).scroll(function(){
		// if($(window).scrollTop()>=$(document).height()-$(window).height()) {
		if($(window).scrollTop()+70>=$(document).height()-$(window).height()) {
			if(pageNo<total_page) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});

function printGuest(data) {
	var uid="${sessionScope.member.userId}";
	var dataCount = data.dataCount;
	var page = data.pageNo;
	var totalPage = data.total_page;
	
	pageNo = page;
	total_page = totalPage;
	
	var out="";
	if(dataCount==0) {
		out+="<tr class='paging'>";
		out+="    <td colspan='2'>등록된 게시물이 없습니다.</td>";
		out+="</tr>"
		
		$("#listGuestBody").html(out);
		return;
	}
	
	if(page == 1) {
		$("#listGuestBody").empty();
	}
	
	for(var idx=0; idx<data.list.length; idx++) {
		var num=data.list[idx].num;
		var userName=data.list[idx].userName;
		var userId=data.list[idx].userId;
		var content=data.list[idx].content;
		var created=data.list[idx].created;
			
		out+="<tr>";
		out+="    <td width='50%'>"+ userName+"</td>";
		out+="    <td width='50%' align='right'>" + created;
		if(uid==userId || uid=="admin") {
			out+=" | <span class='delete' data-num='"+num+"' >삭제</span></td>" ;
		} else {
			out+=" | <span class='notify'>신고</span></td>" ;
		}
		out+="</tr>";
		out+="<tr>";
		out+="    <td colspan='2' valign='top'>"+content+"</td>";
		out+="</tr>";
	}
	
	$("#listGuestBody").append(out);

	if(! checkScrollBar()) { // checkScrollBar() 함수는 util-jquery.js 에 존재
		if(page<totalPage) {
			++page;
			listPage(page);
		}
	}
}

function sendGuest() {
	if(! $("#form-checkin").val()) {
		$("#form-checkin").focus();
		return false;
	}
	if(! $("#form-checkout").val()) {
		$("#form-checkout").focus();
		return false;
	}
	if(! $("#ctg").val()) {
		$("#ctg").focus();
		return false;
	}
	if(! $("#mate_num").val()) {
		$("#mate_num").focus();
		return false;
	}
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return;
	}
	
	var url="${pageContext.request.contextPath}/guest/insert";
	var query=$("form[name=guestForm]").serialize();
	
	var fn = function(data){
		// var state = data.state;
		
		$("#content").val("");
		
		listPage(1);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

$(function(){
	$("body").on("click", ".guest-list .delete", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
			return false;
		}
		
		var num=$(this).attr("data-num");
		var url="${pageContext.request.contextPath}/guest/delete";
		var query="num="+num;
		
		var fn = function(data) {
			listPage(1);
		};

		ajaxFun(url, "post", query, "json", fn);
	});
});

function bringName() {
	var f = document.listForm;
	
	var str = f.upload.value;
	if(str!="") {
		f.placeFileName.value=str;
	} else{
		f.placeFileName.value="fail";
	}
}
function bringPlace() {
	var f = document.listForm;
	
	var str = f.ctg.value;
	if(str!="") {
		f.ctgNum.value=str;
	}
}
</script>

<div class="container body-container">
    <div class="body-main wx-800 ml-30 pt-15" style="margin: 8rem 0;">
    	<div style="display: flex; justify-content: center">
			<h3>여행 메이트를 찾습니다 👋🏻</h3>
		</div>
		<form name="guestForm" method="post">
		<div class="guest-header">
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
				<button type="button" class="btn btnSendGuest" onclick="sendGuest();"> 등록하기 </button>
			</div>
		</div>
		</form>
         
		<div id="listGuest" class="guest-list">
			<table>
				<thead>
					<tr>
						<td width='50%'>
							<span class="list-title">방명록</span>
							<span>[목록]</span>
						</td>
						<td width='50%'>&nbsp;</td>
					</tr>
				</thead>
				<tbody id="listGuestBody" data-pageNo="0" data-totalPage="0"></tbody>
			</table>
		</div>
	</div>
    
</div>