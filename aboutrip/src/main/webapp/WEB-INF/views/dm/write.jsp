<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<style type="text/css">
.body-container {
	height: 600px;
}

form {
  max-width: 660px;
  width: 90%;
  background-color: #f8f9fa;
  padding: 40px;
  border-radius: 4px;
  top: 55%;
  left: 50%;
  color: #b4b4b4;
  box-shadow: 3px 3px 4px rgba(0,0,0,0.2);
  margin: 90px auto;
}
.help-block {
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

.forms-receiver-name {
	display: inline-block;
}
.receiver-user {
	vertical-align: middle;
	display: inline-block;
	padding: 5px;
	border: 1px solid #002e5b;
	border-radius: 3px;
	color: #0d58ba;
	margin-right: 3px;
}

.dialog-header {
	padding: 5px 0;
}
.dialog-receiver-list {
	padding: 5px;
	border: 1px solid #ccc;
	overflow-y: scroll;
	width: 95%;
	height: 220px;
	margin: 5px 0;
}
.dialog-receiver-list ul, .dialog-receiver-list li{
	list-style: none;
	padding: 0;
}
.dialog-footer {
	text-align: right;
	padding: 5px 0;
}

.createBtn {
	color: #3CAEFF;
	border: 1px solid #3CAEFF;
	margin: 5px;
	box-sizing: border-box; 
	float: left;
	cursor: pointer;
	width: 55px;
	height: 55px;
	line-height: 55px;
	border-radius:45px;
	font-weight: bold;
	text-align: center;
	font-size: 13px;
	background: #f8f9fa;
}

.createBtn:hover {
	color: white;
	background-color: #46CCFF;
}
</style>

<script type="text/javascript">
$(function(){
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");

		if(tab=="send") {
			return false;
		}

		var url = "${pageContext.request.contextPath}/dm/receive/list";
		location.href=url;
	});
});

function sendOk() {
	var f = document.dmForm;

	if($("#forms-receiver-list input[name=receivers]").length==0) {
		alert("받는 사람을 추가하세요. ");
		return;
	}

	str = f.content.value;
	if(!str) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}

	f.action="${pageContext.request.contextPath}/dm/write";

	f.submit();
}

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

$(function(){
	$(".btnReceiverDialog").click(function(){
		$("#condition").val("userNum");
		$("#keyword").val("");
		$(".dialog-receiver-list ul").empty();
		
		$("#receiver-dialog").dialog({
			  modal: true,
			  height: 410,
			  width: 350,
			  title: '받는사람',
			  close: function(event, ui) {
			  }
		});
	});
	
	// 대화상자 - 받는사람 검색 버튼
	$(".btnReceiverFind").click(function(){
		var condition = $("#condition").val();
		var keyword = $("#keyword").val();
		if(! keyword) {
			$("#keyword").focus();
			return false;
		}
		
		var url = "${pageContext.request.contextPath}/dm/listFriend"; 
		var query = "condition="+condition+"&keyword="+encodeURIComponent(keyword);
		
		var fn = function(data){
			$(".dialog-receiver-list ul").empty();
			searchListFriend(data);
		};
		ajaxFun(url, "get", query, "json", fn);
	});
	
	function searchListFriend(data) {
		var s;
		for(var i=0; i<data.listFriend.length; i++) {
			var userNum = data.listFriend[i].userNum;
			var nickName = data.listFriend[i].nickName;
			
			s = "<li><input type='checkbox' data-userNum='"+userNum+"' title='"+userNum+"'><span>"+nickName+"</span></li>";
			$(".dialog-receiver-list ul").append(s);
		}
	}
	
	// 대화상자-받는 사람 추가 버튼
	$(".btnAdd").click(function(){
		var len1 = $(".dialog-receiver-list ul input[type=checkbox]:checked").length;
		var len2 = $("#forms-receiver-list input[name=receivers]").length;
		
		if(len1 == 0) {
			alert("추가할 사람을 먼저 선택하세요.");
			return false;			
		}
		
		if(len1 + len2 >= 5) {
			alert("받는사람은 최대 5명까지만 가능합니다.");
			return false;
		}
		
		var b, userNum, nickName, s;

		b = false;
		$(".dialog-receiver-list ul input[type=checkbox]:checked").each(function(){
			userNum = $(this).attr("data-userNum");
			nickName = $(this).next("span").text();
			
			$("#forms-receiver-list input[name=receivers]").each(function(){
				if($(this).val() == userNum) {
					b = true;
					return false;
				}
			});
			
			if(! b) {
				s = "<span class='receiver-user'>"+nickName+" <i class='icofont-bin' data-userNum='"+userNum+"'></i></span>";
				$(".forms-receiver-name").append(s);
				
				s = "<input type='hidden' name='receivers' value='"+userNum+"'>";
				$("#forms-receiver-list").append(s);
			}
		});
		
		$('#receiver-dialog').dialog("close");
	});
	
	$(".btnClose").click(function(){
		$('#receiver-dialog').dialog("close");
	});
	
	$("body").on("click", ".icofont-bin", function(){
		var userId = $(this).attr("data-userNum");
		
		$(this).parent().remove();
		$("#forms-receiver-list input[name=receivers]").each(function(){
			var receiver = $(this).val();
			if(userNum == receiver) {
				$(this).remove();
				return false;
			}
		});
		
	});

});

</script>

<div class="container body-container"  style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/img/jeju.jpg&quot;);">

		<form name="dmForm" method="post">
		<h3 style="padding: 5px 5px 15px 5px;">DM 전송하기</h3>
		<table class="table table-border table-content">
			<tr> 
				<td>받는사람</td>
				<td> 
					<div>
						<button type="button" class="createBtn btnReceiverDialog">추가</button>
						<div class="forms-receiver-name"></div>
					</div>
					<p class="help-block">
						한번에 보낼수 있는 최대 인원은 5명입니다.
					</p>
				</td>
			</tr>
			
			<tr> 
				<td valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td valign="top"> 
					<textarea name="content" class="boxTA">${dto.content}</textarea>
				</td>
			</tr>
			  
		</table>
			
		<table class="table">
			<tr> 
				<td align="center">
					<button type="button" class="createBtn" onclick="sendOk();">전송</button>
					<button type="reset" class="createBtn">리셋</button>
					<button type="button" class="createBtn" onclick="javascript:location.href='${pageContext.request.contextPath}/dm/send/list';">취소</button>
					<div id="forms-receiver-list"></div>
				</td>
			</tr>
		</table>
		</form>
	</div>
	
	<div id="receiver-dialog" style="display: none;">
		<div class="dialog-header">
			<select name="condition" id="condition" class="selectField">
				<option value="nickName" selected="selected">이름</option>
			</select>
			<input type="text" name="keyword" id="keyword" class="boxTF" style="width: 150px;">
			<button type="button" class="btn btnReceiverFind">검색</button>
		</div>
		<div class="dialog-receiver-list">
			<ul></ul>
		</div>
		<div class="dialog-footer">
			<button type="button" class="btn btnAdd">추가</button>
			<button type="button" class="btn btnClose">종료</button>
		</div>
	</div>
    
</div>