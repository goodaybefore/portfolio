<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TRIPMATE LIST</title>
</head>
<body>
	<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<section id="banner">
							<div class="content">
								<header>
									<h1>TRIPMATE Request</h1>
									<p>트립메이트 신청</p>
								</header>
								<section>
								<h3>내가 보낸 트립메이트 신청</h3>
									<div class="tripmate-receive-container">
										<table class="table table-hover" style="table-layout: fixed">
											<thead>
												<tr>
													<th>num</th>
													<th>id</th>
													<th>user spot home</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</section>
								
								<section>
								<h3>나에게 온 트립메이트 신청</h3>
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