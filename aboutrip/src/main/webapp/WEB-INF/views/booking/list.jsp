<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.submit();
}
</script>
<div class="body-container">
	<div class="body-main">
		<div>
			<h3 style="font: bold;">상품</h3>
		</div>
		<table class="table table-header">
		<tr>
			<td width="50%">
				${dataCount}개(${page}/${total_page})페이지
			</td>
			<td align="right">
				<select id="category_num" name="category_num">
					<option value="0" ${category_num==0?"selected='selected'":""}>모두</option>
					<c:forEach var="vo" items="${categorys}">
						<option value="${vo.category_num}" ${category_num==vo.category_num?"selected='selected'":""}>${vo.category_name}</option>
					</c:forEach>
				</select>
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
						<img src="${pageContext.request.contextPath}/uploads/booking/${dto.img_num}">
						<span>${dto.product_name}</span><br>
						<span>${dto.price}</span><br>
					</div>
				</td>
			</c:forEach>
			</table>
			
		</div>
	</div>
</div>