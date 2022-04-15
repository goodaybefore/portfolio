<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>menu view</title>
	</head>
	<style>
	.menu-list-box{
		margin : 10px;
	}
	</style>
<body>
	<div class="menu-list-box">
		<c:forEach items="${menuList }" var="menuList">
		<p>${menuList.sm_name }</p>
		</c:forEach>
	</div>
</body>
</html>