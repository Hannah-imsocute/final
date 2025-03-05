<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>
	<jsp:include page="/WEB-INF/views/layout/sellerimported.jsp"/>


<style type="text/css">
.body-container {
	max-width: 1200px;
}
</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/sellerheader.jsp"/>
</header>

<main>
	<jsp:include page="/WEB-INF/views/layout/sellerside.jsp"/>

	<div class="wrapper">
		<div class="body-container">
		    <div class="body-title">
				<h3><i class="bi bi-calculator"></i> 판매 현황 </h3>
		    </div>
		    
		    <div class="body-main">

		    	<div class="row g-1 mt-1 p-1">
					<div class="col-4 p-2">
						<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 오늘 판매 현황</div>
						<div class="border rounded p-5 text-center">
							<div class="fs-5 mb-2">총 판매 건수 : 
								<span class="product-totalAmount fw-semibold text-primary">${today.COUNT}</span>
							</div>
							<div class="fs-5">총 판매 금액 : 
								<span class="product-totalAmount fw-semibold text-danger"><fmt:formatNumber value="${today.TOTAL}"/></span>원
							</div>
						</div>
					</div>
					
					<div class="col-4 p-2">
						<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 이번달 판매 현황</div>
						<div class="border rounded p-5 text-center">
							<div class="fs-5 mb-2">총 판매 건수 : 
								<span class="product-totalAmount fw-semibold text-primary">${thisMonth.COUNT}</span>
							</div>
							<div class="fs-5">총 판매 금액 : 
								<span class="product-totalAmount fw-semibold text-danger"><fmt:formatNumber value="${thisMonth.TOTAL}"/></span>원
							</div>
						</div>
					</div>
		    	
					<div class="col-4 p-2">
						<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 전월 판매 현황</div>
						<div class="border rounded p-5 text-center">
							<div class="fs-5 mb-2">총 판매 건수 : 
								<span class="product-totalAmount fw-semibold text-primary">${previousMonth.COUNT}</span>
							</div>
							<div class="fs-5">총 판매 금액 : 
								<span class="product-totalAmount fw-semibold text-danger"><fmt:formatNumber value="${previousMonth.TOTAL}"/></span>원
							</div>
						</div>
					</div>
		    	</div>
		    
				<div class="row mt-3 p-1">
					<div class="col-4 p-2">
						<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 최근 1주일 판매 현황</div>
						<div class="charts-day border rounded" style="height: 430px; width: 100%;"></div>
					</div>
					<div class="col-4 p-2">
						<div class="fs-6 fw-semibold mb-2 "><i class="bi bi-chevron-right"></i> <label class="charts-dayOfWeek-title">전월 요일별 판매건수</label></div>
						<div class="charts-dayOfWeek border rounded" style="height: 430px; width: 100%;"></div>
					</div>
					<div class="col-4 p-2">
						<div class="fs-6 fw-semibold mb-2"><i class="bi bi-chevron-right"></i> 최근 6개월 판매 현황</div>
						<div class="charts-month border rounded" style="height: 430px; width: 100%;"></div>
					</div>
				</div>

			</div>
		</div>		
	</div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>

<script type="text/javascript">
$(function(){
	let url = '${pageContext.request.contextPath}/artist/charts';
	
	$.getJSON(url, function(data){
		console.log(data);
		chartsDay(data);
		chartsDayOfWeek(data);
		chartsMonth(data);
	});
	
	function chartsDay(data) {

		let chartData = [];
		
		for(let item of data.days){
			let s = parseInt(item.ORDERDATE.substring(5,7)) + '월 ' + parseInt(item.ORDERDATE.substring(8)) + '일';
			let obj = {value : item.TOTALMONEY, name : s}
			chartData.push(obj);
		}

		var chartDom = document.querySelector('.charts-day');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  legend: {
		    top: '5%',
		    left: 'center'
		  },
		  series: [
		    {
		      name: '일일 판매 현황',
		      type: 'pie',
		      radius: ['40%', '70%'],
		      avoidLabelOverlap: false,
		      itemStyle: {
		        borderRadius: 10,
		        borderColor: '#fff',
		        borderWidth: 2
		      },
		      label: {
		        show: false,
		        position: 'center'
		      },
		      emphasis: {
		        label: {
		          show: true,
		          fontSize: 40,
		          fontWeight: 'bold'
		        }
		      },
		      labelLine: {
		        show: false
		      },
		      data: chartData
		    }
		  ]
		};

		option && myChart.setOption(option);

	}
	
	function chartsDayOfWeek(data) {
		
		let datas = [];		
		datas.push(data.dayOfWeek.SUN);
		datas.push(data.dayOfWeek.MON);
		datas.push(data.dayOfWeek.TUE);
		datas.push(data.dayOfWeek.WED);
		datas.push(data.dayOfWeek.THU);
		datas.push(data.dayOfWeek.FRI);
		datas.push(data.dayOfWeek.SAT);
		
		
		// 만약 2월 1일 이면 전월 데이터가 출력됨 앞에 데이터가 없으니까 
		
		// new Date 의 month 는 0 - 11 
		let m = new Date().getMonth() + 1;
		let m2 = parseInt(data.dayOfWeek.month.substring(4));
		
		// 현재 달과 데이터상의 월이 동일한지 확인 
		let title = (m !== m2) ? '전월 요일별 판매건수':'이번달 요일별 판매건수';
		
		document.querySelector('.charts-dayOfWeek-title').innerText = title;
		
		var chartDom = document.querySelector('.charts-dayOfWeek');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  xAxis: {
		    type: 'category',
		    data: ['일', '월', '화', '수', '목', '금', '토']
		  },
		  yAxis: {
		    type: 'value'
		  },
		  series: [
		    {
		      data: datas,
		      type: 'bar'
		    }
		  ]
		};

		option && myChart.setOption(option);

	}
	
	function chartsMonth(data) {

		let chartData = [];
		
		for(let el of data.months){
			let s = parseInt(el.ORDERDATE.substring(4)) + '월';
			let obj  = {value : el.TOTALMONEY, name : s };
			chartData.push(obj);
		}
		
		var chartDom = document.querySelector('.charts-month');
		var myChart = echarts.init(chartDom);
		var option;

		option = {
		  tooltip: {
		    trigger: 'item'
		  },
		  legend: {
		    top: '5%',
		    left: 'center'
		  },
		  series: [
		    {
		      name: '월별 판매 현황',
		      type: 'pie',
		      radius: ['40%', '70%'],
		      avoidLabelOverlap: false,
		      itemStyle: {
		        borderRadius: 10,
		        borderColor: '#fff',
		        borderWidth: 2
		      },
		      label: {
		        show: false,
		        position: 'center'
		      },
		      emphasis: {
		        label: {
		          show: true,
		          fontSize: 40,
		          fontWeight: 'bold'
		        }
		      },
		      labelLine: {
		        show: false
		      },
		      data: chartData
		    }
		  ]
		};

		option && myChart.setOption(option);

	}
});
</script>


</body>
</html>