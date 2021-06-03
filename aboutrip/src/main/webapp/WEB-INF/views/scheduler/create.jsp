<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/js/fullcalendar/daygrid/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/core/main.js'></script>
<script src='${pageContext.request.contextPath}/resources/js/fullcalendar/daygrid/main.js'></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'dayGrid' ]
		});
		calendar.render();
	});
</script>

<div class="body-main" style="margin: 8rem">
	<div style="display: flex; justify-content: center;">

		<h3>스케줄</h3>
	</div>
	<div style="display: flex; justify-content: center;">
		<div id="cal-container" style="width: 70vw;">
			<div id="calendar"></div>
		</div>
	</div>
</div>