<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/js/fullcalendar5/lib/main.min.css">
<style type="text/css">
.table-article {
	margin-top: 10px;
}

.table-article tr>td {
	padding-left: 5px;
	padding-right: 5px;
}

.table-article tr>td:nth-child(1) {
	width: 100px;
	text-align: center;
	background: #eee;
}

.ui-widget-header {
	background: #2a52be;
	color: white;
}

a, a:hover {
	color: black;
	text-decoration: none;
}

#shot {
	border: none;
	background: none;
	
}

.cal-notice {
	display:none;
    position: relative;
    width: 100%;
    height: 80%;
    background: pink;
    z-index: 9999999;
    text-align: center;
    font-size: 1rem;
}

@media (max-width: 670px) {
	.body-main {
		display: none;
	}
	.cal-notice {
		display: inherit;
	}
}
</style>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/fullcalendar5/lib/main.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/fullcalendar5/lib/locales-all.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
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
var calendar=null;
var group="all";
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth, listWeek'
		},
		initialView: 'dayGridMonth', // 처음 화면에 출력할 뷰
		locale: 'ko',
		editable: true,
		navLinks: true,
		dayMaxEvents: true,
		events:function(info, successCallback, failureCallback) {
			var url="${pageContext.request.contextPath}/scheduler/month";
			var startDay=info.startStr.substr(0, 10);
			var endDay=info.endStr.substr(0, 10);
            var query="start="+startDay+"&end="+endDay;
            
        	var fn = function(data){
        		successCallback(data.list);
        	};
        	ajaxFun(url, "get", query, "json", fn);

		},
		selectable: true,
		selectMirror: true,
		select: function(info) {
			// 날짜의 셀을 선택하거나 드래그하면 입력 대화상자를 출력
			// insertSchedule(info.start, info.end, info.allDay); // start : Date 형
			insertSchedule(info.startStr, info.endStr); //startStr : 2021-06-06T07:00:00+09:00
			
	        calendar.unselect();
		},
		eventClick: function(info) {
			// 일정 제목을 선택할 경우 상세 일정
			viewSchedule(info.event);
		},
		eventDrop: function(info) {
			// 일정을 드래그 한 경우
			updateDrag(info.event);
		},
		eventResize: function(info) {
			// 일정의 크기를 변경 한 경우
			updateDrag(info.event);
		},
		loading: function(bool) {
			document.getElementById('scheduleLoading').style.display = bool ? 'block' : 'none';
		}
	});
	calendar.render();
});
$(function(){
	$("#tab-"+group).addClass("active");
	$("ul.tabs li").click(function() {
		group = $(this).attr("data-group");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+group).addClass("active");
		
		calendar.refetchEvents();
	});
});
// 일정 등록 대화상자
function insertSchedule(start, end) {
	// 폼 초기화
	initForm(start, end, "insert");
	
	$('#schedule-dialog').dialog({
		  modal: true,
		  height: 625,
		  width: 600,
		  title: '일정 등록',
		  close: function(event, ui) {
		  }
	});
}
// 입력 및 수정 폼 초기화
function initForm(start, end, mode) {
	// 폼 reset
	$("form[name=scheduleForm]").each(function(){
		this.reset();
	});
	$("form[name=scheduleForm] input[name=mode]").val(mode);
	
	if(mode=="insert") {
		$(".btnScheduleSendOk").text("일정등록");
		$(".btnScheduleSendCancel").text("등록취소");
	} else {
		$(".btnScheduleSendOk").text("수정완료");
		$(".btnScheduleSendCancel").text("수정취소");
	}
	$("#form-repeat_cycle").hide();
	$("#form-checkout").closest("tr").show();
	
	var startDate, endDate;
		startDate = start.substr(0, 10);
		endDate = end.substr(0, 10);
	
	$("form[name=scheduleForm] input[name=check_in").val(startDate);
	$("form[name=scheduleForm] input[name=check_out").val(endDate);
	
	
	$("#form-checkin").datepicker({showMonthAfterYear:true});
	$("#form-checkout").datepicker({showMonthAfterYear:true});
}
$(function(){
	$("#form-checkin").change(function(){
		$("#form-checkout").val($("#form-checkin").val());
	});
});
// 일정 등록완료 및 수정 완료
$(function(){
	$(".btnScheduleSendOk").click(function(){
		if(! check()) {
			return false;
		}
		
		var mode = $("form[name=scheduleForm] input[name=mode]").val();
		var query=$("form[name=scheduleForm]").serialize();
		var url="${pageContext.request.contextPath}/scheduler/"+mode;
		var fn = function(data) {
			var state=data.state;
			if(state=="true") {
				group="all";
				
				// 모든 소스의 이벤트를 다시 가져와 화면에 다시 렌더링
				calendar.refetchEvents();
			}
			
			$('#schedule-dialog').dialog("close");
		};
		ajaxFun(url, "post", query, "json", fn);
	});
});
// 등록 대화상자 닫기
$(function(){
	$(".btnScheduleSendCancel").click(function(){
		$('#schedule-dialog').dialog("close");
	});
});
// 등록내용 유효성 검사
function check() {
	if(! $("#form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}
	if(! $("#form-checkin").val()) {
		$("#form-checkin").focus();
		return false;
	}
	if($("#form-checkout").val()) {
		var s1=$("#form-checkin").val().replace("-", "");
		var s2=$("#form-checkout").val().replace("-", "");
		if(s1>s2) {
			$("#form-checkout").focus();
			return false;
		}
	}
	
	return true;
}
//  일정 상세 보기
function viewSchedule(calEvent) {
	$("form[name=scheduleForm]").each(function(){
		this.reset();
	});
	var num=calEvent.extendedProps.num;
	var subject=calEvent.extendedProps.subject;
	var color=calEvent.backgroundColor;
	var start=calEvent.startStr;
	var end=calEvent.endStr;
	end=daysLater(end,0);
	var checkin=calEvent.extendedProps.check_in;
	var checkout=calEvent.extendedProps.check_out;
	
	checkin= checkin.substr(0,10);
	checkout=checkout.substr(0,10);
	checkout=daysLater(checkout,0);

	var memo=calEvent.extendedProps.memo;
	var created=calEvent.extendedProps.created;
	created = created.substr(0,10);
	$(".btnScheduleUpdate").attr("data-num", num);
	$(".btnScheduleDelete").attr("data-num", num);
	
	// 수정폼 초기화
	initForm(start, end, "update");
	$("#form-subject").val(subject);
	$("#form-color").val(color);
	$("#form-num").val(num);
	$("#form-memo").val(memo);
	
	// 일정보기
	var s;
	$(".table-article .subject").html(subject);
	
	if(color=="green") s = "개인일정";
	else if(color=="blue") s = "가족일정";
	else if(color=="tomato") s = "회사일정";
	else s = "기타일정";
	
	$(".table-article .color").html(s);
	
	s = checkin;
	
	if( checkout ) s += " ~ " + checkout;
	
	$(".table-article .period").html(s);
	
	$(".table-article .created").html(created);
	
	if(! memo) memo="";
	$(".table-article .memo").html(memo);
	$('#viewSchedule-dialog').dialog({
		  modal: true,
		  height: 420,
		  width: 600,
		  title: '상제 일정',
		  open: function() {
		  },
		  close: function(event, ui) {
		  }
	});	
}
// 일정 상세 대화상자 종료
$(function(){
	$(".btnScheduleClose").click(function(){
		$('#viewSchedule-dialog').dialog("close");
	});
});
// 수정 폼
$(function(){
	$(".btnScheduleUpdate").click(function(){
		$('#viewSchedule-dialog').dialog("close");
		
		$('#schedule-dialog').dialog({
			  modal: true,
			  height: 625,
			  width: 600,
			  title: '일정 수정',
			  close: function(event, ui) {
			  }
		});
	});
});
// 일정 삭제
$(function(){
	$(".btnScheduleDelete").click(function(){
		var num = $(this).attr("data-num");
		if(confirm("일정을 삭제 하시겠습니까 ?")) {
			var url="${pageContext.request.contextPath}/scheduler/delete";
			var query="num="+num;
			
			var fn = function(data){
				var event = calendar.getEventById(num);
				if(event!=null) {
			     	event.remove();
				}
		     	calendar.refetchEvents();
			};
			
			ajaxFun(url, "post", query, "json", fn);
		}
			
		 $("#viewSchedule-dialog").dialog("close");
	});
});
function updateDrag(calEvent) {
	var num=calEvent.extendedProps.num;
	console.log(num);
	var subject=calEvent.title;
	var color=calEvent.backgroundColor;
	var start=calEvent.startStr;
	var end=calEvent.endStr;
	var memo=calEvent.extendedProps.memo;
	
	var startDate="", endDate="";
	startDate = check_in.substr(0, 10);
	endDate = check_out.substr(0, 10);
	
	var query="num="+num+"&subject="+subject+"&color="+color+"&checkin="+startDate+"&checkout="+endDate+"&memo="+memo;
	var url="${pageContext.request.contextPath}/scheduler/update";
	var fn = function(data) {
	};
	ajaxFun(url, "post", query, "json", fn);
}
</script>

<div class="cal-notice">
	<p>	😥 앗...💦</p>
	<p>
	일정은 PC에서 편하게 이용할 수 있어요!<br>
	PC 환경에서 접속해주시길 바랍니다 🤗
	</p>
</div>
<div class="body-main" style="margin: 8rem 8rem 4rem 8rem">
	<div style="display: flex; justify-content: center; margin-bottom: 3rem;">
		<h3>📅스케줄</h3>
		<button id="shot"> 📷</button>
	</div>
	<div class="container body-container">

		<div class="body-main pt-15">
			<div style="display: none">
				<ul class="tabs">
					<li id="tab-all" data-group="all">전체일정</li>
					<li id="tab-green" data-group="green">개인일정</li>
					<li id="tab-blue" data-group="blue">가족일정</li>
					<li id="tab-tomato" data-group="tomato">회사일정</li>
					<li id="tab-purple" data-group="purple">기타일정</li>
				</ul>
			</div>
			<div id="tab-content" style="padding: 25px 10px 15px; clear: both;">
				<div id="calendar"></div>
			</div>
			<div id='scheduleLoading' style="display: none;">loading...</div>
		</div>
	</div>

	<div id="schedule-dialog" style="display: none;">
		<form name="scheduleForm">
			<table
				style="width: 100%; margin: 20px auto 0; border-spacing: 0; border-collapse: collapse;">
				<tr>
					<td width="100" valign="top"
						style="text-align: right; padding-top: 5px;"><label
						style="font-weight: 900;">제목</label></td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<input type="text" name="subject" id="form-subject"
								maxlength="100" class="boxTF"
								style="width: 95%; border: 1px solid black; border-radius: 1rem">
						</p>
						<p class="help-block">* 제목은 필수 입니다.</p>
					</td>
				</tr>

				<tr>
					<td width="100" valign="top"
						style="text-align: right; padding-top: 5px;"><label
						style="font-weight: 900;">일정분류</label></td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<select name="color" id="form-color" class="selectField"
								style="border-radius: 1rem; border: 1px solid black;">
								<option value="green">개인일정</option>
								<option value="blue">가족일정</option>
								<option value="tomato">회사일정</option>
								<option value="purple">기타일정</option>
							</select>
						</p>
					</td>
				</tr>

				<tr>
					<td width="100" valign="top"
						style="text-align: right; padding-top: 5px;"><label
						style="font-weight: 900;">시작일자</label></td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<input type="text" name="check_in" id="form-checkin"
								maxlength="10" class="boxTF" readonly="readonly"
								style="width: 40%; border: 1px solid black; border-radius: 3rem; background: #fff;">
						</p>
						<p class="help-block">* 시작날짜는 필수입니다.</p>
					</td>
				</tr>

				<tr>
					<td width="100" valign="top"
						style="text-align: right; padding-top: 5px;"><label
						style="font-weight: 900;">종료일자</label></td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<input type="text" name="check_out" id="form-checkout"
								maxlength="10" class="boxTF" readonly="readonly"
								style="width: 40%; border: 1px solid black; border-radius: 3rem; background: #fff;">
						</p>
						<p class="help-block">종료일자는 선택사항이며, 시작일자보다 작을 수 없습니다.</p>
					</td>
				</tr>
				<tr>
					<td width="100" valign="top"
						style="text-align: right; padding-top: 5px;"><label
						style="font-weight: 900;">일정 세부 설명</label></td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<textarea name="memo" id="form-memo" class="boxTA"
								style="width: 93%; height: 70px;"></textarea>
						</p>
					</td>
				</tr>

				<tr height="45">
					<td align="center" colspan="2">
						<div class="insert-button">
							<button type="button" class="btn btn-dark btnScheduleSendOk">일정등록</button>
							<button type="button" class="btn btnScheduleSendCancel">등록취소</button>
						</div> 
						 <input type="hidden" id="form-num" name="num" value="0">
						<input type="hidden" id="form-mode" name="mode" value="insert">
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="viewSchedule-dialog" style="display: none;">
		<table class="table table-article" border="1">
			<tr>
				<td>제목</td>
				<td><p class="subject"></p></td>
			</tr>

			<tr>
				<td>일정분류</td>
				<td><p class="color"></p></td>
			</tr>

			<tr>
				<td>날짜</td>
				<td><p class="period"></p></td>
			</tr>

			<tr>
				<td>등록일</td>
				<td><p class="created"></p></td>
			</tr>


			<tr height="70">
				<td valign="top">메모</td>
				<td valign="top"><p class="memo" style="white-space: pre;"></p></td>
			</tr>
		</table>

		<table class="table">
			<tr>
				<td align="right">
					<button type="button" class="btn btnScheduleUpdate">일정수정</button>
					<button type="button" class="btn btnScheduleDelete">일정삭제</button>
					<button type="button" class="btn btnScheduleClose">종료</button>
				</td>
			</tr>
		</table>
	</div>
</div>

<script>
  $(function(){
    $("#shot").on("click", function(){
			// 캡쳐 라이브러리를 통해서 canvas 오브젝트를 받고 이미지 파일로 리턴한다.
	  window.scrollTo(0,0);
	  setTimeout(function() {
	     html2canvas(document.querySelector("#calendar")).then(canvas => {
				saveAs(canvas.toDataURL('image/png'),"일정.png");
			});
		}, 1000);
    });
    function saveAs(uri, filename) { 
			// 캡쳐된 파일을 이미지 파일로 내보낸다.
      var link = document.createElement('a'); 
      if (typeof link.download === 'string') { 
        link.href = uri; 
        link.download = filename; 
        document.body.appendChild(link); 
        link.click(); 
        document.body.removeChild(link); 
      } else { 
        window.open(uri); 
      } 
    }
  });
</script>
