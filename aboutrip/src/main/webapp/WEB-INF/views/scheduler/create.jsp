<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
.body_title span {
   font-size: 30px;
   color: #111;
   font-weight: 200;
}
.boxTA {
   resize: none;
   max-height: 30rem;
   overflow-y: scroll;
   width: 60rem;
   height: 30rem;
   border: solid 1px #ddd;
   border-radius: 0;
   appearance: none;
   line-height: 20px;
   margin-left: 10px;
   margin-top: 20px;
   padding-left: 15px;
   padding-top: 15px;
}
.boxTF {
   height: 42px;
   width: 650px;
   border: solid 1px #ddd;
   padding-left: 15px;
}
.btn {
   width: 150px;
   height: 50px;
   font-size: medium;
   border-radius: 0;
   background-color: #424242;
   color: white;
   cursor: pointer;
   border: none;
}
</style>
<script>
$(document).ready(function(){
	msgAlert();
});
function sendSch(){
	var f = document.listForm;
	var str;
	var search = f.search.value;
	var page = f.page.value;
	var mode = f.mode.value;
	var num = f.num.value;
	
	str = f.subject.value;
	str = str.trim();
	if (!str) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}
	
	str = f.content.value;
	str = str.trim();
	if (!str) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}	
	if(mode == "updateShare"){
		f.action="${pageContext.request.contextPath}/scheduler/updateShare?page"+page+"&search="+search+"&num="+num;	
	} else {
		f.action = "${pageContext.request.contextPath}/scheduler/${mode}?search="+search;
	}
	f.submit();
}
function bringName() {
   var f = document.listForm;
   
   var str = f.upload.value;
   if(str!="") {
      f.placeFileName.value=str;
   } else{
      f.placeFileName.value="fail";
   }
}
function bringPlace() {
   var f = document.listForm;
   
   var str = f.ctg.value;
   if(str!="") {
      f.ctgNum.value=str;
   }
}

function bringPlan() {
   var f = document.listForm;
   
   var str = f.plan.value;
   if(str!="") {
      f.color.value=str; 
   }
}
function findSch(){
	var f = document.listForm;
	var color = f.plan.value;
	var search = f.search.value;
	
	f.action="${pageContext.request.contextPath}/scheduler/findshare?color"+color+"&search="+search;
	f.submit();
}

