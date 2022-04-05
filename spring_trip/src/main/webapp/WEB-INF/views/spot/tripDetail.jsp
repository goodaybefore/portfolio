<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>my spot home</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<!-- IMPORT 결제시스템 -->
		<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
		
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
											<c:if test="${user.me_gr_name !='트립매니저'||user.me_gr_name !='트립파트너' || user.me_gr_name !='트립서포터'}">
												<input type="button" class="btn-purchase" id="check_module" value="purchase"/>
												<div class="purchase-container"></div>
												<input type="button" class="btn-purchase-copy" style="display:none;" onclick="openChild()" value="purchase copy">
											</c:if>
											<c:if test="${trip.tr_me_id != user.me_id}">
												<input type="button" class="btn-copy" onclick="openChild()" value="copy">
											</c:if>
											
											<input type="hidden" id="tr_num" name="tr_num" value="${trip.tr_num }">
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
								<span>span 태그 테스트</span>$
							</section>
					
					</div>
				</div>
			</div>
		
	<script src="/resources/assets/js/spot/tripDetail.js"></script>
	<script>
		$(function(){
			//IMPORT 결제
			var tr_num = '${trip.tr_num}';
			var userId = '${user.me_id}';
			var isSuccess = false; 
			$('#check_module').click(function(){
				IMP.init('imp19089190');

				IMP.request_pay({
				    pg : 'inicis', // version 1.1.0부터 지원.
				    pay_method : 'card',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : '결제한 여행 번호 : ${trip.tr_num}',
				    amount : 100, //판매 가격
				    buyer_name : '${user.me_id}',
				    buyer_tel : '${user.me_phone}'
				}, function(rsp) {
					 	//charge_trip 테이블에 결제내역 추가하기(확인)
					 	var chargeRecords = {
					 			ch_amount : '${trip.tr_charge}',
					 			ch_tr_num : tr_num
					 	}
					 	
		        $.ajax({
		        	async : false,
		        	type : 'post',
		        	data : JSON.stringify(chargeRecords),
		        	url : '<%=request.getContextPath()%>/spot/'+userId+'/chargeRecord',
		        	dataType : "json",
		        	contentType:"application/json; charset=UTF-8",
		        	success : function(res){
		        		
		        		console.log('결제내역 추가 동작');
		        		console.log('result : '+res.result);
		        		if(res.result == 'failed'){
		        			alert('잘못된 결제 접근입니다. 결제를 다시 시도해주세요.')
		        			return ;
		        		}
		        	}
		        	
		        });
				    if ( rsp.success ) {
				        console.log(rsp);
				     	 	//copy_sm_num 선택할 수 있는 창 띄우기
				      	isSuccess = true;
				        /*
				        result : tripNull => trip이 비어있음
				        result : smnumNull => 복사할 sm_num이 비어있음 => 다시 선택하도록
				        ****결제한 trip에 대해서는 결제버튼이 뜨지 않도록 하기 => 대신 copy버튼만 뜨게하기 => Detail.get에서 수정
				        */
				        alert('결제 성공');
				        openChild();
				        
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        msg += '에러내용 : ' + rsp.error_msg;
				        alert(msg);
				    }
				});
				
				
			});
			
			
			
		});
		var win = window;
		var ok = false;
		function openChild(){
			window.name = "select My Menu";
			window.open('selectMenuCategory','window_name','width=600 height=300, location=no, scrollbars=no');
			
		}
	</script>
	</body>
</html>