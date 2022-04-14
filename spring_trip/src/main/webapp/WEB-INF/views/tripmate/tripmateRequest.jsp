<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TRIPMATE LIST</title>
	<!-- fontawesome -->
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	<style>
	p{
		font-family: NotoSansKR !important;
	}
	.tm-title{
		font-family : NotoSansKR !important;
	}
	.tripmate-container{
		margin-bottom : 40px;
	}
	</style>
</head>
<body>
	<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<section id="banner">
							<div class="content">
								<header>
									<h1>Tripmate Request</h1>
									<p class="tm-title">트립메이트 신청</p>
								</header>
								
								<section class="tripmate-container">
								<h3 class="tm-title">내가 보낸 트립메이트 신청</h3>
									<div class="tripmate-receive-container">
										<table class="table table-hover" style="table-layout: fixed">
											<thead>
												<tr>
													<th scpoe="col" style="width:50px;">num</th>
											      <th scope="col" style="width:150px;">user ID</th>
											      <th scope="col" style="width:50px; text-align:center;">cancel</th>
												</tr>
											</thead>
											<tbody>
												<c:if test="${empty sendList}">
											  		<td style="text-align : center;" colspan="5">보낸 트립메이트 신청이 없습니다.</td>
										  	</c:if>
										  	<c:if test="${sendList!=''}">
										  		<c:forEach items="${sendList}" var="send" varStatus="vs">
											  		<td>${vs.index+1}</td>
											  		<td><a href="#">${send.tq_receive_id }</a></td>
											  		<td style="text-align:center;">
											  			<a href="<%=request.getContextPath()%>/spot/${user.me_id}/tripmate/tripmateCancel?receive_id=${send.tq_receive_id}"><i class="fas fa-times"></i></a>
											  		</td>
										  		</c:forEach>
										  	</c:if>
											
											
												
											</tbody>
										</table>
									</div>
								</section>
								<hr class="mt-3">
								<section class="tripmate-container">
								<h3 class="tm-title">나에게 온 트립메이트 신청</h3>
									<div class="tripmate-list-container">
										<table class="table table-hover" style="table-layout: fixed;">
											  <thead>
											    <tr>
											    	<th scpoe="col" style="width:50px;">num</th>
											      <th scope="col" style="width:150px;">user ID</th>
											      <th scope="col" style="width:50px; text-align:center;">accept</th>
											      <th scope="col" style="width:50px; text-align:center;">refuse</th>
											    </tr>
											  </thead>
											  <tbody>
											  	<c:if test="${empty receiveList}">
											  		<td style="text-align : center;" colspan="5">받은 트립메이트 신청이 없습니다.</td>
											  	</c:if>
											  	<c:if test="${receiveList!=''}">
											  		<c:forEach items="${receiveList}" var="receive" varStatus="vs">
												  		<td>${vs.index + 1}</td>
												  		<td><a href="#">${receive.tq_request_id }</a></td>
												  		<td style="text-align:center;">
											  				<a href="<%=request.getContextPath()%>/spot/${user.me_id}/tripmate/tripmateResponse?request_id=${receive.tq_request_id}&&response=true"><i class="fas fa-check"></i></a>
											  			</td>
											  			<td style="text-align:center;">
												  			<a href="<%=request.getContextPath()%>/spot/${user.me_id}/tripmate/tripmateResponse?request_id=${receive.tq_request_id}&&response=false"><i class="fas fa-times"></i></a>
												  		</td>
											  		</c:forEach>
											  	</c:if>
											  </tbody>
											</table>
									</div>
								</section>
							</div>
						</section>
						</div>
					</div>
			</div>
</body>
</html>