function resetSch() {
	var f = document.listForm;
	f.action = "${pageContext.request.contextPath}/scheduler/create";
	f.submit();
}
function msgAlert() {
	var f = document.listForm;
	var msg = f.msg.value;
	if(msg=="false") {
		alert("오류! 일정을 찾을 수 없습니다. '캘린더'에서 확인해주세요.")
	} 
}
</script>
   <div style="margin-top: 8rem">
      <div>
         <div class="body_title">
            <span> 나의 스케줄 공유  </span>
         </div>
			
         <div>
            <form name="listForm" method="post" enctype="multipart/form-data">
               <table
                  style="width: 100%; margin: 30px auto; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #111;">
                  <c:if test="${empty dto }">
                  <tr align="left" height=100px;
                     style="border-bottom: 1px solid #ddd;">
                     <td style="text-align: center; width: 250px;">가져올 일정 제목</td>
                     <td style="padding-left: 10px;"> 
                        <input type="text" name="search" class="boxTF" value="${dto.search}">
                     </td>
                  </tr>
                  <input type="hidden" name="msg" value="${msg}">
                  <tr align="left" height=100px;
                     style="border-bottom: 1px solid #ddd;">
                     <td style="text-align: center;">일정</td>
                     <td style="padding-left: 10px;">
                        <select name="plan" onchange="bringPlan();">
                           <option value="">선 택</option>
                           <option value="green" ${dto.color=="green" ? "selected='selected'" : ""}>개인일정</option>
                           <option value="blue" ${dto.color=="blue" ? "selected='selected'" : ""}>가족일정</option>
                           <option value="tomato" ${dto.color=="tomato" ? "selected='selected'" : ""}>회사일정</option>
                           <option value="purple" ${dto.color=="purple" ? "selected='selected'" : ""}>기타일정</option>
                        </select>
                           <button type="button" class="btn" onclick="findSch();">찾기</button>
                           <button type="button" class="btn" onclick="resetSch();" disabled="disabled">수정하기</button>
                        <input type="hidden" value="" name="color">
						<input type="hidden" value="${page}" name="page">
						<input type="hidden" value="${mode}" name="mode">
						<input type="hidden" value="${dto.num}" name="num">
                     </td>
                  </tr>
                  </c:if>
                  <c:if test="${not empty dto }">
                  <tr align="left" height=100px;
                     style="border-bottom: 1px solid #ddd;">
                     <td style="text-align: center; width: 250px;">가져올 일정 제목</td>
                     <td style="padding-left: 10px;"> 
                        <input type="text" name="search" class="boxTF" value="${dto.scheduler_subject}" readonly="readonly" disabled="disabled">
                     </td>
                  </tr>
                  <tr align="left" height=100px;
                     style="border-bottom: 1px solid #ddd;">
                     <td style="text-align: center;">일정</td>
                     <td style="padding-left: 10px;">
                        <select name="plan" onchange="bringPlan();">
                           <option value="" disabled="disabled">선 택</option>
                           <option value="green" ${dto.color=="green" ? "selected='selected'" : ""} disabled="disabled">개인일정</option>
                           <option value="blue" ${dto.color=="blue" ? "selected='selected'" : ""} disabled="disabled">가족일정</option>
                           <option value="tomato" ${dto.color=="tomato" ? "selected='selected'" : ""} disabled="disabled">회사일정</option>
                           <option value="purple" ${dto.color=="purple" ? "selected='selected'" : ""} disabled="disabled">기타일정</option>
                        </select>
                        <button type="button" class="btn" onclick="findSch();" disabled="disabled">찾기</button>
                        <button type="button" class="btn" onclick="resetSch();" >수정하기</button>
                        <input type="hidden" value="${dto.color }" name="color">
						<input type="hidden" value="${page}" name="page">
						<input type="hidden" value="${mode}" name="mode">
						<input type="hidden" value="${dto.num}" name="num">
                     </td>
                  </tr>
                  </c:if>
                  <tr align="left" height=100px;
                     style="border-bottom: 1px solid #ddd;">
                     <td style="text-align: center;">제목</td>
                     <td style="padding-left: 10px;"><input type="text"
                        name="subject" maxlength="50" class="boxTF"  placeholder="제목을 입력하세요." value="${dto.subject}"></td>
                  </tr>
                  <tr align="left"
                     style="border-bottom: 1px solid #ddd; height: 355px;">
                     <td style="text-align: center; width: 250px;">내용</td>
                     <td valign="top"><textarea name="content" class="boxTA" placeholder="내용을 입력하세요.">${dto.content}</textarea>
                     </td>
                  </tr>
                  <tr align="left" height=100px;
                     style="border-bottom: 1px solid #ddd;">
                     <td style="text-align: center; width: 250px;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
                     <td style="padding-left: 10px;"> 
                        <input type="file" name="upload" class="boxTF" onchange="bringName();">
                        <input type="hidden" name="placeFileName">
                     </td>
                  </tr>
               </table>

               <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
                  <tr height="60">
                     <td align="center" style="padding-bottom: 30px;">
                        <button type="button" class="btn" onclick="sendSch();">${mode=='updateShare'?'수정':'등록'}</button>
                        <button type="button" class="btn"
                           onclick="javascript:location.href='${pageContext.request.contextPath}/scheduler/share';">${mode=='updateShare'?'수정취소':'등록취소'}</button>
                        <button type="reset" class="btn">재입력</button> </td>
                  </tr>
               </table>
            </form>

         </div>
      </div>
   </div>