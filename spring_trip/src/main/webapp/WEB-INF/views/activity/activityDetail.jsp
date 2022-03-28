<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<!-- kakao map -->
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b4d47c161d7b6d187f225aba5f7cc5b5&libraries=services"></script>
		
		<!-- Swiper -->
	 	 <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
		<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
		
		<style>
		/*Demo Styles*/
		html,
     body {
       position: relative;
       height: 100%;
     }

     body {
       color: #000;
       margin: 0;
       padding: 0;
     }

     .swiper {
       width: 100%;
       height: 100%;
     }

     .swiper-slide {
       text-align: center;
       font-size: 18px;
       background: #fff;

       /* Center slide text vertically */
       display: -webkit-box;
       display: -ms-flexbox;
       display: -webkit-flex;
       display: flex;
       -webkit-box-pack: center;
       -ms-flex-pack: center;
       -webkit-justify-content: center;
       justify-content: center;
       -webkit-box-align: center;
       -ms-flex-align: center;
       -webkit-align-items: center;
       align-items: center;
     }

     .swiper-slide img {
       display: block;
       width: 100%;
       height: 100%;
       object-fit: cover;
     }
     .swiper {
       width: 100%;
       height: 300px;
       margin-left: auto;
       margin-right: auto;
     }

     .swiper-slide {
       background-size: cover;
       background-position: center;
     }

     .mySwiper2 {
       height: 80%;
       width: 100%;
     }

     .mySwiper {
       height: 20%;
       box-sizing: border-box;
       padding: 10px 0;
     }

     .mySwiper .swiper-slide {
       width: 25%;
       height: 100%;
       opacity: 0.4;
     }

     .mySwiper .swiper-slide-thumb-active {
       opacity: 1;
     }

     .swiper-slide img {
       display: block;
       width: 100%;
       height: 100%;
       object-fit: cover;
     }
     
     
     /*activityDetail*/
		.activity-reg-box{
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
		.detail-label{
			margin-right : 10px;
			height : auto !important;
			padding : 0px ! important;
		}
		.detail-container{
			margin-bottom : 10px;
		}
		.period-container, .sort-container, .open-range-container, .file-container, .with-container,
		.title-container, .contents-container{
			display : flex;
			margin-bottom : 0px !important;
			padding : 0px !important;
		}
		.period-container, .sort-container, .open-range-container{
			margin-bottom : 5px !important;
		}
		.contents-container{
			height:auto; min-height:100px;
		}
		.with-container{
			margin-top : 10px;
		}
		.btn-primary, .btn-primary.disabled, .btn-primary:disabled{
			background-color : white !important;
			border-color : white !important;
		}
		.daterangepicker td.active, .daterangepicker td.active:hover{
			background-color : #f56a6a !important;
		}
		
		.sort-select-box{
			flex : 2;
			min-width : 200px;
			width : 200px !important;
		}
		.ac-dates{
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
										<h1>Activity Detail</h1>
										<p>활동정보 열람</p>
									</header>
										<input type="hidden" name="reg_sm_num" value="${reg_sm_num}">
									<div class="activity-detail">
											<c:if test="${activity.ac_me_id == user.me_id}">
												<a href="<%=request.getContextPath()%>/spot/${spot_user}/activityMod?ac_num=${activity.ac_num}" style="border-bottom : none;"><button>modify</button></a>
												<a href="<%=request.getContextPath()%>/spot/${spot_user}/activityDel?ac_num=${activity.ac_num}&&tr_num=${activity.ac_tr_num}&&reg_sm_num=${reg_sm_num}" style="border-bottom : none;"><button>delete</button></a>
											</c:if>
										<div class="activity-reg-box detail-container">
											<!-- 활동기간 -->
											<div class="period-container">
												<label class="detail-label">활동기간</label>
												<c:if test="${activity. ac_start_date_str == activity.ac_end_date_str && activity.ac_start_date_str != ''}">
													<p class="start-date">${activity.ac_start_date_str}</p>
												</c:if>
												<c:if test="${activity.ac_start_date_str != activity.ac_end_date_str}">
													<p class="ac-dates start-date">${activity.ac_start_date_str}</p> ~ <p class="ac-dates end-date">${activity.ac_end_date_str}</p><p class="ac-dates activity-period"></p>
												</c:if>
												</div>
											<div class="sort-container">
												<label class="detail-label">활동분류</label>
												<p>${activity.ac_mca_name }</p>
												<p>${activity.ac_sca_name }</p>
											</div>
											<div class="open-range-container">
												<label class="detail-label">공개범위</label>
												<p>${activity.ac_op_name}</p>
											</div>
											
											<div class="title-container">
												<label class="detail-label">활동제목</label>
												<p>${activity.ac_title}</p>
											</div>
											<div class="contents-container">
												<label class="detail-label">활동내용</label>
												<div>${activity.ac_contents }</div>
											</div>
											<!-- 활동사진 -->
											<div class="address-container">
												<label class="detail-label">활동주소</label>
												<p>${activity.ac_address} ${activity.ac_address_detail}</p>
												<div id="map" style="width:100%;height:350px;"></div>
											</div>
											
											<div class="with-container">
												<label class="detail-label">함께한 사람들</label>
												<p>${activity.ac_with}</p>
											</div>
										</div>
										<a href="<%=request.getContextPath()%>/spot/${spot_user}/activityReg?tr_num=${activity.ac_tr_num}" style="border-bottom : none;"><button>add activity</button></a>
									</div>
								</div>
								<span>span 태그 테스트</span>
							</section>
					</div>
				</div>
			</div>
			
	<script src="/resources/assets/js/spot/tripDetail.js"></script>

  
	<script>
		
		//swiperJS
		
		//address
		$(function(){
			var mapAddress = '${activity.ac_address}';//표기할 주소
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
	
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
	
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(mapAddress, function(result, status) {
	
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
	
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
	
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+'${activity.ac_title}'+'</div>'
			        });
			        infowindow.open(map, marker);
	
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});    
			var swiper = new Swiper(".mySwiper", {
		        spaceBetween: 10,
		        slidesPerView: 4,
		        freeMode: true,
		        watchSlidesProgress: true,
		      });
		      var swiper2 = new Swiper(".mySwiper2", {
		        spaceBetween: 10,
		        navigation: {
		          nextEl: ".swiper-button-next",
		          prevEl: ".swiper-button-prev",
		        },
		        thumbs: {
		          swiper: swiper,
		        },
		      });
		})
	</script>
	
	</body>
</html>