package com.richminime.global.common.codef;

import com.richminime.domain.spending.domain.Spending;
import com.richminime.global.common.codef.dto.request.AccountDto;
import com.richminime.global.common.codef.dto.request.CreateConnectedIdReqDto;
import com.richminime.global.common.codef.dto.request.FindSpendingListReqDto;
import com.richminime.global.common.codef.dto.response.CodefOAuthResDto;
import com.richminime.global.common.jwt.JwtHeaderUtilEnums;
import com.richminime.global.util.rsa.RSAUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import javax.annotation.PostConstruct;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
public class CodefWebClient {

    @Value("${codef.auth-header}")
    private String authHeader;

    @Value("${rsa.private-key}")
    private String privateKey;

    private String accessToken;

    private WebClient devWebClient;

    @PostConstruct
    public void init() {
        // 서비스 시작 시 액세스 토큰 발급
        log.info("authHeader -------------------------------------->{}", authHeader);
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
                .defaultHeader(HttpHeaders.AUTHORIZATION, authHeader) // 예시: Authorization 헤더 추가
                .build();
        // api 요청
        Mono<CodefOAuthResDto> response = oAuthWebClient.post()
                .uri("/oauth/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)  // Content-Type 설정
                .body(BodyInserters.fromValue("grant_type=client_credentials&scope=read"))  // 폼 데이터 전송
                .retrieve()
                .bodyToMono(CodefOAuthResDto.class);
        accessToken = response.block().getAccess_token();
    }

    // 커넥티드 아이디 생성
    public String createConnectedId(String organization, String id, String password) throws NoSuchPaddingException, IllegalBlockSizeException, NoSuchAlgorithmException, InvalidKeySpecException, BadPaddingException, InvalidKeyException, UnsupportedEncodingException {
        CreateConnectedIdReqDto request = new CreateConnectedIdReqDto();
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
        // URL 디코드
        String decodedResponse = URLDecoder.decode(response.block(), "UTF-8");
        log.info("response------------------->{}", decodedResponse);
        // json 파싱
        String connectedId = parseConnectedIdFromJson(decodedResponse);
        log.info("connectedId------------------->{}", connectedId);
        return connectedId;
    }

    public String parseConnectedIdFromJson(String jsonResponse) {
        JsonObject jsonObject = Json.createReader(new StringReader(jsonResponse)).readObject();
        return jsonObject.getJsonObject("data").getString("connectedId");
    }

    // 카드 승인내역 조회
    public List<Spending> findSpendingList(FindSpendingListReqDto request, Long userId) throws Exception {
        // rsa로 암호화된 card 번호 개인키로 복호화
        request.setCardNo(RSAUtil.decryptRSA(request.getCardNo(), RSAUtil.privateKeyFromString(privateKey)));

        List<Spending> spendingList = null;
        // api 요청
        Mono<String> response = devWebClient.post()
                .uri("/kr/card/p/account/approval-list")
                .contentType(MediaType.APPLICATION_JSON)  // Content-Type 설정
                .body(BodyInserters.fromValue(request))  // 폼 데이터 전송
                .retrieve()
                .bodyToMono(String.class);
        // URL 디코드
        String decodedResponse = URLDecoder.decode(response.block(), "UTF-8");
        log.info("spending response------------------->{}", decodedResponse);
        // json 파싱
        return parseSpendingListFromJson(decodedResponse, userId);
    }

    /**
     * response에서 소비내역 목록을 추출
     * @param jsonResponse
     * @param userId
     * @return
     */
    public List<Spending> parseSpendingListFromJson(String jsonResponse, Long userId) {
        JsonObject jsonObject = Json.createReader(new StringReader(jsonResponse)).readObject();
        JsonArray jsonArray = jsonObject.getJsonArray("data");
        List<Spending> spendingList = new ArrayList<>();
        return jsonArray.stream().map(json -> {
                    JsonObject jsonObject1 = Json.createObjectBuilder()
                            .add("index", json)
                            .build();
                    jsonObject1 = jsonObject1.getJsonObject("index");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
                    Date date;
                    try {
                        date = sdf.parse(jsonObject1.getString("resUsedDate"));
                    } catch (ParseException e) {
                        throw new RuntimeException(e);
                    }
                    return Spending.builder()
                            .userId(userId)
                            .category(jsonObject1.getString("resMemberStoreType"))
                            .cost(Long.valueOf(jsonObject1.getString("resUsedAmount")))
                            .spentDate(date)
                            .storeNo(Integer.valueOf(jsonObject1.getString("resMemberStoreNo")))
                            .build();
                })
                .collect(Collectors.toList());
    }


}
