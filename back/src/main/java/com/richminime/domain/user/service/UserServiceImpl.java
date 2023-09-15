package com.richminime.domain.user.service;

import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.dto.request.AddUserRequest;
import com.richminime.domain.user.dto.response.CheckEmailResponse;
import com.richminime.domain.user.exception.UserExceptionMessage;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.common.codef.OrganizationCode;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final PasswordEncoder passwordEncoder;
    private final JWTUtil jwtUtil;

    private final UserRepository userRepository;
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

    @Override
    public CheckEmailResponse checkEmail(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        return CheckEmailResponse.builder()
                // 존재하면 false, 존재하지 않으면 true 반환
                .success(!user.isPresent())
                .build();
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

    /**
     * 현재 로그인한 회원 아이디(이메일)을 반환
     */
    private String getLoginId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails principal = (UserDetails) authentication.getPrincipal();
        return principal.getUsername();
    }

}
