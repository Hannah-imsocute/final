package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ApplyManageMapper;
import com.sp.app.admin.model.ApplyManage;
import com.sp.app.mail.Mail;
import com.sp.app.mail.MailSender;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApplyManageServiceImpl implements ApplyManageService {
	private final ApplyManageMapper mapper;
	private final MailSender mailSender;

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<ApplyManage> listApply(Map<String, Object> map) {
		List<ApplyManage> list = null;
		
		try {
			list = mapper.listApply(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;
	}

	@Override
	@Transactional
	public void insertApply(ApplyManage dto) throws Exception {
		try {
			mapper.insertApply(dto);
		} catch (Exception e) {
			log.info("insertApply : ", e);
			
			throw e;
		}
		
	}
	@Override
	@Transactional
	public void updateApply(Map<String, Object> map) throws Exception {
	    try {
	        // DB에서 승인 여부 업데이트
	        mapper.updateApply(map);

	        // 이메일과 이름을 받아오기
	        String sellerEmail = (String) map.get("email");
	        String sellerName = (String) map.get("name");

	        // 메일 내용과 제목 설정
	        String content = "";
	        String subject = "";

	        // 승인 여부 가져오기
	        String agreed = (String) map.get("agreed");
	        String rejectionReason = (String) map.get("rejectionReason");

	        if ("0".equals(agreed)) {  // 승인 처리
	            content = "안녕하세요, " + sellerName + "님.\n\n"
	                    + "귀하의 입점 신청이 승인되었습니다.\n"
	                    + "빠른 시일 내에 안내드리겠습니다.\n\n"
	                    + "감사합니다.";
	            subject = "입점 신청 승인";
	            
	        } else if ("1".equals(agreed)) {  // 거절 처리
	            content = "안녕하세요, " + sellerName + "님.\n\n"
	                    + "귀하의 입점 신청이 거절되었습니다.\n";
	            if (rejectionReason != null && !rejectionReason.isEmpty()) {
	                content += "반려 사유: " + rejectionReason + "\n";
	            }
	            content += "다음 기회에 다시 신청해 주시기 바랍니다.\n\n"
	                    + "감사합니다.";
	            subject = "입점 신청 거절";
	        }

	        // 메일 객체 생성
	        Mail mail = new Mail();
	        mail.setReceiverEmail(sellerEmail);
	        mail.setSenderEmail("sksksukk@gmail.com");  // 발신 이메일
	        mail.setSenderName("관리자"); // 발신자 이름
	        mail.setSubject(subject);
	        mail.setContent(content);

	        // 이메일 전송
	        boolean result = mailSender.mailSend(mail); // 메일 전송
	        if (!result) {
	            throw new Exception("이메일 전송에 실패했습니다.");
	        }

	    } catch (Exception e) {
	        log.error("updateApply 처리 중 오류 발생: ", e);
	        throw e; // 예외를 다시 던져서 트랜잭션이 롤백되게 합니다.
	    }
	}

	@Override
	public void updateSeller(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSeller(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ApplyManage getSellerDetailsBySellerApplyNum(Long sellerApplyNum) {
		
		return mapper.getSellerDetailsBySellerApplyNum(sellerApplyNum);
	}

}
