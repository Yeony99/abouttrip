<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
.allDataCount {
	width: 100%;
	margin: 20px auto 0px;
	border-spacing: 0px;
	border-bottom: 1.5px solid #111;
	font-size: small;
	padding-bottom: 5px;
}
.selectField {
	height: 45px;
	padding-left: 20px;
	padding-right: 50px;
	border: 1px solid #ddd;
	color: #888888;
	font-size: 15px;
	float: left;
	margin-right: 5px;
	margin-top: 53px;
}
.boxTFdiv {
	float: left;
	margin-top: 53px;
	height: 47px;
}
.boxTF {
	width: 425px;
	height: 43px;
	padding-left: 15px;
	border: 1px solid #ddd;
	color: #888888;
	float: left;
	margin-right: 5px;
}
.btnSearch {
	width: 43px;
	height: 43px;
	background-color: white;
	border: 1px solid #ddd;
	cursor: pointer;
}
.btnCreate {
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-bottom: 3rem;
	
}
.btnDelete {
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 10px;
	cursor: pointer;
}


.list {/*
	display: flex;
    flex-direction: column;
    align-items: center;*/
}
.list ul {
	list-style: none;
}
.list-body {
	display: grid;
	width: 700px;
	grid-template: repeat(2, auto) / repeat(4, auto);
	gap: 10px;
}

.list-body .item {
	border: 1px solid #333;
	border-radius: 5px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
   
	/* 이미지를 꽉차게 */
	background-repeat : no-repeat;
	background-size : cover;
}
.list-paging {
	text-align: center;
	padding: 10px;
}
.list-footer {
	padding: 10px 0;
}
.list-footer .item-left {
	box-sizing: border-box; width: 20%; float: left; text-align: left; padding: 15px 0;
}
.list-footer .item-center {
	box-sizing: border-box; width: 60%; float: left; text-align: center; padding: 15px 0;
}
.list-footer .item-right {
	box-sizing: border-box; width: 20%; float: right; text-align: right; padding: 15px 0;
}


.writer {
	margin: 0 auto;
    max-width: 80%;
}


.writer .table-content tr > td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}
.writer .table-content tr > td:nth-child(2) {
	padding-left: 10px;
}
.writer .table-content input[type=text], .table-content input[type=file], .table-content textarea {
	width: 97%;
}

.article {
	width: 80%;
    margin: 0 auto;
}
.article .table-content tr > td {
	padding-left: 5px; padding-right: 5px;
}
.article .content{
	white-space:pre;
}

.imgPreView {
	cursor: pointer;
	border: 1px solid #ccc;
	width: 45px;
	height: 45px;
	line-height: 45px;
	border-radius:45px;
	background: #eee;
	position: relative;
	z-index: 9999;
	background-repeat : no-repeat;
	background-size : cover;
	text-align: center;
	font-size: 13px;
	font-family: 나눔고딕
}

