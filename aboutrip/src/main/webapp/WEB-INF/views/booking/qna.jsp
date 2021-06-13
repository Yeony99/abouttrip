<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
.accordion {
	box-sizing: border-box;
	width: 100%;
	min-height: 50px;
	margin: 15px auto 5px;
}

.accordion h3.question {
	box-sizing: border-box;
	color: #333;
	font-weight: 500;
	border: 1px solid #ccc;
	background-color: #fff;
	padding: 7px 15px 7px;
	border-radius: 4px;
	cursor: pointer;
	margin: 3px 0 0;
}

.accordion h3.question:hover {
	background-color: #e6e6e6;
}

.accordion h3.question .q {
	font-weight: 600;
}

.accordion h3.question .subject:hover {
	color: #0d58ba;
}

.accordion div.answer {
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-top: none;
	min-height: 50px;
	padding: 3px 10px 10px;
	display: none;
}

.accordion div.answer>.category {
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #eee;
}

.accordion div.answer>.content {
	padding: 7px 15px 5px;
}

.accordion div.answer>.content div:first-child {
	font-weight: 700;
	display: inline-block;
	vertical-align: top;
	padding-left: 5px;
}

.accordion div.answer>.content div:last-child {
	display: inline-block;
}

.accordion div.answer>.update {
	text-align: right;
}

.accordion h3.active {
	font-weight: 600;
	background-color: #F8FFFF;
}

.title {
	font-size: 20px;
}

.btnCreate {
	border: none;
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}

.btnReset {
	border: none;
	background-color: #87CEFA;
	color: black;
	border-radius: 7px;
}

.btnList {
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}

.btnSearch {
	border: 1px solid gray;
	background-color: white;
	color: black;
	border-radius: 7px;
}

.boxTF {
	height: 27px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery/js/jquery.form.js"></script>
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

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
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

// 글리스트 및 페이징 처리
function listPage(page) {
	var url = "${pageContext.request.contextPath}/booking/qna";
	var query = "qnaNo="+page;
	var params = $("form[name=code]").serialize();
	query += "&" + params;
	
	var fn = function(data) {
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
}

function printList(data) {
	var dataCount = data.dataCount;
	var totalPage = data.total_page;
	var page = data.qnaNo;
	var paging = data.paging;
	
	if(dataCount == 0) {
		$(".question").height(0);
		$(".question").empty();
		$("list-paging").html("등록된 게시물이 없습니다.");
		return;
	}
	$(".question").attr("data-qnaNo", page);
	
	var n = Math.ceil(dataCount / 4);
	var h = n * 170;
	$(".question").height(h);
	
	if(n==1) {
		document.querySelector(".question").style.gridTemplateRows = "repeat(1, auto)";
	} else {
		document.querySelector(".question").style.gridTemplateRows = "repeat(2, auto)";	
	}
	
	var out="";
	for(var idx = 0; idx < data.list.length; idx++) {
		var title = data.list[idx].title;
		var nickName = data.list[idx].nickName;
		var content= data.list[idx].content;
		var answer = data.list[idx].answer;
		
		var item="<h3><span class='q'>Q.</span> <span class='title'>"+title+"</span></h3> <span>작성자 : "+nickName+"</span>";
		item += "<div class='category'>"+content+"</div></div><div class='answer'><div class='content'>";
		item += "<div>A.</div><div>"+answer+"</div></div>";
	
		out+=item;
	}
	
	$(".question").html(out);
	if(data.dataCount==0){
		$(".list-paging").html("등록된 게시물이 없습니다.");
	} else {
		$(".list-paging").html(paging);
	}
}
</script>

<div class="body-container">
	<div class="body-main" style="padding-bottom: 50px;">

		<div id="tab-content" style="padding: 15px 10px 5px; clear: both;">
			<div class="accordion">
				<div class="question">
						
				</div>
			</div>


			<table class="table">
				<tr>
					<td class="list-paging" align="center"></td>
				</tr>
			</table>
		</div>
	</div>
</div>

