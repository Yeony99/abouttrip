<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
	<div class="page-footer dark">
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <h5>여행명소&amp;다이어리</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/place/mdPick">AboutTrip pick</a></li>
                        <li><a href="${pageContext.request.contextPath}/place/list">한국관광공사 pick</a></li>
                        <li><a href="${pageContext.request.contextPath}/diary/main">여행 다이어리</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>스케줄</h5>
                    <ul>
						<li><a href="${pageContext.request.contextPath}/schedule/scheduler">캘린더</a></li>
						<li><a href="#">여행루트공유</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>여행상품</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/booking/event">초특가 여행상품</a></li>
                        <li><a href="${pageContext.request.contextPath}/booking/best">BEST 인기상품</a></li>
                        <li><a href="${pageContext.request.contextPath}/booking/list">단체패키지/티켓/유심&amp;wifi</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>고객센터</h5>
                    <ul>
                        <li><a href="#">공지사항</a></li>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">문의하기</a></li>
                        <li><a href="#">이벤트</a></li>
                        <li><a href="#">시스템 개선/제안</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer-copyright"></div>
	</div>
</div>

