<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<style>
		.trip-reg-box{
			padding : 10px;
			min-width : 600px;
		}
		.open-range, #isOneday{
			appearance: auto !important;
			opacity:1 !important;
			margin-right: 0px !important;
			display : inline-block !important;
			margin-right : 0px !important;
		}
		.detail-label{
			margin-right : 10px;
			height : auto !important;
			padding : 0px ! important;
		}
		.detail-container{
			margin-bottom : 10px;
		}
		.period-container, .area-container, .open-range-container, .file-container, .with-container{
			display : flex;
			margin-bottom : 0px !important;
			padding : 0px !important;
		}
		.period-container, .area-container, .open-range-container{
			margin-bottom : 5px !important;
		}
		.title-container{
			border : 1px solid gray;
		}
		.with-container{
			margin-top : 10px;
		}
		.file-container{
			margin-top : 10px;
			margin-bottom : 10px;
		}
		.btn-primary, .btn-primary.disabled, .btn-primary:disabled{
			background-color : white !important;
			border-color : white !important;
		}
		.daterangepicker td.active, .daterangepicker td.active:hover{
			background-color : #f56a6a !important;
		}
		
		.area-select-box{
			flex : 2;
			min-width : 200px;
			width : 200px !important;
		}
		.tr-dates{
			display : inline-block !important;
		} 
		</style>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<!-- Banner -->
							<section id="banner">
								<div class="content">
									<header>
										<h1>Detail</h1>
										<p>여행 정보 상세 + 활동정보 관리</p>
										pm : ${pm }
									</header>
									<div class="trip-detail">
											<c:if test="${trip.tr_me_id == user.me_id}">
												<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripModify?tr_num=${trip.tr_num}" style="border-bottom : none;"><button>modify</button></a>
												<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripDelete?tr_num=${trip.tr_num}" style="border-bottom : none;"><button>delete</button></a>
											</c:if>
											<input type="button" onclick="openChild()" value="test link">
											<input type="hidden" id="tr_num" name="tr_num" value="${trip.tr_num }">
											<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripCopy?tr_num=${trip.tr_num}" style="border-bottom : none;"><button>Copy</button></a>
										<div class="trip-reg-box detail-container">
											<!-- 여행기간 -->
											<div class="period-container">
												<label class="detail-label">여행기간</label>
												<c:if test="${trip.tr_start_date_str == trip.tr_end_date_str}">
													<p class="start-date">${trip.tr_start_date_str}</p><p class="oneday-str" style="">(당일치기)</p>
												</c:if>
												<c:if test="${trip.tr_start_date_str != trip.tr_end_date_str}">
													<p class="tr-dates start-date">${trip.tr_start_date_str}</p> ~ <p class="tr-dates end-date">${trip.tr_end_date_str}</p><p class="tr-dates trip-period"></p>
												</c:if>
												</div>
											<div class="area-container">
												<label class="detail-label">지역</label>
												<p>${trip.tr_mca_name }</p>
												<p>${trip.tr_sca_name }</p>
											</div>
											<div class="open-range-container">
												<label class="detail-label">공개범위</label>
												<p>${trip.tr_op_name}</p>
											</div>
											<div class="with-container">
												<label class="detail-label">함께한 사람들</label>
												<p>${trip.tr_with}</p>
											</div>
											<div class="file-container">
												<label class="detail-label">첨부파일</label>
												<c:if test="${fileList==null || fileList.size()==0}">
													<p>첨부파일 없음</p>
												</c:if>
												<c:if test="${fileList != null && fileList.size() > 0 }">
													<c:forEach items="${fileList}" var="file">
														<a href="<%=request.getContextPath()%>/spot/download?fileName=${file.fi_name}">${file.fi_ori_name}</a>
													</c:forEach>
												</c:if>
											</div>
										</div>
											<table class="table table-hover" style="table-layout: fixed;">
											  <thead>
											    <tr>
											      <th scope="col" style="width:50px;">num</th>
											      <th scope="col" class="col-12 " style="min-width:200px;">activity title</th>
											      <th scope="col" class="text-center" style="width:150px;">date</th>
											      <th scope="col" class="text-center" style="width:100px;">sort</th>
											      <th scope="col" class="text-center" style="width:120px;">공개범2위</th>
											    </tr>
											  </thead>
											  <tbody>
											  	<c:forEach items="${actList}" var="actList">
											  	<tr>
											  		<td>${actList.ac_num}</td>
											  		<td style="text-overflow: ellipsis; overflow:hidden">
											  			<a href="<%=request.getContextPath()%>/spot/${spot_user}/activityDetail/${trip.tr_sm_num}/${trip.tr_num}/${actList.ac_num}">${actList.ac_title}</a>
											  		</td>
											  		<td>${actList.ac_start_date_str} ~ ${actList.ac_end_date_str }</td>
											  		<td>${actList.ac_mca_name}</td>
											  		<td>${actList.ac_op_name }</td>
											  	</tr>
											  	</c:forEach>
											  </tbody>
											</table>
											<div style="display : flex; justify-content : center;">
											<!-- pagination -->
											<ul class="pagination" style="">
												<li>
													<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripDetail/${trip.tr_sm_num }/${trip.tr_num}?page=${pm.startPage-1}" class="<c:if test="${!pm.prev}">disabled</c:if>">Prev</a>
												</li>
												<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
													<li>
														<a href="<%=request.getContextPath()%>/spot/${spot_user}/tripDetail/${trip.tr_sm_num }/${trip.tr_num}?page=${i}" class="page <c:if test="${pm.criteria.page==i}">active</c:if>">${i}</a>
													</li>
												</c:forEach>
													<li><a href="<%=request.getContextPath()%>/spot/${spot_user}/tripDetail/${trip.tr_sm_num }/${trip.tr_num}?page=${pm.endPage+1}" class="<c:if test="${!pm.next}">disabled</c:if>">Next</a></li>
											</ul>
										</div>
										<a href="<%=request.getContextPath()%>/spot/${spot_user}/activityReg?tr_num=${trip.tr_num}" style="border-bottom : none;"><button>add activity</button></a>
									</div>
								</div>
								<span>span 태그 테스트</span>
							</section>
					
					</div>
				</div>
			</div>
		
	<script src="/resources/assets/js/spot/tripDetail.js"></script>
	<script>
		function openChild(){
			window.name = "select My Menu";
			window.open('selectMenuCategory','window_name','width=600 height=300, location=no, scrollbars=no');
			
		}
	</script>
	</body>
</html>