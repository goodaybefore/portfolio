<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
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
											<h1 style="width : 100%;">My Spot Home</h1>
											<c:if test="${user == null}">
												<p>로그인하면 더 많은 기능을 사용할 수 있습니다!</p>
											</c:if>
											<c:if test="${user !=null }">
												<p>${user.me_id }의 여행 다이어리에 오신 것을 환영합니다!</p>
											</c:if>
											<div style="height : 500px; width : 100%;"></div>
										</header>
									</div>
								</section>

							<!-- Section -->
								<section>
									<header class="major">
									</header>
								</section>

						</div>
					</div>

			</div>
	</body>
</html>