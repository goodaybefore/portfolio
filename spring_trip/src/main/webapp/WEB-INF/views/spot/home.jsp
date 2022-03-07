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

							<!-- Section -->
								<section>
									<header class="major">
									</header>
								</section>

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