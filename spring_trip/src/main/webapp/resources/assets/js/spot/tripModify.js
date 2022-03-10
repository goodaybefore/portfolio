/**
 * 
 */
$(function() {
	
	setMiddleCategory();
	$('.middle-category').change(function(){
		let mc_num = $(this).val();
		let middle_ca_str = '<input type="hidden" name="mc_num" value="'+mc_num+'">'; 
		setSmallCategory(mc_num);
		$('.area-select-mcnum').html(middle_ca_str);
	})
	
	
	$('.small-category').change(function(){
		let sc_num = $(this).val();
		let small_ca_str = '<input type="hidden" name="sc_num" value="'+sc_num+'">'; 
		$('.area-select-scnum').html(small_ca_str);
		//setSmallCategory(sc_num);
	})
	
	function setMiddleCategory(){
		let str = '';
		$.ajax({
				async :false,
		    type:'get',
		    url : '/spot/middlecategory',
		    dataType:"json",
		    success : function(res){
		    	for(middle of res.list){
		    		str += '<option value="'+middle.mc_num+'">'+middle.mc_name+'</option>';
		    	}
		    	$('.middle-category').html(str);
		    	}
		})
	}
	
	function setSmallCategory(mc_num){
		let str = '';
		if(mc_num<=0){
			$('.middle-category').html(str);
			return;
		}
		$.ajax({
				async :false,
		    type:'get',
		    url : '/spot/smallcategory?sc_mc_num='+mc_num,
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
	
	function showDateRangePickerr(){
		$("#from").on('show.daterangepicker', function (ev, picker) {
	    $(".yearselect").css(("float", "left"));
	    $(".monthselect").css("float", "right");
	    $(".cancelBtn").css("float", "right");
	});	
	}
	
	
	
});
