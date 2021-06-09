<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="vo" items="${listAllCategory}">
	<tr>
		<td> <input type="text" name="category" disabled="disabled" value="${vo.category}"> </td>
		<td>
			<select name="enabled" class="selectField" disabled="disabled">
				<option value="1" ${vo.enabled==1?"selected=selected":"" }>활성</option>
				<option value="0" ${vo.enabled==0?"selected=selected":"" }>비활성</option>
			</select>
		</td>
		<td> <input type="text" name="orderNo" disabled="disabled" value="${vo.orderNo}"> </td>
		<td>
			<input type="hidden" name="categoryNum" value="${vo.categoryNum}">
			<span class="btnSpanIcon btnUpdateIcon" title="수정">✂</span>
			<span class="btnSpanIcon btnDeleteIcon" title="삭제">🗑</span>
			<span class="btnSpanIcon btnUpdateOkIcon" title="수정완료" style="display: none;">☑</span>
			<span class="btnSpanIcon btnUpdateCancelIcon" title="수정취소" style="display: none;">↩</span>
		</td>
	</tr>
</c:forEach>
