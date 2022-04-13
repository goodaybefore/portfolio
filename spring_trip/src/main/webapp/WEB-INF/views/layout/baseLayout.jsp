<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
		<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		<!-- 구글웹폰트 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">

		<script src="/resources/assets/js/spot/jquery.min.js"></script>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<!-- Header -->
							<tiles:insertAttribute name="header"/>
							<tiles:insertAttribute name="body"/>
						</div>
					</div>
					<!-- Sidebar -->
					<tiles:insertAttribute name="sidebar"/>
			</div>
  		
			<script src="/resources/assets/js/spot/browser.min.js"></script>
			<script src="/resources/assets/js/spot/breakpoints.min.js"></script>
			<script src="/resources/assets/js/spot/util.js"></script>
			<script src="/resources/assets/js/spot/main.js"></script>
		
	</body>
	
</html>
