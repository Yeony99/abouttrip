<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
var check=true;
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
function sendtest(){
	var f = document.mateForm;
	f.action ="${pageContext.request.contextPath}/scheduler/insertMate";
	f.submit();
}
function bringPlace() {
	var f = document.mateForm;
	
	var str = f.ctgNum.value;
	if(str!="") {
		f.ctgNum.value=str;
	}
}

$(function(){
	listPage(1);
});

// 글리스트 및 페이징 처리
function listPage(page) {
	var url = "${pageContext.request.contextPath}/scheduler/matelist";
	var query = "page="+page;
	
	var fn = function(data){
		printList(data);
	};
	ajaxFun(url, "get", query, "json", fn);
}

$(function(){
	$("body").on("click", ".deleteMate", function(){
		if(! confirm("게시글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		var nickName="${sessionScope.member.nickName}"
		var mateNum=$(this).attr("data-mateNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/scheduler/deleteMate";
		var query="num="+mateNum+"&nickName="+nickName;
		
		var fn = function(data){
			location.reload();
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

//댓글별 답글 리스트
function listMateAnswer(mate_num) {
	var url="${pageContext.request.contextPath}/scheduler/listReply";
	var query="mate_num="+mate_num;
	
	var fn = function(listReply){
		//$(selector).html(data);
		listAnswer(listReply);
	};
	ajaxFun(url, "get", query, "json", fn);
}
function listAnswer(data){
	var dataCount = data.listReply.length;
	var out="";
	if(dataCount==0) {
		out+="<tr class='paging'>";
		out+="    <td colspan='2'>등록된 댓글이 없습니다.</td>";
		out+="</tr>"
		$("#listMateAnswer").html(out);
		return;
	}
	var num = data.listReply[0].mate_num;
	for(var idx=0; idx<dataCount; idx++){
		var uNickName="${sessionScope.member.nickName}";
		var uid="${sessionScope.member.userId}";
		var reply_num = data.listReply[idx].reply_num;
		var user_num = data.listReply[idx].user_num;
		var mate_num = data.listReply[idx].mate_num;
		var content = data.listReply[idx].content;
		var created = data.listReply[idx].created;
		var nickName = data.listReply[idx].nickName;
		var answer = data.listReply[idx].answer;
		
		
		out +="<div class='answer' style='padding: 0 10 px;'>";
		out +="<div style='clear:both; padding:10px 0;'>";
		out +="<div style='float: left; width: 5%;'>└</div>";
		out +="<div style='float: left; width:95%; min-height:50px;'>";
		out +="<div style='float: left;'><b>"+nickName+"</b></div>";
		out +="<div style='float: right;'>";
		out +="<span style='font-size:10px;'>"+created+"</span><br>";
		if(uNickName===nickName||uid ==="admin"){
			out +="<div><span class='deleteMateAnswer' style='cursor: pointer;' data-replyNum='"+reply_num+"' data-mateNum='"+mate_num+"' data-answer='"+answer+"'>| 삭제</span> |";
			out +="<span class='updateMateAnswer' style='cursor: pointer;' data-replyNum='"+reply_num+"' data-mateNum='"+mate_num+"' data-answer='"+answer+"'>수정</span></div>";
		}
		out +="</div></div></div>";
		out +="<div class='answers' style='clear:both; padding: 5px 25px; border-bottom: 1px solid #ccc;'>"+content+"<div id='updateMateAnswer"+reply_num+"'>";
		out+="</div></div></div>"
		
	}
	$("#listMateAnswer"+num).html(out);
	console.log(num);
}
$(function(){
	$("body").on("click", ".updateMateAnswer", function(){
		
		var mate_num=$(this).attr("data-mateNum");
		var	reply_num=$(this).attr("data-replyNum");
		updateReply(mate_num, reply_num,check);
		$("form[name ='updateReplyForm']").parent().show();
		var test = $("form[name ='updateReplyForm']").parent().parent();
		console.log(test);
		test.css({"min-height": "200px"});
	});
});

$(function(){
	$("body").on("click", ".replyCancel", function(){
		$("form[name ='replyForm']").show();
		$("form[name ='updateReplyForm']").parent().hide();
		$(".answers").css({"min-height": "inherit"});
		
	})
})
function updateReply(mate_num, reply_num,check){
	$("form[name ='replyForm']").hide();
	out="<br><form name='updateReplyForm' method='post' accept-charset='utf-8' action='${pageContext.request.contextPath}/scheduler/updateReply'>";
	out+="<div style='clear: both; padding: 10px 10px;'> <div style='float: left; width: 5%;'>└</div> <div style='float: left; width:95%'>";
	out+="<textarea name='content' class='boxTA' style='width:100%; height: 70px;'></textarea>";
	out+=" <input type='hidden' name='mate_num' value='"+mate_num+"'>";
	out+=" <input type='hidden' name='reply_num' value='"+reply_num+"'>";
	out+="<input type='submit' class='btn' value='답글 수정'><input type='button' class='btn replyCancel' value='답글 취소'></div></div></form><br>";
	var sector = $("#updateMateAnswer"+reply_num);
	//$("#updateMateAnswer").html(out);
	sector.html(out);
}
$(function(){
	$("body").on("click", ".deleteMateAnswer", function(){
		if(! confirm("댓글을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var mate_num=$(this).attr("data-mateNum");
		var	reply_num=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="${pageContext.request.contextPath}/scheduler/deleteReply";
		var query="mate_num="+mate_num+"&reply_num="+reply_num;
		
		var fn = function(data){
			// var state=data.state;
			listMateAnswer(mate_num);
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
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
//답글 버튼(댓글별 답글 등록폼 및 답글리스트)
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
function bringPeople() {
	var f = document.mateForm;
	
	var str = f.people_num.value;
	if(str!="") {
		f.people_num.value=str;
	}	
}
</script>
<body>
<div class="container body-container">
    <div class="body-main wx-800 ml-30 pt-15" style="margin: 4rem 0;">
    	<div style="display: flex; justify-content: center">
			<h3>트립 메이트를 찾습니다 👋🏻</h3>
		</div>
		
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
						</select>
						</label>
					</td>
					<td>
						<label> 메이트 인원 <input type="number" min="1" max="3" id="people_num" name='people_num' value="1" onchange="bringPeople();"></label>
					</td>
					<td>
						<label> 출발 <input type="date" id="form-checkin" name="start_date"> </label> ~ <label> 도착 <input type="date" id="form-checkout" name="end_date"> </label> 
					</td>
					
				</tr>
				<tr>
					<td colspan="3">
						<label> 제목 <input type="text" name="subject" placeholder="제목">  </label>
					</td>
				</tr>

				<tr>
					<td colspan="3">
						<textarea class='boxTA' style='width:100%; height: 300px;' id="content" name="content" placeholder="즐거운 여행이 될 수 있도록 자세한 계획을 알려주세요!"></textarea>
					</td>
				</tr>
				
				<tr>
				   <td align='right' colspan="3">
				        <button type='button' class='btn' style='padding:7px 20px;' onclick="sendtest();">등록</button>
				        
				    </td>
				 </tr>
			</table>
			</form>
			
			
			
			
			<div id="listMate">
				<table class='table mate-list'>
					<thead id='listMateHeader'>
						<tr>
						    <td colspan='2'>
						       <div style='clear: both;'>
						           <div style='float: left;'><span style='font-weight: bold;'>메이트를 찾는 ${dataCount} 분이 계세요! 🙋🏻‍♀️</span> 
						           <span>[${page}/${total_page} 페이지]</span></div>
						           <div style='float: right; text-align: right;'></div>
						       </div>
						    </td>
						</tr>
					</thead>
					
					<tbody id='listMateBody'>
					<c:forEach var="dto" items="${list}">
					    <tr style='background: lightskyblue;'>
					       <td width='50%'>
								<span><b>작성자 : ${dto.nickName}</b> </span>
					        </td>
					       <td width='50%' align='right'>
								<span>${dto.created}</span>
								<c:choose>
									<c:when test="${sessionScope.member.userNum==dto.user_num || sessionScope.member.userId=='admin'}">
										<span class="deleteMate" style="cursor: pointer;" data-mateNum='${dto.num}' data-pageNo='${pageNo}'>삭제</span>
									</c:when>
								</c:choose>
					        </td>
					    </tr>
					    <tr>
					        <td colspan='2' valign='top'>
					        	<span>제목 : ${dto.subject}</span><br>
					        	<c:choose>
								<c:when test="${dto.ctgNum==1}">
										<span>장소 : 서울</span>
								</c:when>
								<c:when test="${dto.ctgNum==2}">
										<span>장소 : 부산</span>
								</c:when>
								<c:when test="${dto.ctgNum==3}">
										<span>장소 : 제주 제주시</span>
								</c:when>
								<c:when test="${dto.ctgNum==4}">
										<span>장소  : 제주 서귀포</span>
								</c:when>
								<c:when test="${dto.ctgNum==5}">
										<span>장소 : 제주 성산</span>
								</c:when>
								<c:when test="${dto.ctgNum==6}">
										<span>장소: 제주 기타</span>
								</c:when>
							</c:choose>
					        	
					        	&nbsp;|&nbsp;<span>메이트 인원 : ${dto.people_num} </span>&nbsp;|&nbsp;<span>여행일 : ${dto.start_date} ~ ${dto.end_date}</span>
					        	<div style="border-top: 1px solid #ccc; padding:5px; min-height: 150px">
					        		${dto.content}
					        	</div>
					        </td>
					    </tr>
					    
					    <tr>
					        <td colspan="2">
					            <button type='button' class='btn btnMateAnswerLayout' data-mateNum='${dto.num}'>답글 <span id="answerCount${dto.num}">${dto.answer}</span></button>
					            <input type="hidden" name="mate_num" value="${dto.num }">
					        </td>
					    </tr>
					
					    <tr class='mateAnswer' style='display: none;'>
					        <td colspan='2'>
					        
					        
					
						<div id="listMateAnswer${dto.num }">			
						</div>
						<div id="updateMateAnswer">			
						</div>    
					
							<form name="replyForm" method="post" accept-charset="utf-8" action="${pageContext.request.contextPath}/scheduler/insertReply">					
					            <div style='clear: both; padding: 10px 10px;'>
					                <div style='float: left; width: 5%;'>└</div>
					                <div style='float: left; width:95%'>
					                    <textarea name="content" class='boxTA' style='width:100%; height: 70px;'></textarea>
					                    <input type="hidden" name="mate_num" value="${dto.num }">
					                    <input type="hidden" name="reply_answer" value="0">
					                   	<input type="submit" class='btn' value="답글 등록">
					                   	
					                 </div>
					            </div>
					        </form>
					        
					        
							</td>
					    </tr>
					    </c:forEach>
					</tbody>
					<tfoot id='listMateFooter'>
						<tr align="center">
							<td colspan='2' >
								${paging}
							</td>
						</tr>
					</tfoot>
				</table>
				</div>
			</div>			
		</div>
	</div>