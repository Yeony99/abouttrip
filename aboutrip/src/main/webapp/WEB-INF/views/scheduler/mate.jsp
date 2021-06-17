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

//페이징 처리
$(function(){
	listPage(1);
});

// 페이징한다면...
function listPage(page) {
	var url = "${pageContext.request.contextPath}/scheduler/listMate";
	var query = "num=${dto.num}&pageNo="+page;
	var selector = "#listMate";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 리플 등록
$(function(){
	$(".btnSendMate").click(function(){
		var num="${dto.num}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/scheduler/insertMate";
		var query="num="+num+"&content="+content+"&answer=0";
		
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
	});
});

function sendMate() {
	if(! $("#ctg").val()) {
		$("#ctg").focus();
		return false;
	}
	if(! $("#mate_num").val()) {
		$("#mate_num").focus();
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
}
// 댓글 삭제
$(function(){
	$("body").on("click", ".deleteMate", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var mateNum=$(this).attr("data-mateNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/scheduler/deleteMate";
		var query="mateNum="+mateNum+"&mode=mate";
		
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
	var query="answer="+answer;
	var selector="#listMateAnswer"+answer;
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 댓글별 답글 개수
function countMateAnswer(answer) {
	var url="${pageContext.request.contextPath}/scheduler/countMateAnswer";
	var query="answer="+answer;
	
	var fn = function(data){
		var count=data.count;
		var vid="#answerCount"+answer;
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
		var mateNum = $(this).attr("data-mateNum");
			
		if(isVisible) {
			$trMateAnswer.hide();
		} else {
			$trMateAnswer.show();
            
			// 답글 리스트
			listMateAnswer(mateNum);
			
			// 답글 개수
			countMateAnswer(mateNum);
		}
	});
	
});

// 답글 등록
$(function(){
	$("body").on("click", ".btnSendMateAnswer", function(){
		var num="${dto.num}";
		var mateNum=$(this).attr("data-mateNum");
		var $td=$(this).closest("td");
		
		var content=$td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="${pageContext.request.contextPath}/scheduler/insertMate";
		var query="num="+num+"&content="+content+"&answer="+mateNum;
		
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
			<form name="mateForm" method="post">
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
						<select name="ctg" onchange="bringPlace();" id="ctg" style="width: 200px;">
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
					</td>
					<td>
						<label> 메이트 인원 <input type="number" min="1" max="3" id="mate_num"></label>
						<input type="hidden" value="여기에 인원" name="mate_num">
					</td>
					<td>
						<label> 출발 <input type="date" id="form-checkin" name="start_date"> </label> ~ <label> 도착 <input type="date" id="form-checkout" name="end_date"> </label> 
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<textarea class='boxTA' style='width:100%; height: 300px;' placeholder="즐거운 여행이 될 수 있도록 자세한 계획을 알려주세요!"></textarea>
					</td>
				</tr>
				<tr>
				   <td align='right' colspan="3">
				        <button type='button' class='btn btnSendMate' style='padding:7px 20px;' onclick="sendMate()">등록</button>
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
						           <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>메이트 찾기 ${mateCount}개</span> <span>[${pageNo}/${total_page} 페이지]</span></div>
						           <div style='float: right; text-align: right;'></div>
						       </div>
						    </td>
						</tr>
					</thead>
					
					<tbody id='listMateBody'>
					    <tr style='background: #eee; border:1px solid #ccc;'>
					       <td width='50%'>
								<span><b>이름</b></span>
					        </td>
					       <td width='50%' align='right'>
								<span>작성일</span>
								<c:choose>
									<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
										<span class="deleteMate" style="cursor: pointer;" data-mateNum='${vo.mateNum}' data-pageNo='${pageNo}'>삭제</span>
									</c:when>
								</c:choose>
					        </td>
					    </tr>
					    <tr>
					        <td colspan='2' valign='top'>
					        	<span>장소:  ctgname</span>&nbsp;|&nbsp;<span>메이트 인원 : mate_num </span>&nbsp;|&nbsp;<span>여행일 : start_date ~ end_date</span>
					        	<div style="border-top: 1px solid #ccc; padding:5px;">
					        	테스트 내용 textarea ("br \n 치환 必")
					        	</div>
					        </td>
					    </tr>
					    
					    <tr>
					        <td colspan="2">
					            <button type='button' class='btn btnMateAnswerLayout' data-mateNum='${vo.mateNum}'>답글 <span id="answerCount${vo.mateNum}">${vo.answerCount}</span></button>
					        </td>
					    </tr>
					
					    <tr class='mateAnswer' style='display: none;'>
					        <td colspan='2'>
					        <!-- listMateAnswer.jsp 파일 분리후 넣어두기 -->
					        <!--
					        <div id='listMateAnswer${vo.mateNum}' class='answerList' style='border-top: 1px solid #ccc;'></div>
					          -->
					        
					        
					   <!-- listMateAnswer.jsp 내용 -->  
					   <!-- listMate.jsp에는  c:forEach 처리 -->   
							 <div class='answer' style='padding: 0 10px;'>
								<div style='clear:both; padding: 10px 0;'>
									<div style='float: left; width: 5%;'>└</div>
									<div style='float: left; width:95%;'>
										<div style='float: left;'><b>댓작성자이름</b></div>
										<div style='float: right;'>
											<span>작성일</span> |
											<c:choose>
												<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
													<span class='deleteMateAnswer' style='cursor: pointer;' data-mateNum='${vo.mateNum}' data-answer='${vo.answer}'>삭제</span>
												</c:when>
											</c:choose>
										</div>
									</div>
								</div>
								<div style='clear:both; padding: 5px 5px; border-bottom: 1px solid #ccc;'>
									저 참여하고 싶어요~! 댓 내용 표시
								</div>
							</div>	            
						<!-- 여기까지 listMateAnswer.jsp -->
						
						
						
				
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
