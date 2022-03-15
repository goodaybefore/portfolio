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
						<!-- Banner -->
						<section id="banner">
							<div class="content">
								<header>
									<h1>Trip Modify</h1>
									<p>여행 수정 ${trip }<br>${trip.tr_start_date_str}<br>${trip.tr_end_date_str}<br>
									mc_num : ${mc_num }<br>
									sc_num : ${sc_num }</p>
								</header>
								<form action="<%=request.getContextPath()%>/spot/${spot_user}/tripModify" method="post" enctype="multipart/form-data">
									<div class="trip-reg-box period-select-container">
										<div class="period">
											<label class="period-label" for="from">period</label>
											<c:if test="${trip.tr_start_date_str != trip.tr_end_date_str}">
												<input type="text" class="day-input" id="from" name="from" value="${trip.tr_start_date_str} ~ ${trip.tr_end_date_str}" readonly>
											</c:if>
											<c:if test="${trip.tr_start_date_str == trip.tr_end_date_str}">
												<input type="text" class="day-input" id="from" name="from" value="${trip.tr_start_date_str}" readonly>
											</c:if>
										</div>`
										<div class="period">
											<label class="period-label">당일여행인가요?</label>
											<input type="checkbox" id="isOneday" <c:if test="${trip.tr_start_date_str == trip.tr_end_date_str }">checked</c:if>>
										</div>
										
									</div>
									<div class="trip-reg-box area-select-container">
										<label style="flex:1;">지역선택박스</label>
										<div class="area-select-box col-6">
											<select class="middle-category">
												<option value="${mc_num}">${trip.tr_mca_name}</option>
											</select>
										</div>
										<div class="area-select-box col-6">
											<select class="small-category">
												<c:if test="${trip.tr_sca_name != null}">
													<option value="${sc_num}">${tritp.tr_sca_name}</option>
												</c:if>
												<c:if test="${trip.tr_sca_name ==null }">
													<option value="0">세부선택</option>
												</c:if>
											</select>
										</div>
										<div class="area-select-mcnum">
											<input type="hidden" name="mc_num" value="${mc_num}">
										</div>
										<div class="area-select-scnum">
											<input type="hidden" name="sc_num" value="${sc_num}">
										</div>
									</div>
									<div class="trip-reg-box box-open-range">
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="전체공개" <c:if test="${trip.tr_op_name=='전체공개'}">checked</c:if> />전체공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="트립메이트공개" <c:if test="${trip.tr_op_name=='트립메이트공개'}">checked</c:if> />트립메이트공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="회원공개" <c:if test="${trip.tr_op_name=='회원공개'}">checked</c:if> />회원공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="tr_op_name" value="비공개" <c:if test="${trip.tr_op_name=='비공개'}">checked</c:if> /> 비공개
										</label>
									</div>
									<div class="trip-reg-box title-container">
										<label>title</label><input type="text" class="form-control" name="tr_title" value="${trip.tr_title}"/>
									</div>
									<input type="hidden" name="tr_me_id" value="${user.me_id}"/>
									<div class="trip-reg-box with-container">
										<label>with</label>
										<input type="text" class="form-control" name="tr_with" placeholder="누구와 함께였나요?" value="${trip.tr_with}"/>
									</div>
									<div class="trip-reg-box file-container attachment">
										<label>첨부파일</label>
										<c:forEach items="${fileList}" var="file">
											<div class="">
								        <input type="hidden" class="form-control" name="fileNums" value="${file.fi_num}"/>
								        <span>${file.fi_ori_name }</span>
								        <a class="btn-close" href="#">X</a>
								    	</div>
										</c:forEach>
										<c:forEach begin="1" end="${2-fileList.size()}">
											<input type="file" class="form-control" name="file">
										</c:forEach>
									</div>
									<input type="hidden" name="tr_num" value="${trip.tr_num}"/>
									<input type="hidden" name="tr_sm_num" value="${trip.tr_sm_num}"/>
									
									
									<div>
										<input type="submit" class="btn-write" value="write">
									</div>
								</form>
							</div>
						</section>

					</div>
				</div>
			</div>
			<script src="/resources/assets/js/spot/tripModify.js"></script>
			<script type="text/javascript">

			$(function(){
				console.log('hi');
			
				//여행 기간이 하루이면 start_date_str만 출력하도록 하기
				var from = '${trip.tr_start_date_str}';
				var to = '${trip.tr_end_date_str}'
				var spot_user = "${spot_user}";
				console.log(spot_user);
				console.log(from == to)
				$('#from').val(123);
				if(from == to){
					$('#from').val(from);
				}
				
				let mc_num = $('.middle-category').children().val();
				//let mc_name = $('.middle-category').children().text();
				let mc_name = '${trip.tr_mca_name}';
				
				let sc_num = $('.small-category').children().val();
				//let sc_name = $('.small-category').children().text();
				let sc_name = '${trip.tr_sca_name}';
				let isChanged = false;
				
				if(sc_name)
				setMiddleCategory(mc_num, mc_name);
				setSmallCategory(mc_num);
				//middle-category's change
				
				$('.middle-category').change(function(){
					let mc_num = $(this).val();
					let middle_ca_str = '<input type="hidden" name="mc_num" value="'+mc_num+'">';
					isChanged = true;
					setSmallCategory(mc_num, isChanged);
					isChanged = false;
					$('.area-select-mcnum').html('');
					$('.area-select-mcnum').html(middle_ca_str);
					$('.area-select-scnum').html('');
					//console.log('changed middle-category');
				});
				
				function setMiddleCategory(mc_num, mc_name){
					let str = '<option value="'+mc_num+'">'+mc_name+'</option>';
					$.ajax({
							async :false,
					    type:'get',
					    url : '/spot/'+spot_user+'/middlecategory?lc_num=1',
					    dataType:"json",
					    success : function(res){
					    	console.log(res);
					    	for(middle of res.list){
					    		str += '<option value="'+middle.mc_num+'">'+middle.mc_name+'</option>';
					    	}
					    	$('.middle-category').html(str);
					    	}
					})
				}
				
				
				
				//small-category's change
				$('.small-category').change(function(){
					let new_sc_num = $(this).val();
					let small_ca_str = '<input type="hidden" name="sc_num" value="'+new_sc_num+'">'; 
					//$('.area-select-scnum').html('');
					$('.area-select-scnum').html(small_ca_str);
				});
				
				function setSmallCategory(mc_num, isChanged){
					console.log('setSmallcategory');
					let str = '';
					if(isChanged == true){
						str = '<option value="0">세부선택</option>'
					}
					
					if(mc_num<=0){
						$('.middle-category').html(str);
						return;
					}
					$.ajax({
							async :false,
					    type:'get',
					    url : '/spot/'+spot_user+'/smallcategory?sc_mc_num='+mc_num,
					    dataType:"json",
					    success : function(res){
								//세부선택 항목 만들어주기
					    	for(small of res.list){
					    		str += '<option value="'+small.sc_num+'">'+small.sc_name+'</option>';
					    	}
					    	$('.small-category').html(str);
					    	}
					})
				}
				
				
				
				
				
				
				
			})
			</script>
	</body>
</html>