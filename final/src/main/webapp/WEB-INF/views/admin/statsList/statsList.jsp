<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<div class="container-fluid w-75 p-2 ms-0">
	<!-- 1. 상단 요약 카드 -->
	<div class="row g-3">
		<div class="col-md-3">
			<div class="card text-center p-3">
				<h6>총 회원 수</h6>
				<h4>1,234명</h4>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card text-center p-3">
				<h6>신규 가입</h6>
				<h4>120명</h4>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card text-center p-3">
				<h6>총 매출</h6>
				<h4>￦12,345,678</h4>
			</div>
		</div>
		<div class="col-md-3">
			<div class="card text-center p-3">
				<h6>총 거래 수</h6>
				<h4>567건</h4>
			</div>
		</div>
	</div>

	<!-- 회원 연령별 비율 -->
	<div class="row g-3 mt-4">
		<div id="ageChart" class="col-md-6">
			<div class="card p-3" style="height: 400px;">
				<div id="ageChartContainer" style="height: 100%;"></div>
			</div>
		</div>

		<!-- 활성/비활성 회원 차트 -->
		<div id="activeChart" class="col-md-6">
			<div class="card p-3" style="height: 400px;">
				<div id="activeChartContainer" style="height: 100%;"></div>
				<!-- 차트 컨테이너로 높이 100% -->
			</div>
		</div>
	</div>

	<!-- 3. 매출 및 인기 상품 -->
	<div class="row g-3 mt-4">
		<div id="salesChart" class="col-md-6">
			<div class="card p-3" style="height: 350px;">
				<div id="salesChartContainer" style="height: 100%;"></div>
			</div>
		</div>

		<div class="col-md-6">
			<div class="card p-3">
				<h5 class="text-center">인기 상품 TOP 5</h5>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>상품명</th>
							<th>판매량</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>상품 A</td>
							<td>320개</td>
						</tr>
						<tr>
							<td>2</td>
							<td>상품 B</td>
							<td>290개</td>
						</tr>
						<tr>
							<td>3</td>
							<td>상품 C</td>
							<td>250개</td>
						</tr>
						<tr>
							<td>4</td>
							<td>상품 D</td>
							<td>210개</td>
						</tr>
						<tr>
							<td>5</td>
							<td>상품 E</td>
							<td>180개</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

$(document).ready(function() {
    memberAnalysis();
});

function memberAnalysis() {
    let url = '${pageContext.request.contextPath}/admin/statsList/memberAgeSection';
    $.getJSON(url, function(data){
        let titles = [];
        let values = [];

        for(let item of data.list) {
            let section = item.SECTION || "기타"; // null 방지
            let count = item.COUNT || 0; // null 방지

            titles.push(section);
            values.push(count);
        }

        console.log(titles, values);  // 데이터 확인

        Highcharts.chart('ageChartContainer', {
            title:{
                text : '연령대별 회원수'
            },
            xAxis : {
                categories: titles
            },
            yAxis : {
                title:{
                    text:'인원(명)'
                }
            },
            series:[{
                type: 'column',
                colorByPoint: true,
                name: '인원수',
                data: values,
                showInLegend: false
            }],
            // 차트 클릭시 권한 관리로 이동
            chart: {
            	events: {
            		click: function() {
            			let url = '/admin/authList'
            			window.location.href = url;
            		}
            	}
            }
        });
    });
}

$(document).ready(function() {
	memberStatus();
});

function memberStatus() {
	let url = '${pageContext.request.contextPath}/admin/statsList/memberStatus'
	$.getJSON(url, function(data) {
		let block = 0; // 비활성
		let unblock = 0; // 활성
		
		// 데이터 처리
		for (let item of data.list) {
			if (item.STATUS === '활성') {
				unblock = item.COUNT;
			} else if (item.STATUS === '비활성') {
				block = item.COUNT;
			}
		}
		
    // 활성/비활성화 회원 비율 차트
    Highcharts.chart('activeChartContainer', {
        chart: { 
        	type: 'pie', 
        	options3d: { enabled: true, alpha: 45 },
	        events: {
	            click: function() {
	                let url = '/admin/authList';
	                window.location.href = url;  // 클릭 시 이동
	            }
	        }
	    },
        title: {
        	text: '활성/비활성화 회원 비율' 
        },
        plotOptions: {
        	pie: { 
        		innerSize: 100, 
        		depth: 45 
        	} 
        },
        series: [{
            name: '활성/비활성화',
            data: [
	            	{ name: '활성 회원', y: unblock }, 
	            	{ name: '비활성 회원', y: block }
            	]
        	}]
    	});
	});
}

    // 일별 매출 차트
    Highcharts.chart('salesChartContainer', {
        chart: { type: 'line' },
        title: { text: '일별 매출' },
        xAxis: { categories: ['1일', '2일', '3일', '4일', '5일'] },
        yAxis: { title: { text: '매출' } },
        series: [{ name: '매출', data: [500, 700, 650, 800, 900] }]
    });

</script>



