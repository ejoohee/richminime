package com.richminime.domain.user.service;

import com.richminime.domain.user.domain.RefreshToken;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.dto.request.AddUserRequest;
import com.richminime.domain.user.dto.request.GenerateConnectedIdRequest;
import com.richminime.domain.user.dto.request.LoginRequest;
import com.richminime.domain.user.dto.response.CheckEmailResponse;
import com.richminime.domain.user.dto.response.GenerateConnectedIdResponse;
import com.richminime.domain.user.dto.response.LoginResponse;
import com.richminime.domain.user.exception.UserExceptionMessage;
import com.richminime.domain.user.repository.RefreshTokenRepository;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.common.codef.CodefWebClient;
import com.richminime.global.common.codef.OrganizationCode;
import com.richminime.global.common.jwt.JwtExpirationEnums;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private final PasswordEncoder passwordEncoder;
    private final JWTUtil jwtUtil;
    private final CodefWebClient codefWebClient;

    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private Map<UUID, String> connectedIdMap = new HashMap<>();
    private Map<String, OrganizationCode> organizationCodeMap = new HashMap<>() {{
        put("KB카드", OrganizationCode.KB_CARD);
        put("현대카드", OrganizationCode.HYNDAI_CARD);
        put("삼성카드", OrganizationCode.SAMSUNG_CARD);
        put("NH카드", OrganizationCode.NH_CARD);
        put("BC카드", OrganizationCode.BC_CARD);
        put("신한카드", OrganizationCode.SINHAN_CARD);
        put("씨티카드", OrganizationCode.CITY_CARD);
        put("산업은행카드", OrganizationCode.DEV_BANK_CARD);
        put("우리카드", OrganizationCode.WOORI_CARD);
        put("롯데카드", OrganizationCode.LOTTE_CARD);
        put("하나카드", OrganizationCode.HANA_CARD);
        put("전북카드", OrganizationCode.JEONBOOK_CARD);
        put("광주카드", OrganizationCode.KWANGJU_CARD);
        put("수협카드", OrganizationCode.SUHYUP_CARD);
        put("제주카드", OrganizationCode.JEJU_CARD);
    }};

    @Transactional(readOnly = true)
    @Override
    public CheckEmailResponse checkEmail(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        return CheckEmailResponse.builder()
                // 존재하면 false, 존재하지 않으면 true 반환
                .success(!user.isPresent())
                .build();
    }

    @Override
    public GenerateConnectedIdResponse generateConnectedId(GenerateConnectedIdRequest generateConnectedIdRequest) {
        String organization = organizationCodeMap.get(generateConnectedIdRequest.getOrganization()).getCode();
        String id = generateConnectedIdRequest.getId();
        String password = generateConnectedIdRequest.getPassword();
        //외부 API 호출
        try {
            String connectedId = codefWebClient.createConnectedId(organization, id, password);
            // uuid 생성
            UUID uuid = UUID.randomUUID();
            // uuid를 키로 생성된 커넥티드 아이디 저장
            connectedIdMap.put(uuid, connectedId);
            return GenerateConnectedIdResponse.builder()
                    .uuid(uuid)
                    .build();
        } catch (NoSuchPaddingException e) {
            throw new RuntimeException(e);
        } catch (IllegalBlockSizeException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        } catch (BadPaddingException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeyException e) {
            throw new RuntimeException(e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addUser(AddUserRequest addUserRequest) {
        // uuid에 해당하는 커넥티드 아이디 가져오기
        String connectedId = connectedIdMap.remove(addUserRequest.getUuid());
        if(connectedId == null) throw new NoSuchElementException(UserExceptionMessage.CONNECTED_ID_NOT_CREATED.getMessage());
        String organizationCode = organizationCodeMap.get(addUserRequest.getOrganization()).getCode();
        // 패스워드 암호화
        addUserRequest.setPassword(passwordEncoder.encode(addUserRequest.getPassword()));
        userRepository.save(addUserRequest.toEntity(connectedId, organizationCode));
    }

    @Override
    public LoginResponse login(LoginRequest loginRequest) {
        // 이메일 인증 후 로그인 가능하게 변경해야 함
        // 해당 이메일 아이디의 회원이 존재하지 않으면 예외처리
        User user = userRepository.findByEmail(loginRequest.getEmail()).orElseThrow(() -> new NoSuchElementException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        // 패스워드 일치 비교
        if (!passwordEncoder.matches(loginRequest.getPassword(), user.getPassword()))
            throw new IllegalArgumentException(UserExceptionMessage.LOGIN_PASSWORD_ERROR.getMessage());
        // 로그인 성공
        // 토큰 생성
        String accessToken = jwtUtil.generateAccessToken(loginRequest.getEmail());
        String refreshToken = jwtUtil.generateRefreshToken(loginRequest.getEmail());
        // Redis에 refresh 토큰 저장 필요
        // 회원의 이메일 아이디를 키로 저장
        refreshTokenRepository.save(RefreshToken.builder()
                        .email(user.getEmail())
                        .refreshToken(refreshToken)
                        .expiration(JwtExpirationEnums.REFRESH_TOKEN_EXPIRATION_TIME.getValue() / 1000)
                .build());
        return LoginResponse.builder()
                .accessToken(accessToken)
                .nickname(user.getNickname())
                .balance(user.getBalance())
                .build();
    }

    /**
     * 현재 로그인한 회원 아이디(이메일)을 반환
     */
    private String getLoginId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails principal = (UserDetails) authentication.getPrincipal();
        return principal.getUsername();
    }

}
