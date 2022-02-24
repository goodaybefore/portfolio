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
		<style>
		textarea.bd_contents{
			resize: none;
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
									<a href="<%=request.getContextPath()%>/board/list" class="logo"><strong>Board</strong></a>
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
										<h1>Detail</h1>
										<p>게시글 상세</p>
										<div class="board bd_title">
											<p><strong>${board.bd_title}</strong></p>
										</div>
										
										<div class="board bd_contents">
											<textarea class="bd_contents" rows="10" readonly>${board.bd_contents}</textarea>
										</div>
									</header>
								</div>
								<span>span 태그 테스트</span>
								ㅗㅑ
							</section>
							
					<c:if test="${user.me_gr_name == '트립매니저' || user.me_gr_name =='트립파트너'}">
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>modify</button></a>
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>delete</button></a>
					</c:if>
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
										<c:forEach items="${menu }" var="menu">
											<li><a href="<%=request.getContextPath()%>/myspot/tripList?menu=${menu}">${menu}</a></li>
										</c:forEach>
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