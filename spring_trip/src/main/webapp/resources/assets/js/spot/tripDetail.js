/**
 * 
 */
$(function() {
	var strStartDate = $('.start-date').text();
	var strEndDate = $('.end-date').text();
	console.log(strStartDate);
	console.log(strEndDate);
	if(strEndDate != ''){
		var arr1 = strStartDate.split('.');
		var arr2 = strEndDate.split('.');
		var startDate = new Date(arr1[0], arr1[1], arr1[2]);
		var endDate = new Date(arr2[0], arr2[1], arr2[2]);
		
		var dateCalc = endDate - startDate;
		var resDay = 24 * 60 * 60 * 1000; //시*분*초*밀리세컨
		console.log('여행 기간 : '+((dateCalc/resDay)+1)+'일');
		$('.trip-period').html('('+((dateCalc/resDay)+1)+'일)');
	}
	
	
	function showDbMarkers(){
		
				showDefaultMap();
				
			//주소를 좌표로 변환하는 코드
			var callback = function(result, status){
				if(status ==kakao.maps.services.Status.OK){
					coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					coordList.push(coords);
				}
			}
			
			
			for(i=0;i<address_list.length;i++){
				geocoder.addressSearch(address_list[i], callback);
			}
			
			//배열에 들어간 coordList 사용하기
			setTimeout(function(){
				console.log(coordList);
				
				var marker;
				for(var i=0;i<coordList.length;i++){
					marker = new kakao.maps.Marker({position : coordList[i]})
					marker.setMap(map);
					bounds.extend(coordList[i]);
				}
				$('#btnMaps').click();
			}, 200);
			}
			
			//기본지도 출력
			function showDefaultMap(){
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    	mapOption = {
						center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		      	level: 3 // 지도의 확대 레벨
		    	};
				map = new kakao.maps.Map(mapContainer, mapOption);
			}
});
