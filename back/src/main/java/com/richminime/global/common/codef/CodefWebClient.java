package com.richminime.global.common.codef;

import com.richminime.global.common.codef.dto.request.AccountDto;
import com.richminime.global.common.codef.dto.request.CreateConnectedIdRequest;
import com.richminime.global.common.codef.dto.response.CodefOAuthResponse;
import com.richminime.global.common.codef.dto.response.CreateConnectedIdResponse;
import com.richminime.global.common.jwt.JwtHeaderUtilEnums;
import com.richminime.global.util.rsa.RSAUtil;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

@Slf4j
public class CodefWebClient {

//    @Value("${codef.authHeader}")
    String authHeader;

    String accessToken;

    WebClient devWebClient;

    public CodefWebClient() {
        // 서비스 시작 시 액세스 토큰 발급
        generateAccessToken();
        // codef url로 초기화
        devWebClient = WebClient.builder()
                .baseUrl("https://development.codef.io/v1")
                .defaultHeader(HttpHeaders.AUTHORIZATION, JwtHeaderUtilEnums.GRANT_TYPE.getValue() + accessToken)
                .build();
    }

    // 만료될 때마다 액세스 토큰 재발급
    // 스케줄링으로 만료되기 전 갱신해주는 작업 필요할듯?
    private void generateAccessToken(){
        // 클라이언트아이디, 시크릿코드 Base64 인코딩
        // 헤더에 추가
        WebClient oAuthWebClient = WebClient.builder()
                .baseUrl("https://oauth.codef.io")
                .defaultHeader(HttpHeaders.AUTHORIZATION, "Basic MjFjZTRiYTgtNTUzNy00NTRmLTg3YmUtN2RhYWQyOGVjYjFmOjA0MTZmODdjLWI4YTYtNGJjMS05ZDM2LTJlYTgwOTVlMTNjNA==") // 예시: Authorization 헤더 추가
                .build();
        // api 요청
        Mono<CodefOAuthResponse> response = oAuthWebClient.post()
                .uri("/oauth/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)  // Content-Type 설정
                .body(BodyInserters.fromValue("grant_type=client_credentials&scope=read"))  // 폼 데이터 전송
                .retrieve()
                .bodyToMono(CodefOAuthResponse.class);
        accessToken = response.block().getAccess_token();
    }

    // 호출하는 api를 메서드로 설정
    public String createConnectedId(String organization, String id, String password) throws NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException {
        CreateConnectedIdRequest request = new CreateConnectedIdRequest();
        // 등록할 계정 정보
        AccountDto account = AccountDto.builder()
                .organization(organization)
                .id(id)
                .password(RSAUtil.encryptRSA(password, CommonConstant.PUBLIC_KEY))
                .build();
        request.getAccountList().add(account);
        // api 요청
        Mono<String> response = devWebClient.post()
                .uri("/account/create")
                .contentType(MediaType.APPLICATION_JSON)  // Content-Type 설정
                .body(BodyInserters.fromValue(request))  // 폼 데이터 전송
                .retrieve()
                .bodyToMono(String.class);
        // json 파싱
        CreateConnectedIdResponse createConnectedIdResponse = (CreateConnectedIdResponse) parseDataFromJson(response.block());
        log.info("connectedId------------------->{}", createConnectedIdResponse.getConnectedId());
        return createConnectedIdResponse.getConnectedId();
    }

    public Object parseDataFromJson(String jsonResponse) {
        JSONObject jsonObject = new JSONObject(jsonResponse);
        return jsonObject.get("data");
    }

}
