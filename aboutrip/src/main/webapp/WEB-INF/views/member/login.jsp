<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Home - Brand</title>
    <link rel="stylesheet" href="webapp/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
    <link rel="stylesheet" href="webapp/assets/fonts/ionicons.min.css">
    <link rel="stylesheet" href="webapp/assets/fonts/simple-line-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="webapp/assets/css/Login-Form-Clean.css">
    <link rel="stylesheet" href="webapp/assets/css/Login-Form-Dark.css">
    <link rel="stylesheet" href="webapp/assets/css/vanilla-zoom.min.css">
</head>

<body>
    <nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
        <div class="container"><a class="navbar-brand logo" href="#">AboutTrip</a><button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-1"><span class="visually-hidden">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navcol-1">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="index.html">여행명소</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">스케줄</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">여행상품</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">다이어리</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">고객센터</a></li>
                    <li class="nav-item"></li>
                    <li class="nav-item"></li>
                    <li class="nav-item"><a class="nav-link" href="about-us.html">로그인</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact-us.html">회원가입</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page landing-page">
        <section class="clean-block slider dark">
            <div class="container">
                <div class="block-heading"></div>
                <section class="login-clean">
                    <section class="login-dark">
                        <form method="post">
                            <h2 class="visually-hidden">Login Form</h2>
                            <div class="illustration"><i class="icon ion-ios-locked-outline"></i></div>
                            <div class="mb-3"><input class="form-control" type="text" name="id" placeholder="id"></div>
                            <div class="mb-3"><input class="form-control" type="password" name="password" placeholder="Password"></div>
                            <div class="mb-3"><button class="btn btn-primary d-block w-100" type="submit">Log In</button></div><a class="forgot" href="#">Forgot your id or password?</a>
                        </form>
                    </section>
                </section>
                <div class="carousel slide" data-bs-ride="carousel" id="carousel-1">
                    <div class="carousel-inner">
                        <div class="carousel-item active"></div>
                    </div>
                    <div><a class="carousel-control-prev" href="#carousel-1" role="button" data-bs-slide="prev"><span class="carousel-control-prev-icon"></span><span class="visually-hidden">Previous</span></a><a class="carousel-control-next" href="#carousel-1" role="button" data-bs-slide="next"><span class="carousel-control-next-icon"></span><span class="visually-hidden">Next</span></a></div>
                    <ol class="carousel-indicators">
                        <li data-bs-target="#carousel-1" data-bs-slide-to="0" class="active"></li>
                    </ol>
                </div>
            </div>
        </section>
        <section class="clean-block about-us"></section>
    </main>
    <footer class="page-footer dark">
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <h5>Get started</h5>
                    <ul>
                        <li><a href="#">Home</a></li>
                        <li><a href="#">Sign up</a></li>
                        <li><a href="#">Downloads</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>About us</h5>
                    <ul>
                        <li><a href="#">Company Information</a></li>
                        <li><a href="#">Contact us</a></li>
                        <li><a href="#">Reviews</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>Support</h5>
                    <ul>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Help desk</a></li>
                        <li><a href="#">Forums</a></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <h5>Legal</h5>
                    <ul>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Terms of Use</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer-copyright">
            <p>© 2021 Copyright Text</p>
        </div>
    </footer>
    <script src="webapp/assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
    <script src="webapp/assets/js/vanilla-zoom.js"></script>
    <script src="webapp/assets/js/theme.js"></script>
</body>

</html>