<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<!-- fontawesome -->
		 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
		<style>
		.mypage-box{
			padding-top : 10px;
			min-width : 600px;
			width : ;
			border : 1px solid #f56a6a;
			margin-bottom : 10px !important;
			padding : 5px !important;
			
		}
		.open-range{
			appearance: auto !important;
			opacity:1 !important;
			margin-right: 0px !important;
			display : inline-block !important;
			
		}
		.mypage-label{
			display : block;
		}
		.label-box{
			display:flex;
		}
		.detail-label{
			margin-right : 10px;
			height : auto !important;
			padding : 0px ! important;
		}
		.detail-container{
			margin-bottom : 10px;
		}
		.intro-box{
			resize : none;
		}
		.nickname-input{
			width : 200px !important;
		}
		.profile-box{
			margin : 5px;
			display:flex;
		}
		.profile-img{
			height : 200px;
			width : 200px;
			border : 1px solid gray;
			text-align : center;
			line-height : 200px;
		}
		.profile-btn-box{
			margin-top :5px;
			margin-left:5px;
		}
		.btn-input-profile-img{
			padding : 6px 25px;
			background : #f56a6a;
			color : white;
			font-weight:white;
			border-radius : 4px;
			text-align:center;
			cursor : pointer;
			display : inline-block;
			width : 200px;
		}
		.btn-input-profile-img:hover{
			color:white !important;
		}
		
		.menu-setting-btn{
			font-weight:bold;
			padding : 6px 6px;
			background : white;
			color : #f56a6a;
			border-radius : 4px;
			border : 2px solid #f56a6a;
			text-align:center;
			cursor : pointer;
			display : inline-block;
			width:55px;
			height:35px;
			box-sizing : border-box;
		}
		.menu-setting-btn:hover{
			background : #f56a6a;
			color : white !important;
		}
		.primary{
			background : #f56a6a;
			color : white;
		}
		.primary:hover{
			color:white !important;
		}
		.phone{
			width : 250px !important;
			letter-spacing : 1px !important;
		}
		.nickname-contianer, .profile-container, .intro-container,
		.open-range-container, .grade-container, .attend-container,
		.phone-container,
		.membership-container{
			
		}
		.btn-primary, .btn-primary.disabled, .btn-primary:disabled{
			background-color : white !important;
			border-color : white !important;
		}
		.daterangepicker td.active, .daterangepicker td.active:hover{
			background-color : #f56a6a !important;
		}
		
		.area-select-box{
			flex : 2;
			min-width : 200px;
			width : 200px !important;
		}
		.tr-dates{
			display : inline-block !important;
		}
		
		.thumb-image, .user-photo-img{
			width : 198px;
			height : 198px !important;
		}
		
		.height-line{
			width:1px; height:200px; border-right:1px solid gray; margin-left:15px; margin-right:15px;
		}
		
		.menu-setting-container{
			display:flex;
		}
		</style>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<!-- Banner -->
							<section id="banner">
								<div class="content">
									<header>
										<h1>MyPage</h1>
										<p>mypage</p>
									</header>
										<form action="<%=request.getContextPath()%>/mypage" method="post" enctype="multipart/form-data">
											<input type="hidden" name="me_id" value="${user.me_id}"/>
											<div class="mypage-box nickname-contianer">
												<label class="mypage-label">nickname</label>
												<input type="text" class="nickname-input col-6" name="me_nickname" value="${user.me_nickname }">
											</div>
											<div class="mypage-box password-container">
												<label class="mypage-label">change password</label>
												<input type="password" class="col-6" name="me_pw" placeholder="변경할 비밀번호를 입력하세요">
												<input type="password" class="col-6" name="me_pw2" placeholder="다시 입력하세요">
												
											</div>
											<div class="mypage-box open-range-container">
												<label class="mypage-label">open range</label>
												<div class="label-box">
													<label class="open-range-label">
														<input type="radio" class="open-range" name="me_op_name" value="전체공개" <c:if test="${user.me_op_name=='전체공개'}">checked</c:if>/>전체공개
													</label>
													<label class="open-range-label">
														<input type="radio" class="open-range" name="me_op_name" value="트립메이트공개" <c:if test="${user.me_op_name=='트립메이트공개'}">checked</c:if>/>트립메이트공개
													</label>
													<label class="open-range-label">
														<input type="radio" class="open-range" name="me_op_name" value="회원공개" <c:if test="${user.me_op_name=='회원공개'}">checked</c:if>/>회원공개
													</label>
													<label class="open-range-label">
														<input type="radio" class="open-range" name="me_op_name" value="비공개" <c:if test="${user.me_op_name=='비공개'}">checked</c:if>/> 비공개
													</label>
												</div>
											</div>
											<div class="mypage-box profile-container">
												<label class="mypage-label">profile & menu settings</label>
												<div class="profile-box">
													<div class="profile-img">
														<c:if test="${user.me_photo != null }">
															<img class="user-photo-img" src="/img/portfolio/member_profile${user.me_photo}"/>
															<input type="hidden" name="me_photo" value="${user.me_photo }"/>
														</c:if>
														<c:if test="${user.me_photo == null }">no image</c:if>
													
													</div>
													<div class="height-line"></div>
													<div class="menu-setting-container">
														<div id="menu-view-box" class="menu-view-box" style="width:170px; height:200px; border:1px solid gray; font-weight:bold; color:black;"></div>
														<div class="button-container" style="margin-left:10px;">
															<a class="menu-setting-btn btn-menu-add">add</a>
															<a class="menu-setting-btn btn-menu-mod">mod</a>
															<a class="menu-setting-btn btn-menu-del">del</a>
															<div class="menu-setting-details" style="margin-top:15px; width:100%;display:flex;">
																
															</div>
														</div>
													</div>
												</div>
												
												<div class="profile-btn-box">
														<input type="file" multiple accept="image/*" id="fileUpload" name="file" style="display: none">
														<a class="btn-input-profile-img" href="javascript:;">upload</a>
												</div>
												
												
											</div>
											<div class="mypage-box intro-container">
												<label class="mypage-label">intro</label>
												<textarea class="form-control intro-box" name="me_intro" placeholder="다른사람들에게 나를 소개해보세요" rows="3">${user.me_intro }</textarea>
											</div>
											<div class="mypage-box phone-container">
												<label class="mypage-label">phone</label>
												<input type="text" class="form-input phone" name="me_phone" maxlength="13" placeholder="11자리의 숫자를 입력하세요" value="${user.me_phone}"/>
                      </div>
                      <div class="mypage-box email-container">
												<label class="mypage-label">email</label>
												<input type="email" class="form-input email" name="me_email" placeholder="이메일을 입력하세요!" value="${user.me_email}"/>
                      </div>
											<div class="mypage-box grade-container">
												<label class="mypage-label">grade</label>
												<p>${user.me_gr_name }</p>
											</div>
											<div class="mypage-box attend-container">
												<label class="mypage-label">attend</label>
												<p>${user.me_attend_num}일째 출석</p>
											</div>
											
											<div>
												<input type="submit" class="btn-write primary fit" value="write">
											</div>
									</form>
									<div class="mypage-box membership-container">
										<label class="mypage-label">membership</label>
										<c:if test="${user.me_membership != 'Y'}">
											<p>멤버십 사용 기간이 아닙니다.</p>
											<button class="fit">멤버십 신청하기(30일)</button>
										</c:if>
									</div>
								</div>
							</section>
					
					</div>
				</div>
			</div>
		
	<script src="/resources/assets/js/spot/tripDetail.js"></script>
	<script>
	$(document).ready(function(){
		$('.btn-write').click(function(){
			var pw = $('[name=me_pw]');
			var pw2 = $('[name=me_pw2]');
			if(!pw.equals(pw2)) {
				alert('비밀번호를 다시 확인하세요');
				return;
			}
			
			
		})
		
		$('.menu-view-box').load('/MemberMenu');
		
		//add
		$('.btn-menu-add').click(function(){
			console.log('click add');
			$('.menu-setting-details').html('');
			var addStr = '';
			addStr += '<input type="text" name="sm_name" placeholder="메뉴이름입력" style="width:120px; line-height:25px; margin-right:5px;"/>'+
			'<input type="hidden" name="btn-type" value="add">'+
			'<a href="#" class="menu-setting-btn primary btn-submit" style="width:50px;"><i class="fas fa-check"></i></a>';
			$('.menu-setting-details').html(addStr);
		});
		
		//mod
		$('.btn-menu-mod').click(function(){
			$('.menu-setting-details').html('');
			var modStr = '';
			modStr += '<div><select class="menu-select" style="width:120px"><option value="none;">메뉴선택</option></select><div class="menu"></div>';
			
			modStr += '<input type="hidden" name="btn-type" value="mod">'+
			'<input type="text" class="get-sm-name" name="sm_name" style="width:120px; line-height:25px; margin-right:5px; margin-top:5px;"/></div>'+
			 '<a href="#" class="menu-setting-btn primary btn-submit" style="width:50px;"><i class="fas fa-check"></i></a>'+
			'<div class="menu-select-smnum"></div>';
			$('.menu-setting-details').html(modStr);
			setMenuModify();
			
		})
		
		//del
		$('.btn-menu-del').click(function(){
			$('.menu-setting-details').html('');
			var delStr = '';
			delStr += '<select class="menu-select" style="width:120px"><option value="none;">메뉴선택</option></select><div class="menu"></div>';
			delStr += '<input type="hidden" name="btn-type" value="del">'+
			 '<a href="#" class="menu-setting-btn primary btn-submit" style="width:50px; margin-left:5px;"><i class="fas fa-check"></i></a>'+
			'<div class="menu-select-smnum"></div>';
			$('.menu-setting-details').html(delStr);
			setMenuDelete();
			
			
		})
		
		
		function reloadDiv(divId){
			$(divId).load(window.location.href + divId);
		}
		$(document).on('click', '.btn-submit', function(){
			
			console.log('btn-type : '+ $('[name=btn-type]').val());
			var sm_name = $('[name=sm_name]').val();
			var sm_num = $('[name=sm_num]').val();
			var type = $('[name=btn-type]').val();
			
			if(sm_name == ''){
				alert('메뉴제목을 기입해주세요'); return;
			}
			if(type != 'add' && type != 'mod' && type !='del'){
				alert('잘못된 접근입니다.'); return;
			}
			
			if(sm_num == undefined) sm_num = 0;
			var data = {
				sm_name : sm_name,
				sm_num : sm_num,
				type : type
			};
			
			$.ajax({
				async:false,
				url:'/mypage/menuSetting',
				type:'post',
				contentType:'application/json; charset=UTF-8',
				data:JSON.stringify(data),
				dataType:'json',
				success:function(res){
					console.log('res: ',res);
					//menuCntOver, menuCntLack, true, false
						if(res.res == 'true'){
							console.log('성공');
							//주석 풀면 콘솔창에 target 에러 나면서 add mod del을 여러번 하면 여러번 실행됨(메뉴가 2번 추가되거나..등)
							//$('#menu-view-box').load(window.location.href + '#menu-view-box');
						}
						if(res.res == 'menuCntOver'){
							alert('메뉴는 최대 5개까지 만들 수 있습니다.');
						}
						if(res.res == 'menuCntLack'){
							alert('메뉴는 최소 1개가 존재해야합니다.');
						}
						if(res.res == 'false'){
							alert('잘못된 접근입니다. 다시 시도해주세요');
						}
				}
				
			})
		})
		
	
		
		function getContextPath(){
			var hostIndex = location.href.indexOf(location.host)+location.host.length;
			var contextPath = location.href.substring(hostIndex, location.href.indexOf('/',hostIndex+1));
			
		}
		function setMenuModify(){
			var userId = '${user.me_id}';
			setMenuCategory(userId);
			$('.menu-select').change(function(){
				let sm_num = $(this).val();
				let sm_name = $('.menu-select option:selected').text();
				let sm_ca_str = '<input type="hidden" name="sm_num" value="'+sm_num+'">';
				$('.menu-select-smnum').html(sm_ca_str);
				
				$('.get-sm-name').val(sm_name);
			});
		}
		
		function setMenuDelete(){
			var userId = '${user.me_id}';
			setMenuCategory(userId);
			$('.menu-select').change(function(){
				let sm_num = $(this).val();
				let sm_ca_str = '<input type="hidden" name="sm_num" value="'+sm_num+'">';
				$('.menu-select-smnum').html(sm_ca_str);
				
			});
		}
		function setMenuCategory(userId){
			let str='<option value="0">메뉴선택</option>';
			$.ajax({
				async :false,
			    type:'get',
			    url : '/mypage/menuCategory?userId='+userId,
			    dataType:"json",
			    success : function(res){
			    	for(menu of res.list){
			    		str += '<option value="'+menu.sm_num+'">'+menu.sm_name+'</option>';
			    	}
			    	
			    	$('.menu-select').html(str);
			    	}
			})
			
		}
		
	})
	
	$("#fileUpload").on('change', function() {
	    //Get count of selected files
	    var countFiles = $(this)[0].files.length;
	    var imgPath = $(this)[0].value;
	    //확장자 체크
	    var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
	    //'no image' 글자 제거
	    $('.profile-img').html('');
	    var image_holder = $('.profile-img');
	    image_holder.empty();

	    if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
	        if (typeof (FileReader) != "undefined") {

	            //loop for each file selected for uploaded.
	            for (var i = 0; i < countFiles; i++) {
	                var reader = new FileReader();
	                reader.onload = function (e) {
	                    $("<img />", {
	                        "src": e.target.result,
	                            "class": "thumb-image"
	                    }).appendTo(image_holder);
	                }

	                image_holder.show();
	                reader.readAsDataURL($(this)[0].files[i]);
	            }

	        } else {
	            alert("This browser does not support FileReader.");
	        }
	    } else {
	        alert("Pls select only images");
	    }
	});
	$('.btn-input-profile-img').click(function(){
		$('#fileUpload').click();
	})
	
	
	
	$('.phone').keydown(function(event) {
	    var key = event.charCode || event.keyCode || 0;
	    $text = $(this);
	    if (key !== 8 && key !== 9) {
	        if ($text.val().length === 3) {
	            $text.val($text.val() + '-');
	        }
	        if ($text.val().length === 8) {
	            $text.val($text.val() + '-');
	        }
	    }
	    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));          
	});
	</script>
	</body>
</html>