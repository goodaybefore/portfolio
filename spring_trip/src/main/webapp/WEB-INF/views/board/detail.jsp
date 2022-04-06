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
										<h1>Detail</h1>
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
								<span>span 태그 테스트</span>
							</section>
							
					<c:if test="${user.me_gr_name == '트립매니저' || user.me_gr_name =='트립파트너'}">
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>modify</button></a>
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>delete</button></a>
					</c:if>
					
					<!-- 댓글 -->
					<hr class="mt-3">
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
						//ajax
						var url = '/comment/insert';
						commentService.insert(url, comment, insertSuccess);
					})
				 
			 });
			 
			 function insertSuccess(res){
					if(res){
						$('.text-comment').val('');//기존에 입력한 댓글을 지워줌
						//댓글등록시 댓글목록 새로고침
						var listUrl = '/comment/list?page=1&bd_num='+'${board.bd_num}';
						commentService.list(listUrl, listSuccess);
					}else{
						alert('댓글 등록에 실패하였습니다');
					}
				}
			 </script>
	</body>
</html>