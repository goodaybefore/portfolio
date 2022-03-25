<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<style>
		.mypage-box{
			padding-top : 10px;
			min-width : 600px;
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
		}
		.btn-input-profile-img{
			padding : 6px 25px;
			background : #f56a6a;
			color : white;
			border-radius : 4px;
			text-align:center;
			cursor : pointer;
			display : inline-block;
			width : 200px;
			
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
			width : 200px;
			height : 200px !important;
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
										<p>mypage<br>${user }</p>
									</header>
										<form action="<%=request.getContextPath()%>/mypage" method="post" enctype="multipart/form-data">
											<input type="hidden" name="me_id" value="${user.me_id}"/>
											<div class="mypage-box nickname-contianer">
												<label class="mypage-label">nickname</label>
												<input type="text" class="nickname-input col-6" name="me_nickname" value="${user.me_nickname }">
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
												<label class="mypage-label">profile</label>
												<div class="profile-box">
													<div class="profile-img">
														<c:if test="${user.me_photo != null }">
															<img class="user-photo-img" src="/img/portfolio/member_profile${user.me_photo}"/>
														</c:if>
														<c:if test="${user.me_photo == null }">no image</c:if>
													
													</div>
													<div class="profile-btn-box">
														<input type="file" multiple accept="image/*" id="fileUpload" name="file" style="display: none">
														<a class="btn-input-profile-img" href="javascript:;">upload</a>
														<!-- <input type="file" id="fileUpload" name="file" style="display:none;" value="${user.me_photo}" multiple accept="image/*"/> -->
													</div>
													
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
											
											<div class="mypage-box membership-container">
												<label class="mypage-label">membership</label>
												<c:if test="${user.me_membership != 'Y'}">
													<p>멤버십 사용 기간이 아닙니다.</p>
												</c:if>
											</div>
											
											<div class="mypage-box attend-container">
												<label class="mypage-label">attend</label>
												<p>${user.me_attend_num}일째 출석</p>
											</div>
											
											<div>
												<input type="submit" class="btn-write primary fit" value="write">
											</div>
									</form>
								</div>
							</section>
					
					</div>
				</div>
			</div>
		
	<script src="/resources/assets/js/spot/tripDetail.js"></script>
	<script>
	$("#fileUpload").on('change', function () {

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