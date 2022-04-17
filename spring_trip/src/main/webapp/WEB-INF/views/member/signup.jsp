<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
 		<script src="/resources/assets/js/spot/jquery.min.js"></script>
    <title>Sign Up Form</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <!-- <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/signup/style.css" /> -->
    <link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		<!-- Validation 검사를 위한 플러그인 -->
    <!-- 순서 바뀌면 안됨 -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/signup/jquery.validate.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/js/signup/additional-methods.min.js"></script>
  	
  	<style>
  		.signup-content{
  			min-width:600px;
  			width:100%;
  			padding:100px;
  		}
  		input[type=text], input[type=password], input[type=email], input[type=button]{
  			margin-bottom:5px;
  			min-width:600px;
  			width:90%;
  		}
  		input[type=checkbox], input[type=radio]{
  			appearance: auto !important;
				opacity:1 !important;
				margin-right: 0px !important;
				display : inline-block !important;
				margin-right : 5px !important;
  		}
  		#submit, #idCheck{
  			min-width:600px;
  			width:90%;
  		}
  		
  		.gender-container{
  			display :flex;
  		}
  		.gender-label{
  			display: inline-block;
  		}
  		
  		.pw-container{
  			position : relative;
  			width:90%;
  			min-width:600px;
  		}
  		.toggle-password, .zmdi-eye-off .zmdi-eye{
	  		position : absolute;
	  		top:0;
	  		bottom:0;
	  		right:20px;
	  		margin:auto 2px;
	  		height:14px;
	  		font-size:16px;
	  		curser:pointer;
  		}
  		.eye-icon{
  			top : -14px;
  		}
  		.form-title{  			
  			min-width : 600px;
  			width : 90%;
  		}
  		.error{color:red;}
  	</style>
</head>
<body>
    <div class="main">
        <section class="signup">
            <!--<img src="resources/images/signup/signup-bg.jpg" alt=""> -->
            <div class="container">
            
            	<div class="signup-content">
                    <form id="signup-form" class="signup-form" action="<%= request.getContextPath()%>/signup" method="POST">
                        <div class="form-group">
	                        <h2 class="form-title" style="text-align:center;">Create account</h2>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-input" name="me_id" id="id" placeholder="Your Id" value="${member.me_id}"/>
                            <input type="button" id="idCheck" class="fit btn-id-check" value="ID CHECK">
                        </div>
                        <div class="form-group pw-container">
                            <input type="password" class="form-input" name="me_pw" id="password" placeholder="Your Password" value="${member.me_pw}"/>
                            <div toggle="#password" class="zmdi zmdi-eye field-icon toggle-password"></div>
                        </div>
                        <label id="me_pw-error" class="error" for="password"></label>
                        <div class="form-group">
                            <input type="password" class="form-input" name="me_pw2" id="re_password" placeholder="Repeat your password"/>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-input" name="me_name" id="name" placeholder="Your Name" value="${member.me_name}"/>
                        </div>
                        <div class="form-group gender-container">
													<label class="form-check-label gender-label">
														<input type="radio" class="form-check-input" name="me_gender" value="female" >female
													</label>
													<label class="form-check-label gender-label">
														<input type="radio" class="form-check-input" name="me_gender" value="male">male
													</label>
												</div>
												<label id="me_gender-error" class="error" for="me_gender"></label>
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
                            <input type="checkbox" name="agree" id="agree-term" class="agree-term" />
                            I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                        </div>
                        <div class="form-group">
                            <input type="submit" name="submit" id="submit" class="form-submit fit primary" value="Sign up"/>
                        </div>
                    </form>
                    <p>
                        Have already an account ? <a href="<%=request.getContextPath() %>/" class="loginhere-link ">Login here</a>
                    </p>
                </div>
             </div>
        </section>

    </div>
		<script>
			var idCheck = false;
		
			$('#idCheck').click(function(){
				var id = $('[name=me_id]').val();
				$.ajax({
					async:false,
					type:'POST',
					data: {id : id },
					url:"<%=request.getContextPath()%>/idcheck",
					success : function(res){
				    if(res == 'ok')
				    	idCheck = true;
				    else
				    	idCheck = false;
				    //idCheck = res == 'ok' ? true : false;
				    if(idCheck)
				    	alert('사용 가능한 아이디입니다.');
				    else if(id == '' || id == 'guest')
				    	alert('사용할 수 없는 아이디입니다.');
				    else
				    	alert('이미 사용 중인 아이디입니다.');
					}
				});
			});
			
			$('[name=me_id]').change(function(){
				idCheck = false;
			});
			
			$('form').submit(function(){
				var isAgree = $('[name=agree]').is(':checked');
				//동의에 체크되지 않으면
				if(!isAgree){
					alert('동의에 체크해야합니다.');
					$('[name=agree]').focus();
					return false;
				}
				
				if(!idCheck){
					alert('아이디 중복검사를 하세요.');
					return false;
				}
				
			});
	
			
			$("form").validate({
	      rules: {
	        me_id: {
	          required : true,
	          regex : /^[A-z]\w{4,7}$/
	        },
	        me_pw: {
	          required : true,
	          //regex: /^(?=\w{5,20}$)\w*(\d[A-z]|[A-z]\d)\w*$/
	          regex: /^\w*(\d[A-z]|[A-z]\d)\w*$/,
	          minlength : 5,
	          maxlength : 20
	        },
	        me_pw2: {
	          equalTo : password
	        },
	        me_name: {
	          required : true
	        },
	        me_gender:{
	        	required : true
	        },
	        me_email:{
	        	required:true
	        	
	        }
	      },
	      //규칙체크 실패시 출력될 메시지
	      messages : {
	        me_id: {
	          required : "필수로입력하세요",
	          regex : "영문자, 숫자로 이루어져 있으며 5~8자로 구성되어야 한다."
	        },
	        me_pw: {
	          required : "필수로입력하세요",
	          minlength : "최소 {0}글자이상이어야 합니다",
	          maxlength : "최대 {0}글자이하이어야 합니다",
	          regex : "영문자, 숫자로 이루어져있으며 최소 하나이상 포함"
	        },
	        me_pw2: {
	          equalTo : "비밀번호가 일치하지 않습니다."
	        },
	        me_name: {
	          required : "필수로입력하세요"
	        },
	        me_gender: {
	        	required : "필수로입력하세요"
	        },
	        me_email:{
	        	required : "필수로입력하세요. 비밀번호찾기 시 이메일로 새 비밀번호를 전송합니다."
	        	
	        }
	      }
	    });
			$.validator.addMethod(
		    "regex",
		    function(value, element, regexp) {
	        var re = new RegExp(regexp);
	        return this.optional(element) || re.test(value);
		    },
		    "Please check your input."
			);
	</script>
	
   <script src="/resources/assets/js/signup/main.js"></script>
</body>
</html>