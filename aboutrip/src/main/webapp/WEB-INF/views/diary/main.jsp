<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
	var url = "${pageContext.request.contextPath}/diary/list";
	var query = "pageNo="+page;
	var params = $("form[name=searchForm]").serialize();
	query += "&" + params;
	
	var fn = function(data) {
		printList(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

function printList(data) {
	//console.log(data);
	var dataCount = data.dataCount;
	var totalPage = data.total_page;
	var page = data.pageNo;
	var paging = data.paging;
	
	if(dataCount == 0) {
		$("list-body").height(0);
		$("list-body").empty();
		$("list-paging").html("등록된 게시물이 없습니다.");
		
		return;
	}
	$(".list-body").attr("data-pageNo", page);
	
	var n = Math.ceil(dataCount / 4);
	var h = n*170;
	$(".list-body").height(h);
	
	if(n==1) {
		document.querySelector(".list-body").style.gridTemplateRows = "repeat(1, auto)";
	} else {
		document.querySelector(".list-body").style.gridTemplateRows = "repeat(2, auto)";
	}
	
	var out = "";
	for(var idx = 0; idx < data.list.length; idx++) {
		var diaryNum = data.list[idx].diaryNum;
		var userNum = data.list[idx].userNum;
		var diaryTitle = data.list[idx].diaryTitle;
		var diaryImgNum = data.list[idx].diaryImgNum;
		
		var src = "${pageContext.request.contextPath}/uploads/diary/"+diaryImgNum;
		var item = "<div class='item' style='background-image:url("+src+");' data-diaryNum='"+diaryNum+"'></div>";
		
		out += item;
	}
	
	$(".list-body").html(out);
	$(".list-paging").html(paging);
}

function reload() {
	var f=document.searchForm;
	f.condition.value = "all";
	f.hashTag.value = "";
	
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
		$(".writer .imgPreView").text("사진");
		
		$("form[name=diaryForm] .btnSendOk").text("등록완료");
		$("form[name=diaryForm] .btnSendCancel").text("등록취소");
		
		// 폼 초기화
		$("form[name=diaryForm]").each(function(){
			this.reset();
		});
		
		$("form[name=diaryForm] input[name=mode]").val("insert");

		$(".list").hide(100);
		$(".writer").show(100);
	});
	
	// 리스트-글보기
	$("body").on("click", ".list-body .item", function(){
		var diaryNum = $(this).attr("data-diaryNum");
		//alert(num);
		var url = "${pageContext.request.contextPath}/diary/article";
		var query = "diaryNum="+diaryNum;
		var params = $("form[name=searchForm]").serialize();
		query += "&" + params;
		
		var fn = function(data) {
			printArticle(data);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function printArticle(data) {
		//console.log(data);
		if(data.state=="false") {
			alert("삭제된 게시물입니다.");
			return;
		}
		
		$(".list").hide(100);
		$(".article").show(100);
		
		var uid = data.uid;
		
		var diaryNum = data.dto.diaryNum;
		var userNum = data.dto.userNum;
		var diaryTitle = data.dto.diaryTitle;
		var diaryContent = data.dto.diaryContent;
		var diaryImgNum = data.dto.diaryImgNum;
		var diaryCreated = data.dto.diaryCreated;
		
		// 글보기
		$(".article .diaryTitle").html(diaryTitle);
		$(".article .userNum").html(userNum);
		$(".article .diaryCreated").html(diaryCreated);
		$(".article .diaryContent").html(diaryContent);
		var src = "${pageContext.request.contextPath}/uploads/diary/"+diaryImgNum;
		$(".article .img").attr("src", src);
		
		// 글수정
		$("form[name=diaryForm]")[0].reset();
		$(".article .btnUpdateForm").prop("disabled", false);
		$(".article .btnDelete").prop("disabled", false);
		if(uid=="writer") {
			// 글 작성자
			$(".article .btnUpdateForm").attr("data-diaryNum", diaryNum);
			
			$(".article .btnDelete").attr("data-diaryNum", diaryNum);
			$(".article .btnDelete").attr("data-diaryImgNum", diaryImgNum);
			
			$("form[name=diaryForm] input[name=diaryTitle]").val(diaryTitle);
			$("form[name=diaryForm] textarea[name=diaryContent]").val(diaryContent);
			$("form[name=diaryForm] input[name=diaryNum]").val(diaryNum);
			$("form[name=diaryForm] input[name=diaryImgNum]").val(diaryImgNum);
			$("form[name=diaryForm] input[name=mode]").val("update");
			
			$(".writer .imgPreView").empty();
			$(".writer .imgPreView").css("background-image", "url("+src+")");
			
			$("form[name=diaryForm] .btnSendOk").text("수정완료");
			$("form[name=diaryForm] .btnSendCancel").text("수정취소");
			
		} else if(uid=="guest") {
			// 게스트
			$(".article .btnUpdateForm").prop("disabled", true);
			$(".article .btnDelete").prop("disabled", true);
		} else {
			// 관리자
			$(".article .btnUpdateForm").prop("disabled", true);
			
			$(".article .btnDelete").attr("data-diaryNum", diaryNum);
			$(".article .btnDelete").attr("data-diaryImgNum", diaryImgNum);
		}
	}
	
});

$(function(){
	// 글쓰기폼-등록 완료 버튼
	$(".btnSendOk").click(function(){
		var f = document.diaryForm;
		
		if(! f.diaryTitle.value) {
			f.diaryTitle.focus();
			return false;
		}
		
		if(! f.diaryContent.value) {
			f.diaryContent.focus();
			return false;
		}
		
		var mode = f.mode.value;
		if(mode=="insert" && ! f.upload.value) {
			f.upload.focus();
			return false;
		}
		
		var url="${pageContext.request.contextPath}/diary/"+mode;
		var query = new FormData(f); // IE는 10이상에서만 가능
		var fn = function(data){
			var state=data.state;
	    	
			if(mode=="insert") {
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
		if(! confirm("게시글을 삭제하시 겠습니까 ?")) {
			return false;
		}
		

	});
});

$(function(){
	$(".writer .imgPreView").click(function(){
		$("form[name=diaryForm] input[name=upload]").trigger("click");
	});
	
	$("form[name=diaryForm] input[name=upload]").change(function(){
		var file = this.files[0];
		//console.log(file);
		
		if(! file.type.match("image.*")) {
			this.focus();
			return false;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(".writer .imgPreView").empty();
			$(".writer .imgPreView").css("background-image","url("+e.target.result+")");
		};
		reader.readAsDataURL(file);
		
	});
});
</script>
<div class="body-container">
	<div>
		<h3 style="font: bold;">다이어리</h3>
	</div>
	
	<div class="body-main">
		<div class="list clear">
			<!-- 리스트 -->
			<div class="list-body clear" data-pageNo="0"></div>
			<div class="list-paging clear"></div>
			<div class="list-footer clear">
				<ul>
					<li>
						<button type="button">새로고침</button>
					</li>
					<li>
						<form name="searchForm" method="post">
							<input type="text" name="hashTag" placeholder="해쉬태그">
							<button type="button" class="btn btnSearch">검색</button>
						</form>
					</li>
					<li class="item-right">
						<button type="button" class="btn btnInsertForm">새글 등록</button>
					</li>
				</ul>
			</div>
		</div>
		<div class="clear"></div>
		
		<!-- 등록 -->
		<div class="writer clear" style="display: none;">
			<form name="diaryForm" method="post"  enctype="multipart/form-data">
			<table>
				<tr>
				<td>제목</td>
				<td>
					<input type="text" name="diaryTitle" maxlength="50">
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<!-- sessionScope 다시 확인 -->
				<td> 
					${sessionScope.member.userNum}
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="diaryContent">${dto.diaryContent}</textarea>
				</td>
			</tr>
			<tr>
				<td>첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
				<td>
					<div class="imgPreView"></div>
					<input type="file" name="upload" accept="image/*" style="display: none;">
				</td>
			</tr>
		</table>
		<table>
			<tr> 
				<td>
					<button type="button" class="btn btnSendOk">등록완료</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn btnSendCancel">등록취소</button>
						
					<input type="hidden" name="mode">
					<input type="hidden" name="num" value="0">
					<input type="hidden" name="diaryImgNum">
				</td>
			</tr>
			</table>
			</form>
		</div>
		
		<!-- 리스트 -->
		<div class="article clear" style="display: none;">
			<table class="table table-content">
				<tr>
					<td colspan="2" align="center">
						<span class="subject"></span>
					</td>
				</tr>
				
				<tr>
					<td width="50%" align="left">
						이름 : <span class="name"></span>
					</td>
					<td width="50%" align="right">
						<span class="created"></span>
					</td>
				</tr>
				
				<tr style="border-bottom: none;">
					<td colspan="2">
						<img class="img" style="max-width:100%; height:auto; resize:both;">
					</td>
				</tr>			
				<tr>
					<td colspan="2">
						<div class="content"></div>
					</td>
				</tr>
			</table>
				
			<table class="table table-footer">
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
	</div>
</div>
