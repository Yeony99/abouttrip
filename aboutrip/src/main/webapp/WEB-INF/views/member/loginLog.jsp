<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}
.table-paging tr > td {
	height: 40px;
	line-height: 40px;
	text-align:center;
	padding: 5px;
	box-sizing: border-box;
}
.table-paging {
    border: 1px solid #e28d8d;
    background: #fff;
    color: #cb3536;
    font-weight: 600;
    height: 28px;
    padding: 3px 7px;
    margin-left: 3px;
    vertical-align: middle;
}
</style>
<div class="body-container">        
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post" name="paymentForm">
               <div class="body-main">
         <table class="table table-header">
			<tr>
				<td align="left" width="50%">
					${dataCount}개(${page}/${total_page} 페이지)
				</td>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table>
		
		<table class="table table-list" style="color:white;">
			<tr> 
				<th width="100">번호</th>
				<th width="100">로그인 ip</th>
				<th width="100">로그인한 날짜 / 시간</th>
			</tr>
		 
			<c:forEach var="dto" items="${list}">
			<tr> 
				<td>${dto.logNum}</td>
				<td>${dto.ipaddr}</td>
				<td>${dto.logDate}</td>
			</tr>
			</c:forEach>
			<c:if test="${list==null}">
				<td width="100">No card</td>
			</c:if>
		</table>
		<table class="table table-paging">
			<tr>
				<td>${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
			</tr>
		</table>
		<table class="table table-footer">
			<tr>
				<td align="left" width="100">
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/member/mypage';" style="color:white; background-color: skyblue;">되돌아가기</button>
				</td>
			</tr>
		</table>
	</div>
              
            </form>
        </section>
</div>