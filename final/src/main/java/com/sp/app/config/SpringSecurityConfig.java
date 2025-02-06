package com.sp.app.config;

import com.sp.app.security.LoginFailureHandler;
import com.sp.app.security.LoginSuccessHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig {
  @Bean
  SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    HttpSessionRequestCache requestCache = new HttpSessionRequestCache();
    requestCache.setMatchingRequestParameterName(null);

    String[] excludeUri = {"/", "/index.jsp", "/member/**", "/member/login", "/member/member", "/member/complete",
                          "/member/emailCheck", "/member/pwdFind", "/member/expired", "/member/account","/uploads/event/**","/uploads/product/**",
                          "/dist/**", "/uploads/photo/**", "/favicon.ico","/cart/*", "/kakao/*", "/WEB-INF/views/**", "/admin/**", "/static/**"};

//    "/favicon.ico",
    http.cors(Customizer.withDefaults())
        .csrf(AbstractHttpConfigurer::disable) // 공격 못하게 막음
        .requestCache(request -> request.requestCache(requestCache))
        .headers(headers -> headers
            .frameOptions(HeadersConfigurer.FrameOptionsConfig::disable)); ; // 스프링 버전 6부터 ?continue 가 붙어서 지움..

     http.authorizeHttpRequests(authoriz -> authoriz
        .requestMatchers(excludeUri).permitAll()
        .requestMatchers("/admin/**").hasRole("ADMIN")
        .requestMatchers("/**").hasAnyRole("USER", "AUTHOR","ADMIN")
        .anyRequest().authenticated())
        .formLogin(login -> login.loginPage("/member/login")
            .loginProcessingUrl("/member/login")
            .usernameParameter("email")
            .passwordParameter("pwd")
            .successHandler(loginSuccessHandler())
            .failureHandler(loginFailureHandler())
            .permitAll()
        )
        .logout((logout -> logout.logoutUrl("/member/logout")
            .invalidateHttpSession(true)
            .deleteCookies("JSESSIONID")
            .logoutSuccessUrl("/")
        ))
        .sessionManagement(management -> management.maximumSessions(1)
            .expiredUrl("/member/expired")); // 로그인 성공
    // excludeUri에 대한 permitAll -> 모든 권한을 준다.


    // 권한이 없는 경우
    http.exceptionHandling((exceptionConfig) -> exceptionConfig
        .accessDeniedPage("/member/noAuthorized"));

    return http.build();
  }

  @Bean
  // BCryptPasswordEncoder 암호화 클래스, 패스워드 암호화에 특화됨
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }

  @Bean
  LoginSuccessHandler loginSuccessHandler() {
    LoginSuccessHandler handler = new LoginSuccessHandler();
    handler.setDefaultUrl("/");
    return handler;
  }


  @Bean
  LoginFailureHandler loginFailureHandler() {
    LoginFailureHandler handler = new LoginFailureHandler();
    handler.setDefaultFailureUrl("/member/login?login_error");
    return handler;
  }

}
