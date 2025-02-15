<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="card shadow-lg p-4">
    <h4 class="text-center mb-4">출석 이벤트 등록</h4>
    <div class="inputs-cover">
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="daypoint" class="col-form-label fw-bold">일일 적립 포인트</label>
            </div>
            <div class="col-md-8">
                <input type="number" id="daypoint" name="daybyday" class="form-control form-control-lg" placeholder="포인트를 입력하세요">
            </div>
        </div>
        
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="weeklypoint" class="col-form-label fw-bold">7일 연속 출석 포인트</label>
            </div>
            <div class="col-md-8">
                <input type="number" id="weeklypoint" name="weekly" class="form-control form-control-lg" placeholder="포인트를 입력하세요">
            </div>
        </div>

        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="monthlypoint" class="col-form-label fw-bold">한달 연속 출석 포인트</label>
            </div>
            <div class="col-md-8">
                <input type="number" id="monthlypoint" name="monthly" class="form-control form-control-lg" placeholder="포인트를 입력하세요">
            </div>
        </div>
    </div>
</div>
<input type="hidden" value="checkin" name="eventType">