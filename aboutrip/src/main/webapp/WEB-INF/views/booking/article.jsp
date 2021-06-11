<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style type="text/css">
.allDataCount {
	width: 100%;
	margin: 20px auto 0px;
	border-spacing: 0px;
	border-bottom: 1.5px solid #111;
	font-size: small;
	padding-bottom: 5px;
}

.selectField {
	height: 45px;
	padding-left: 20px;
	padding-right: 50px;
	border: 1px solid #ddd;
	color: #888888;
	font-size: 15px;
	float: left;
	margin-right: 5px;
	margin-left: 250px;
	margin-top: 53px;
}

.boxTFdiv {
	float: left;
	margin-top: 53px;
	height: 47px;
}

.boxTF {
	width: 425px;
	height: 43px;
	padding-left: 15px;
	border: 1px solid #ddd;
	color: #888888;
	float: left;
	margin-right: 5px;
}

.btnSearch {
	width: 43px;
	height: 43px;
	background-color: white;
	border: 1px solid #ddd;
	cursor: pointer;
}

.btnCreate {
	width: 60px;
	height: 40px;
	background-color: #424242;
	color: white;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-left: 1040px;
	margin-bottom: 30px;
}

.btnDelete {
	width: 50px;
	height: 30px;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 10px;
	cursor: pointer;
}
</style>

<script>
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
	qna_listPage(1);
/* 	rev_listPage(1); */
});

function qna_listPage(page) {
	var url = "${pageContext.request.contextPath}/booking/qna";
	var query = "pageNo="+page;
	var params = $("form[name=qnaForm]").serialize();
	query += "&" + params;
	
	var fn = function(data) {
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
}

function rev_listPage(page) {
	var url = "${pageContext.request.contextPath}/booking/rev";
	var query = "pageNo="+page;
	var params = $("form[name=qnaForm]").serialize();
	query += "&" + params;
	
	var fn = function(data) {
		printList(data);
	};
	
	ajaxFun(url, "get", query, "json", fn);
}

function printList(data) {
	var dataCount = data.dataCount;
	var totalPage = data.total_page;
	var page = data.pageNo;
	var paging = data.paging;
	
	if(dataCount == 0) {
		$(".list-body").height(0);
		$(".list-body").empty();
		$("list-paging").html("등록된 게시물이 없습니다.");
		return;
	}
	$(".list-body").attr("data-pageNo", page);
	
	var n = Math.ceil(dataCount / 4);
	var h = n * 50;
	$(".list-body").height(h);
	
	if(n==1) {
		document.querySelector(".list-body").style.gridTemplateRows = "repeat(1, auto)";
	} else {
		document.querySelector(".list-body").style.gridTemplateRows = "repeat(2, auto)";	
	}
	
	var out="";
	for(var idx = 0; idx < data.list.length; idx++) {
		var no = idx+1;
		var nickName = data.list[idx].nickName;
		var title = data.list[idx].title;
		var content = data.list[idx].content;
		var c_date = data.list[idx].c_date;
		var answer = data.list[idx].answer;
		var a_date = data.list[idx].a_date
		
		var item="<tr><td>"+no+"</td><td>"+nickName+"</td><td>"+title+"</td>";
		item += "<td>"+content+"</td><td>"+c_date+"</td><td>"+answer+"</td><td>"+a_date+"</td></tr>";
		out+=item;
		console.log(out);
	}	
	$(".list-body").append(out);
	$(".list-paging").html(paging);
}

$(function() {
	$('.tabmenu').click(function() {
		var activeTab = $(this).attr('data-tab');
		$('td').css('background-color', 'inherit');
		$(this).css('background-color', 'green');
		$.ajax({
			type : 'GET',                 //get 방식
			url : activeTab + ".html",    //tab에 있는 data-tab 속성으로 html 통신
			dataType : "html",            //html 형식으로 값 불러들이기
			error : function() {          //통신 실패시에 확인 (값 연결 아직)
				alert('통신실패!');
			},
			success : function(data) {    //통신 성공시 #tabcontent <div> 안에 콘텐츠 삽입
				$('#tabcontent').html(data);
			}
		});
	});
	$('#default').click();          
});
</script>

<div class="body-container">
	<div class="body-main">
		<table style="width: 100%">
			<tr>
				<td style="width: 50%; height: 500px;" rowspan="2"><img
					class="box-img"
					src="${pageContext.request.contextPath}/resources/img/img/${dto.img_name}"
					alt="${dto.product_name}" title="${dto.product_name}"
					style="width: 100%; height: 100%; object-fit: cover;"></td>
				<td>
					<div style="font-size: 35px; text-align: center;">${dto.product_name}</div>
					<div
						style="margin-top: 2rem; margin-right: 30px; text-align: right; font-size: 30px; color: skyblue; font-weight: 600;">${dto.price}원</div>
				</td>
			</tr>
			<tr>
				<td style="background-color: aliceblue; padding: 20px;">
					<div style="font-size: 1.0rem; margin-bottom: 10px;">꼭 읽어보세요
						!</div>
					<div>
						<ul>
							<li style="font-size:0.8rem;">일반 입장권의 경우 유효기간 : 구매후 30일</li>
							<li style="font-size:0.8rem;">렌터카 및 자가운전자만 가능합니다.</li>
							<li style="font-size:0.8rem;">(단체 관광 및 운전기사, 가이드등반, 렌터카 기사대여,<br> 택시 가이드 이용시 사용이
								불가합니다.)
							</li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
		<table style="width: 100%; background-color: skyblue;">
			<tr class="tab">
				<td data-tab="tab1" class="tabmenu" id="defaultMenu" style="padding: 30px; font-size: large;"><a
					style="text-decoration: none; color: black;" href="#detail">상품정보</a></td>
				<td data-tab="tab2" class="tabmenu" style="padding: 30px; font-size: large;"><a
					style="text-decoration: none; color: black;" href="#qna">상품문의</a></td>
				<td data-tab="tab3" class="tabmenu" style="padding: 30px; font-size: large;"><a
					style="text-decoration: none; color: black;" href="#review">리뷰</a></td>
				<td style="width: 60%">&nbsp;</td>
			</tr>
		</table>
		<div id="tabcontent"></div>
		<div style="background-color: aliceblue;">
			<div id="detail">상품정보</div>
			${dto.product_detail}

			<div id="qna">상품문의</div>
			<div>
				<form name="qnaForm" method="post">
					<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
						<tr align="center" height="55">
							<th>번호</th>
							<th>닉네임</th>
							<th>제목</th>
							<th>내용</th>
							<th>질문날짜</th>
							<th>답변</th>
							<th>답변날짜</th>
						</tr>
						<tbody class="list-body">
						</tbody>
					</table>
				<div class="list-paging"></div>
				<input type="hidden" name="code" value="${dto.code}">
				</form>


			</div>
			<div id="review">리뷰</div>

		</div>
	</div>
</div>
