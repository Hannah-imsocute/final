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
	            <div id="ageChartContainer" style="height: 100%;"></div> <!-- 차트 컨테이너로 높이 100% -->
	        </div>
	    </div>
	
	    <!-- 활성/비활성 회원 차트 -->
	    <div id="activeChart" class="col-md-6">
	        <div class="card p-3" style="height: 400px;">
	            <div id="activeChartContainer" style="height: 100%;"></div> <!-- 차트 컨테이너로 높이 100% -->
	        </div>
	    </div>
	</div>

	<!-- 3. 매출 및 인기 상품 -->
	<div class="row g-3 mt-4">
		<div class="col-md-6">
			<div class="card p-3">
				<h5 class="text-center">일별 매출 변화</h5>
				<canvas id="salesChart"></canvas>
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
		// 연령대 별 비율
		Highcharts.chart('ageChartContainer', {
		    chart: {
		        type: 'column'
		    },
		    title: {
		        text: '회원 연령대별 비율' // 차트 제목
		    },
		    xAxis: {
		        categories: ['10대', '20대', '30대', '40대', '50대', '60대이상'], // x 축 컬럼
		        accessibility: {
		            description: 'age'
		        }
		    },
		    yAxis: {
		        min: 0, // 시작 값
		        max: 100, // 끝 값
		        tickInterval: 10, // y축 값 간격
		        title: {
		            text: '비율 (%)' // y축 제목
		        }
		    },
		    tooltip: {
		        valueSuffix: '%' // 마우스 호버 팝업 박스에 표시되는 
		    },
		    plotOptions: {
		        column: {
		            pointPadding: 0.0, // 바 사이 간격
		            borderWidth: 0 // 바 테두리
		        }
		    },
		    series: [
		        {
		            name: '연령대',
		            colors: ['#FFBB00'],
		            colorByPoint: true, 
		            data: (function() {
		                let totalMembers = 100;  // 100은 임의 값. 전체 회원 수 (memberMangeMapper = Countdata 쿼리 사용)
		                let ageData = [10, 20, 40, 10, 10, 10];  // 각 연령대별 회원 수 (예시)
		                
		                // 비율 계산식 :  각 연령대의 비율 = (회원 수 / 전체 회원 수) * total회원 수
		                return ageData.map(function(count) {
		                    return (count / totalMembers) * 100;
		                });
		            })()  // 비율로 변환된 데이터를 반환
		        },
		    ],
		});
		
		// 활성/비활성화 회원 비율
		Highcharts.chart('activeChartContainer', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45
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
		            { name: '활성 회원', y: 16 },
		            { name: '비활성 회원', y: 12 }
		        ]
		    }]
		});

        // 일별 매출 변화 차트
        new Chart(document.getElementById("salesChart"), {
            type: 'line',
            data: {
                labels: ["1일", "2일", "3일", "4일", "5일", "6일", "7일"],
                datasets: [{
                    label: "매출(₩)",
                    borderColor: "#36a2eb",
                    fill: false,
                    data: [500000, 750000, 800000, 650000, 900000, 1100000, 950000]
                }]
            }
        });
    </script>


