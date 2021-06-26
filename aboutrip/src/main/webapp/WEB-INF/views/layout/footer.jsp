<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${sessionScope.member.userId=='admin'}">
<div class="container">
	<div class="page-footer dark">
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <h5>여행명소&amp;다이어리</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/place/mdPick">AboutTrip pick</a></li>
                        <li><a href="${pageContext.request.contextPath}/place/list">한국관광공사 pick</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/diaryManage/list">여행 다이어리</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>스케줄</h5>
                    <ul>
						<li><a href="${pageContext.request.contextPath}/scheduler/mycalendar">캘린더</a></li>
						<li><a href="${pageContext.request.contextPath}/scheduler/share">여행루트공유</a></li>
						<li><a href="${pageContext.request.contextPath}/scheduler/mate">트립메이트</a></li>
						<li><a href="${pageContext.request.contextPath}/scheduler/review">여행후기</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>여행상품</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/product/list">초특가 여행상품</a></li>
                        <li><a href="${pageContext.request.contextPath}/product/list">단체패키지/티켓/유심&amp;wifi</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>고객센터</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
                        <li><a href="${pageContext.request.contextPath}/faq/main">FAQ</a></li>
                        <li><a href="${pageContext.request.contextPath}/qna/list">문의하기</a></li>
                        <li><a href="${pageContext.request.contextPath}/event/list">이벤트</a></li>
                        <li><a href="${pageContext.request.contextPath}/sug/list">시스템 개선/제안</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer-copyright" style="color: white">
        	<span> 회사소개 | </span>
        	<span> 인재채용 | </span>
        	<span> 제휴제안 | </span>
        	<span> 개인정보처리방침 | </span>
        	<span> 어바웃트립 정책 | </span>
        	<span> ⓒ Aboutrip Corp. </span>
        </div>
	</div>
</div>
</c:if>

<c:if test="${sessionScope.member.userId!='admin'}">
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
						<li><a href="${pageContext.request.contextPath}/scheduler/mycalendar">캘린더</a></li>
						<li><a href="${pageContext.request.contextPath}/scheduler/share">여행루트공유</a></li>
						<li><a href="${pageContext.request.contextPath}/scheduler/mate">트립메이트</a></li>
						<li><a href="${pageContext.request.contextPath}/scheduler/review">여행후기</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>여행상품</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/product/event">초특가 여행상품</a></li>
                        <li><a href="${pageContext.request.contextPath}/product/list">단체패키지/티켓/유심&amp;wifi</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>고객센터</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
                        <li><a href="${pageContext.request.contextPath}/faq/main">FAQ</a></li>
                        <li><a href="${pageContext.request.contextPath}/qna/list">문의하기</a></li>
                        <li><a href="${pageContext.request.contextPath}/event/list">이벤트</a></li>
                        <li><a href="${pageContext.request.contextPath}/sug/list">시스템 개선/제안</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer-copyright" style="color: white">
        	<span> 회사소개 | </span>
        	<span> 인재채용 | </span>
        	<span> 제휴제안 | </span>
        	<span> 개인정보처리방침 | </span>
        	<span> 어바웃트립 정책 | </span>
        	<span> ⓒ Aboutrip Corp. </span>
        </div>
	</div>
</div>
</c:if>
