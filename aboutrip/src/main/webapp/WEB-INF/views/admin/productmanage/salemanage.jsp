<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script src = "https://code.highcharts.com/highcharts.js"></script>
<script>
	$(function() {
		Highcharts.chart('container', {

			title : {
				text : '어바웃트립 매출현황 분석 '
			},

			subtitle : {
				text : 'Source: aboutrip'
			},

			yAxis : {
				title : {
					text : 'Number of Employees'
				}
			},

			xAxis : {
				accessibility : {
					rangeDescription : 'Range: 2010 to 2017'
				}
			},

			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle'
			},

			plotOptions : {
				series : {
					label : {
						connectorAllowed : false
					},
					pointStart : 2010
				}
			},

			series : [
					{
						name : 'Installation',
						data : [ 43934, 52503, 57177, 69658, 97031, 119931,
								137133, 154175 ]
					},
					{
						name : 'Manufacturing',
						data : [ 24916, 24064, 29742, 29851, 32490, 30282,
								38121, 40434 ]
					},
					{
						name : 'Sales & Distribution',
						data : [ 11744, 17722, 16005, 19771, 20185, 24377,
								32147, 39387 ]
					},
					{
						name : 'Project Development',
						data : [ null, null, 7988, 12169, 15112, 22452, 34400,
								34227 ]
					},
					{
						name : 'Other',
						data : [ 12908, 5948, 8105, 11248, 8989, 11816, 18274,
								18111 ]
					}
					],

			responsive : {
				rules : [ {
					condition : {
						maxWidth : 500
					},
					chartOptions : {
						legend : {
							layout : 'horizontal',
							align : 'center',
							verticalAlign : 'bottom'
						}
					}
				} ]
			}

		});
	})
</script>

<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>