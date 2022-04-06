<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Find ID/PW</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
	</head>
	<style>
		.tab-container{
			margin-top : 50px;
		}
	</style>
<body>
	<div class="container body tab-container">
		<h1>아이디/비밀번호 찾기</h1>
		<ul class="nav nav-tabs" role="tablist">
		  <li class="nav-item">
		    <a class="nav-link active" data-toggle="tab" href="#home">아이디 찾기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-toggle="tab" href="#menu1">비밀번호 찾기</a>
		  </li>
		</ul>
		
		<!-- Tab panes -->
		<div class="tab-content">
		  <div id="home" class="container tab-pane active"><br>
		    <h3>아이디 찾기</h3>
		     <div id="id-box">
		     	<div class="form-group">
		     		<input type="text" class="form-control" name="me_email" placeholder="이메일 입력">
				</div>
				<div class="form-group">
				    <input type="text" class="form-control" name="me_name" placeholder="이름 입력">
			    </div>
		     </div>
		     <button class="btn fit btn-find-id primary">아이디 찾기</button>
		  </div>
		  <div id="menu1" class="container tab-pane fade"><br>
		    <h3>비밀번호 찾기</h3>
		    <div id="pw-box">
			    <div class="form-group">
				    <input type="text" class="form-control" name="me_email" placeholder="이메일 입력">
				</div>
				<div class="form-group">
				    <input type="text" class="form-control" name="me_id" placeholder="아이디 입력">
			    </div>
		    </div>
		    <button class="btn fit btn-find-pw primary">비밀번호 찾기</button>
		  </div>
		</div>
	</div>
	<script>
	$(function(){
		$('.btn-find-id').click(function(){
			var me_email = $(this).siblings().find('[name=me_email]').val();
			var me_name= $(this).siblings().find('[name=me_name]').val();
			var member ={
					me_email : me_email,
					me_name : me_name
			};
			$.ajax({
		    	async : false,
		        type:'POST',
		        url:'<%=request.getContextPath()%>/member/find/id',
		        data:JSON.stringify(member),
		        //화면이 서버로 보낸 데이터의 타입
		        contentType:"application/json; charset=UTF-8",
		        success : function(res){
		        	if(res == '') alert('일치하는 정보가 없습니다.')
					if(res != null){
						alert('찾으시는 아이디는 '+res+' 입니다.');
					}
		        }
			});
		});
		$('.btn-find-pw').click(function(){
			var me_email = $(this).siblings().find('[name=me_email]').val();
			var me_id= $(this).siblings().find('[name=me_id]').val();
			var member ={
					me_email : me_email,
					me_id : me_id
			};
			setTimeout(()=> {
				$.ajax({
			    	async : false,
			        type:'POST',
			        url:'<%=request.getContextPath()%>/member/find/pw',
			        data:JSON.stringify(member),
			        //화면이 서버로 보낸 데이터의 타입
			        contentType:"application/json; charset=UTF-8",
			        success : function(res){
						if(res == 'true'){
							alert('등록된 이메일로 비밀번호를 전송하였습니다.');
						}else if(res == 'false'){
							alert('비밀번호 전송에 실패하였습니다. 다시 시도해주세요.');
						}
						else if(res == 'error'){
							alert('비밀번호 전송에 실패하였습니다. 관리자에게 문의해주세요.');
						}
						$('.spinner-box').hide();
			        }
				});
			},100)
			
			
		});
		
	});
	</script>
</body>
</html>