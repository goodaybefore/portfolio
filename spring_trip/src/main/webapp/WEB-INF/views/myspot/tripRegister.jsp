<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<!-- jQuery library -->
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
		<!-- 부트스트랩 -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<!-- Popper JS -->
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- 이 템플릿의 원래 css -->
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		
		<!-- date range picker -->
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />		 
		<!-- js -->
		<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
		
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
		
		</style>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
				<div id="main">
					<div class="inner">
						<!-- Header -->
							<header id="header">
								<a href="/" class="logo"><strong>Board</strong></a>
								<ul class="icons">
									<c:if test="${user==null}"><li><a href="<%=request.getContextPath()%>/" class=""><span class="label">login</span></a></li></c:if>
									<c:if test="${user!=null}"><li><a href="<%=request.getContextPath()%>/logout" class=""><span class="label">logout</span></a></li></c:if>
									<li><a href="#" class=""><span class="label">tripmate</span></a></li>
									<li><a href="#" class=""><span class="label">notice</span></a></li>
									<li><a href="#" class=""><span class="label">event</span></a></li>
									<li><a href="#" class=""><span class="label">special</span></a></li>
								</ul>
							</header>

						<!-- Banner -->
						<section id="banner">
							<div class="content">
								<header>
									<h1>Trip Register</h1>
									<p>여행 등록</p>
								</header>
								<form action="<%=request.getContextPath()%>/myspot/tripReg" method="post" enctype="multipart/form-data">
									<input type="hidden" value="${reg_sm_num}" name="tr_sm_num">
									<div class="trip-reg-box period-select-container">
										<div class="period">
											<label class="period-label" for="from">period</label>
											<input type="text" class="day-input" id="from" name="from">
										</div>
										<!-- <div class="period">
											<label class="period-label" for="to">last</label>
											<input type="text" class="day-input" id="to" name="to">
										</div> -->
										<div class="period">
											<label class="period-label">당일여행인가요?</label><input type="checkbox" id="isOneday">
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

				
				<!-- Sidebar -->
				<div id="sidebar">
					<div class="inner">
						<!-- Menu -->
							<nav id="menu">
								<header class="major">
									<h2>My Menu</h2>
								<section id="search" class="alt">
									<form method="post" action="#">
										<input type="text" name="query" id="query" placeholder="Search" />
									</form>
								</section>
								</header>
								<ul>
									<li><a href="<%=request.getContextPath()%>/myspot/home">my spot home</a></li>
									<li>
										<span class="opener">trip</span>
										<ul>
										<c:forEach items="${menu}" var="menu">
											<li><a href="<%=request.getContextPath()%>/myspot/tripList?sm_num=${menu.sm_num}">${menu.sm_name}</a></li>
										</c:forEach>
										</ul>
									</li>
									<li>
										<span class="opener">Tripmate</span>
										<ul>
											<li><a href="#">request</a></li>
											<li><a href="#">my tripmates</a></li>
										</ul>
									</li>
									<li>
										<span class="opener">trip info</span>
										<ul>
											<li><a href="#">notice</a></li>
											<li><a href="#">today's trip</a></li>
										</ul>
									</li>
									<li><a href="#">my page</a></li>
								</ul>
							</nav>
						</div>
					</div>

			</div>
			<script>

			
			
			</script>
			<!-- <script src="/resources/assets/js/myspot/jquery.min.js"></script> -->
			<script src="/resources/assets/js/myspot/browser.min.js"></script>
			<script src="/resources/assets/js/myspot/breakpoints.min.js"></script>
			<script src="/resources/assets/js/myspot/util.js"></script>
			<script src="/resources/assets/js/myspot/main.js"></script>
			<script src="/resources/assets/js/myspot/tripRegister.js"></script>
			
			
			
	</body>
</html>