<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.body-container {
	color: #f8f9fa;
	font-family: 나눔고딕;
	padding: 20px;
}

form {
	margin: 2px 15px;
}

.body-main {
	margin: 10px auto;
	max-width: 500px;
}

.diaryBtn {
	color: #f8f9fa;
	background: none;
	border: none;
}
.diaryBtn:hover {
	color: #f8f9fa;
	border: 1px dotted #f8f9fa;
	border-radius: 3px;
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
	border: none;
	font-weight: bold;
	text-align: center;
	font-size: 13px;
	background: #f8f9fa;
	position: fixed;
	left: 1050px; top: 222px;
}

.createBtn:hover {
	color: #f8f9fa;
	border: 1px solid #f8f9fa;
	background-color: transparent;
}
.shape {
	width: 500px;
  	background-color: #f8f9fa;
  	border-radius: 4px;
  	color: #b4b4b4;
  	box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  	margin: 20px auto;
  	padding: 15px;
  	
}

</style>

<script type="text/javascript">
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
	var url="${pageContext.request.contextPath}/diary/list";
	var query="page="+page;
	
	var fn = function(data) {
		printGuest(data);
	}
	
	ajaxFun(url, "get", query, "json", fn);
}

function printGuest(data) {
	var uid="${sessionScope.member.userNum}";
	var dataCount = data.dataCount;
	var page = data.page;
	var totalPage = data.total_page;
	
	$("#listDiaryBody").attr("data-page", page); // 현재 화면상에 보이는 페이지 저장
	$("#listDiaryBody").attr("data-totalPage", totalPage); // 전체 페이지 저장
	
	$("#listDiaryFooter").hide();
	
	var out="";
	if(dataCount==0) {
		out+="<tr class='paging'>";
		out+="    <td colspan='2'>등록된 게시물이 없습니다.</td>";
		out+="</tr>"
		$("#listDiaryBody").html(out);
		return;
	}
	
	if(page==1) {
		$("listDiaryBody").empty();
	}
	
	var articleUrl=data.articleUrl;
	
	for(var idx=0; idx<data.list.length; idx++) {
		var diaryNum=data.list[idx].diaryNum;
		var nickName=data.list[idx].nickName;
		var diaryTitle=data.list[idx].diaryTitle
		var diaryCreated=data.list[idx].diaryCreated;
		var saveImgName=data.list[idx].saveImgName;
		
		out+="<div class='shape'>";
		out+="<table>"
		out+="<tr>";
		out+="<td rowspan='3'>";
		out+="    <a href="+articleUrl+"&diaryNum="+diaryNum+">";
		out+="    	<img src="+"'${pageContext.request.contextPath}/uploads/diary/"+saveImgName+"'style='background-size: contain; width: 220px;'>";
		out+="    </a>";
		out+="</td>";
		
		out+="<td style='line-height: 25px; margin: 10px;'>";
		out+="<button type='button' class='btnAddFollow' title='팔로우'><i class='far fa-grin' style='color:${isFollow?'red;':'black;'}'></i><span id='addFollowing'>"+nickName+"</span></button></td>";
		out+="</tr>";
		
		out+="<tr>";
		out+="<td style='line-height: 25px; '>"+diaryTitle+"</td>";
		out+="</tr>";
		
		out+="<tr>";
		out+="<td style='line-height: 25px; '>"+diaryCreated+"</td>";
		out+="</tr></table><input type='hidden' name='userNum' value='${dto.userNum}'></div>";
	}
	
	$("#listDiaryBody").append(out); // html은 기존 내용이 지워지고, append는 기존 내용이 지워지지 않는다.
	
	if(page < totalPage) {
		$("#listDiaryFooter").show();
	}
}

$(function(){
	$(".diary-list .more").click(function(){
		var page = $("#listDiaryBody").attr("data-page");
		var totalPage = $("#listDiaryBody").attr("data-totalPage");
		if(page<totalPage) {
			page++;
			listPage(page);
		}
	});
});

$(function(){
	$('.slider').bxSlider({
		auto: true,				// 자동 애니메이션 시작
		speed: 500,				// 애니메이션 속도
		pause: 5000,			// 애니메이션 유지시간(단위:ms) 
		mode: 'horizontal',		// 기본값. 슬라이드 모드 : 'fade', 'horizontal', 'vertical'
		autoControls: true,		// 시작 및 중지 버튼
		pager: true,			// 동그라미(불릿) 버튼 노출 여부
		captions: true,			// 이미지 위에 텍스트 표시
		touchEnabled: false		// <a href="주소"> 에서 설정한 주소로 이동 가능하도록
	});
});

function searchList() {
	var f=document.searchForm;
	f.submit();
}

$(function(){
	$(".btnAddFollow").click(function(){		
		var $btn = $(this);
		var bLike = $btn.find("i").css("color")=="rgb(255, 0, 0)";
		var msg = "${dto.nickName}님을 팔로우합니다. ";
		if(bLike) {
			msg = "팔로우를 취소합니다. ";
		}
		
		if( ! confirm(msg)) {
			return false;	
		}
		
		var url="${pageContext.request.contextPath}/diary/addFollowing";
		if(bLike) {
			url="${pageContext.request.contextPath}/diary/cancelFollowing";
		}
		var followingUser="${dto.userNum}";
		var query="followingUser="+followingUser;
		
		var fn = function(data){
			//console.log(data);
			var state = data.state;
			if(state=="true") {
				if(bLike) {
					$btn.find("i").css("color","black");
				} else {
					$btn.find("i").css("color","red");
				}
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>

<div class="body-container" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">
	
	<div>
		<c:if test="${listImg.size() > 0}">
			<ul class="slider" style="margin: 0;">
				<c:forEach var="dto" items="${listImg}">
					<c:choose>
						<c:when test="${not empty dto.saveImgName}">
							<li><a href="${articleUrl}&diaryNum=${dto.diaryNum}"><img src="${pageContext.request.contextPath}/uploads/diary/${dto.saveImgName}" title="${dto.diaryTitle}"></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${articleUrl}&diaryNum=${dto.diaryNum}"><img src="${pageContext.request.contextPath}/resources/images/noimage.png" title="${dto.diaryContent}"></a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</c:if>
	</div>

	<div class="body-main">
		<h3 style="font: bold; margin: 10px 0px 30px;">다이어리</h3>
		<table style="border-bottom: 2px solid white;">
			<tr>
				<td>
					<button type="button" style="margin: 0px 0px 0px 13px;" class="diaryBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/main';">새로고침</button>
				</td>
				<td>
					<form name="searchForm" action="${pageContext.request.contextPath}/diary/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
							<option value="diaryTitle" ${condition=="diaryTitle"?"selected='selected'":""}>제목</option>
							<option value="diaryContent" ${condition=="diaryContent"?"selected='selected'":""}>내용</option>
						</select>
						<input type="text" style="width: 250px;" name="keyword" value="${keyword}">
						<button type="button" style="margin: 0px 0px 0px 14px;" class="diaryBtn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td>
					<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/diary/create';">새글</button>
				</td>
			</tr>
		</table>
         
		<div id="listDiary" class="diary-list">
			<table>
				<tbody id="listDiaryBody" data-page="0" data-totalPage="0"></tbody>
				<tfoot id="listDiaryFooter">
					<tr>
						<td width="50%">&nbsp;</td>
						<td width="50%" align="right">
							<span class="more">더보기</span>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
