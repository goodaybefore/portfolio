<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
		.icons{
			padding-right:50px !important;
		}
		.logo{
			padding-left : 50px !important;
		}
		.header-logo{
			list-style : none;
			padding-left : 0px !important;
			
		}
		.header-logo-li{
			float : left !important;
			margin-right : 30px;
		}
		</style>
	</head>
	<body>
		<!-- Header -->
		<header id="header">
			
			<ul class="header-logo">
				<li class="header-logo-li">my Trip Spot</li>
				<li class="header-logo-li"><a href="<%=request.getContextPath()%>/spot/${spot_user}/home">${spot_user }</a></li>
			</ul>
			<ul class="icons">
				<c:if test="${user==null}"><li><a href="<%=request.getContextPath()%>/" class=""><span class="label">login</span></a></li></c:if>
				<c:if test="${user!=null}"><li><a href="<%=request.getContextPath()%>/logout" class=""><span class="label">logout</span></a></li></c:if>
				<li><a href="#" class=""><span class="label">tripmate</span></a></li>
				<li><a href="#" class=""><span class="label">notice</span></a></li>
				<li><a href="#" class=""><span class="label">event</span></a></li>
				<li><a href="#" class=""><span class="label">special</span></a></li>
			</ul>
		</header>
	</body>
</html>