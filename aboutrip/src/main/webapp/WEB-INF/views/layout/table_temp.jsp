<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style type="text/css">
.table-list {
	width: 100%;
}

.table-list tr {
	height: 35px;
	border-bottom: 1px solid #ccc;
	text-align: center;
}

.table-list thead tr:first-child {
	border-top: 2px solid #ccc;
	background: #eee;
	height: 35px;
}

.table-list tr>th {
	color: #777;
}

.table-list tr>td:nth-child(2) {
	box-sizing: border-box;
	padding-left: 10px;
	text-align: left;
}

.table-paging tr>td {
	height: 40px;
	line-height: 40px;
	text-align: center;
	padding: 5px;
	box-sizing: border-box;
}

.table-footer {
	margin: 10px auto;
}

.table-footer tr {
	height: 45px;
}

</style>


<div class="body-container">
	<div class="body-main">
		<div>
			
				<div style="text-align: left; color: black" >
				
				<h2>TABLE</h2>
					<p>테이블 소개입니다	</p>
					<br>					
				</div>
				
				<div class="board">
					<table style="width: 100%; margin-top: 10px; border-spacing: 0; border-collapse: collapse;">
						<tr height="35">
							<td align="left" width="50%">
								<select name="tags" id="tags" class="selectField">
									<option value="tags" selected="selected">카테고리</option>
									<option value="sale">스케줄 공유</option>
									<option value="buy">여행 친구찾기</option>
								</select>
							</td>
							
						</tr>
					</table>
					
					<form name="Form" method="post">
						<table id="marketTable" style="width: 100%; border-spacing: 0; border-collapse: collapse;">
							<tr align="center" bgcolor="#eeeeee" height="35" style="border: 1px solid white;"> 
								<th width="60" style="color: #787878; border: 1px solid white;">번호</th>
								<th width="60" style="color: #787878; border: 1px solid white;">카테고리</th>
						        <th style="color: #787878; border: 1px solid white;">제목</th>
						        <th width="100" style="color: #787878; border: 1px solid white;">작성자</th>
						        <th width="80" style="color: #787878; border: 1px solid white;">등록일</th>
						     </tr>
						     
						     <tr align="center" height="30" style="border-bottom: 1px solid #cccccc;">
								  <td><img src="https://www.milkcocoa.co.kr/board/_skin/market//img/i_notice.gif"></td>
								  <td>  </td>
								  <td style="padding-left: 10px; text-align: left">
									   <a href="">	★위의 공지글을 확인 후 글을 작성하여 주세요★ </a>
								  </td>
								  <td>abouttrip</td>
								  <td>2021-05-01</td>
							  </tr>
							  
							  <tr align="center" height="30" style="border-bottom: 1px solid #cccccc;">
								  <td>15832	</td>
								  <td> [스케줄 공유] </td>
								   <td style="padding-left: 10px; text-align: left">
									   <a href=""> [여행스케줄] 제주도 동부 2박 3일 스케줄 공유해요~ </a>
								  </td>
								  <td>triplover</td>
								  <td>2021-06-29</td>
							  </tr>
							  
							  
						     
						</table>		
					</form>
					
					<div class="board-paging" style="margin-top: 10px; text-align: center; padding: 10px">
						<a href="#" style="color: powderblue">1</a>
						<a href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">5</a>
						<a href="#">6</a>
						<a href="#">7</a>
						<a href="#">8</a>
						<a href="#">9</a>
						<a href="#">10</a>
						<a href="#">></a>
				    </div>
				    
				    <table style="width: 100%;  border-spacing: 0; border-collapse: collapse;">
					   <tr>
						  <td align="center" width="100%">
							  <form name="searchForm" action="" method="post">
								  <input type="radio" name="search" id="writer" value="작성자" 
									 class="boxTF" checked="checked">
									<label for="writer" title="작성자">작성자</label>
							   		
							   		<input type="radio" name="search" id="title" value="제목" 
									 class="boxTF" >
									<label for="title" title="title">제목</label>
									
									<input type="radio" name="search" id="content" value="내용" 
									 class="boxTF" >
									<label for="content" title="content">내용</label>
									
								<input type="text" name="searchValue" class="boxTF">
								
								<input type="button" value="SEARCH" class="btn2">
								
								
							</form>
						  </td>
						  <td align="right" width="100%">
							   <input type="button" value="WRITE" class="btn2">
							
						  </td>
					   </tr>
					</table>
					
				</div>	
			</div>	
			</div>
		</div>