<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<div>
			<span>리뷰작성</span>

			<div>

				<form method="post"	action="${pageContext.request.contextPath}/product/revsubmit">
					<table>
						<tr>
							<th>작성자</th>
							<th>내용</th>
							<th>별점</th>
							<th>&nbsp;</th>
						</tr>
						<tr>
							<td>${user.nickName}</td>
							<td><textarea name="reviewContent"></textarea>
							<td><select name="rate">
									<option value=5.0>5.0</option>
									<option value=4.5>4.5</option>
									<option value=4.0>4.0</option>
									<option value=3.5>3.5</option>
									<option value=3.0>3.0</option>
									<option value=2.5>2.5</option>
									<option value=2.0>2.0</option>
									<option value=1.5>1.5</option>
									<option value=1.0>1.0</option>
									<option value=0.5>0.5</option>
									<option value=0.0>0.0</option>
							</select></td>
							<td>
								<input type="hidden" name="order_detail" value="${dto.order_detail}">
								<button type="submit">리뷰 등록</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</section>
</div>