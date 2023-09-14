package com.richminime.domain.user.service;

import com.richminime.domain.user.dto.request.AddUserRequest;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.common.codef.OrganizationCode;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private Map<String, String> connectedIdMap = new HashMap<>();
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
    public void addUser(AddUserRequest addUserRequest) {
        String connectedId = connectedIdMap.get(addUserRequest.getEmail());
        String organizationCode = organizationCodeMap.get(addUserRequest.getOrganization()).getCode();
        userRepository.save(addUserRequest.toEntity(connectedId, organizationCode));
    }

}
