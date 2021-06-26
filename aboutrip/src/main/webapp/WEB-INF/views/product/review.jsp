<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div>

	<div>
		<div>리뷰 ${revCount}건</div>
		<div style="border: 1px solid rgb(240, 240, 240);">
			<c:forEach var="dto" items="${list}">
				<div
					style="border-bottom: 2px solid rgb(230, 230, 230); padding: 20px; margin-bottom: 10px;">
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
						<div>평점 ${dto.rate}/5.0</div>
						<div style="font-size: 12px; color: gray;">${dto.nickName}&nbsp;&nbsp;${dto.order_date}</div>
						<div style="font-size: 12px; color: gray;">옵션 선택 :
							${dto.option_name}</div>
					</div>
					<div style="padding: 20px 80px; margin: 30px 0px;">${dto.reviewContent}</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<table class="table">
		<tr>
			<td align="center">${dataCount==0?"등록된 게시물이 없습니다.":paging}</td>
		</tr>
	</table>
	<span> <a class="btn"
		href="${pageContext.request.contextPath}/product/article?code=${code}">게시글로
			돌아가기</a></span>

</div>