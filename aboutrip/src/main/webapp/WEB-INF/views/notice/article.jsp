<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.table-content {
	margin-top: 25px;
}
.table-content tr {
	border-bottom: 1px solid #ccc;
	height: 35px;
}
.table-content tr:first-child {
	border-top: 2px solid #ccc;
}
.table-content tr:last-child {
	border-bottom: 1px solid #ccc;
}
.table-content tr > td {
	padding: 7px 5px;
}

.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height:45px;
}
</style>

<script type="text/javascript">
<c:if test="${sessionScope.member.userId=='admin'}">
	function deleteSend() {
		var query = "num=${dto.num}&${query}";
		var url = "${pageContext.request.contextPath}/notice/delete?" + query;
	
		if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
			location.href=url;
		}
	}
</c:if>
</script>

<div class="body-container">
	<div class="body-title">
		<div style="text-align: left; color: black">
				<h2>NOTICE</h2>
				<p>AboutTrip 공지사항</p>
				<hr>
				<br>
		</div>
	</div>
    
	<div class="body-main">
		<table class="table table-content">
			<tr>
				<td colspan="2" align="center">
					${dto.title}
				</td>
			</tr>
			
			<tr>
				<td width="50%" align="left">
					이름 : ${dto.AdminNum}
				</td>
				<td width="50%" align="right">
					${dto.reg_date} 
				</td>
			</tr>
			
			<tr>
				<td colspan="2" valign="top" height="200">
					${dto.content}
				</td>
			</tr>
			
			<c:forEach var="vo" items="${listFile}">
				<tr>
					<td colspan="2">
						<a href="${pageContext.request.contextPath}/notice/download?fileNum=${vo.NfileNum}">${vo.originalFilename}</a>
						(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
					</td>
				</tr>
			</c:forEach>
			
			<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/notice/article?${query}&num=${preReadDto.NOTICEnum}">${preReadDto.title}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/notice/article?${query}&num=${nextReadDto.NOTICEnum}">${nextReadDto.title}</a>
					</c:if>
				</td>
			</tr>
		</table>
			
		<table class="table table-footer">
			<tr>
				<td width="50%" align="left">
					<c:choose>
						<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/update?num=${dto.NOTICEnum}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btn" onclick="deleteSend();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btn" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
    </div>
    
</div>