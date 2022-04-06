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
										<h1>Notice</h1>
										<p>공지가 올라오는 Board 게시판(트립매니저, 트립파트너만 작성가능)</p>
										
									</header>
								</div>
								<span class="image object">
								</span>
							</section>
							
							
							<table class="table table-hover">
							  <thead>
							    <tr>
							      <th scope="col" class="col-1">num</th>
							      <th scope="col" class="col-5">title</th>
							      <th scope="col" class="col-3">writer</th>
							      <th scope="col">date</th>
							    </tr>
							  </thead>
							  <tbody>
							  <c:forEach items="${list}" var="list">
							    <tr>
							      <th scope="row">${list.bd_num}</th>
							      <td><a href="<%=request.getContextPath()%>/board/detail?bd_num=${list.bd_num}">${list.bd_title}</a></td>
							      <td>${list.bd_me_id}</td>
							      <td>${list.bd_date_str}</td>
							    </tr>
							 </c:forEach>
							  </tbody>
							</table>
							<!-- pagination -->
							<ul class="pagination justify-content-center">
								<li><a href="<%=request.getContextPath()%>/board/list?page=${pm.startPage-1}" class="<c:if test="${!pm.prev}">disabled</c:if>">Prev</a></li>
								<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
									<li class="">
										<a href="<%=request.getContextPath()%>/board/list?page=${i}" class="page <c:if test="${pm.criteria.page==i}">active</c:if>">${i}</a>
									</li>
								</c:forEach>
								<li><a href="<%=request.getContextPath()%>/board/list?page=${pm.endPage+1}" class="<c:if test="${!pm.next}">disabled</c:if>">Next</a></li>
							</ul>
							
							
					<c:if test="${user.me_gr_name == '트립매니저' || user.me_gr_name =='트립파트너'}">
						<a href="<%=request.getContextPath()%>/board/register" style="border-bottom : none;"><button>write</button></a>
					</c:if>
					</div>
				</div>
							
			</div>
			
	</body>
</html>