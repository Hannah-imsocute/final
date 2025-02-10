<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="inputs-cover">
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="eventName" class="col-form-label">이벤트명 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="eventName" name="eventName" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="daypoint" class="col-form-label">일일 적립 포인트를 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="daypoint" name="daypoint" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="weeklypoint" class="col-form-label">7일연속 출석 적립 포인트를 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="weeklypoint" name="weeklypoint" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="monthlypoint" class="col-form-label">한달 연속 출석 적립 포인트를 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="monthlypoint" name="monthlypoint" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponStart" class="col-form-label">시작일</label>
		</div>
		<div class="col-auto">
			<input type="date" id="eventStart" name="eventStart" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponEnd" class="col-form-label">종료일</label>
		</div>
		<div class="col-auto">
			<input type="date" id="eventEnd" name="eventEnd" class="form-control">
		</div>
	</div>

</div>