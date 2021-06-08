<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tabs.css" type="text/css">
<script type="text/javascript">
$(function(){
	$("#tab-week").addClass("active");
});

$(function(){
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="${pageContext.request.contextPath}/schedule"	
		if(tab=="month") {
			url+="/month";
		} else if(tab=="week") {
			url+="/week";
		} else if(tab=="day") {
			url+="/day";
		} else if(tab=="year") {
			url+="/year";
		}
		
		location.href=url;
		
	});
});
</script>

<div class="container body-container">
    <div class="body-title">
		<h2><i class="icofont-calendar"></i> 일정관리 </h2>
    </div>
    
    <div class="body-main wx-900 content-center">
		<div>
			<ul class="tabs">
				<li id="tab-month" data-tab="month">월별</li>
				<li id="tab-week" data-tab="week">주별</li>
				<li id="tab-day" data-tab="day">일자별</li>
				<li id="tab-year" data-tab="year">년별</li>
			</ul>
		</div>
		
		<div id="tab-content" style="clear:both; padding: 20px 0px 0px;">
		</div>
	</div>
</div>
