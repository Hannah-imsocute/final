<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="card shadow-lg p-4">
    <h4 class="text-center mb-4">쿠폰 등록</h4>
    <div class="inputs-cover">
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="couponName" class="col-form-label fw-bold">쿠폰명</label>
            </div>
            <div class="col-md-8">
                <input type="text" id="couponname" name="couponname" class="form-control form-control-lg" placeholder="쿠폰명을 입력하세요">
            </div>
        </div>
        
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="couponRate" class="col-form-label fw-bold">할인율 (%)</label>
            </div>
            <div class="col-md-8">
                <input type="number" id="couponRate" name="rate" class="form-control form-control-lg" placeholder="할인율을 입력하세요">
            </div>
        </div>
        
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="couponStart" class="col-form-label fw-bold">발급 시작일</label>
            </div>
            <div class="col-md-8">
                <input type="date" id="couponStart" name="couponstart" class="form-control form-control-lg">
            </div>
        </div>
        
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="couponEnd" class="col-form-label fw-bold">발급 종료일</label>
            </div>
            <div class="col-md-8">
                <input type="date" id="couponEnd" name="expiredate" class="form-control form-control-lg">
            </div>
        </div>
        
        <div class="row g-3 align-items-center eachinput mb-3">
            <div class="col-md-4 text-end">
                <label for="couponValid" class="col-form-label fw-bold">유효기간 (일)</label>
            </div>
            <div class="col-md-8">
                <input type="number" id="couponValid" name="valid" class="form-control form-control-lg" placeholder="유효기간을 입력하세요">
            </div>
        </div>
    </div>
</div>
<input type="hidden" value="coupon" name="eventType">
