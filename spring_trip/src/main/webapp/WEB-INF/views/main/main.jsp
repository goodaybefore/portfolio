<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>MY TRIP DIARY</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Tinos:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&amp;display=swap" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="resources/assets/css/main/styles.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.js"></script>
        <style>
        .login-menu {
        color : white;
        font-weight : bold;
        }
        </style>
    </head>
    <body>
        <!-- Background Video-->
        <video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop"><source src="resources/mp4/bg.mp4" type="video/mp4" /></video>
        <!-- Masthead-->
        <div class="masthead">
            <div class="masthead-content text-white">
                <div class="container-fluid px-4 px-lg-0">
                    <h1 class="fst-italic lh-1 mb-4">Welcome to<br>MY TRIP DIARY!</h1>
                    <p class="mb-5"></p>
                    <!-- * * * * * * * * * * * * * * *-->
                    <!-- * * SB Forms Contact Form * *-->
                    <!-- * * * * * * * * * * * * * * *-->
                    <!-- This form is pre-integrated with SB Forms.-->
                    <!-- To make this form functional, sign up at-->
                    <!-- https://startbootstrap.com/solution/contact-forms-->
                    <!-- to get an API token!-->
                    <c:if test="${user==null}">
	                    <form id="contactForm" data-sb-form-api-token="API_TOKEN" action="<%=request.getContextPath()%>/login" method="post">
	                        <!-- Email address input-->
	                      <div class="row input-group-newsletter">
	                      	<div class="form-group mt-3 col-12"><input class="form-control" name="me_id" type="text" placeholder="Enter your id..." aria-label="Enter your id..." /></div>
	                       	<div class="form-group mt-3 col-12"><input class="form-control" name="me_pw" type="password" placeholder="Enter your password..." aria-label="Enter your password..." /></div>
							<div class="form-group mt-3" style="float: left; width: 50%;"><a href="<%=request.getContextPath()%>/signup">sign up>></a></div>
							<div class="form-group mt-3" style="float: right; width: 50%;"><button class="btn btn-primary" style="float: right;" type="submit">get started!</button></div>
							<div class="form-group" style="float: right; width: 100%;"><a href="<%=request.getContextPath()%>/board/notice" class="" id="" style="float: right; margin-right: 5px;">guest login>></a></div>
	                      </div>
	                    </form>
					</c:if>
					<c:if test="${user != null}">
						<a class="login-menu" href="<%=request.getContextPath()%>/logout">logout</a><br>
						<a class="login-menu" href="<%=request.getContextPath()%>/myspot/home">myspot</a><br>
						<a class="login-menu" href="<%=request.getContextPath()%>/myspot/tripmate_list">tripmate</a><br>
						<a class="login-menu" href="<%=request.getContextPath()%>/board/notice">notice</a><br>
						<a class="login-menu" href="<%=request.getContextPath()%>/board/event">event</a><br>
						<a class="login-menu" href="<%=request.getContextPath()%>/board/special_trip">special trip</a><br>
					</c:if>
                </div>
            </div>
        </div>
        <!-- Social Icons-->
        <!-- For more icon options, visit https://fontawesome.com/icons?d=gallery&p=2&s=brands-->
        <div class="social-icons">
            <div class="d-flex flex-row flex-lg-column justify-content-center align-items-center h-100 mt-3 mt-lg-0">
                <a class="btn btn-dark m-3" href="#!"><i class="fab fa-twitter"></i></a>
                <a class="btn btn-dark m-3" href="#!"><i class="fab fa-facebook-f"></i></a>
                <a class="btn btn-dark m-3" href="#!"><i class="fab fa-instagram"></i></a>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="resources/assets/js/main/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        
    </body>
</html>
    