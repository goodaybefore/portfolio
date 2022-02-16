(function($) {

    $(".toggle-password").click(function() {

        $(this).toggleClass("zmdi-eye zmdi-eye-off");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "password") {
          input.attr("type", "text");
        } else {
          input.attr("type", "password");
        }
      });
      
    $('.phone').keydown(function(event) {
			    var key = event.charCode || event.keyCode || 0;
			    $text = $(this);
			    if (key !== 8 && key !== 9) {
			        if ($text.val().length === 3) {
			            $text.val($text.val() + '-');
			        }
			        if ($text.val().length === 8) {
			            $text.val($text.val() + '-');
			        }
			    }
			    return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));          
			});
			
	$('form').submit(function(){
		
		//동의체크
		let isAgree = $('[name=agree-term]').is('checked');
		if(!isAgree){
			alert('Please agree the checkbox');
			return false;
		}
		
		//아이디체크
		//구현
	});

	$('form').validate({
		rules : {
			me_id : {
				required : true//필수항목인지
				//영어로 시작해야하고, 영어나숫자중 5~8글자
				//,regex :  /^[A-z]\w{4,7}$/
			},
			password : {
				required : true
				//영어나 숫자가 들어가있고 8~20자
				//,regex : /^(?=\w{4,20}$)\w*(\d[A-z]|[A-z]\d)\w*$/
			},
			re_password : {
				required : true,
				equalTo : password
			},
			me_name : {
				required : true,
				minlength : 2
			},
			me_gender : {
				required : true
			}
		},
		massages : {
			me_id : {
				required : '필수로 입력하세요'
				//,regex : '영문자, 숫자로 이루어져있으며 5~8자로 구성되어야합니다.'
			},
			password : {
				required : '필수로 입력하세요',
				minlength : '최소 {0}글자 이상이어야 합니다.',
				maxlength : '최대 {0}글자 이하여야 합니다.'
				//,regex : '영문자, 숫자로 이루어져있으며 5~8자로 구성되어야합니다.'
			},
			re_password : {
				equalTo : '비밀번호가 일차하지 않습니다.'
			},
			me_name : {
				required : '필수로 입력하세요.'
			},
			me_gender : {
				required : '필수로 입력하세요.'
			}
		}
	});
	$.validator.addMethod(
	    "regex",
	    function(value, element, regexp) {
	        var re = new RegExp(regexp);
	        return this.optional(element) || re.test(value);
	    },
	    "Please check your input."
	);
	
	
	
})(jQuery);