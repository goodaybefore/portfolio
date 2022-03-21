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
			border : 1px solid black !important;
		}
		.open-range{
			appearance: auto !important;
			opacity:1 !important;
			margin-right: 0px !important;
			display : inline-block !important;
			margin-right : 0px !important;
		}
		.detail-label{
			margin-right : 10px;
			height : auto !important;
			padding : 0px ! important;
		}
		.nickname-label{
			display : inline;
		}
		.detail-container{
			margin-bottom : 10px;
		}
		.nickname-container, .profile-container, .open-range-container, .grade-container, .attend-container{
			display : flex;
			margin-bottom : 0px !important;
			padding : 0px !important;
		}
		.period-container, .area-container, .open-range-container{
			margin-bottom : 5px !important;
		}
		.title-container{
			border : 1px solid gray;
		}
		.with-container{
			margin-top : 10px;
		}
		.file-container{
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
										<h1>MyPage</h1>
										<p>mypage<br>${user }</p>
									</header>
										<form action="<%=request.getContextPath()%>/mypage" method="post" enctype="multipart/form-data">
										<div class="mypage-box">
											<div class="period">
												<label class="nickname-label">nickname</label>
												<input type="text" name="me_nickname">
											</div>
										</div>
										<div class="mypage-box box-open-range">
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
										<div class="mypage-box title-container">
											<label>title</label><input type="text" class="form-control" name="tr_title"/>
										</div>
										<div>
											<input type="hidden" name="tr_me_id" value="${user.me_id}"/>
										</div>
										<div class="mypage-box with-container">
											<label>with</label>
											<input type="text" class="form-control" name="tr_with" placeholder="누구와 함께였나요?"/>
										</div>
										<div class="mypage-box file-container">
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
		
	<script src="/resources/assets/js/spot/tripDetail.js"></script>
	</body>
</html>