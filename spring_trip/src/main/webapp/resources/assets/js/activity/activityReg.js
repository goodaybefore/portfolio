/**
 * 
 */
$(function() {
	console.log('hi');
	setMiddleCategory();
	
	$('.middle-category').change(function(){
		let mc_num = $(this).val();
		let middle_ca_str = '<input type="hidden" name="mc_num" value="'+mc_num+'">'; 
		setSmallCategory(mc_num);
		$('.activity-select-mcnum').html(middle_ca_str);
	})
	
	function setMiddleCategory(){
		let str = '<option value="0">활동선택</option>';
		$.ajax({
				async :false,
		    type:'get',
		    url : '/spot/middlecategory?lc_num='+2,
		    dataType:"json",
		    success : function(res){
		    	for(middle of res.list){
					console.log('middle : '+middle);
		    		str += '<option value="'+middle.mc_num+'">'+middle.mc_name+'</option>';
		    	}
		    	$('.middle-category').html(str);
		    	}
		})
	}
	function setSmallCategory(mc_num){
		let str = '<option value="0">세부선택</option>';
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
		    },
				"singleDatePicker": true
			});
	showDateRangePickerr();
	
	$('#form').val('${trip.tr_start_date}');
	function showDateRangePickerr(){
		$("#from").on('show.daterangepicker', function (ev, picker) {
	    $(".yearselect").css(("float", "left"));
	    $(".monthselect").css("float", "right");
	    $(".cancelBtn").css("float", "right");
	});	
	}
	
	
	
});
//address
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if(data.userSelectedType === 'R'){
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if(data.buildingName !== '' && data.apartment === 'Y'){
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if(extraAddr !== ''){
						extraAddr = ' (' + extraAddr + ')';
				}
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode;
			document.getElementById("address").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("detailAddress").focus();
		}
	}).open();
	}