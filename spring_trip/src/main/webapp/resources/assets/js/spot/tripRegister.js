/**
 * 
 */
$(function() {
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
	showDateRangePickerr();
	
	$('#isOneday').change(function(){
		if($('#isOneday').is(':checked')){
			console.log('당일여행입니다')
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
		}else{
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
		showDateRangePickerr();
	});
	$('#form').val('${trip.tr_start_date}');
	function showDateRangePickerr(){
		$("#from").on('show.daterangepicker', function (ev, picker) {
	    $(".yearselect").css(("float", "left"));
	    $(".monthselect").css("float", "right");
	    $(".cancelBtn").css("float", "right");
	});	
	}
	
	
	
});
