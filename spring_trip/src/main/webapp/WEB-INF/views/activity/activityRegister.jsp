<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Activity Register</title>
	<!-- 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- date range picker -->
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />		 
	<!-- js -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<style>
			.activity-reg-box{
				padding : 10px;
				min-width : 600px;
			}
			.open-range{
				appearance: auto !important;
				opacity:1 !important;
				margin-right: 0px !important;
				display : inline-block !important;
				margin-right : 0px !important;
			}
			.activity-select-container{
				margin-bottom : 10px;
				display : flex;
				border : 1px solid red;
			}
			.box-open-range{
				display : flex;
			}
			.open-range-label{
				margin-right : 10px;
			}
			.date-select-container{
				margin-bottom : 10px;
				border : 1px solid red;
			}
			.date{
				display : inline-block;
			}
			.date-label{
				display : inline;
				margin-left : 10px;
			}
			.day-input{
				display : inline !important;
				width : 200px !important;
				margin-left : 10px;
			}
			.address-container{
				margin-bottom : 10px;
				border : 1px solid red;
			}
			
			.address-box{
				margin-bottom : 10px;
			}
			.title-container{
				border : 1px solid gray;
			}
			.with-container{
				border : 1px solid green;
				margin-top : 10px;
			}
			.file-container{
				border : 1px solid black;
				margin-top : 10px;
				margin-bottom : 10px;
			}
			.btn-primary, .btn-primary.disabled, .btn-primary:disabled{
				background-color : white !important;
				border-color : white !important;
			}
			.daterangepicker td.active, .daterangepicker td.active:hover{
				background-color : #f56a6a !important;
			}
			
			.activity-select-box{
				flex : 2;
				min-width : 200px;
				width : 200px !important;
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
									<h1>Activity Register</h1>
									<p>활동 등록</p>
								</header>
								<form action="<%=request.getContextPath()%>/spot/{${spot_user}/activityReg" method="post" enctype="multipart/form-data">
									<div class="activity-reg-box box-open-range">
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="전체공개"/>전체공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="트립메이트공개" />트립메이트공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="회원공개" />회원공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="비공개" /> 비공개
										</label>
									</div>
									<div class="activity-reg-box date-select-container">
										<div class="date">
											<label class="date-label act-label" for="from">date</label>
											<input type="text" class="day-input" id="from" name="from">
										</div>
									</div>
									
									<div class="activity-reg-box activity-select-container">
										<label style="flex:1;">활동선택박스</label>
										<div class="activity-select-box col-6">
											<select class="middle-category">
												<option value="none">활동종류</option>
											</select>
										</div>
										<div class="activity-select-box col-6">
											<select class="small-category">
												<option value="none">세부선택</option>
											</select>
										</div>
										<div class="activity-select-mcnum"></div>
										<div class="activity-select-scnum"></div>
									</div>
									
									<div class="activity-reg-box address-container">
										<label class="act-label">address</label>
										<!-- 주소 -->
										<div class="">
											<input type="text" id="postcode" placeholder="우편번호" class="col-6 address-box"> 
											<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="col-12 address-box">
										</div>
										<input type="text" id="address" placeholder="주소" class="mb-2 address-box">
										<input type="text" id="detailAddress" placeholder="상세주소" class="mn-2 address-box">
										<input type="text" name="me_address" style="">
									</div>
									
									<div class="activity-reg-box title-container">
										<label class="act-label">title</label><input type="text" class="form-control" name="tr_title"/>
									</div>
									<div>
										<input type="hidden" name="tr_me_id" value="${user.me_id}"/>
									</div>
									<div class="activity-reg-box with-container">
										<label class="act-label">with</label>
										<input type="text" class="form-control" name="tr_with" placeholder="누구와 함께였나요?"/>
									</div>
									<div class="activity-reg-box file-container">
										<label>첨부파일</label>
										<div class="">
							        <input type="file" class="form-control" name="file"/>
							        <input type="file" class="form-control" name="file"/>
							    	</div>
									</div>
									<div>
										<input type="submit" class="btn-write" value="write">
									</div>
								</form>
							</div>
						</section>

					</div>
				</div>
			</div>
			
			<script src="/resources/assets/js/activity/activityReg.js"></script>
	</body>
</html>