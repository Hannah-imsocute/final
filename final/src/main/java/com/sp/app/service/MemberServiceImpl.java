package com.sp.app.service;

import com.sp.app.mail.Mail;
import com.sp.app.mail.MailSender;
import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.Member;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional

public class MemberServiceImpl implements MemberService {
  private final MemberMapper mapper;
  private final MailSender mailSender;
  private final PasswordEncoder bcryptEncoder;


  @Override
  public void insertMember(Member dto) throws Exception {

  }

  @Override
  public void updateLastLogin(String userId) throws Exception {

  }

  @Override
  public void updateMember(Member dto) throws Exception {

  }

  @Override
  public Member findByEmail(String email) {

    return null;
  }


  @Override
  public List<String> listRoles(String email) {
    List<String> list = null;

    try {
      list = mapper.listRoles(email);
    } catch (Exception e) {
      log.info("listAuthority", e);
    }

    return list;
  }

  @Override
  public String findByAuthority(String email) {
    String authority = null;

    try {
      authority = mapper.findByAuthority(email);
    } catch (Exception e) {
      log.info("findByAuthority", e);
    }

    return authority;
  }

  @Override
  public boolean isPasswordCheck(String email, String pwd) {
    try {
      Member dto = Objects.requireNonNull(findByUserEmail(email));

      return bcryptEncoder.matches(pwd, dto.getPassword());
    } catch (NullPointerException e) {
    } catch (Exception e) {
      log.info("isPasswordCheck", e);
    }

    return false;
  }

  @Override
  @Transactional
  public void updatePassword(Member dto) throws Exception {

    if( isPasswordCheck(dto.getEmail(), dto.getPassword()) ) {
      throw new RuntimeException("패스워드가 기존 패스워드와 일치합니다.");
    }

    try {
      String encPassword = bcryptEncoder.encode(dto.getPassword());
      dto.setPassword(encPassword);

      mapper.updateMember1(dto);
    } catch (Exception e) {
      log.info("updatePassword : ", e);

      throw e;
    }
  }

  @Override
  public void deleteMember(Map<String, Object> map) throws Exception {

  }


  @Override
  public int checkFailureCount(String email) {
    int result = 0;
    try {
      result = mapper.checkFailureCount(email);
    } catch (Exception e) {
      log.info("checkFailureCount : ", e);
    }
    return result;
  }

  @Override
  public void updateFailureCount(String userId) throws SQLException {
    try {
      mapper.updateFailureCount(userId);
    } catch (Exception e) {
      log.info("updateFailureCount", e);
    }
  }

  @Override
  public void updateMemberEnabled(Map<String, Object> map) throws Exception {

  }

  @Override
  public void insertMemberStatus(Member dto) throws Exception {

  }

  @Override
  public Member findByUserEmail(String email) {
    Member member = null;

    try {
      member = Objects.requireNonNull(mapper.findByUserEmail(email));

    } catch (NullPointerException e) {
    } catch (Exception e) {
      log.info("findByUserEmail", e);
    }

    return member;
  }

  @Override
  public Long getMemberIdx(String email) {
    Long memberIdx = null;
    try {
      memberIdx = mapper.getMemberIdx(email);
    } catch (Exception e) {
      log.info("getMemberIdx", e);
    }
    return memberIdx;
  }

  @Override
  public void insertAuthority(Member dto) throws Exception {
    try {
      mapper.insertAuthority(dto);
    } catch (Exception e) {
      log.info("insertAuthority", e);
    }
  }

  @Override
  public void deleteAuthority(Map<String, Object> map) throws Exception {
    try {
      mapper.deleteAuthority(map);
    } catch (Exception e) {
      log.info("deleteAuthority", e);

    }
  }

  @Override
  public void generatePwd(Member dto) throws Exception {
    // 10 자리 임시 패스워드 생성

    String lowercase = "abcdefghijklmnopqrstuvwxyz";
    String uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String digits = "0123456789";
    String special_characters = "!#@$%^&*()-_=+[]{}?";
    String all_characters = lowercase + digits + uppercase + special_characters;

    try {
      // 암호화적으로 안전한 난수 생성(예측 불가 난수 생성)
      SecureRandom random = new SecureRandom();

      StringBuilder sb = new StringBuilder();

      // 각 문자는 최소 하나 이상 포함
      sb.append(lowercase.charAt(random.nextInt(lowercase.length())));
      sb.append(uppercase.charAt(random.nextInt(uppercase.length())));
      sb.append(digits.charAt(random.nextInt(digits.length())));
      sb.append(special_characters.charAt(random.nextInt(special_characters.length())));

      for(int i = sb.length(); i < 10; i++) {
        int index = random.nextInt(all_characters.length());

        sb.append(all_characters.charAt(index));
      }

      // 문자 섞기
      StringBuilder password = new StringBuilder();
      while (sb.length() > 0) {
        int index = random.nextInt(sb.length());
        password.append(sb.charAt(index));
        sb.deleteCharAt(index);
      }

      String result;
      result = dto.getNickName() +"님의 새로 발급된 임시 패스워드는 <b> "
          + password.toString() + " </b> 입니다.<br>"
          + "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";

      Mail mail = new Mail();
      mail.setReceiverEmail(dto.getEmail());

      mail.setSenderEmail("메일설정이메일@도메인");
      mail.setSenderName("관리자");
      mail.setSubject("임시 패스워드 발급");
      mail.setContent(result);

      // 테이블의 패스워드 변경
      String encPassword = bcryptEncoder.encode(password.toString());
      dto.setPassword(encPassword);
      mapper.updateMember1(dto);

      mapper.updateFailureCountReset(dto.getEmail());

      // 메일 전송
      boolean b = mailSender.mailSend(mail);

      if( ! b ) {
        throw new Exception("이메일 전송중 오류가 발생했습니다.");
      }

    } catch (Exception e) {
      throw e;
    }
  }


}
