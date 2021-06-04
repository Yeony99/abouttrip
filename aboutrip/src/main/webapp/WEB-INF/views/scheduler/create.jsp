<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link
	href='${pageContext.request.contextPath}/resources/js/fullcalendar/timegrid/main.min.css'
	rel='stylesheet' />
<link
	href='${pageContext.request.contextPath}/resources/js/fullcalendar/core/main.css'
	rel='stylesheet' />
<link
	href='${pageContext.request.contextPath}/resources/js/fullcalendar/daygrid/main.css'
	rel='stylesheet' />
<script
	src='${pageContext.request.contextPath}/resources/js/fullcalendar/core/main.js'></script>
<script
	src='${pageContext.request.contextPath}/resources/js/fullcalendar/daygrid/main.js'></script>
<script
	src='${pageContext.request.contextPath}/resources/js/fullcalendar/interaction/main.js'></script>
<script
	src='${pageContext.request.contextPath}/resources/js/fullcalendar/timegrid/main.min.js'></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var Calendar = FullCalendar.Calendar;
		var Draggable = FullCalendarInteraction.Draggable;

		var containerEl = document.getElementById('external-events');
		var calendarEl = document.getElementById('calendar');
		var checkbox = document.getElementById('drop-remove');

		//init external events 
		new Draggable(containerEl, {
			itemSelector : '.fc-event',
			eventData : function(eventEl) {
				return {
					title : eventEl.innerText
				};
			}
		});

		//init calendar
		var calendar = new Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid', 'timeGrid' ],
			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,timeGridWeek,timeGridDay'
			},
			editable : true,
			eventResizableFromStart : true,
			events : [ 
			{
				title : "event 1",
				start: '2021-06-04',
				end:'2021-06-08',
				color : "#98ddca",
			}, {
				title : "event 2",
				start: '2021-06-04',
				end:'2021-06-04',
				color : '#d5ecc2'
			}, {
				title : "event 3",
				start: '2021-06-05',
				end:'2021-06-09',
				color : '#ffd3b4'
			}, {
				title : "event 4",
				start: '2021-06-17',
				end:'2021-06-20',
				color : '#ffaaa7'
			}, {
				title : "event 5",
				start: '2021-06-19',
				end:'2021-06-20',
				color : '#aed9ea'
			} ],
			eventOverlap : true,
			droppable : true,
			drop : function(info) {
				if (checkbox.checked) {
					info.draggedEl.parentNode.removeChild(info.draggedEl);
				}
			},
			dateClick : function() {

			},
			eventClick: function(calEvent, jsEvent, view) {
		          var title = prompt('Event Title:', calEvent.title, { buttons: { Ok: true, Cancel: false} });

		          if (title){
		              calEvent.title = title;
		              Calendar('updateEvent',calEvent);
		          }
		},
			locale : 'ko'
		});
		calendar.render();

	});
</script>

<div class="body-main" style="margin: 8rem 8rem 40rem 8rem">
	<div style="display: flex; justify-content: center;">
		<h3 style="margin-bottom: 3rem;">📅스케줄</h3>
	</div>
	<div id="external-events"
		style="width: 70vw; display: flex; flex-wrap: wrap; flex-direction: row; margin: 0 auto; display: none" >
		<div class="fc-event" style="margin: 0 auto; width: 10vw; text-align: center;">event 1</div>
		<div class="fc-event" style="margin: 0 auto; width: 10vw; text-align: center;">event 2</div>
		<div class="fc-event" style="margin: 0 auto; width: 10vw; text-align: center;">event 3</div>
		<div class="fc-event" style="margin: 0 auto; width: 10vw; text-align: center;">event 4</div>
		<div class="fc-event" style="margin: 0 auto; width: 10vw; text-align: center;">event 5</div>
	</div>
	<div style="height: 70vh; display: flex; justify-content: center;">
		<div id="cal-container" style="width: 70vw;">
			<div id="calendar"></div>
		</div>
	</div>
</div>