<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up Form</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/signup/style.css" />
    
  
</head>
<body>
    <div class="main">
        <section class="signup">
            <!--<img src="resources/images/signup/signup-bg.jpg" alt=""> -->
            <div class="container">
            
            	<div class="signup-content">
                    <form id="signup-form" class="signup-form" action="<%= request.getContextPath()%>/signup" method="POST">
                        <h2 class="form-title">Create account</h2>
                        <div class="form-group">
                            <input type="text" class="form-input" name="me_id" id="id" placeholder="Your Id" value="${member.me_id}"/>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-input" name="me_pw" id="password" placeholder="Your Password" value="${member.me_pw}"/>
                            <span toggle="#password" class="zmdi zmdi-eye field-icon toggle-password"></span>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-input" name="re_password" id="re_password" placeholder="Repeat your password"/>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-input" name="me_name" id="name" placeholder="Your Name" value="${member.me_name}"/>
                        </div>
                        <div class="form-group">
													<label class="form-check-label">
														<input type="radio" class="form-check-input" name="me_gender" value="female" >female
													</label>
													<label class="form-check-label">
														<input type="radio" class="form-check-input" name="me_gender" value="male">male
													</label>
												</div>
                        <div class="form-group">
                            <input type="text" class="form-input phone" name="me_phone" maxlength="13" placeholder="Your Phone"/>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-input" name="me_email" id="email" placeholder="Your Email"/>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-input" name="me_birth" placeholder="Your Birthday"/>
                        </div>
                        <div class="form-group">
                            <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                            <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                        </div>
                        <div class="form-group">
                            <input type="submit" name="submit" id="submit" class="form-submit" value="Sign up"/>
                        </div>
                    </form>
                    <p class="loginhere">
                        Have already an account ? <a href="#" class="loginhere-link ">Login here</a>
                    </p>
                </div>
             </div>
        </section>

    </div>
		
    <!-- JS -->
    <script src="/resources/assets/js/login/jquery.min.js"></script>
    <!-- Validation 검사를 위한 플러그인 -->
	<!-- 순서 바뀌면 안됨 -->
	<script src="<%=request.getContextPath()%>/resources/assets/js/signup/jquery.validate.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/signup/additional-methods.min.js"></script>
    <script src="/resources/assets/js/signup/main.js"></script>
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>