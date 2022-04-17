<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		
		<!-- 부트스트랩 -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- 이 템플릿의 원래 css -->
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/assets/js/comment.js"></script>
		<style>
		textarea.bd_contents{
			resize: none;
		}
		.board-title{
			font-size : 18px;
		}
		.bd_title{
			margin-top : 10px !important;
			margin-bottom : 10px !important;
		}
		.btn-comment{
			width : 100%;
			height : 100%;
		}
		.btn-comment{
			width : 60px;
			height : 40px;
			float : right;
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
										<h1>Board Detail</h1>
										<p>게시글 상세</p>
										<div class="board bd_title">
											<p>제목</p><input type="text" value="${board.bd_title}" readonly>
										</div>
										
										<div class="board bd_contents">
										<p>내용</p>
											<textarea class="bd_contents" rows="10" readonly>${board.bd_contents}</textarea>
										</div>
									</header>
								</div>
							</section>
							
					<c:if test="${user.me_gr_name == '트립매니저' || user.me_gr_name =='트립파트너'}">
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>modify</button></a>
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>delete</button></a>
					</c:if>
					
					<!-- 댓글 -->
					<div class="comment-list"></div>
					<div class="comment-pagination"></div>
					<div class="comment-box">
						<div class="input-group mb-3 mt-3">
							<textarea class="form-control text-comment" rows="2" placeholder="Comment"></textarea>
							<div class="input-group-append">
								<button class="btn btn-comment primary">등록</button>  
							</div>
						</div>
					</div>
					
					</div>
				</div>
			</div>
			 <script>
			 var contextPath = '<%=request.getContextPath()%>';
			 commentService.setContextPath(contextPath);
			 $(function(){
				 
				 var co_bd_num = '${board.bd_num}';
				 var co_me_id = '${user.me_id}';
				
				 //화면 로딩 준비가 끝나면 댓글 1페이지 출력
				 var listUrl = '/comment/list?page=1&bd_num='+'${board.bd_num}';
				 commentService.list(listUrl, listSuccess);
					
				 //댓글 등록
				 $('.btn-comment').click(function(){
						var co_contents = $('.text-comment').val();
						
						if(co_me_id=='') {
							alert('로그인 후 시도하세요');
							return;
						}
					
						if(co_contents==''){
							alert('내용을 입력하세요');
							return;
						}
						
						var comment = {
								co_me_id : co_me_id,
								co_contents : co_contents,
								co_bd_num : co_bd_num
						};
						//댓글 삽입
						var url = '/comment/insert';
						commentService.insert(url, comment, insertSuccess);
					})
				 
			 });
			 
			 /////////////////////////함수/////////////////////////
			 
			 
			 
			 
			 function listSuccess(res){
					var str ='';
					var co_me_id ='${user.me_id}';
					console.log('list Success')
					//댓글이 없으면 페이지네이션의 이전/다음을 지워줌... 이라는데 난왜 보이는거지?ㅠ
					if(res.list.length == 0){
						$('.comment-list').html('');
						$('.comment-pagination').html('');
					}
					
	        for(tmp of res.list){
	        	str += createComment(tmp, co_me_id);
	        }
	        
	        //댓글리스트 불러오기
	        $('.comment-list').html(str);
	        
	        //페이지네이션리스트 불러오기
	        var paginationStr = creatPagination(res.pm);
	        $('.comment-pagination').html(paginationStr);
				}
			 
			 
			 function insertSuccess(res){
					if(res){
						$('.text-comment').val('');//기존에 입력한 댓글 내용 지우기
						//댓글등록시 댓글목록 새로고침
						var listUrl = '/comment/list?page=1&bd_num='+'${board.bd_num}';
						commentService.list(listUrl, listSuccess);
					}else{
						alert('댓글 등록에 실패하였습니다');
					}
				}
			 
			 function createComment(comment, me_id){
					//날짜 정상출력을 위한 변환코드
					var co_reg_date = getDateToString(new Date(comment.co_reg_date));
					
					var str = '';
					str += '<div class="comment-box clearfix">'
					if(comment.co_ori_num != comment.co_num){//대댓인경우
					str += 	'<div class="float-left" style="width:24px;">ㄴ</div>'
					str += 	'<div class="float-left" style="width:calc(100% - 24px);">'
					}else{
					str += 	'<div class="float-left" style="width:calc(100%); margin-top : 10px;">'
					}
					str += 		'<div class="co_me_id" style="font-size:12px; font-weight:bold;">'+comment.co_me_id+'</div>'
					str += 		'<div class="co_contents">'+comment.co_contents+'</div>'
					str += 		'<div class="co_reg_date" style="font-size:11px; color:grey;">'+co_reg_date+'</div>'
					
					if(comment.co_ori_num == comment.co_num){
					str += 		'<button class="btn btn-comment mr-2" data-num="'+comment.co_num+'">답글</button>'	
					}
					
					if(comment.co_me_id == me_id){
					str += 		'<button class="btn btn-comment mr-2" data-num="'+comment.co_num+'">수정</button>'
					str += 		'<button class="btn btn-comment mr-2" data-num="'+comment.co_num+'">삭제</button>'
					}
					
					str += 	'</div>'
					str += 	'<hr class="mt-3">'
					str += '</div>';
					return str;
				}
			 
			 function getDateToString(date){
					return ""+ date.getFullYear() + "-" +
								(date.getMonth()+1) + "-" +
								date.getDate() + " "+
								date.getHours()+ " : "+
								date.getMinutes();
				}
			 
			//pagenaition하는 str을 만드는 함수
				function creatPagination(pm){
					str = '';
					//prev, next버튼 활성화결정
					var prevDisabled = pm.prev ? '' : 'disabled';
					var nextDisabled = pm.next  ? '' : 'disabled';
					var page = pm.criteria.page;
					//prev출력
					//for문으로 pagination추가
					str += '<ul class="pagination justify-content-center">'+
					    '<li class="page-item '+prevDisabled+'" data-page="'+(pm.startPage-1)+'"><a class="page-link " href="javascript:; ">이전</a></li>';
					for(i = pm.startPage; i<=pm.endPage;i++){
						var currentActive = page == i ? 'active' : '';
						str += '<li class="page-item '+currentActive+'" data-page='+i+'><a class="page-link " href="javascript:;">'+i+'</a></li>';
					}
					    
					    str += '<li class="page-item '+nextDisabled+'" data-page="'+(pm.endPage+1)+'"><a class="page-link " href="javascript:;" >다음</a></li>'+
					  '</ul>';
					//next출력
					return str;
					
				}
			 </script>
	</body>
</html>