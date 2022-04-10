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
		<style>
		.map-container{
			display : flex;
		}
		#map{
			margin:auto;
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
											<h1 style="width : 100%;">My Spot Home</h1>
											<c:if test="${spot_user != null}">
												<p>${spot_user }의 여행 다이어리에 오신 것을 환영합니다!</p>
											</c:if>
											
										</header>
										<div class="map-container">
											<div id="map" style="min-width : 700px; width:100%; height: 700px;"></div>
										</div>
									</div>
								</section>

							<!-- Section -->
								<section>
									<header class="major">
									</header>
								</section>

						</div>
					</div>
			</div>
			<script>
			var bounds = new kakao.maps.LatLngBounds();
			var geocoder = new kakao.maps.services.Geocoder();
			$(function(){
				var points=[];
				var coords;
				var point_list; 
				
				
				if('${points}' != ''){
					point_list = new Array();
					<c:forEach items="${points}" var="item1">
					point_list.push("${item1}");
					</c:forEach>
				}
				
				
				if(point_list == ''){
					var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
					var options = { //지도를 생성할 때 필요한 기본 옵션
						center: new kakao.maps.LatLng(36.36975595142133, 127.63680706407531), //지도의 중심좌표.
						level: 13 //지도의 레벨(확대, 축소 정도)
					};

					var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
					return;
				}
				else{
					showDefaultMap();
					
					var callback = function(result, status){
						if(status == kakao.maps.services.Status.OK){
							coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							points.push(coords);
						}
					}
					
					for(i=0;i<point_list.length;i++){
						geocoder.addressSearch(point_list[i], callback);
					}
					
					setTimeout(function(){
						var marker;
						for(var i=0;i<points.length;i++){
							marker = new kakao.maps.Marker({position : points[i]})
							marker.setMap(map);
							bounds.extend(points[i]);
						}
					}, 200);
					
				}
				
				
				
				
				function showDefaultMap(){
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    	mapOption = {
							center: new kakao.maps.LatLng(36.36975595142133, 127.63680706407531), //지도의 중심좌표.
							level: 13 //지도의 레벨(확대, 축소 정도)
			    	};
					map = new kakao.maps.Map(mapContainer, mapOption);
				}
			});
						
			</script>
	</body>
</html>