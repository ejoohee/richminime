package com.richminime.domain.user.api;

import com.richminime.domain.user.dto.request.*;
import com.richminime.domain.user.dto.response.*;
import com.richminime.domain.user.service.UserService;
import com.richminime.global.common.jwt.JwtHeaderUtilEnums;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/user")
public class UserController {


    private final UserService userService;

    @Value("${jwt.cookieName}")
    private String jwtCookieName;

    /**
     * 회원 가입
     * @param addUserRequest
     * @return
     */
    @Operation(
            summary = "회원가입",
            description = "필요한 정보를 입력하여 회원 가입합니다."
    )
    @PostMapping
    public ResponseEntity<Void> addUser(@RequestBody @Valid AddUserReqDto addUserRequest) {
        userService.addUser(addUserRequest);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    /**
     * 이메일 중복 검사
     * @param email
     * @return
     */
    @Operation(
            summary = "이메일 중복 검사",
            description = "회원 가입 시 해당 이메일로 이미 가입한 회원이 있는지 검사합니다."
    )
    @GetMapping("/check-login-email")
    public ResponseEntity<CheckResDto> checkEmail(@RequestParam(name = "email") String email) {
        return ResponseEntity.ok().body(userService.checkEmail(email));
    }

    @Operation(
            summary = "이메일 인증 코드 전송",
            description = "이메일로 인증 코드를 전송합니다."
    )
    @PostMapping("/send-email-code")
    public ResponseEntity<Void> sendEmailCode(@RequestParam(name = "email") String email) {
        userService.sendEmailCode(email);
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "이메일 인증 코드 검사",
            description = "입력한 코드가 전송한 인증 코드와 일치하는지 검사합니다."
    )
    @PostMapping("/check-email-code")
    public ResponseEntity<CheckResDto> checkEmailCode(@RequestBody CheckEmailCodeReqDto checkEmailCodeReqDto) {
        return ResponseEntity.ok().body(userService.checkEmailCode(checkEmailCodeReqDto));
    }

    @Operation(
            summary = "카드 유효성 검사",
            description = "입력한 코드가 전송한 인증 코드와 일치하는지 검사합니다."
    )
    @PostMapping("/check-card")
    public ResponseEntity<CheckResDto> checkCardNumber(@RequestBody CheckCardNumberReqDto checkCardNumberReqDto) {
        return ResponseEntity.ok().body(userService.checkCardNumber(checkCardNumberReqDto));
    }

    @Operation(
            summary = "커넥티드 아이디 발급",
            description = "커넥티드 아이디를 codef api를 호출하여 발급합니다."
    )
    @PostMapping("/connected-id")
    public ResponseEntity<GenerateConnectedIdResDto> generateConnectedId(@RequestBody GenerateConnectedIdReqDto generateConnectedIdRequest) {
        log.info("기관코드" + " " +generateConnectedIdRequest.getOrganization());
        log.info("아이디" + " " + generateConnectedIdRequest.getId());
        log.info("비밀번호" + " " + generateConnectedIdRequest.getPassword());
        log.info("카드번호" + " " + generateConnectedIdRequest.getCardNumber());
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.generateConnectedId(generateConnectedIdRequest));
    }

    @Operation(
            summary = "비밀번호 찾기",
            description = "비밀번호를 이메일로 전송합니다."
    )
    @PostMapping("/password")
    public ResponseEntity<Void> findPassword(@RequestParam(name = "email") String email) {
        return ResponseEntity.ok().build();
    }

    /**
     * 회원 로그인
     * 바디에 access 토큰 전달
     * 쿠키로 refresh 토큰 전달
     * @param loginRequest
     * @return
     */
    @Operation(
            summary = "로그인",
            description = "아이디와 비밀번호를 입력하여 로그인합니다."
    )
    @PostMapping("/login")
    public ResponseEntity<LoginResDto> login(@RequestBody LoginReqDto loginRequest) {
        return ResponseEntity.ok().body(userService.login(loginRequest));
    }

    @Operation(
            summary = "로그아웃",
            description = "로그아웃 합니다."
    )
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestHeader("Authorization") String accessToken) {
        userService.logout(accessToken.substring(JwtHeaderUtilEnums.GRANT_TYPE.getValue().length()));
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "회원 정보 수정",
            description = "필요한 정보를 입력하여 회원 정보를 수정합니다."
    )
    @PutMapping
    public ResponseEntity<Void> updateUser(@RequestBody UpdateUserReqDto updateUserReqDto) {
        userService.updateUser(updateUserReqDto);
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "비밀번호 수정",
            description = "회원의 비밀번호를 수정합니다."
    )
    @PutMapping("/password")
    public ResponseEntity<Void> updatePassword(@RequestBody UpdatePasswordReqDto updatePasswordReqDto) {
        userService.updatePassword(updatePasswordReqDto);
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "회원 탈퇴",
            description = "회원(본인) 탈퇴 합니다."
    )
    @DeleteMapping
    public ResponseEntity<Void> deleteUser() {
        userService.deleteUser();
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "회원 정보 조회",
            description = "회원 정보를 조회합니다."
    )
    @GetMapping
    public ResponseEntity<FindUserResDto> findUser() {
        return ResponseEntity.ok().body(userService.findUser());
    }

    @Operation(
            summary = "잔액 조회",
            description = "회원의 잔액을 조회합니다."
    )
    @GetMapping("/balance")
    public ResponseEntity<FindBalanceResDto> findBalance() {
        return ResponseEntity.ok().body(userService.findBalance());
    }

    @Operation(
            summary = "잔액 갱신",
            description = "회원의 잔액을 갱신합니다."
    )
    @PatchMapping("/balance")
    public ResponseEntity<Void> updateBalance(@RequestParam(name = "balance") Long balance) {
        userService.updateBalance(balance);
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "토큰 재발급",
            description = "JWT 토큰을 재발급합니다."
    )
    @PostMapping("/reissue-token")
    public ResponseEntity<ReissueTokenResDto> reissueToken(@RequestHeader("Authorization") String accessToken, @RequestHeader("Refresh-Token") String refreshToken) {
        return ResponseEntity.ok()
                .body(userService.reissueToken(accessToken, refreshToken));
    }

    @Operation(
            summary = "회원 강제 탈퇴",
            description = "관리자에 의하여 특정 회원을 강제 탈퇴합니다."
    )
    @DeleteMapping("/{email}")
    public ResponseEntity<Void> deleteUserByAdmin(@PathVariable(name = "email") String email) {
        userService.deleteUser(email);
        return ResponseEntity.ok().build();
    }

    @Operation(
            summary = "회원 목록 조회",
            description = "관리자에 의해 회원 전체 목록을 조회합니다."
    )
    @GetMapping("/all")
    public ResponseEntity<List<FindUserResDto>> findUserList() {
        return ResponseEntity.ok().body(userService.findUserList());
    }

}
