<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<div class="inputs-cover">
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="eventSubject" class="col-form-label">이벤트명 입력해주세요</label>
		</div>
		<div class="col-auto">
			<input type="text" id="eventSubject" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto" >
			<label for="eventContent" class="col-form-label">컨텐츠를 입력해주세요</label>
		</div>
		<div class="col-auto">
			<textarea id="eventContent" class="form-control"></textarea>
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="eventStart" class="col-form-label">시작일</label>
		</div>
		<div class="col-auto">
			<input type="date" id="eventStart" class="form-control">
		</div>
	</div>
	<div class="row g-3 align-items-center eachinput">
		<div class="col-auto">
			<label for="eventEnd" class="col-form-label">종료일</label>
		</div>
		<div class="col-auto">
			<input type="date" id="eventEnd" class="form-control">
		</div>
	</div>
</div>
