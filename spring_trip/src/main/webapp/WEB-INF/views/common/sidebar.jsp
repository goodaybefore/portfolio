<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Sidebar -->
	<div id="sidebar">
		<div class="inner">
			<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<h2>My Menu</h2>
					<section id="search" class="alt">
						<form method="post" action="#">
							<input type="text" name="query" id="query" placeholder="Search" />
						</form>
					</section>
					</header>
					<ul>
						<p> 현재 로그인 유저 : ${user.me_id}<br> 현재 spot 주인 :  ${spot_user}</p>
						<li><a href="<%=request.getContextPath()%>/spot/home">my spot home</a></li>
						<li>
							<span class="opener">trip</span>
							<ul>
							<c:forEach items="${menu }" var="menu">
								<li><a href="<%=request.getContextPath()%>/spot/${spot_user}/tripList/${menu.sm_num}">${menu.sm_name}</a></li>
							</c:forEach>
							</ul>
						</li>
						<c:if test="${user.me_id != spot_user && user.me_id !=null && isTripmate == 'false'}">
							<li>
								<a href="javascript:void(0)" onclick="javascript:goTripmateRequest('${spot_user}')">request tripmate</a>
							</li>
						</c:if>
						<c:if test="${user.me_id == spot_user && user.me_id !=null}">
						<li>
							<span class="opener">Tripmate</span>
							<ul>
								<li><a href="<%=request.getContextPath()%>/spot/${user.me_id}/tripmate/tripmateRequest">request</a></li>
								<li><a href="<%=request.getContextPath()%>/spot/${user.me_id}/tripmate/tripmateList">my tripmates</a></li>
							</ul>
						
						</li>
						</c:if>
						<li>
							<span class="opener">trip info</span>
							<ul>
								<li><a href="<%=request.getContextPath()%>/board/list">notice</a></li>
								<li><a href="#">today's trip</a></li>
							</ul>
						</li>
						<li><a href="<%=request.getContextPath()%>/mypage">my page</a></li>
					</ul>
				</nav>
			</div>
		</div>
		<script>
		
		function goTripmateRequest(spot_user){
			let newForm = $('<form></form>')
			//let spot_user = '${spot_user}';
			
			let url = getContextPath()+'/'+spot_user+'/tripmate/sendTripmateRequest';
			console.log('url : '+url);
			
			newForm.attr('method', 'post');
			newForm.attr('action', url);
			newForm.append($('<input type="hidden" name="spot_user" value="'+spot_user+'"/>'));
			newForm.appendTo('.opener');
			document.charset = 'UTF-8';
			console.log('newForm : '+newForm.html());
			newForm.submit();
		}
		
		
		function getContextPath(){
			var hostIndex = location.href.indexOf(location.host) + location.host.length;
			var contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
			return contextPath;
		}
		</script>
</body>
</html>