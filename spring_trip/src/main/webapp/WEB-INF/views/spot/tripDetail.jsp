<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		
		<!-- 부트스트랩 -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
		<!-- Popper JS -->
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- 이 템플릿의 원래 css -->
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		<style>
		.trip-reg-box{
			padding : 10px;
			min-width : 600px;
		}
		.open-range, #isOneday{
			appearance: auto !important;
			opacity:1 !important;
			margin-right: 0px !important;
			display : inline-block !important;
			margin-right : 0px !important;
		}
		.box-open-range{
			display : flex;
		}
		.open-range-label{
			margin-right : 10px;
		}
		.period-select-container{
			margin-bottom : 10px;
			border : 1px solid red;
		}
		.period{
			display : inline-block;
		}
		.period-label{
			display : inline;
		}
		.day-input{
			display : inline !important;
			width : 200px !important;
		}
		.area-select-container{
			margin-bottom : 10px;
			display : flex;
			border : 1px solid red;
			
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
		
		.area-select-box{
			flex : 2;
			min-width : 200px;
			width : 200px !important;
		}
		.tr-dates{
			display : inline-block !important;
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
										<h1>Detail</h1>
										<p>여행 정보 상세
										<br>${trip }
										</p>
									</header>
									<div class="detail">
										
										<input type="hidden" value="${reg_sm_num}" name="tr_sm_num">
										<div class="trip-reg-box period-select-container">
											<div class="period">
											<label>여행기간</label>
												<c:if test="${trip.tr_start_date_str == trip.tr_end_date_str}">
													<p class="start-date">${trip.tr_start_date_str}</p><p>(당일치기)</p>
												</c:if>
												<c:if test="${trip.tr_start_date_str != trip.tr_end_date_str}">
													<p class="tr-dates start-date">${trip.tr_start_date_str}</p> ~ <p class="tr-dates end-date">${trip.tr_end_date_str}</p><p class="tr-dates trip-period"></p>
												</c:if>
												
											</div>
										</div>
										<div class="trip-reg-box area-select-container">
											<label style="flex:1;">지역선택박스</label>
											<div class="area-select-box col-6">
												<select class="middle-category">
													<option value="0">시/도선택</option>
												</select>
											</div>
											<div class="area-select-box col-6">
												<select class="small-category">
													<option value="0">세부선택</option>
												</select>
											</div>
											<div class="area-select-mcnum"></div>
											<div class="area-select-scnum"></div>
										</div>
										<div class="trip-reg-box box-open-range">
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
										<div class="trip-reg-box title-container">
											<label>title</label><input type="text" class="form-control" name="tr_title"/>
										</div>
										<div>
											<input type="hidden" name="tr_me_id" value="${user.me_id}"/>
										</div>
										<div class="trip-reg-box with-container">
											<label>with</label>
											<input type="text" class="form-control" name="tc_name" placeholder="누구와 함께였나요?"/>
										</div>
										<div class="trip-reg-box file-container">
											<label>d첨부파일</label>
											<div class="">
								        <input type="file" class="form-control" name="file"/>
								        <input type="file" class="form-control" name="file"/>
								    	</div>
										</div>
										<div>
											<input type="submit" class="btn-write" value="write">
										</div>
									</div>
									
								</div>
								<span>span 태그 테스트</span>
							</section>
					<c:if test="${trip.tr_me_id == user.me_id}">
						<a href="<%=request.getContextPath()%>/spot/tripModify?tr_num=${trip.tr_num}" style="border-bottom : none;"><button>modify</button></a>
						<a href="<%=request.getContextPath()%>/spot/tripDelete" style="border-bottom : none;"><button>delete</button></a>
					</c:if>
					</div>
				</div>
			</div>
		
	<script src="/resources/assets/js/spot/tripDetail.js"></script>
	</body>
</html>