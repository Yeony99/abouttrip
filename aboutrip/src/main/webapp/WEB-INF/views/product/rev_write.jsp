<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="body-container">
	<section class="payment-dark"
		style="background-image: url(&quot;${pageContext.request.contextPath}/resources/img/star-sky.jpg&quot;);">
		<div>

			<div>

				<form method="post"
					action="${pageContext.request.contextPath}/product/revsubmit">
					<div>
						<p>리뷰작성</p>
					</div>
					<div style="width: 800px; height: 100px; margin-bottom: 40px;">
						<img class="box-img"
							src="${pageContext.request.contextPath}/uploads/product/${product.img_name}"
							alt="${product.product_name}" title="${product.product_name}"
							style="width: 100px; height: 100px; object-fit: cover; margin-right: 20px">
						${product.product_name}
					</div>
					<table>
						<tr>
							<th style="padding-right: 20px;">작성자</th>
							<th>내용</th>
							<th>별점</th>
							<th>&nbsp;</th>
						</tr>
						<tr>
							<td>${user.nickName}</td>
							<td><textarea name="reviewContent"
									style="resize: none; width: 730px;"></textarea>
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
							<td><input type="hidden" name="order_detail"
								value="${dto.order_detail}">
								<button type="submit">등록</button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</section>
</div>