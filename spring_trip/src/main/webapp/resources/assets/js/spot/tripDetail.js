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
		console.log('여행 기간 : '+dateCalc/resDay+'일');
		$('.trip-period').html('('+dateCalc/resDay+'일)');
	}
});
