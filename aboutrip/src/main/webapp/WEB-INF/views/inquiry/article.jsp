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

.btnupdate {
	border: none;
	background-color: #055ada;
	color: #fff;
	border-radius: 7px;
}

.btndelete {
	border: none;
	background-color: #87CEFA;
	color: black;
	border-radius: 7px;
	
}

.btnList{
	border: none;
	background-color: #EAEAEA;
	color: black;
	border-radius: 7px;
}


a {
	text-decoration: none;
}
</style>

<div class="body-container">
	<div class="body-title" style="padding-top: 50px;">
			<h2>INQUIRY</h2>
	</div>
    
	<div class="body-main" style="padding-bottom: 50px;">
		<table class="table table-content">
			<tr>
				<td colspan="2" align="center" style="color: blue; font-weight: 600;">
				  ${dto.num} &nbsp;&nbsp; | &nbsp;&nbsp; ${dto.title}
				</td>
			</tr>
			
			<tr style="font-weight: 600;">
				<td width="50%" align="left">
					관리자
				</td>
				<td width="50%" align="right">
					${dto.reg_date} 
				</td>
			</tr>
			
			<tr>
				<td colspan="2" valign="top" height="200" style="padding-left: 10px;">
					${dto.content}
				</td>
			</tr>
			
			<c:forEach var="vo" items="${listFile}">
				<tr>
					<td colspan="2">
						<a href="${pageContext.request.contextPath}/notice/download?fileNum=${vo.fileNum}">
						📃 ${vo.originalFilename}</a>
					</td>
				</tr>
			</c:forEach>
			
			<tr>
				<td colspan="2">
					이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="${pageContext.request.contextPath}/notice/article?${query}&num=${preReadDto.num}">${preReadDto.title}</a>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="${pageContext.request.contextPath}/notice/article?${query}&num=${nextReadDto.num}">${nextReadDto.title}</a>
					</c:if>
				</td>
			</tr>
		</table>
			
		<table class="table table-footer">
			<tr>
				<td width="50%" align="left">
					<c:choose>
						<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btnupdate" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/update?num=${dto.num}&page=${page}';">수정</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btnupdate" disabled="disabled">수정</button>
			    		</c:otherwise>
			    	</c:choose>
			    	
			    	<c:choose>
			    		<c:when test="${sessionScope.member.userId=='admin'}">
			    			<button type="button" class="btndelete" onclick="deleteSend();">삭제</button>
			    		</c:when>
			    		<c:otherwise>
			    			<button type="button" class="btndelete" disabled="disabled">삭제</button>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			
				<td align="right">
					<button type="button" class="btnList" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
    </div>
    
</div>