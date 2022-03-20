<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Activity Register</title>
	<!-- 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b4d47c161d7b6d187f225aba5f7cc5b5&libraries=services"></script>
	<!-- date range picker -->
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />		 
	<!-- js -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	
	<!-- summernote -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	
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
				display:inline-block;
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
				/*margin-left : 10px;*/
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
			.address-input, .title-container, .contents-container{
				margin-bottom : 10px;
				border : 1px solid red;
			}
			.with-container{
				border : 1px solid red;
				margin-top : 10px;
				margin-bottom : 10px;
			}
			
			.address-box{
				
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
				margin-right:5px;
			}
			#map{
				width:auto;
				height:300px;
				margin-top:10px;
				display:none;
				margin : 0 auto;
			}
			.map-container{
				display : felx;
				justify-content: center;
			}
			.note-btn{
				box-shadow : none;
				height:auto;
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
									<h1>Activity Modify</h1>
									<p>활동 수정<br>${activity }<br>${mc_num},${sc_num }</p>
								</header>
								<form action="<%=request.getContextPath()%>/spot/${spot_user}/activityMod" method="post" enctype="multipart/form-data">
									<input type="hidden" name="reg_sm_num" value="${reg_sm_num}">
									<input type="hidden" name="ac_num" value="${ac_num }">
									<input type="hidden" name="ac_tr_num" value="">
									<div class="activity-reg-box box-open-range">
										<label class="open-range-label">
											<input type="radio" class="open-range" name="ac_op_name" value="전체공개" <c:if test="${activity.ac_op_name=='전체공개'}">checked</c:if> >전체공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="ac_op_name" value="트립메이트공개" <c:if test="${activity.ac_op_name == '트립메이트공개'}">checked</c:if> >트립메이트공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="ac_op_name" value="회원공개" <c:if test="${activity.ac_op_name == '회원공개'}">checked</c:if> >회원공개
										</label>
										<label class="open-range-label">
											<input type="radio" class="open-range" name="ac_op_name" value="비공개" <c:if test="${activity.ac_op_name == '비공개'}">checked</c:if> > 비공개
										</label>
									</div>
									
									<div class="activity-reg-box activity-select-container">
										<label style="flex:1;">활동선택박스</label>
										<div class="activity-select-box col-6">
											<select class="middle-category">
												<option value="${mc_num}">${activity.ac_mca_name }</option>
											</select>
										</div>
										<div class="activity-select-box col-6">
											<select class="small-category">
												<option value="${sc_num}">${activity.ac_sca_name }</option>
											</select>
										</div>
										<div class="activity-select-mcnum">
											<input type="hidden" name="mc_num" value="${mc_num}">
										</div>
										<div class="activity-select-scnum">
											<input type="hidden" name="sc_num" value="${sc_num}">
										</div>
									</div>
									
									<div class="activity-reg-box date-select-container">
										<div class="date">
											<label class="date-label act-label" for="from">date</label>
											<input type="text" class="day-input" id="from" name="from" style="text-align : center; width:auto;" readonly>
										</div>
									</div>

									<div class="activity-reg-box title-container">
										<label class="act-label">title</label>
										<input type="text" class="form-control" name="ac_title" placeholder="장소 이름을 입력해주세요!" value="${activity.ac_title}">
									</div>
									
									<div class="activity-reg-box contents-container">
										<label class="act-label">contents</label>
										<textarea id="summernote" name="ac_contents" rows="7" >${activity.ac_contents}</textarea>
									</div>
									
									<div class="activity-reg-box address-container">
										<label class="act-label">address</label>
										<!-- 주소 -->
										<div class="address-box">
											<div class="address-input-container">
												<input type="text" id="sample5_address" placeholder="주소" class="col-6 address-input" name="ac_address" value="${activity.ac_address}" readonly>
											</div>
											<div class="address-input-container">
												<input type="button" onclick="sample5_execDaumPostcode()" value="search address" class="button fit address-input"><br>
											</div>
											<div class="address-input-container">
												<input type="text" id="detailAddress" placeholder="상세주소" class="mn-2 address-input" name="ac_address_detail" value="${activity.ac_address_detail }">
											</div>
											<div class="map-container">
												<div id="map"></div>
											</div>
										</div>
									</div>
									
									<div>
										<input type="hidden" name="ac_me_id" value="${user.me_id}"/>
									</div>
									<div class="activity-reg-box with-container">
										<label class="act-label">with</label>
										<input type="text" class="form-control" name="ac_with" placeholder="누구와 함께였나요?" value="${activity.ac_with }"/>
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
			
			
			<script>
			var spot_user = '${spot_user}';
			$('form').submit(function(){
				
				let ac_tr_num = '${activity.ac_tr_num}';
				$('[name=ac_tr_num]').val(ac_tr_num);
				
				let reg_sm_num= '${reg_sm_num}';
				$('[name=reg_sm_num]').val(reg_sm_num);
				
			});
			
			//summernote
			$('#summernote').summernote({
        placeholder: '활동 내용을 입력하세요!',
        tabsize: 2,
        height: 120,
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'underline', 'clear']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ]
      });
			
			singleDatePicker();
			showDateRangePickerr();
			
			
			$(function(){
				var from = '${activity.ac_start_date_str}';
				var to = '${activity.ac_end_date_str}';
				var spot_user = '${spot_user}';
				if(from != to){
					$('#from').val(from+" ~ "+to);
				}
				
				
				let mc_num = $('.middle-category').children().val();
				let sc_num= $('.small-category').children().val();
				let mc_name = '${activity.ac_mca_name}';
				let sc_name = '${activity.ac_sca_name}';
				let isChanged = false;
				console.log('not changed');
				console.log("mc_num : "+mc_num);
				console.log("sc_num : "+sc_num);
				//select box
				setMiddleCategory(mc_num, mc_name);
				setSmallCategory(mc_num);
				
				$('.middle-category').change(function(){
					let mc_num = $(this).val();
					let middle_ca_str = '<input type="hidden" name="mc_num" value="'+mc_num+'">'; 
					isChanged = true;
					setSmallCategory(mc_num, isChanged);
					isChanged = false;
					
					$('.activity-select-mcnum').html('');
					$('.activity-select-mcnum').html(middle_ca_str);
					$('.activity-select-scnum').html('');
					
					console.log('changed middle category');
					
					
					//mc_num이 '숙박' 일 때 date를 기간으로 설정하도록 함
					if(mc_num == 20){
						periodDatePicker();
						showDateRangePickerr();
					}else{//mc_num이 숙박 아닐때
						singleDatePicker();
						showDateRangePickerr();
					}
				});
				
				
				
				
				function setMiddleCategory(mc_num, mc_name){
					let str = '<option value="'+mc_num+'">'+mc_name+'</option>';
					$.ajax({
							async :false,
					    type:'get',
					    url : '/spot/'+spot_user+'/middlecategory?lc_num=2',
					    dataType:"json",
					    success : function(res){
					    	for(middle of res.list){
					    		str += '<option value="'+middle.mc_num+'">'+middle.mc_name+'</option>';
					    	}
					    	$('.middle-category').html(str);
					    	}
					})
				}
				
				
				$('.small-category').change(function(){
					let sc_num = $(this).val();
					let small_ca_str = '<input type="hidden" name="sc_num" value="'+sc_num+'">'; 
					$('.activity-select-scnum').html(small_ca_str);
					

					$('.activity-select-scnum').html('');
					$('.activity-select-scnum').html(small_ca_str);
				})
				
				
				function setSmallCategory(mc_num, isChanged){
						let str = '';
						if(isChanged == true){
							str = '<option value="0">세부선택</option>';
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
						    	for(small of res.list){
						    		str += '<option value="'+small.sc_num+'">'+small.sc_name+'</option>';
						    	}
						    	$('.small-category').html(str);
						    	}
						})
					}
				
				
				
			});
			
			
			
			function singleDatePicker(){
				$('#from').daterangepicker({
					"locale": {
		        "format": "YYYY-MM-DD",
		        "separator": " ~ ",
		        "applyLabel": "확인",
		        "cancelLabel": "취소",
		        "fromLabel": "from",
		        "toLabel": "to",
		        "customRangeLabel": "Custom",
		        "weekLabel": "W",
		        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
		  			"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		        "firstDay": 1,
						"opens": "center"
				    },
						"singleDatePicker": true
					});
			}
			function periodDatePicker(){
				$('#from').daterangepicker({
				    "locale": {
				        "format": "YYYY-MM-DD",
				        "separator": " ~ ",
				        "applyLabel": "확인",
				        "cancelLabel": "취소",
				        "fromLabel": "from",
				        "toLabel": "to",
				        "customRangeLabel": "Custom",
				        "weekLabel": "W",
				        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
			    			"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				        "firstDay": 1,
								"opens": "center"
				    }
				});
			}
			function showDateRangePickerr(){
				$("#from").on('show.daterangepicker', function (ev, picker) {
			    $(".yearselect").css(("float", "left"));
			    $(".monthselect").css("float", "right");
			    $(".cancelBtn").css("float", "right");
				});	
			}
			
			
			
				
				
			
			//address
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
				mapOption = {
			        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
			        level: 5 // 지도의 확대 레벨
			    };
			//지도를 미리 생성
			var map = new daum.maps.Map(mapContainer, mapOption);
			//주소-좌표 변환 객체를 생성
			var geocoder = new daum.maps.services.Geocoder();
			//마커를 미리 생성
			var marker = new daum.maps.Marker({
			    position: new daum.maps.LatLng(37.537187, 127.005476),
			    map: map
			});
			</script>
			<script src="/resources/assets/js/activity/activityReg.js"></script>
			
	</body>
</html>