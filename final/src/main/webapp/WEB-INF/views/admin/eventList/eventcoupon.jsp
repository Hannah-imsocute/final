<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="inputs-cover">
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponName" class="col-form-label">쿠폰명 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="couponName" name="couponName" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponRate" class="col-form-label">쿠폰 할인율을 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="couponRate" name="couponRate" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponStart" class="col-form-label">발급시작일</label>
		</div>
		<div class="col-auto">
			<input type="date" id="couponStart" name="couponStart" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponEnd" class="col-form-label">발급종료일</label>
		</div>
		<div class="col-auto">
			<input type="date" id="couponEnd" name="couponEnd" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="couponValid" class="col-form-label">유효기간</label>
		</div>
		<div class="col-auto">
			<input type="text" id="couponValid" name="couponValid" class="form-control" >
		</div>
	</div>
</div>