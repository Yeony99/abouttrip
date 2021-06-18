<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.mate-header {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 70px;
    max-width: 700px;
    margin: 3rem auto;
}
.mate-header > div:nth-child(2) {
	padding-top: 10px;
}
.mate-header > div:last-child {
	padding-top: 5px;
	text-align: right;
}
.mate-header .write-title {
	font-weight: 700;
}
.mate-header textarea {
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
.mate-header button {
	padding: 8px 25px;
}

.mate-list table {
	width: 100%;
	margin: 15px auto 0;
	border-spacing: 0;
	border-collapse: collapse;
}

.mate-list table thead > tr {
	height: 35px;
}

.mate-list table tbody > tr:nth-child(2n+1) {
	border: 1px solid #ccc;
	background: #eee;
}
.mate-list table tbody > tr:nth-child(2n) {
	height: 35px;
}
.mate-list table tbody > tr:nth-child(2n+1) td {
	padding: 7px 5px;
}
.mate-list table tbody > tr:nth-child(2n) td {
	padding: 5px 5px 20px;
}

.mate-list .list-title {
	color: #3EA9CD;
	font-weight: 700;
}
.mate-list table tbody tr.paging {
	text-align: center;
	background: #fff;
	border: none;
}
.mate-list .delete, .mate-list .notify {
	cursor: pointer;
}
.mate-list .delete:hover, .mate-list .notify:hover {
	color: #0d58ba;
}
</style>

<script type="text/javascript">
var replystate = 1;
function reload(){
	location.reload();
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

//페이징 처리
$(function(){
	listPage(1);
});

// 페이징한다면...
function listPage(page) {
	var url = "${pageContext.request.contextPath}/scheduler/matelist";
	var query = "pageNo="+page;
	var selector = "#listMate";
	
	var fn = function(data){
		printMate(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

// 리플 등록
$(function(){
	$(".btnSendMate").click(function(){
		sendMate();
	});
}); 
function printMate(data){
	var uid="${sessionScope.member.userNum}";
	var dataCount = data.dataCount;
	var page = data.page;
	var totalPage = data.total_page;
	$("#listMateBody").attr("data-page", page); // 현재 화면상에 보이는 페이지 저장
	$("#listMateBody").attr("data-totalPage", totalPage); // 전체 페이지 저장
	
	var out="";
	if(dataCount==0) {
		out+="<tr class='paging'>";
		out+="    <td colspan='2'>등록된 게시물이 없습니다.</td>";
		out+="</tr>"
		$("#listMateBody").html(out);
		return;
	}
	
	if(page==1) {
		$("listMateBody").empty();
	}
	
	for(var idx=0; idx<data.list.length; idx++) {
		var Num=data.list[idx].num;
		var listNum = data.list[idx].listNum;
		var user_num = data.list[idx].user_num;
		var nickName=data.list[idx].nickName;
		var subject=data.list[idx].subject
		var created=data.list[idx].created;
		var start_date=data.list[idx].start_date;
		var end_date=data.list[idx].end_date;
		var people_num =data.list[idx].people_num;
		var current_num = data.list[idx].current_num;
		var ctgNum = data.list[idx].ctgNum;
		var content = data.list[idx].content;
		var replyNum = 0; //추후 수정
		var answerCount = 0; // 추후 추가
		var ctg;
		if(ctgNum == 1){
			ctg ="서울";
		} else if(ctgNum == 2){
			ctg ="부산";
		} else if(ctgNum == 3){
			ctg ="제주 제주시";
		} else if(ctgNum == 4){
			ctg ="제주 서귀포";
		} else if(ctgNum == 5){
			ctg ="제주 성산";
		} else if(ctgNum == 6){
			ctg ="제주 기타";
		}
		out+="<div class='shape'>";
		out+="<table>"
		out+="<tr>";
		out+="<td style='line-height: 25px; margin: 10px;'>모집 번호 :"+listNum+"</td>";
		out+="<td style='line-height: 25px; margin: 10px;'>"+nickName+"</td>";
		out+="<td style='line-height: 25px; margin: 10px;'>일정 :"+start_date+"~"+end_date+"지역 :"+ctg+"</td>";
		out+="<td style='line-height: 25px; margin: 10px;'>현재 인원: "+current_num+", 모집인원 : "+people_num+"</td>";
		out+="</tr>";
		
		out+="<tr>";
		out+="<td style='line-height: 25px; '>제목 : "+subject+"</td>";
		out+="</tr>";
		
		out+="<tr>";
		out+="<td style='line-height: 25px; '>"+content+"</td>";
		out+="</tr>";
		
		out+="<tr>";
		out+="<td style='line-height: 25px; '>작성일 : "+created+"</td>";
		out+="<td colspan='2'><button type='button' class='btn btnMateAnswerLayout' data-replyNum='"+replyNum+"'>답글<span id='answerCount'"+answerCount+"'>"+answerCount+"</span></button>";
		out+="<td colspan='2'><button type='button' class='btn btnMatedelete' data-num='"+Num+"' data-user_num='"+user_num+"'>삭제하기</button>";
		out+="</td></tr>";
		out+="<tr id='mateSubject'></tr>"
		out+="</table></div>";
	}
	
	$("#listMateBody").append(out); // html은 기존 내용이 지워지고, append는 기존 내용이 지워지지 않는다.
}
function sendMate() {
	var f = document.mateForm;
	var ctgNum = f.ctgNum.value;
	var people_num = f.people_num.value;
	var start_date = f.start_date.value;
	var end_date = f.end_date.value;
	var content = f.content.value;
	var subject = f.subject.value;
	if(! $("#ctg").val()) {
		$("#ctg").focus();
		return false;
	}
	
	if(! $("#people_num").val()) {
		$("#people_num").focus();
		return false;
	}
	
	if(! $("#form-checkin").val()) {
		$("#form-checkin").focus();
		return false;
	}
	if(! $("#form-checkout").val()) {
		$("#form-checkout").focus();
		return false;
	}
	
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return;
	}
	
	var url="${pageContext.request.contextPath}/scheduler/insertMate";
	var query="ctgNum="+ctgNum+"&people_num="+people_num+"&start_date="+start_date+"&end_date="+end_date+"&content="+
	content+"&subject="+subject+"&reply_answer=0";
	var fn = function(data){
		$tb.find("textarea").val("");
		
		var state=data.state;
		if(state==="true") {
			listPage(1);
		} else if(state==="false") {
			alert("추가 하지 못했습니다.");
		}
	};
	
	ajaxFun(url, "post", query, "json", fn);
	reload();
}
// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var people_num=$(this).attr("data-people_num");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/scheduler/deleteReply";
		var query="reply_num="+reply_num+"&mode=mate&reply_answer="+reply_num;
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 댓글별 답글 리스트
function listMateAnswer(answer) {
	var url="${pageContext.request.contextPath}/scheduler/listMateAnswer";
	var query="reply_answer="+reply_answer;
	var selector="#listMateAnswer"+reply_answer;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countMateAnswer(answer) {
	var url="${pageContext.request.contextPath}/scheduler/countMateAnswer";
	var query="reply_answer="+reply_answer;
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"reply_+answer;
		$(vid).html(count);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}

// 답글 버튼(댓글별 답글 등록폼 및 답글리스트)
$(function(){
	$("body").on("click", ".btnMateAnswerLayout", function(){
		var $trMateAnswer = $(this).closest("tr").next();
		// var $trMateAnswer = $(this).parent().parent().next();
		// var $answerList = $trMateAnswer.children().children().eq(0);
		
		var isVisible = $trMateAnswer.is(':visible');
		var reply_num = $(this).attr("data-reply_num");
			
		if(isVisible) {
			$trMateAnswer.hide();
		} else {
			$trMateAnswer.show();
            
			// 답글 리스트
			//listMateAnswer(mateNum);
			
			// 답글 개수
			//countMateAnswer(mateNum);
		}
	});
	
});
//작업하다 안된거
/* $(function(){
	$("body").on("click", ".btnMateAnswerLayout", function(){
		
		var reply_num = $(this).attr("data-replyNum");
		var out="";
		out+="<tr class='mateAnswer' style='display: none' id='reply'>";
		out+="<div id='listMateAnswer${vo.mateNum}' class='answerList' style='border-top: 1px solid #ccc;'></div>";
		out+="<div style='clear: both; padding: 10px 10px;'>";
		out+="<div style='float: left; width: 5%;'>└</div>";
		out+="<div style='float: left; width:95%'>";
		out+="<textarea class='boxTA' style='width:100%; height: 70px;'></textarea>";
		out+="</div> </div>";
		out+="<div style='padding: 0 13px 10px 10px; text-align: right;'>";
		out+=" <button type='button' class='btn btnSendMateAnswer' data-mateNum='${vo.mateNum}'>답글 등록</button>";
		out+="</div></td></tr>";
		if(replystate) {
			$("#mateSubject").html(out);
			replystate=0;
		} else {
			$("#mateSubject").html("");
            
			// 답글 리스트
			//listMateAnswer(reply_num);
			
			// 답글 개수
			//countMateAnswer(reply_num);
			replystate=1;
		}
	});
	
}); */
$(function(){
	$("body").on("click",".btnMatedelete",function(){
		var uid = "${sessionScope.member.userNum}";
		var user_num = $(this).attr("data-user_num");
		var num = $(this).attr("data-num");
		
		if(uid===user_num || uid==="관리자"){
			var url="${pageContext.request.contextPath}/scheduler/deleteMate";
			var query="num="+num;
		} else {
			alert("본인이 아니면 삭제 할 수 없습니다.");
			return;
		}
		var fn = function(data){
			listPage(1);
		};
		ajaxFun(url, "post", query, "json", fn);
		reload();
	});
});
// 답글 등록
$(function(){
	$("body").on("click", ".btnSendMateAnswer", function(){
		var num=$(this).attr("data-num");
		var $td=$(this).closest("td");
		
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/scheduler/insertReply";
		var query="content="+content+"&mate_num="+num+"&reply_answer="+num;
		
		var fn = function(data){
			$td.find("textarea").val("");
			
			var state=data.state;
			if(state==="true") {
				listMateAnswer(mateNum);
				countMateAnswer(mateNum);
			}
		};
		ajaxFun(url, "post", query, "json", fn);
	});
});

function bringPlace() {
	var f = document.mateForm;
	
	var str = f.ctgNum.value;
	if(str!="") {
		f.ctgNum.value=str;
	}
}
// 댓글별 답글 삭제
$(function(){
	$("body").on("click", ".deleteMateAnswer", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return;
		}
		
		var mateNum=$(this).attr("data-mateNum");
		var answer=$(this).attr("data-answer");
		
		var url="${pageContext.request.contextPath}/scheduler/deleteMate";
		var query="mateNum="+mateNum+"&mode=answer";
		
		var fn = function(data){
			listMateAnswer(answer);
			countMateAnswer(answer);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>

<div class="container body-container">
    <div class="body-main wx-800 ml-30 pt-15" style="margin: 4rem 0;">
    	<div style="display: flex; justify-content: center">
			<h3>트립 메이트를 찾습니다 👋🏻</h3>
		</div>
		
<!-- <form name="mateForm" method="post">
		<div class="mate-header">
			<div>
				<label style="width: 80%"> 제목 <input type="text" id="subject"></label>
			</div>
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
				<button type="button" class="btn btnSendMate" onclick="sendMate();"> 등록하기 </button>
			</div>
		</div>
		</form>
-->
		
		<div class="mate" style="width: 70vw; margin:2rem auto">
			<form name="mateForm" method="post" accept-charset="utf-8">
			<table class="table table-mate">
				<tr> 
					<td align='left'>
						<span style='font-weight: bold;' >🧭 당신의 여행 계획을 알려주세요!</span>
					</td>
					<td colspan="2">
						<span style="color: red">※ 코로나19 방역지침에 따라 5인 이상 모임은 불가능합니다.</span> 
					</td>
				</tr>
				<tr>
					<td>
						<label> 장소
						<select name="ctgNum" onchange="bringPlace();" id="ctg" style="width: 200px;">
							<option value="">선 택</option>
							<option value="1" ${dto.ctgNum=="1" ? "selected='selected'" : ""}>서울</option>
							<option value="2" ${dto.ctgNum=="2" ? "selected='selected'" : ""}>부산</option>
							<option value="3" ${dto.ctgNum=="3" ? "selected='selected'" : ""}>제주 제주시</option>
							<option value="4" ${dto.ctgNum=="4" ? "selected='selected'" : ""}>제주 서귀포</option>
							<option value="5" ${dto.ctgNum=="5" ? "selected='selected'" : ""}>제주 성산</option>
							<option value="6" ${dto.ctgNum=="6" ? "selected='selected'" : ""}>제주 기타</option>
						</select><%-- 
						<input type="hidden" value="${dto.ctgNum}" name="ctgNum"> --%>
						</label>
					</td>
					<td>
						<label> 메이트 인원 <input type="number" min="1" max="3" id="people_num" name='peple_num' value="1"></label>
					</td>
					<td>
						<label> 출발 <input type="date" id="form-checkin" name="start_date"> </label> ~ <label> 도착 <input type="date" id="form-checkout" name="end_date"> </label> 
					</td>
					<td colspan="2">
						<input type="text" name="subject" placeholder="제목">
					</td>
				</tr>
				
				<tr>
					<td colspan="3">
						<textarea class='boxTA' style='width:100%; height: 300px;' id="content" name="content" placeholder="즐거운 여행이 될 수 있도록 자세한 계획을 알려주세요!"></textarea>
					</td>
				</tr>
				<tr>
				   <td align='right' colspan="3">
				        <button type='button' class='btn' style='padding:7px 20px;' onclick="sendMate();">등록</button>
				    </td>
				 </tr>
			</table>
			</form>
<!-- listMate.jsp에 추가할 내용 -->
			<!-- mate.jsp 에는 <div id="listMate"> 만 남겨두기 -->
			<div id="listMate">
				<table class='table mate-list'>
					<thead id='listMateHeader'>
						<tr>
						    <td colspan='2'>
						       <div style='clear: both;'>
						           <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>메이트 찾기</span></div>
						           <div style='float: right; text-align: right;'></div>
						       </div>
						    </td>
						</tr>
					</thead>
					
					<tbody id='listMateBody'>
						<tr class='mateAnswer' style='display: none;' id="reply">
	        					<td colspan='2'>
						            <div id='listMateAnswer${vo.mateNum}' class='answerList' style='border-top: 1px solid #ccc;'></div>
						            <div style='clear: both; padding: 10px 10px;'>
						                <div style='float: left; width: 5%;'>└</div>
						                <div style='float: left; width:95%'>
						                    <textarea class='boxTA' style='width:100%; height: 70px;'></textarea>
						                 </div>
						            </div>
						             <div style='padding: 0 13px 10px 10px; text-align: right;'>
						                <button type='button' class='btn btnSendMateAnswer' data-mateNum='${vo.mateNum}'>답글 등록</button>
						            </div>
							</td>
					    </tr>
					</tbody>
					<!-- 페이징 처리한다면  -->
					<tfoot id='listMateFooter'>
						<tr align="center">
							<td colspan='2' >
								${paging}
							</td>
						</tr>
					</tfoot>
				</table>
				
				<!-- 여기까지 listMate.jsp -->
			
			</div>			
		</div>
	</div>
</div>
