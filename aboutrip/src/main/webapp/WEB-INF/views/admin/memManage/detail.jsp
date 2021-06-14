<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<form name="enableForm" method="post">
<table style="margin: 10px auto 20px; width: 100%; border-spacing: 1px;">
	<tr height="37" style="background: #fff;">
		<td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">아이디</label></td>
		<td align="left" width="35%" style="padding-left: 5px;"><span>${dto.userId}</span></td>
		<td align="right" width="15%" style="padding-right: 7px;"><label style="font-weight: 900;">회원번호</label></td>
		<td align="left" width="35%" style="padding-left: 5px;"><span>${dto.userNum}</span></td>
	</tr>
	<tr height="37" style="background: #fff;">
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">이름</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.nickName}</span></td>
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">생년월일</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.birth}</span></td>
	</tr>
	<tr height="37" style="background: #fff;">
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">주소</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.zip}</span><span>${dto.address1}</span></td>
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">전화번호</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.tel}</span></td>
	</tr>
	<tr height="37" style="background: #fff;">
		<td align="right" style="padding-right: 9px;"><label style="font-weight: 900;">상세주소</label></td>
		<td align="left" style="padding-left: 5px;"><span>${dto.address2}</span></td>
	</tr>

	<tr height="37" style="background: #fff;">
		<td align="right" width="15%" style="padding-right: 9px;"><label style="font-weight: 900;">계정상태</label></td>
		<td style="padding-left: 5px;">
			<input type="radio" name="enable" value="0" checked="checked">활성
			<input type="radio" name="enable" value="1">잠금
		</td>
	</tr>
</table>
<input type="hidden" name="userNum" value="${dto.userNum}">
<input type="hidden" name="userId" value="${dto.userId}">
</form>