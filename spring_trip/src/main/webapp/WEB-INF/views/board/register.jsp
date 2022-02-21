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
		<!-- jQuery library -->
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
		<!-- Popper JS -->
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- 이 템플릿의 원래 css -->
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		
		
		<script src="/resources/assets/js/board/register.js"></script>
		<style>
		.open-range{
			appearance: auto !important;
			opacity:1 !important;
			margin-right: 0px !important;
			display : inline-block !important;
		}
		</style>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
				<div id="main">
					<div class="inner">
						<!-- Header -->
							<header id="header">
								<a href="/" class="logo"><strong>Board</strong></a>
								<ul class="icons">
									<c:if test="${user==null}"><li><a href="<%=request.getContextPath()%>/" class=""><span class="label">login</span></a></li></c:if>
									<c:if test="${user!=null}"><li><a href="<%=request.getContextPath()%>/logout" class=""><span class="label">logout</span></a></li></c:if>
									<li><a href="#" class=""><span class="label">tripmate</span></a></li>
									<li><a href="#" class=""><span class="label">notice</span></a></li>
									<li><a href="#" class=""><span class="label">event</span></a></li>
									<li><a href="#" class=""><span class="label">special</span></a></li>
								</ul>
							</header>

						<!-- Banner -->
						<section id="banner">
							<div class="content">
								<header>
									<h1>Register</h1>
									<p>게시글 작성(트립매니저, 트립파트너만 작성가능)</p>
								</header>
								<form action="<%=request.getContextPath()%>/board/register" method="post">
									<div>
									<label>
										<input type="radio" class="open-range" name="bd_op_name" value="전체공개"/>전체공개
									</label>
									<label>
										<input type="radio" class="open-range" name="bd_op_name" value="회원공개" /> 회원공개
									</label>
									</div>
									<div>
										title <input type="text" class="form-control" name="bd_title"/>
									</div>
									<div>
										<input type="hidden" name="bd_me_id" value="${user.me_id}"/>
									</div>
									<div>
										contents <textarea name ="bd_contents" rows="10"></textarea>
									</div>
									<div>
										file
										~첨부파일~
									</div>
									<div>
										<input type="submit" class="btn-write" value="write">
									</div>
								</form>
							</div>
						</section>

					</div>
				</div>

				
				<!-- Sidebar -->
				<div id="sidebar">
					<div class="inner">
						<!-- Menu -->
							<nav id="menu">
								<header class="major">
									<h2>My Menu</h2>
								<section id="search" class="alt">
									<form method="post" action="#">
										<input type="text" name="query" id="query" placeholder="Search" />
									</form>
								</section>
								</header>
								<ul>
									<li><a href="<%=request.getContextPath()%>/myspot/home">my spot home</a></li>
									<li>
										<span class="opener">trip</span>
										<ul>
											<li><a href="#">Default-Menu(Trip Plan)</a></li>
											<li><a href="#">Add-Menu-1</a></li>
											<li><a href="#">Add-Menu-2</a></li>
											<li><a href="#">Add-Menu-3</a></li>
											<li><a href="#">Add-Menu-4</a></li>
											<li><a href="#">Add-Menu-5</a></li>
											
										</ul>
									</li>
									<li>
										<span class="opener">Tripmate</span>
										<ul>
											<li><a href="#">request</a></li>
											<li><a href="#">my tripmates</a></li>
										</ul>
									</li>
									<li>
										<span class="opener">trip info</span>
										<ul>
											<li><a href="#">notice</a></li>
											<li><a href="#">today's trip</a></li>
										</ul>
									</li>
									<li><a href="#">my page</a></li>
								</ul>
							</nav>
							
						</div>
					</div>

			</div>
			<script src="/resources/assets/js/myspot/jquery.min.js"></script>
			<script src="/resources/assets/js/myspot/browser.min.js"></script>
			<script src="/resources/assets/js/myspot/breakpoints.min.js"></script>
			<script src="/resources/assets/js/myspot/util.js"></script>
			<script src="/resources/assets/js/myspot/main.js"></script>
			
			
	</body>
</html>