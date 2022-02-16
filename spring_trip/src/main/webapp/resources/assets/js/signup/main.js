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
})(jQuery);