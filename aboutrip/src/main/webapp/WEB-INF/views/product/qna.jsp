<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
	function inputqna() {
		var d = document.qnaForm;

		d.action = "${pageContext.request.contextPath}/product/qnasubmit";
		d.submit();
	}
</script>

<div>
	
	<div>
		<div>QNA ${qnaCount}건</div>
		<div style="border: 1px solid rgb(240, 240, 240);">
			<c:forEach var="dto" items="${list}">
				<div
					style="border-bottom: 2px solid rgb(220, 220, 220); padding: 20px; margin-bottom: 10px;">
					<c:if test="${dto.profile_pic!=null}">
						<img id="preImageView"
							style="vertical-align: middle; width: 50px; border-radius: 25px; border: 1px solid #eee; float: left; margin-right: 30px;"
							width="50" height="50"
							src="${pageContext.request.contextPath}/uploads/member/${dto.profile_pic}">
					</c:if>
					<c:if test="${dto.profile_pic==null}">
						<img id="preImageView"
							style="vertical-align: middle; width: 50px; border-radius: 25px; border: 1px solid #eee; float: left; margin-right: 30px;"
							width="50" height="50"
							src="${pageContext.request.contextPath}/resources/img/img/profile_img_none.png">
					</c:if>
					<div>
						<div>질문제목 : ${dto.title}</div>
						<div style="font-size: 12px; color: gray;">작성자 :
							${dto.nickName}&nbsp;&nbsp;|&nbsp;&nbsp;질문 유형 : ${dto.type}</div>
						<div style="font-size: 12px; color: gray;">질문 날짜 :
							${dto.c_date}</div>
					</div>
					<div style="padding: 20px 80px; margin: 30px 0px;">${dto.content}</div>
					<c:if test="${dto.answer!=null}">
						<div style="border: 1px solid rgb(235, 235, 235);">
							<div style="padding: 20px 80px;">답변</div>
							<div style="font-size: 12px; color: gray; padding: 0px 80px;">답변
								날짜 : ${dto.a_date}</div>
							<div style="padding: 20px 80px; margin: 30px 0px;">${dto.answer}</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
	<table class="table">
		<tr>
			<td align="center">${qnaCount==0?"등록된 게시물이 없습니다.":paging}</td>
		</tr>
	</table>
	<span> <a class="btn" href="${pageContext.request.contextPath}/product/article?code=${code}">게시글로
			돌아가기</a></span>
</div>