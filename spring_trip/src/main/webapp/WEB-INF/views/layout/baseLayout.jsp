<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<html>
		<head>
		<title>my trip</title>
		<link rel="stylesheet" href="/resources/assets/css/myspot/main.css" />
		<style>
		</style>
		</head>
	<body class="is-preload">
    <tiles:insertAttribute name="header" />
    <tiles:insertAttribute name="body" />
    <tiles:insertAttribute name="sidebar" />
    <tiles:insertAttribute name="footer" />
	</body>
	<script src="/resources/assets/js/spot/jquery.min.js"></script>
	<script src="/resources/assets/js/spot/browser.min.js"></script>
	<script src="/resources/assets/js/spot/breakpoints.min.js"></script>
	<script src="/resources/assets/js/spot/util.js"></script>
	<script src="/resources/assets/js/spot/main.js"></script>
</html>
