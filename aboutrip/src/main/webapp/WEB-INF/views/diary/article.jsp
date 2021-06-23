<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	height: 900px;
	padding: 90px;
}

form {
  max-width: 650px;
  width: 90%;
  background-color: #f8f9fa;
  padding: 40px;
  border-radius: 4px;
  color: #b4b4b4;
  box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  margin: 0px auto;
}
.btnAddFollow {
	padding: 0px;
	margin: 8px;
	box-sizing: border-box; 
	cursor: pointer;
	width: 60px;
	height: 60px;
	border-radius:45px;
	border: 1px solid #4682B4;
	font-weight: bold;
	text-align: center;
	font-size: 14px;
	background: #f8f9fa;
}
.btnAddFollow:hover {
	color: #f8f9fa;
	border: 1px solid #f8f9fa;
	background-color: #4682B4;
}
.createBtn {
	margin: 8px;
	color: #4682B4;
	box-sizing: border-box; 
	cursor: pointer;
	width: 60px;
	height: 60px;
	border-radius:45px;
	border: 1px solid #4682B4;
	font-weight: bold;
	text-align: center;
	font-size: 14px;
	background: #f8f9fa;

}

.createBtn:hover {
	color: #f8f9fa;
	border: 1px solid #f8f9fa;
	background-color: #4682B4;
}

.photoSlider {
	width: 350px;
	margin: 10px auto;
}
.photoSlider img {
	width: 970%;
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
		var bLike = $btn.find(".liker").css("color")=="rgb(255, 255, 0)";
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
					$btn.find(".liker").css("color","black");
				} else {
					$btn.find(".liker").css("color","yellow");
				}
			}
			
			$("#diaryLikeCount").text(diaryLikeCount);
			
		};
		ajaxFun(url, "post", query, "json", fn);

	});
});

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
/*
function addFollowing() {
	if(! $.trim($("#userNum").val()) ) {
		$("#userNum").focus();
		return;
	}
	
	var url="${pageContext.request.contextPath}/diary/addFollowing";
	var query=$("form[name=followForm]").serialize();
	
	var fn = function(data){
		// var state = data.state;
		
		$("#userNum").val("");
		
		listPage(1);
	};
	
	ajaxFun(url, "post", query, "json", fn);
}
*/

$(function(){
	$(".btnAddFollow").click(function(){		
		var $btn = $(this);
		var bFol = $btn.find(".follow").css("color")=="rgb(255, 0, 0)";
		var msg = "${dto.nickName}님을 팔로우합니다. ";
		if(bFol) {
			msg = "팔로우를 취소합니다. ";
		}
		
		if( ! confirm(msg)) {
			return false;	
		}
		
		var url="${pageContext.request.contextPath}/diary/addFollowing";
		if(bFol) {
			url="${pageContext.request.contextPath}/diary/cancelFollowing";
		}
		//var followerUser="${sessionScope.member.userNum}";
		var followingUser="${dto.userNum}";
		var query="diaryNum=${dto.diaryNum}";
		
		var fn = function(data){
			//console.log(data);
			var state = data.state;
			if(state=="true") {
				if(bFol) {
					$btn.find(".follow").css("color","black");
				} else {
					$btn.find(".follow").css("color","red");
				}
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

</script>

<div class="body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
	
	<div class="body-main">
	<form name="followForm" method="post" >
		<div class="body-title">
			<h3>다이어리</h3>
		</div>
		<div class="photoSlider">
		<c:if test="${listImg.size() > 0}">	
			<ul class="slider" style="margin: 0;">
				<c:forEach var="dto" items="${listImg}">
					<c:choose>
						<c:when test="${not empty dto.saveImgName}">
							<li><img src="${pageContext.request.contextPath}/uploads/diary/${dto.saveImgName}"></li>
						</c:when>
						<c:otherwise>
							<li><img src="${pageContext.request.contextPath}/resources/images/noimage.png"></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</c:if>
		</div>
		<table>
			<tr>
				<td align="left">${dto.nickName}</td>
			</tr>
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

			<tr>
				<td>${dto.diaryContent}</td>
			</tr>
			<tr>
				<td colspan="2" style="padding-bottom: 15px;" align="center">
					<button type="button" class="btn btnSendDiaryLike" title="좋아요"><i class="fas fa-thumbs-up liker" style="color:${isDiaryLikeUser?'yellow;':'black;'}"></i>&nbsp;&nbsp;<span id="diaryLikeCount">${dto.diaryLikeCount}</span></button>
				</td>
			</tr>

			<tr>
				<td align="left">
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
			    			<button type="button" class="createBtn" onclick="deleteDiary();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="createBtn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/main?${query}';">리스트</button>
					<!-- 
					<button type="button" class="btn btnAddFollow" title="팔로우"><i class="far fa-grin follow" style="color:${isFollow?'red;':'#4682B4;'}"></i><span id="addFollowing">팔로우</span></button>
					 -->
					<button type="button" class="btn btnAddFollow" title="팔로우"><span class="follow" style="color:${isFollow?'red;':'#4682B4;'}" id="addFollowing">팔로우</span></button>
				</td>
			</tr>
		</table>
		<input type="hidden" name="userNum" value="${dto.userNum}">
	</form>
    </div>
    <div id="dialogDiary">
	      <div id="imgDiaryLayout"></div>
	</div>
</div>