.item>div:hover {
	opacity:1;
}
</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>
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
	var url = "${pageContext.request.contextPath}/scheduler/reviewlist";
	var query = "pageNo="+page;
	var params = $('form[name=searchForm]').serialize();
	query = query + "&" + params;
	
	var fn = function(data){
		printList(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

function printList(data) {
	var dataCount = data.dataCount;
	var totalPage = data.total_page;
	var page = data.pageNo;
	var paging = data.paging;

	if(dataCount==0) {
		$(".list-body").height(0);
		$(".list-body").empty();
		$(".list-paging").html("등록된 게시물이 없습니다.");
		return;
	}
	
	$(".list-body").attr("data-pageNo", page);
	
	// 크거나 같은수 중 가장 적은 정수
	var n =  Math.ceil(dataCount / 4);
	var h = 170 * n;
	
	$(".list-body").height(h);
	if(n == 1) {
		document.querySelector(".list-body").style.gridTemplateRows = "repeat(1, auto)";
	} else {
		document.querySelector(".list-body").style.gridTemplateRows = "repeat(2, auto)";
	}
	
	var out="";
	for(var idx=0; idx<data.list.length; idx++) {
		var num = data.list[idx].num;
		var nickName = data.list[idx].nickName;
		var subject = data.list[idx].subject;
		var imageFileName = data.list[idx].imageFileName;
		var created = data.list[idx].created;
		var src = "${pageContext.request.contextPath}/uploads/Review/"+imageFileName;
		var item = "<div class='item' style='background-image: url("+src+");' data-num='"+num+"'></div>";
		
		out += item;
	}
	
	$(".list-body").html(out);
	$(".list-paging").html(paging);
}

function reload() {
	var f=document.searchForm;
	f.condition.value = "all";
	f.keyword.value = "";
	
	listPage(1);
}

$(function(){
	// 리스트-검색
	$(".btnSearch").click(function(){
		listPage(1);
	});
	
	// 리스트-새로고침
	$(".btnNew").click(function(){
		reload();
	});
	
	// 리스트-글 등록하기 버튼
	$(".btnInsertForm").click(function(){
		$(".writer .imgPreView").css("background-image", "none");
		$(".writer .imgPreView").html("<i class='icofont-camera-alt'></i>");
		$("form[name=reviewForm] .btnSendOk").text("등록완료");
		$("form[name=reviewForm] .btnSendCancel").text("등록취소");
		
		// 폼 초기화
		// $("form[name=reviewForm]")[0].reset();
		$("form[name=reviewForm]").each(function(){
			this.reset();
		});
		
		$("form[name=reviewForm] input[name=mode]").val("insertReview");

		$(".list").hide(100);
		$(".writer").show(100);
	});
	
	// 리스트-글보기
	$("body").on("click", ".list-body .item", function(){
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/scheduler/articleReview";
		var query = "num="+num;
		var params = $('form[name=searchForm]').serialize();
		query = query + "&" + params;
		
		var fn = function(data){
			printArticle(data);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function printArticle(data) {
		if(data.state == "false") {
			alert("삭제된 게시물입니다.");
			return;
		}
		
		$(".list").hide(100);
		$(".article").show(100);
		
		var uid = data.uid;
		
		var num = data.dto.num;
		var nickName = data.dto.nickName;
		var subject = data.dto.subject;
		var content = data.dto.content;
		var imageFileName = data.dto.imageFileName;
		var created = data.dto.created;
		$(".article .subject").html(subject);
		$(".article .name").html(nickName);
		$(".article .created").html(created);
		$(".article .content").html(content);
		var src = "${pageContext.request.contextPath}/uploads/Review/"+imageFileName;
		$(".article .img").attr("src",src);		
		
		$("form[name=reviewForm]")[0].reset();
		$(".article .btnUpdateForm").prop("disabled", false);
		$(".article .btnDelete").attr("disabled", false);
		//$(".writer .imgPreView").css("background-image", "none");
		if(uid=="writer") {
			// 등록한 사람
			$(".article .btnUpdateForm").attr("data-num", num);
			$(".article .btnDelete").attr("data-num", num);
			$(".article .btnDelete").attr("data-imageFileName", imageFileName);
			
			$("form[name=reviewForm] input[name=subject]").val(subject);
			$("form[name=reviewForm] textarea[name=content]").val(content);
			$("form[name=reviewForm] input[name=num]").val(num);
			$("form[name=reviewForm] input[name=imageFileName]").val(imageFileName);
			$("form[name=reviewForm] input[name=mode]").val("updateReview");
			
			$(".writer .imgPreView").empty();
			$(".writer .imgPreView").css("background-image", "url("+src+")");
			
			$("form[name=reviewForm] .btnSendOk").text("수정완료");
			$("form[name=reviewForm] .btnSendCancel").text("수정취소");
			
		} else if(uid=="guest"){
			// 게스트
			$("form[name=ReplyForm] input[name=rev_num]").val(num);
			$(".article .btnUpdateForm").prop("disabled", true);
			$(".article .btnDelete").attr("disabled", true);
		} else {
			// 관리자
			$(".article .btnUpdateForm").prop("disabled", true);
			$(".article .btnDelete").attr("data-num", num);
			$(".article .btnDelete").attr("data-imageFileName", imageFileName);
		}
	}
	
	/* function printReply(data){
		var num = data.list.num;
		var nickName = data.list.nickName;
		var content = data.list.content;
		var created = data.list.created;
		
		$(".reply .nickName").html(nickName);
		$(".reply .reply_content").html(content);
		$(".reply .reply_created").html(created);
		$(".reply .btnUpdateReply").prop("disabled", false);
		$(".reply .btnDeleteReply").attr("disabled", false);
		
		$(".reply .btnUpdateReply").attr("data-num", num);
		$(".reply .btnDeleteReply").attr("data-num", num);
		
		$("form[name=reviewForm] textarea[name=reply_content]").val(content);
		$("form[name=reviewForm] textarea[name=reply_created]").val(created);
		if(nickName.equals("관리자")||{sessionScope.member.nickName}.equals(nickName)) {
			$("form[name=ReplyForm] input[name=rev_num]").val(num);
			$(".article .btnUpdateForm").prop("disabled", true);
			$(".article .btnDelete").attr("disabled", true);
			
		} 
	} */
});

$(function(){
	// 글쓰기폼-등록 완료 버튼
	$(".btnSendOk").click(function(){
		var f = document.reviewForm;
		
		if(! f.subject.value) {
			f.subject.focus();
			return false;
		}
		
		if(! f.content.value) {
			f.content.focus();
			return false;
		}
		
		var mode = f.mode.value;
		if(mode=="insertReview" && ! f.upload.value) {
			f.upload.focus();
			return false;
		}
		
		var url="${pageContext.request.contextPath}/scheduler/"+mode;
		var query = new FormData(f); // IE는 10이상에서만 가능
		var fn = function(data){
			var state=data.state;
	    	
			if(mode=="insertReview") {
				reload();
			} else {
				var page = $(".list-body").attr("data-pageNo");
				listPage(page);
			}
			
			$(".list").show(100);
			$(".writer").hide(100);
		};
		
		ajaxFileFun(url, "post", query, "json", fn);		
	});

	// 글쓰기폼-등록 취소 버튼
	$(".btnSendCancel").click(function(){
		$(".list").show(100);
		$(".writer").hide(100);
	});
	
});

$(function(){
	// 글쓰기폼-등록 완료 버튼
	$(".btnReplyOk").click(function(){
		var f = document.ReplyForm;
		
		if(! f.ReplyContent.value) {
			f.ReplyContent.focus();
			return false;
		}
		
		var url="${pageContext.request.contextPath}/scheduler/insertReviewReply";
		var query = new FormData(f); // IE는 10이상에서만 가능
		var fn = function(data){
			var state=data.state;
	    	
			//printReply(data);
			
			$(".article").show(100);
		};
		
		ajaxFileFun(url, "post", query, "json", fn);		
	});
	
	// 글쓰기폼-등록 취소 버튼
	$(".btnSendCancel").click(function(){
		$(".list").show(100);
		$(".writer").hide(100);
	});
});

$(function(){
	// 글보기-글리스트
	$(".btnList").click(function(){
		$(".list").show(100);
		$(".article").hide(100);
	});

	// 글보기-글수정폼
	$(".btnUpdateForm").click(function(){
		$(".article").hide(100);
		$(".writer").show(100);
	});

	// 글보기-글삭제
	$(".btnDelete").click(function(){
		if(! confirm("게시글을 삭제하시겠습니까 ?")) {
			return false;
		}
		
		var num = $(this).attr("data-num");
		var imageFileName = $(this).attr("data-imageFileName");		
		var url = "${pageContext.request.contextPath}/scheduler/deleteReview";
		var query = "num="+num+"&imageFileName="+imageFileName;

		var fn = function(data){
			var page = $(".list-body").attr("data-pageNo");
			listPage(page);
			$(".list").show(100);
			$(".article").hide(100);
		};
		ajaxFun(url, "post", query, "json", fn);
	});
});

$(function(){
	$(".writer .imgPreView").click(function(){
		$("form[name=reviewForm] input[name=upload]").trigger("click"); 
	});
	
	$("form[name=reviewForm] input[name=upload]").change(function(){
		var file=this.files[0];
		if(! file.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".writer .imgPreView").empty();
			$(".writer .imgPreView").css("background-image", "url("+e.target.result+")");
		}
		reader.readAsDataURL(file);
	});
});
function insertReply(){
	var f = document.ReviewReplyForm;
	
	f.action= "${pageContext.request.contextPath}/scheduler/insertReiviewReply";
	f.submit();
}
</script>

<div class="body-container">
	<div class="body-main" style="margin: 4rem 0;">
		<div style="display: flex; justify-content: center">
			<h3>여행 후기 ✒</h3>
			
		</div>    
    <div class="body-main wx-700 ml-30 pt-15">
    
		<div class="list clear">
			<!-- 글리스트 -->
			<div class="list-body clear" data-pageNo="0"></div>
			<div class="list-paging clear"></div>
			<table
			style="width: 100%; height: 120px; margin: 30px auto; border-spacing: 0px;">
			<tr>
				<td align="center" style="width: 100%; border-top: 2px solid #111; display: flex; justify-content: center;">
					<form name="listSearchForm"
						action="${pageContext.request.contextPath}/place/${pick}"
						method="post">
						<select name="condition" class="selectField">
							<option value="placeName">제목</option>
							<option value="placeContent">내용</option>
							<option value="all">제목+내용</option>
						</select>
						<div class="boxTFdiv">
							<input type="text" name="keyword" class="boxTF"
								value="${keyword}">
							<button type="button" class="btnSearch" onclick="searchList()">
								<img alt=""
									src="${pageContext.request.contextPath}/resource/images/notice_search.png"
									style="padding-top: 5px;">
							</button>
						</div>
					</form>
				</td>
			</tr>
		</table>			
			<div class="list-footer clear">
				<ul>
					<li class="item-left">
						<button type="button" class="btn btnNew">새로고침</button>
					</li>
					<li class="item-right">
						<button type="button" class="btn btnInsertForm">등록하기</button>
					</li>
				</ul>
			</div>
		</div>
		<div class="clear"></div>
		
		<!-- 글 등록 폼 -->
		<div class="writer clear" style="display: none;">
			<form name="reviewForm" method="post" enctype="multipart/form-data">
			<table class="table table-border table-content">
				<tr> 
					<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					<td> 
						<input type="text" name="subject" maxlength="100" class="boxTF">
					</td>
				</tr>
				
				<tr> 
					<td>작성자</td>
					<td> 
						${sessionScope.member.nickName}
					</td>
				</tr>
				
				<tr> 
					<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top"> 
						<textarea name="content" class="boxTA" placeholder="이번 여행을 대표하는 사진 하나를 올려주세요!" style="min-height: 400px;"></textarea>
					</td>
				</tr>
				  
				<tr>
					<td>이미지</td>
					<td>
						<div class="imgPreView"></div>
						<input type="file" name="upload" class="boxTF" accept="image/*" style="display: none;">
					</td>
				</tr>
				  
			</table>
				
			<table class="table">
				<tr> 
					<td align="center">
						<button type="button" class="btn btn-dark btnSendOk">등록완료</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn btnSendCancel">등록취소</button>
						
						<input type="hidden" name="mode">
						<input type="hidden" name="num" value="0">
						<input type="hidden" name="imageFileName">
					</td>
				</tr>
			</table>
			</form>
		</div>

		<!-- 글리스트 -->
		<form name="ReplyForm" method="post">
		<div class="article clear" style="display: none;">
			<table class="table table-border table-content">
				
				<tr>
					<td align="left" colspan="2">
						제목 : <span class="subject"></span>
					</td>
				</tr>
				<tr>
					<td width="70%" align="left">
						이름 : <span class="name"></span>
					</td>
					<td width="30%" align="right">
						<span class="created"></span>
					</td>
				</tr>
				<tr style="border-bottom: none;">
					<td colspan="2">
						<img class="img" style="min-width:100%; height:auto; resize:both;">
					</td>
				</tr>			
				<tr>
					<td colspan="2">
						<div class="content" style="min-height: 200px; "></div>
					</td>
				</tr>
				<tr>
				<td>
					<textarea name="ReplyContent" class="boxTA" placeholder="고운 댓글을 달아주세요" style="min-height: 400px;"></textarea>
					<button type="button" class="btn btn-dark btnReplyOk">댓글 등록</button>
					<input type="hidden" name="rev_num">
				</td>
				</tr>
			</table>
				<table>
				<tr>
					<td class="reply"><span class="nickName" >이름 :</span></td>
					<td class="reply"><span class="reply_content" ></span></td>
					<td class="reply"><span class="reply_created" ></span></td>
					<td width="50%" align="left">
						<button type="button" class="btn btnUpdateReply">수정</button>
		    			<button type="button" class="btn btnDeleteReply">삭제</button>
					</td>
				</tr>
				</table>
			<table class="table">
				<tr>
					<td width="50%" align="left">
						<button type="button" class="btn btnUpdateForm">수정</button>
		    			<button type="button" class="btn btnDelete">삭제</button>
					</td>
				
					<td align="right">
						<button type="button" class="btn btnList">리스트</button>
					</td>
				</tr>
			</table>
		</div>
			</form>
	</div>
	</div>
</div>
