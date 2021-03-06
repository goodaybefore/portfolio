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
											<p>여행지 목록을 등록해보세요</p>
										</header>
										<table class="table table-hover" style="table-layout: fixed;">
										  <thead>
										    <tr>
										      <th scope="col" style="width:50px;">num</th>
										      <th scope="col" style="width:100px;" class="">area</th>
										      <th scope="col" class="col-12 " style="min-width:200px; width:200px;">trip title</th>
										      <th scope="col" class="text-center" style="width:150px;">period</th>
										      <th scope="col" class="text-center" style="width:120px;">with</th>
										      <th scope="col" class="text-center" style="width:120px;">공개범위</th>
										      <th scope="col" class="text-center" style="width:50px;">즐찾</th>
										    </tr>
										  </thead>
										  <tbody>
										  	<c:forEach items="${tripList}" var="tripList">
										  	<tr>
										  		<td>${tripList.tr_num}</td>
										  		<td>${tripList.tr_mca_name}</td>
										  		<td style="text-overflow: ellipsis; overflow:hidden">
										  			<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripDetail/${sm_num}/${tripList.tr_num}">${tripList.tr_title}</a>
										  		</td>
										  		<td>
										  			<c:if test="${tripList.tr_start_date_str == tripList.tr_end_date_str}">
										  				${tripList.tr_start_date_str}
										  			</c:if>
										  			<c:if test="${tripList.tr_start_date_str != tripList.tr_end_date_str}">
										  				${tripList.tr_start_date_str} ~ ${tripList.tr_end_date_str }
										  			</c:if>
										  		
										  		</td>
										  		<td>${tripList.tr_with}</td>
										  		<td>${tripList.tr_op_name }</td>
										  		<td class="text-center">*</td>
										  	</tr>
										  	</c:forEach>
										  </tbody>
										</table>
										
										<div style="display : flex; justify-content : center;">
											<!-- pagination -->
											<ul class="pagination" style="">
												<li>
													<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripList/${sm_num}?page=${pm.startPage-1}" class="<c:if test="${!pm.prev}">disabled</c:if>">Prev</a>
												</li>
												<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
													<li>
														<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripList/${sm_num}?page=${i}" class="page <c:if test="${pm.criteria.page==i}">active</c:if>">${i}</a>
													</li>
												</c:forEach>
													<li><a href="<%=request.getContextPath()%>/spot/${spot_user}/tripList/${sm_num}?page=${pm.endPage+1}" class="<c:if test="${!pm.next}">disabled</c:if>">Next</a></li>
											</ul>
										</div>
										<c:if test="${user.me_id == spot_user}">
										<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripRegister?reg_sm_num=${sm_num}"><button class="btn-trip-write">add</button></a>
										</c:if>
									</div>
									
								</section>
								
						</div>
					</div>
			</div>
	</body>
</html>