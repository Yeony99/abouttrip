<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 
<table class='table mate-list'>
	<thead id='listMateHeader'>
		<tr>
		    <td colspan='2'>
		       <div style='clear: both;'>
		           <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>댓글 ${mateCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
		           <div style='float: right; text-align: right;'></div>
		       </div>
		    </td>
		</tr>
	</thead>
	
	<tbody id='listMateBody'>
	<c:forEach var="vo" items="${listMate}">
	    <tr style='background: #eee; border:1px solid #ccc;'>
	       <td width='50%'>
				<span><b>${vo.userName}</b></span>
	        </td>
	       <td width='50%' align='right'>
				<span>${vo.created}</span> |
				<c:choose>
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">
						<span class="deleteMate" style="cursor: pointer;" data-mateNum='${vo.mateNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:when>
					<c:otherwise>
						<span class="notifyMate">신고</span>
					</c:otherwise>
				</c:choose>
	        </td>
	    </tr>
	    <tr>
	        <td colspan='2' valign='top'>
				${vo.content}
	        </td>
	    </tr>
	    
	    <tr>
	        <td colspan="2">
	            <button type='button' class='btn btnMateAnswerLayout' data-mateNum='${vo.mateNum}'>답글 <span id="answerCount${vo.mateNum}">${vo.answerCount}</span></button>
	        </td>
	    </tr>
	
	    <tr class='mateAnswer' style='display: none;'>
	        <td colspan='2'>
	            <div id='listMateAnswer${vo.mateNum}' class='answerList' style='border-top: 1px solid #ccc;'></div>
	            <div style='clear: both; padding: 10px 10px;'>
	                <div style='float: left; width: 5%;'>└</div>
	                <div style='float: left; width:95%'>
	                    <textarea class='boxTA' style='width:100%; height: 70px;'></textarea>
	                 </div>
	            </div>
	             <div style='padding: 0 13px 10px 10px; text-align: right;'>
	                <button type='button' class='btn btnSendMateAnswer' data-mateNum='${vo.mateNum}'>답글 등록</button>
	            </div>
	        
			</td>
	    </tr>
	</c:forEach>
	</tbody>
	
	<tfoot id='listMateFooter'>
		<tr align="center">
			<td colspan='2' >
				${paging}
			</td>
		</tr>
	</tfoot>
</table>
-->