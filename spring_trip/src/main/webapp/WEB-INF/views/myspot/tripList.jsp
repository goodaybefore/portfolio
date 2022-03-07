<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		<style>
		a{
			border-bottom : none !important;
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
									<a href="/" class="logo"><strong>My Trip List</strong> ${user.me_id}</a>
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
											<h1>TRIP LIST</h1>
											<p>여행지 목록을 등록해보세요<br>${pm }</p>
										</header>
										<table class="table table-hover" style="table-layout: fixed;">
										  <thead>
										    <tr>
										      <th scope="col" style="width:50px;">num</th>
										      <th scope="col" style="width:100px;" class="">area</th>
										      <th scope="col" class="col-12 " style="min-width:200px;">trip title</th>
										      <th scope="col" class="text-center" style="width:150px;">period</th>
										      <th scope="col" class="text-center" style="width:100px;">with</th>
										      <th scope="col" class="text-center" style="width:120px;">공개범위</th>
										      <th scope="col" class="text-center" style="width:50px;">즐찾</th>
										    </tr>
										  </thead>
										  <tbody>
										  	<c:forEach items="${tripList}" var="tripList">
										  	<tr>
										  		<td>${tripList.tr_num}</td>
										  		<td>${tripList.tr_ca_name}</td>
										  		<td style="text-overflow: ellipsis; overflow:hidden">${tripList.tr_title}</td>
										  		<td>${tripList.tr_start_date_str} ~ ${tripList.tr_end_date_str }</td>
										  		<td>아직안함</td>
										  		<td>${tripList.tr_op_name }</td>
										  		<td class="text-center">*</td>
										  	</tr>
										  	</c:forEach>
										  </tbody>
										</table>
										
										<!-- pagination -->
										<ul class="pagination justify-content-center">
											<li><a href="<%=request.getContextPath()%>/myspot/tripList?sm_num=${thisSmNum}&spot_user=${user.me_id}&page=${pm.startPage-1}" class="<c:if test="${!pm.prev}">disabled</c:if>">Prev</a></li>
											<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
												<li class="">
													<a href="<%=request.getContextPath()%>/myspot/tripList?sm_num=${thisSmNum}&spot_user=${user.me_id}&page=${i}" class="page <c:if test="${pm.criteria.page==i}">active</c:if>">${i}</a>
												</li>
											</c:forEach>
											<li><a href="<%=request.getContextPath()%>/myspot/tripList?sm_num=${thisSmNum}&spot_user=${user.me_id}&page=${pm.endPage+1}" class="<c:if test="${!pm.next}">disabled</c:if>">Next</a></li>
										</ul>
										<a href="<%=request.getContextPath()%>/myspot/tripReg?reg_sm_num=${thisSmNum}"><button class="btn-trip-write">add</button></a>
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
										<c:forEach items="${menu }" var="menu">
											<li><a href="<%=request.getContextPath()%>/myspot/tripList?menu=${menu.sm_num}">${menu.sm_name}</a></li>
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

							<!-- Section -->
								<section>
									<header class="major">
										<h2>Ante interdum</h2>
									</header>
									<div class="mini-posts">
										<article>
											<a href="#" class="image"><img src="/resources/images/myspot/pic07.jpg" alt="" /></a>
											<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
										</article>
										<article>
											<a href="#" class="image"><img src="/resources/images/myspot/pic08.jpg" alt="" /></a>
											<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
										</article>
										<article>
											<a href="#" class="image"><img src="/resources/images/myspot/pic09.jpg" alt="" /></a>
											<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
										</article>
									</div>
									<ul class="actions">
										<li><a href="#" class="button">More</a></li>
									</ul>
								</section>

							<!-- Section -->
								<section>
									<header class="major">
										<h2>Get in touch</h2>
									</header>
									<p>Sed varius enim lorem ullamcorper dolore aliquam aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin sed aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
									<ul class="contact">
										<li class="icon solid fa-envelope"><a href="#">information@untitled.tld</a></li>
										<li class="icon solid fa-phone">(000) 000-0000</li>
										<li class="icon solid fa-home">1234 Somewhere Road #8254<br />
										Nashville, TN 00000-0000</li>
									</ul>
								</section>

							<!-- Footer -->
								<footer id="footer">
									<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
								</footer>

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