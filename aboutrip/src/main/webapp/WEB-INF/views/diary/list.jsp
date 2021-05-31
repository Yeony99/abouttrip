<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}

var pageNo = 1;
var total_page = 1;
$(function(){
	$(window).scroll(function(){
		if($(window).scrollTop()+70>=$(document).height()-$(window).height()) {
			if(pageNo<total_page) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});

function listPage(page) {
	var url="${pageContext.request.contextPath}/diary/list";
	var query="pageNo="+page;
	
	var fn = function(data) {
		printGuest(data);
	}
	
	ajaxFun(url, "get", query, "json", fn);
}

function printGuest(data) {
	
	$("#").append(out); // html은 기존 내용이 지워지고, append는 기존 내용이 지워지지 않는다.
	
	if(! checkScrollBar()) {
		if(page < totalPage) {
			++page;
			listPage(page);
		}
	}
	
}
</script>


		<div>
			<h3>다이어리</h3>
		</div>
		<table>
			<tr>
				<td>
					<form name="searchForm" action="${pageContext.request.contextPath}/diary/list.jsp" method="post">
						<input type="text" name="hashTag" value="${hashTag}" placeholder="해쉬태그">
						<button type="button" onclick="searchList()">검색</button>
					</form>
				</td>
			</tr>
		</table>
		
		<div>
			<table>
			<c:forEach var="dto" items="${list}">
				<c:if test="${status.index == 0}">
					<tr>
				</c:if>
				<c:if test="${status.index != 0 && status.index%3 == 0}">
					<c:out value="</tr><tr>" escapeXml="false"></c:out>
				</c:if>
				
				<td>
					<div onclick="location.href='${url}'">
						<img src="${pageContext.request.contextPath}/uploads/diary/${dto.diaryImgNum}#">
						<span>${dto.product_name}</span><br>
						<span>${dto.price}</span><br>
					</div>
				</td>
			</c:forEach>
			</table>
			
		</div>
