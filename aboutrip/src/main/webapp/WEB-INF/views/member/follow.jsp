<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="body-container">        
        <section class="login-dark" style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
            <form method="post" name="paymentForm">
               <div class="body-main">
		<table class="table table-list" style="color:white;">
			<tr> 
				<th width="50">번호</th>
				<th width="150">${mode=="follower" ? "followerUser 목록":"followingUser 목록"}</th>
				<th width="150">following 시작일</th>
			</tr>
		 
			<c:forEach var="dto" items="${list}">
			<tr> 
				<td>${dto.followingNum}</td>
			<c:if test="${mode==follower }">
				<td>${dto.followingNickname }</td>
			</c:if>
				<td>${dto.followerNickname }</td>
				<td>${dto.following_date}</td>
			</tr>
			</c:forEach>
			
			<c:if test="${list==null}">
				<td width="100">No card</td>
			</c:if>
		</table>
	</div>
              
            </form>
        </section>
</div>