<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>TRIPMATE LIST</title>
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
													<th>num</th>
													<th>id</th>
													<th>user spot home </th>
												</tr>
											</thead>
											<tbody>
												<td style="text-align : center;" colspan="3">보낸 트립메이트 신청이 없습니다.</td>
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
											      <th scope="col" style="width:200px;" class="">user spot home</th>
											    </tr>
											  </thead>
											  <tbody>
											  	<td style="text-align : center;" colspan="3">받은 트립메이트 신청이 없습니다.</td>
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