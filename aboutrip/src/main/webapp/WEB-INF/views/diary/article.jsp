<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<<script type="text/javascript">
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

// 게시글 공감 여부
$(function(){
	$(".btnSendDiaryLike").click(function(){
		if(! confirm("게시물에 공감 하십니까 ? ")) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/diary/insertdiaryLike";
		var num="${dto.diaryNum}";
		var query="diaryNum="+diaryNum;
		
		var fn = function(data){
			var state=data.state;
			if(state==="true") {
				var count = data.diaryLikeCount;
				$("#diaryLikeCount").text(count);
			} else if(state==="false") {
				alert("게시글 공감은 한번만 가능합니다. !!!");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 페이징 처리
$(function(){
	listPage(1);
});

function imageViewer(img) {
	var viewer = $("#imgDiaryLayout");
	var s="<img src='"+img+"' width=570 height=450>";
	viewer.html(s);
	
	$("#dialogDiary").dialog({
		title:"이미지",
		width: 600,
		height: 530,
		modal: true
	});
}
</script>

<div class="body-container">
	<div class="body-title">
		<h3>다이어리</h3>
	</div>
	
	<!-- diaryTitle, diaryContent, diaryCreated, originalFilename,  -->
	
	<div class="body-main">
		<table>
			<tr>
				<td align="left">${dto.diaryTitle}</td>
				<td align="right">${dto.diaryCreated}</td>
			</tr>
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;">
					<div>
						<c:forEach var="vo" items="${listImg}">
			      			<img src="${pageContext.request.contextPath}/uploads/diary/${vo.saveImgName}" style="max-width: 100%; height: auto; resize: both;"
			      				onclick="imageViewer('${pageContext.request.contextPath}/uploads/diary/${vo.diaryImgName}');">
			      		</c:forEach>
			      	</div>
				</td>
			</tr>
			<tr>
				<td>${dto.diaryContent}</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendDiaryLike" title="좋아요"><i class="fas fa-thumbs-up" style="color:${isDiaryLikeUser?'red;':'black;'}"></i>&nbsp;&nbsp;<span id="diaryLikeCount">${dto.diaryLikeCount}</span></button>
				</td>
			</tr>
			
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendDiaryLike" title="좋아요"><i class="icofont-like"></i>&nbsp;&nbsp;<span id="boardLikeCount">${dto.diaryLikeCount}</span></button>
				</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userId==dto.userId}">
			    			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/update?num=${dto.diaryNum}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteDiary();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
    </div>
    <div id="dialogDiary">
	      <div id="imgDiaryLayout"></div>
	</div>
</div>
