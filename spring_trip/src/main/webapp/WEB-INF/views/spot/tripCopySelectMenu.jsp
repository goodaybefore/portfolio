<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert222</title>
<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
<script src="/resources/assets/js/spot/jquery.min.js"></script>
<style>
	html, body{
		display : flex;
		width : 100%;
		height : 100%;
		margin : 0px;
		padding : 0px;
	}
	.copy-trip-select-container{
		border : 1px solid red;
		margin : auto;
		padding : 20px;
		align-items : center;
		flex-direction : row;
		justify-content : center;
		
	}
	.select-group{
		display : flex;
	}
	.menu-selectbox{
		width : 200px;
	}
</style>
</head>
<body>
	<form class="copy-trip-select-container"
	action="<%=request.getContextPath()%>/spot/${spot_user}/tripDetail/${sm_num}/selectMenuCategory" method="post">
		<input type="hidden" name="sm_num" value=${sm_num }>
		<input type="hidden" name="tr_num" value=${tr_num }>
		<div class="select-group">
			<select class="menu-selectbox">
				<option>메뉴 선택</option>
			</select>
		</div>
		<div class="select-str"></div>
		<input type="submit" class="btn-select primary fit" value="copy">
		<input type="submit" class="btn-close" style="display : none;" onClick="window.close()">
	</form>
	<script>
	$(function(){
		
		var userId = '${user.me_id}';
		console.log('userId : '+userId);
		setMenuCategory();
		
		var tr_num = opener.$('#tr_num').val();
		$('[name=tr_num]').val(tr_num);
		console.log('tr_num : ' + tr_num);
		
		$('.menu-selectbox').change(function(){
			let sm_num = $(this).val();
			let menu_ca_str = '<input type="hidden" name="copy_sm_num" value="'+sm_num+'">';
			console.log('menu_ca_str : '+menu_ca_str);
			$('.select-str').html(menu_ca_str);
		})
		
		
		function setMenuCategory(){
			let str='<option value="0">메뉴선택</option>';
			$.ajax({
				async : false,
				type : 'get',
				url : '/spot/'+userId+'/menuCategory?userId='+userId,
				dateType : "json",
				success : function(res){
					console.log(res);
					for(menu of res.menuList){
						str += '<option name="copy_sm_num" value="'+menu.sm_num+'">'+menu.sm_name+'</option>';
					}
					$('.menu-selectbox').html(str);
				}
				
			})
		}
		
	});
	</script>
</body>
</html>