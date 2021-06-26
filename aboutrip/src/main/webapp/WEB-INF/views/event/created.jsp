<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.table-content {
	margin-top: 25px;
}
.table-content tr {
	border-bottom: 1px solid #ccc;
	height: 40px;
}
.table-content tbody tr:first-child {
	border-top: 1px solid #ccc;
}

.table-content tr > td {
	padding: 5px 0;
}
.table-content tr > td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}
.table-content tr > td:nth-child(2) {
	padding-left: 10px;
}
.table-content input[type=text], .table-content input[type=file], .table-content textarea {
	width: 97%;
}

.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height:45px;
	text-align: center;
}

form textarea{
	min-height: 200px;
	max-height: 500px;

}

a {
	text-decoration: none;
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

.btnList{
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}

</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
    function sendOk() {
        var f = document.eventForm;

    	var str = f.title.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.title.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return false;
        }
        
        str= f.eventStart.value;
        if(! str){
        	 alert("이벤트 시작일을 입력하세요. ");
             f.eventStart.focus();
             return false;
        }
        
        str= f.eventEnd.value;
        if(! str){
        	 alert("이벤트 종료일을 입력하세요. ");
             f.eventEnd.focus();
             return false;
        }
        
        str= f.winDate.value;
        if(! str){
        	 alert("발표일을 입력하세요. ");
             f.winDate.focus();
             return false;
        }
        
        str= f.winCount.value;
        if(! str){
        	 alert("당첨자 수를 입력하세요. ");
             f.winCount.focus();
             return false;
        }
        
        str= f.present.value;
        if(! str){
        	 alert("당첨자 상품을 입력하세요. ");
             f.present.focus();
             return false;
        }

    	f.action="${pageContext.request.contextPath}/event/${mode}";

    	return true;
    }
</script>

<div class="body-container">
	<div class="body-title" style="padding-top: 50px;">
		<h2>🎁 이벤트</h2>
	</div>
    
	<div class="body-main" style="padding-bottom: 50px;">
		<form name="eventForm" method="post" onsubmit="return submitContents(this);">
		 <table class="table table-content">
			<tr> 
				<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td> 
					<input type="text" name="title" maxlength="100" class="boxTF" value="${dto.title}">
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
					<textarea name="content" id="content" class="boxTA">${dto.content}</textarea>
				</td>
			</tr>
			  
			<tr>
				<td>이벤트 시작일</td>
				<td > 
					<input type="date" name="eventStart" value="${dto.eventStart}">
				</td>
			</tr>
			 
			<tr>
				<td>이벤트 종료일</td>
				<td > 
					<input type="date" name="eventEnd" value="${dto.eventEnd}">
				</td>
			</tr>
			
			<tr>
				<td>당첨자 발표일</td>
				<td > 
					<input type="date" name="winDate" value="${dto.winDate}">
				</td>
			</tr>
			
			<tr>
				<td>당첨자 수</td>
				<td > 
					<input type="number" name="winCount" value="${dto.winCount}">
				</td>
			</tr>
			
			<tr>
				<td>당첨자 상품</td>
				<td > 
					<input type="text" name="present" value="${dto.present}">
				</td>
			</tr>

		</table>
			
		<table class="table table-footer">
			<tr> 
				<td align="center">
					<button type="submit" class="btnCreate">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btnReset">다시입력</button>
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/event/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
							<input type="hidden" name="num" value="${dto.num}">
							<input type="hidden" name="page" value="${page}">
						</c:if>
				</td>
			</tr>
		</table>
		</form>
	</div>
        <script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "${pageContext.request.contextPath}/resources/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script> 
</div>