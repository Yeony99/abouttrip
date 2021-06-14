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

<script type="text/javascript">

$(function(){
	$("form input[name=upload]").change(function() {
		if(! $(this).val() )
			return false;
		
		var b = false;
		
		$("form input[name=upload]").each(function() {
			if( ! $(this).val() ){
				b=true;
				return false;
			}
		});
		if(b) {
			return false;
		}
		
		var $tr = $(this).closest("tr").clone(true); //이벤트도 복제 
		$tr.find("input").val("");
		$("#tb").append($tr);
		
	});
});

  <c:if test="${mode=='update'}">
  function deleteFile(fileNum) {
		var url="${pageContext.request.contextPath}/notice/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
  }
</c:if>
</script>

<script type="text/javascript">
    function sendOk() {
        var f = document.noticeForm;

    	var str = f.title.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.title.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }

    	f.action="${pageContext.request.contextPath}/notice/${mode}";

        f.submit();
    }
</script>

<div class="body-container">
	<div class="body-title" style="padding-top: 50px;">
			<h2>INQUIRY</h2>
	</div>
	<div class="body-main" style="padding-bottom: 50px;">
		<form name="inquiryForm" method="post" enctype="multipart/form-data">
		<table class="table table-content">
			<tbody id="tb">
				<tr> 
					<td>제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
					<td> 
						<input type="text" name="title" maxlength="100" class="boxTF" value="${dto.title}">
					</td>
				</tr>
			
				<tr> 
					<td>구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
				<td> 
					<select name="category" class="selectField">
						<option value="회원문의" ${dto.category=="여행상품"?"selected='selected'":"" }>회원문의</option>
						<option value="스케줄문의" ${dto.category=="스케줄문의"?"selected='selected'":"" }>스케줄문의</option>
						<option value="다이어리문의" ${dto.category=="다이어리가입"?"selected='selected'":"" }>다이어리문의</option>
						<option value="기타문의" ${dto.category=="기타문의"?"selected='selected'":"" }>기타문의</option>
					</select>
				</td>
				</tr>
			  
				<tr> 
					<td>작성자</td>
					<td style="padding-left:10px;"> 
						${sessionScope.member.userName}
					</td>
				</tr>
			
				<tr> 
					<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
					<td valign="top"> 
						<textarea name="content" class="boxTA">${dto.content}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
			
		<table class="table table-footer">
			<tr height="45"> 
				<td align="center" >
					<button type="button" class="btnCreate" onclick="sendOk('${mode}', '${pageNo}');">${mode=='update'?'수정완료':'등록하기'}</button>
					<button type="reset" class="btnReset">다시입력</button>
					<button type="button" class="btnList" onclick="sendCancel('${pageNo}');">${mode=='update'?'수정취소':'등록취소'}</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="num" value="${dto.num}">
						<input type="hidden" name="pageNo" value="${pageNo}">
					</c:if>
				</td>
			</tr>
		</table>
		</form>
	</div>
    </div>