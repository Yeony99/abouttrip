<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	margin-top: 80px;
	height: 1000px;
}
form {
  max-width: 650px;
  width: 90%;
  background-color: #f8f9fa;
  padding: 40px;
  border-radius: 4px;
  color: #b4b4b4;
  box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  margin: 90px auto;
}

.createBtn {
	margin: 8px;
	color: #46CCFF;
	box-sizing: border-box; 
	cursor: pointer;
	width: 55px;
	height: 55px;
	line-height: 55px;
	border-radius:45px;
	border: 1px solid #46CCFF;
	font-weight: bold;
	text-align: center;
	font-size: 13px;
	background: #f8f9fa;

}

.createBtn:hover {
	color: #f8f9fa;
	border: 1px solid #f8f9fa;
	background-color: #46CCFF;
}


</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/slider/css/jquery.bxslider.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/slider/js/jquery.bxslider.min.js"></script>

<script type="text/javascript">
function deleteDiary() {
	var query = "diaryNum=${dto.diaryNum}&${query}";
	var url = "${pageContext.request.contextPath}/diary/delete?" + query;
	
	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
		location.href=url;
	}
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

//게시글 공감
$(function(){
	$(".btnSendDiaryLike").click(function(){
		var $btn = $(this);
		var bLike = $btn.find("i").css("color")=="rgb(255, 0, 0)";
		var msg = "게시글에 공감하시겠습니까 ?";
		if(bLike) {
			msg = "게시글 공감을 취소하시겠습니까 ?";
		}
		
		if( ! confirm(msg)) {
			return false;	
		}
		
		var url="${pageContext.request.contextPath}/diary/insertDiaryLike";
		if(bLike) {
			url="${pageContext.request.contextPath}/diary/deleteDiaryLike";
		}
		var query="diaryNum=${dto.diaryNum}";
		var fn = function(data) {
			var state = data.state;
			var diaryLikeCount = data.diaryLikeCount;
			if(state=="true") {
				if(bLike) {
					$btn.find("i").css("color","black");
				} else {
					$btn.find("i").css("color","red");
				}
			}
			
			$("#diaryLikeCount").text(diaryLikeCount);
			
		};
		ajaxFun(url, "post", query, "json", fn);

	});
});

/*
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
*/
$(function(){
	$('.slider').bxSlider({
		auto: true,				// 자동 애니메이션 시작
		speed: 500,				// 애니메이션 속도
		pause: 5000,			// 애니메이션 유지시간(단위:ms) 
		mode: 'horizontal',		// 기본값. 슬라이드 모드 : 'fade', 'horizontal', 'vertical'
		pager: true,			// 동그라미(불릿) 버튼 노출 여부
		captions: true			// 이미지 위에 텍스트 표시
	});
});

</script>

<div class="body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
	<div class="body-title">
		<h3>다이어리</h3>
	</div>
	
	<!-- diaryTitle, diaryContent, diaryCreated, originalFilename,  -->
	
	<div class="body-main">
	<form>
		<table>
			<tr>
				<td align="left">${dto.diaryTitle}</td>
				<td align="right">${dto.diaryCreated}</td>
			</tr>
			<!--  
			<tr>
				<td colspan="2" align="center" style="padding: 10px 5px;">
					<div>
						<c:forEach var="vo" items="${listImg}">
			      			<img src="${pageContext.request.contextPath}/uploads/diary/${vo.saveImgName}" style="width:300px; height: auto;"
			      				onclick="imageViewer('${pageContext.request.contextPath}/uploads/diary/${vo.saveImgName}');">
			      		</c:forEach>
			      	</div>
				</td>
			</tr>
			-->		
			
			<c:if test="${listImg.size() > 0}">	
				<tr class="slider" style="margin: 0;">
					<c:forEach var="dto" items="${listImg}">
						<c:choose>
							<c:when test="${not empty dto.saveImgName}">
								<td><img src="${pageContext.request.contextPath}/uploads/diary/${dto.saveImgName}"></td>
							</c:when>
							<c:otherwise>
								<td><img src="${pageContext.request.contextPath}/resources/images/noimage.png"></td>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tr>
			</c:if>
		
			<tr>
				<td>${dto.diaryContent}</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendDiaryLike" title="좋아요"><i class="icofont-like" style="color:${isDiaryLikeUser?'red;':'black;'}"></i>&nbsp;&nbsp;<span id="diaryLikeCount">${dto.diaryLikeCount}</span></button>
				</td>
			</tr>

			<tr>
				<td width="50%">
					<c:choose>
						<c:when test="${sessionScope.member.userNum==dto.userNum}">
			    			<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/update?diaryNum=${dto.diaryNum}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="createBtn" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userNum==dto.userNum || sessionScope.member.userId=='admin'}">
			    			<button type="button" class="createBtn" class="btn" onclick="deleteDiary();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="createBtn" class="btn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/main?${query}';">리스트</button>
				</td>
			</tr>
		</table>
	</form>
    </div>
    <div id="dialogDiary">
	      <div id="imgDiaryLayout"></div>
	</div>
</div>
