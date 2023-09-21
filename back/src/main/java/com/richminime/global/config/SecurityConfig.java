package com.richminime.global.config;

import com.richminime.global.common.security.CustomAccessDeniedHandler;
import com.richminime.global.common.security.CustomAuthenticationEntryPoint;
import com.richminime.global.common.security.CustomAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final CustomAuthenticationFilter customAuthenticationFilter;
    private final CustomAccessDeniedHandler customAccessDeniedHandler;
    private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http.antMatcher("/**")
                .authorizeRequests()
                // 토큰 인증 없이도 접근 가능한 api
                .antMatchers(HttpMethod.POST, "/user", "/user/login", "/user/send-email-code", "/user/check-email-code", "/user/connected-id", "/user/reissue-token").permitAll()
                .antMatchers(HttpMethod.GET, "/user/check-login-email", "/user/email", "/swagger-ui/**").permitAll()
                .antMatchers("/user/all").hasRole("ADMIN")
                .antMatchers(HttpMethod.DELETE, "/user/*").hasRole("ADMIN")
                .antMatchers("/**").hasRole("USER")
                .and()
                // HTTP 기본 인증을 사용하지 않도록 설정
                .httpBasic().disable()
                // 폼 로그인을 사용하지 않도록 설정
                .formLogin().disable()
                // Cross-Origin Resource Sharing (CORS)를 비활성화
                .cors().disable()
                // token을 사용하는 방식이기 때문에 csrf를 disable
                .csrf().disable()
                // 무상태 세션 정책 설정
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                // 커스텀 필터 등록
                .addFilterBefore(customAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .exceptionHandling()
                // 401 처리
                .authenticationEntryPoint(customAuthenticationEntryPoint)
                // 403 처리
                .accessDeniedHandler(customAccessDeniedHandler).and().build();
    }

}
