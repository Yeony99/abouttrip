<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="body-container">
	<div class="body-main" style="margin: 8rem 0;">
		<div style="display: flex; justify-content: center">
			<h3>🏆Best 스케줄 ✨</h3>
		</div>
		<div id="main-container">
			<div class="img-container">
				<div class="imgs"
					style="display: flex; flex-direction: row; align-content: stretch; justify-content: space-evenly; flex-wrap: wrap;">
					<div class="bximg"
						style="width: 300px; height: 300px; background-color: pink; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/busan.jpg"
							alt="1위 스케줄" title="img1"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
					</div>

					<div class="bximg"
						style="width: 300px; height: 300px; background-color: red; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/hwasung.jpg"
							alt="2위 스케줄" title="img1"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
					</div>

					<div class="bximg"
						style="width: 300px; height: 300px; background-color: blue; overflow: hidden; border-radius: 1rem; margin-top: 10px;">
						<a href="#"><img class="box-img"
							src="${pageContext.request.contextPath}/resources/img/img/bukchon.jpg"
							alt="3위 스케줄" title="img1"
							style="width: 100%; height: 100%; object-fit: cover;"></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>