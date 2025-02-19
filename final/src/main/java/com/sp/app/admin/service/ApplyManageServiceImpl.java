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
	        mapper.updateApply(map);

	        String sellerEmail = (String) map.get("email");
	        String sellerName = (String) map.get("name");
	        String agreed = (String) map.get("agreed");
	        String rejectionReason = (String) map.get("rejectionReason");

	        String content = "";
	        String subject = "";

	        if ("0".equals(agreed)) {  // 승인
	            content = "<br><br>안녕하세요, " + sellerName + "님.<br><br>"
	                    + "귀하의 입점 신청이 승인되었습니다.<br>"
	                    + "로그인하시어 작가님의 꿈을 마음껏 펼치시길 바라겠습니다.<br><br>"
	                    + "감사합니다.<br><br>"
	                    + "- 뚝딱뚝딱 드림 -";
	            subject = "뚝딱뚝딱 " + sellerName + "님 입점 신청 승인";
	            
	        } else if ("1".equals(agreed)) {  // 반려
	            content = "안녕하세요, " + sellerName + "님.<br><br>"
	                    + "귀하의 입점 신청이 거절되었습니다.<br>";
	            if (rejectionReason != null && !rejectionReason.isEmpty()) {
	                content += "반려 사유: " + rejectionReason + "<br><br>";
	            }
	            content += "추가 보완을 하시어 다음 기회에 다시 신청해 주시기 바랍니다.<br><br>"
	                    + "감사합니다.<br><br>"
	                    + "- 뚝딱뚝딱 드림 -";
	            subject = "뚝딱뚝딱 " + sellerName + "님 입점 신청 거절";
	        }

	        Mail mail = new Mail();
	        mail.setReceiverEmail(sellerEmail);
	        mail.setSenderEmail("sksksukk@gmail.com");
	        mail.setSenderName("관리자");
	        mail.setSubject(subject);
	        mail.setContent(content);

	        boolean result = mailSender.mailSend(mail);
	        if (!result) {
	            throw new Exception("이메일 전송 실패");
	        }

	    } catch (Exception e) {
	        throw e;
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
