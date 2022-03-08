<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<!-- Header -->
						<header id="header">
							<a href="/" class="logo"><strong>My Trip List</strong> ${spot_user}</a>
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
											<h1>My Spot Home</h1>
											<p>${menu}</p>
											<c:if test="${user == null}">
												<p>로그인하면 더 많은 기능을 사용할 수 있습니다!</p>
											</c:if>
										</header>
										<p>${user.me_id }</p>
										<ul class="actions">
											<li><a href="#" class="button big">Learn More</a></li>
										</ul>
									</div>
									<span class="image object">
										<img src="/resources/images/myspot/pic10.jpg" alt="" />
									</span>
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
										<p> 현재 로그인 유저 : ${user.me_id}<br> 현재 spot 주인 :  ${spot_user}</p>
										<li><a href="<%=request.getContextPath()%>/spot/home">my spot home</a></li>
										<li>
											<span class="opener">trip</span>
											<ul>
											<c:forEach items="${menu }" var="menu">
												<li><a href="<%=request.getContextPath()%>/spot/${spot_user}/tripList/${menu.sm_num}">${menu.sm_name}</a></li>
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
			
			<script src="/resources/assets/js/spot/jquery.min.js"></script>
			<script src="/resources/assets/js/spot/browser.min.js"></script>
			<script src="/resources/assets/js/spot/breakpoints.min.js"></script>
			<script src="/resources/assets/js/spot/util.js"></script>
			<script src="/resources/assets/js/spot/main.js"></script>
	</body>
</html>