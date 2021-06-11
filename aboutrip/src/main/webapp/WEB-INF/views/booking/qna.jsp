<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
.accordion {
	box-sizing: border-box;
	width: 100%;
	min-height: 50px;
	margin: 15px auto 5px;
}

.accordion h3.question {
	box-sizing: border-box;
	color: #333;
	font-weight: 500;
	border: 1px solid #ccc;
	background-color: #fff;
	padding: 7px 15px 7px;
	border-radius: 4px;
	cursor: pointer;
	margin: 3px 0 0;
}

.accordion h3.question:hover {
	background-color: #e6e6e6;
}

.accordion h3.question .q {
	font-weight: 600;
}

.accordion h3.question .subject:hover {
	color: #0d58ba;
}

.accordion div.answer {
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-top: none;
	min-height: 50px;
	padding: 3px 10px 10px;
	display: none;
}

.accordion div.answer>.category {
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #eee;
}

.accordion div.answer>.content {
	padding: 7px 15px 5px;
}

.accordion div.answer>.content div:first-child {
	font-weight: 700;
	display: inline-block;
	vertical-align: top;
	padding-left: 5px;
}

.accordion div.answer>.content div:last-child {
	display: inline-block;
}

.accordion div.answer>.update {
	text-align: right;
}

.accordion h3.active {
	font-weight: 600;
	background-color: #F8FFFF;
}

.title {
	font-size: 20px;
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

.btnList {
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}

.btnSearch {
	border: 1px solid gray;
	background-color: white;
	color: black;
	border-radius: 7px;
}

.boxTF {
	height: 27px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("body").on("click", ".accordion h3.question", function() {
			var $answer = $(this).next(".accordion div.answer");
			var isVisible = $answer.is(':visible');
			if (isVisible) {
				$(this).next(".accordion div.answer").hide();
				$(this).removeClass("active");
			} else {
				$(".accordion div.answer").hide();
				$(".accordion h3.question").removeClass("active");

				$(this).next(".accordion div.answer").show();
				$(this).addClass("active");
			}
		});
	});

	$(function() {
		var categoryNum = "${categoryNum}";
		var pageNo = "${pageNo}";
		if (pageNo == "") {
			pageNo = 1;
		}
		$("#tab-" + categoryNum).addClass("active");
		listPage(pageNo);

		$("ul.tabs li").click(function() {
			categoryNum = $(this).attr("data-categoryNum");

			$("ul.tabs li").each(function() {
				$(this).removeClass("active");
			});

			$("#tab-" + categoryNum).addClass("active");

			listPage(1);
		});
	});

	function login() {
		location.href = "${pageContext.request.contextPath}/member/login";
	}

	function ajaxFun(url, method, query, dataType, fn) {
		$.ajax({
			type : method,
			url : url,
			data : query,
			dataType : dataType,
			success : function(data) {
				fn(data);
			},
			beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			},
			error : function(jqXHR) {
				if (jqXHR.status === 403) {
					login();
					return false;
				}

				console.log(jqXHR.responseText);
			}
		});
	}

	// 글리스트 및 페이징 처리
	function listPage(page) {
		var $tab = $(".tabs .active");
		var categoryNum = $tab.attr("data-categoryNum");

		var url = "${pageContext.request.contextPath}/booking/qnalist";
		var query = "pageNo=" + page + "&categoryNum=" + categoryNum;
		var search = $('form[name=faqSearchForm]').serialize();
		query = query + "&" + search;

		var selector = "#tab-content";

		var fn = function(data) {
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}

	// 검색
	function searchList() {
		var f = document.faqSearchForm;
		f.condition.value = $("#condition").val();
		f.keyword.value = $.trim($("#keyword").val());

		listPage(1);
	}

</script>

<div class="body-container">
	<div class="body-title" style="padding-top: 50px; padding-left: 50px;">
		<h3>❓QNA</h3>
	</div>

	<div class="body-main" style="padding-bottom: 50px;">

		<div id="tab-content" style="padding: 15px 10px 5px; clear: both;">
			<c:if test="${list.size() > 0}">
				<div class="accordion">
					<c:forEach var="dto" items="${list}">
						<h3 class="question">
							<span class="q">Q.</span> <span class="title">${dto.title}</span>
						</h3>
						<div class="answer">
							<div class="category">분류 : ${dto.category}</div>
							<div class="content">
								<div>A.</div>
								<div>${dto.content}</div>
							</div>
							<c:if test="${sessionScope.member.userId=='admin'}">
								<div class="update">
									<a
										onclick="javascript:location.href='${pageContext.request.contextPath}/faq/update?num=${dto.num}&pageNo=${pageNo}';">수정</a>&nbsp;|&nbsp;
									<a onclick="deleteFaq('${dto.num}', '${pageNo}');">삭제</a>
								</div>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<table class="table">
				<tr>
					<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
				</tr>
			</table>
		</div>
	</div>
</div>


