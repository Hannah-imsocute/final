package com.sp.app.security;

import com.sp.app.model.Member;
import com.sp.app.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService{
	private final MemberService memberService;
	
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
//		Member member = memberService.findByEmail(email);
		Member member = memberService.findByUserEmail(email);
		if(member == null) {
			throw new UsernameNotFoundException("이메일이 존재하지 않습니다.");
		}
		
		List<String> authorities = new ArrayList<>(); 
		String authority = memberService.findByAuthority(email);
		authorities.add(authority);
		
		return toUserDetails(member, authorities);
	}

    private UserDetails toUserDetails(Member member, List<String> authorities) {
        String[] roles = authorities.toArray(new String[authorities.size()]);
        
        return User.builder()
                .username(member.getEmail())
                .password(member.getPassword()) // 암호화된 패스워드
                //.authorities(grantedAuthorities)
                //.authorities(new SimpleGrantedAuthority("ROLE_USER")) // 유저가 하나의 role를 가지고 있는 경우
                //.roles("USER", "ADMIN") // ROLE_ 로 시작할수 없음
                .roles(roles) // ROLE_ 로 시작할수 없음. 권한 리스트
                .build();
    }	
}
