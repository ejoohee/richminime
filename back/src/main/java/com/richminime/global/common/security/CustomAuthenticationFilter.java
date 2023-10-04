package com.richminime.global.common.security;

import com.richminime.domain.user.repository.LogoutAccessTokenRedisRepository;
import com.richminime.global.common.jwt.JwtHeaderUtilEnums;
import com.richminime.global.exception.security.SecurityExceptionMessage;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class CustomAuthenticationFilter extends OncePerRequestFilter {

    private final JWTUtil jwtUtil;
    private final CustomUserDetailsService customUserDetailService;
    private final LogoutAccessTokenRedisRepository logoutAccessTokenRedisRepository;


    /**
     * 특정 URI는 필터를 거치지 않음
     * @param request current HTTP request
     * @return
     * @throws ServletException
     */
    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        // refresh 토큰을 이용한 access 토큰 재발급 시 필터를 거치치 않도록 함
        return request.getRequestURI().contains("/reissue-token");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String accessToken = getAccessToken(request);
        if (accessToken != null && !accessToken.equals("undefined")) {
            // 로그아웃 여부 확인
            // 로그아웃 한 상태면 해당 액세스 토큰은 만료되지 않았어도 유효하지 않음
            checkLogout(accessToken);
            try {
                String id = jwtUtil.getUsername(accessToken);
                log.info("필터 id------------------------------>{}", id);
                if (id != null) {
                    UserDetails userDetails = customUserDetailService.loadUserByUsername(id);
                    // 액세스 토큰 생성 시 사용된 이메일 아이디와 현재 이메일 아이디가 일치하는지 확인
                    equalsUsernameFromTokenAndUserDetails(userDetails.getUsername(), id);
                    // 액세스 토큰의 유효성 검증
                    validateAccessToken(accessToken, userDetails);
                    // securityContextHolder에 인증된 회원의 정보를 저장
                    processSecurity(request, userDetails);
                }
            } catch(Exception e) {
                // jwt 만료 등 예외가 발생할 때 다음 필터로 넘어감
                log.info("토큰 필터에서 에러남=========================================");
                filterChain.doFilter(request, response);
            }
        }
        // 다음 순서 필터로 넘어가기
        filterChain.doFilter(request, response);
    }

    private String getAccessToken(HttpServletRequest request) {
        String headerAuth = request.getHeader(JwtHeaderUtilEnums.AUTHORIZATION.getValue());
        if (StringUtils.hasText(headerAuth) && headerAuth.startsWith(JwtHeaderUtilEnums.GRANT_TYPE.getValue())) {
            return headerAuth.substring(JwtHeaderUtilEnums.GRANT_TYPE.getValue().length());
        }
        return null;
    }

    private void checkLogout(String accessToken) {
        if (logoutAccessTokenRedisRepository.existsById(accessToken)) {
            throw new IllegalArgumentException("이미 로그아웃된 회원입니다.");
        }
    }

    private void equalsUsernameFromTokenAndUserDetails(String userDetailsUsername, String tokenUsername) {
        if (!userDetailsUsername.equals(tokenUsername)) {
            throw new IllegalArgumentException(SecurityExceptionMessage.MISMATCH_TOKEN_ID.getMessage());
        }
    }

    private void validateAccessToken(String accessToken, UserDetails userDetails) {
        if (!jwtUtil.validateToken(accessToken, userDetails)) {
            throw new IllegalArgumentException(SecurityExceptionMessage.INVALID_TOKEN.getMessage());
        }
    }

    private void processSecurity(HttpServletRequest request, UserDetails userDetails) {
        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(userDetails,null, userDetails.getAuthorities());
        usernamePasswordAuthenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
    }

}
