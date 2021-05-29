<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="../resources/img/favicon.ico">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
body {
	margin: 0;
	font-family: Arial, Helvetica, sans-serif;
	background-image: url(../resources/img/bg.jpg);
	background-position: center center;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
}

.topnav {
	overflow: hidden;
	background: #ffffff6e;
}

.topnav a {
	background: #ffffff00;
	float: left;
	display: block;
	color: #2a52be;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	font-size: 17px;
}

.topnav a:hover {
	background-color: rgba(255, 255, 255, 0.562);
	color: black;
}

.topnav a.active {
	background-color: #ffffff00;
	padding: 0;
	margin-right: 60vw;
	color: white;
}

#logo {
	width: 90px;
	padding-left: 10px;
}

.topnav .icon {
	display: none;
	background-color: #ffffff00;
}

.main-title {
	margin-left: 100px;
	margin-top: 100px;
	font-size: 6rem;
	color: #2a52be;
}

.main-title a, .main-title a:link {
	padding: 10px;
	font-size: 2.5rem;
	text-decoration: none;
	color: #2a52be;
	background: none;
	border: 2px solid;
	transition: color 0.25s, border-color 0.25s, box-shadow 0.25s, transform
		0.25s;
}

.main-title a:hover {
	border-color: #2a52be;
	color: #224091;
	box-shadow: 0 0.5em 0.5em -0.4em #2a52be;
	transform: translateY(-0.25em);
	cursor: pointer;
}

.mobile-main-btn {
	display: none;
}

.mobile-main-btn a, .mobile-main-btn a:link {
	padding: 10px;
	font-size: 2.5rem;
	text-decoration: none;
	color: #2a52be;
	background: none;
	border: 2px solid;
	transition: color 0.25s, border-color 0.25s, box-shadow 0.25s, transform
		0.25s;
}

.mobile-main-btn a:hover {
	border-color: #2a52be;
	color: #224091;
	box-shadow: 0 0.5em 0.5em -0.4em #2a52be;
	transform: translateY(-0.25em);
	cursor: pointer;
}

@media screen and (max-width: 1187px) {
	.topnav a:not (:first-child ), .content {
		display: none;
	}
	.topnav a.icon {
		float: right;
		display: block;
	}
	.mobile-main-btn {
		display: flex;
		margin: 0 auto;
		justify-content: center;
		margin-top: 15rem;
	}
}

@media screen and (max-width: 1187px) {
	.topnav.responsive {
		position: relative;
	}
	.topnav.responsive .icon {
		position: absolute;
		right: 0;
		top: 0;
	}
	.topnav.responsive a {
		float: none;
		display: block;
		text-align: left;
	}
}
</style>
</head>
<body>

	<div class="topnav" id="myTopnav">
		<a href="#home" class="active"><img src="logo.svg" alt="어바웃트립로고"
			id="logo"></a> <a href="#about">menu1</a> <a href="#contact">menu2</a>
		<a href="#news">menu3</a> <a href="#account">user</a> <a
			href="javascript:void(0);" class="icon" onclick="myFunction()"> <i
			class="fa fa-bars"></i>
		</a>
	</div>

	<div class="container">
		<div class="content"
			style="background: #ffffff6e; width: 20vw; min-width: 20vw; height: 92vh;">
			<div style="display: flex;">
				<span class="main-title">AbouTrip<br>
				<a href="#">여행 떠나기 🛫</a></span> <!-- 스케줄 작성 페이지 혹은 로그인 페이지로 -->
			</div>
		</div>
		<div class="mobile-main-btn">
			<a href="#">여행 떠나기 🛫</a> <!-- 스케줄 작성 페이지 혹은 로그인 페이지로 -->
		</div>
	</div>

	<script>
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}
</script>

</body>
</html>
