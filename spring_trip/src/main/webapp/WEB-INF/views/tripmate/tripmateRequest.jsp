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
									<h1>TRIPMATE LIST</h1>
									<p>트립메이트 리스트</p>
								</header>
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
										  <c:forEach items="${mateList }" var="mateList">
										  	<tr>
										  		 <td>${mateList.tm_num }</td>
										  		 <td>${mateList.tm_mate_id }</td>
										  		 <td><a href="#">spot home</a></td>
										  	</tr>
										  </c:forEach>
										  </tbody>
										</table>
								</div>
							</div>
						</section>
						</div>
					</div>
			</div>
</body>
</html>