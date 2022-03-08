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
			<div class="body" id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
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
										  		<td style="text-overflow: ellipsis; overflow:hidden">
										  			<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripDetail/${sm_num}/${tripList.tr_num}">${tripList.tr_title}</a>
										  		</td>
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
											<li><a href="<%=request.getContextPath()%>/spot/tripList?sm_num=${thisSmNum}&page=${pm.startPage-1}" class="<c:if test="${!pm.prev}">disabled</c:if>">Prev</a></li>
											<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
												<li class="">
													<a href="<%=request.getContextPath()%>/spot/tripList?sm_num=${thisSmNum}&page=${i}" class="page <c:if test="${pm.criteria.page==i}">active</c:if>">${i}</a>
												</li>
											</c:forEach>
											<li><a href="<%=request.getContextPath()%>/spot/tripList?sm_num=${thisSmNum}&page=${pm.endPage+1}" class="<c:if test="${!pm.next}">disabled</c:if>">Next</a></li>
										</ul>
										<a href="<%=request.getContextPath()%>/spot/tripReg?reg_sm_num=${thisSmNum}"><button class="btn-trip-write">add</button></a>
									</div>
									
								</section>
								
						</div>
					</div>
			</div>
	</body>
</html>