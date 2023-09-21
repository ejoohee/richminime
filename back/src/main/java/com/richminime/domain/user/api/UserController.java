package com.richminime.domain.user.api;

import com.richminime.domain.user.dto.request.*;
import com.richminime.domain.user.dto.response.*;
import com.richminime.domain.user.service.UserService;
import com.richminime.global.common.jwt.JwtHeaderUtilEnums;
import com.richminime.global.dto.ResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequiredArgsConstructor
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
    @PostMapping
    public ResponseEntity<ResponseDto<Void>> addUser(@RequestBody AddUserReqDto addUserRequest) {
        userService.addUser(addUserRequest);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    /**
     * 이메일 중복 검사
     * @param email
     * @return
     */
    @GetMapping("/check-login-email")
    public ResponseEntity<CheckEmailResDto> checkEmail(@RequestParam(name = "email") String email) {
        return ResponseEntity.ok().body(userService.checkEmail(email));
    }

    @PostMapping("/send-email-code")
    public ResponseEntity<Void> sendEmailCode(@RequestParam(name = "email") String email) {
        userService.sendEmailCode(email);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/check-email-code")
    public ResponseEntity<CheckEmailResDto> checkEmailCode(@RequestBody CheckEmailCodeReqDto checkEmailCodeReqDto) {
        return ResponseEntity.ok().body(userService.checkEmailCode(checkEmailCodeReqDto));
    }

    @PostMapping("/connected-id")
    public ResponseEntity<GenerateConnectedIdResDto> generateConnectedId(@RequestBody GenerateConnectedIdReqDto generateConnectedIdRequest) {
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.generateConnectedId(generateConnectedIdRequest));
    }

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
    @PostMapping("/login")
    public ResponseEntity<LoginResDto> login(@RequestBody LoginReqDto loginRequest) {
        Map<String, Object> map = userService.login(loginRequest);
        LoginResDto loginResDto = (LoginResDto) map.get("accessToken");
        String refreshToken = (String) map.get("refreshToken");
        return ResponseEntity.ok()
                .header("Set-Cookie", jwtCookieName + "=" + refreshToken + "; HttpOnly; Max-Age=" + 1000L * 60 * 60 * 24 + "; SameSite=None; Secure")
                .body(loginResDto);
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestParam(name = "email") String email, @RequestHeader("Authorization") String accessToken) {
        userService.logout(email, accessToken.substring(JwtHeaderUtilEnums.GRANT_TYPE.getValue().length()));
        return ResponseEntity.ok().build();
    }

    @PutMapping
    public ResponseEntity<Void> updateUser(@RequestBody UpdateUserReqDto updateUserReqDto) {
        userService.updateUser(updateUserReqDto);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/password")
    public ResponseEntity<Void> updatePassword(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteUser() {
        userService.deleteUser();
        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<FindUserResDto> findUser() {
        return ResponseEntity.ok().body(userService.findUser());
    }

    @GetMapping("/balance")
    public ResponseEntity<FindBalanceResDto> findBalance() {
        return ResponseEntity.ok().body(userService.findBalance());
    }

    @PatchMapping("/balance")
    public ResponseEntity<Void> updateBalance(@RequestParam(name = "balance") Long balance) {
        userService.updateBalance(balance);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/reissue-token")
    public ResponseEntity<ReissueTokenResDto> reissueToken(@RequestHeader("Authorization") String accessToken, @RequestHeader("Refresh-Token") String refreshToken) {
        Map<String, Object> map = userService.reissueToken(accessToken, refreshToken);
        ReissueTokenResDto reissueResDto = (ReissueTokenResDto) map.get("accessToken");
       refreshToken = (String) map.get("refreshToken");
        return ResponseEntity.ok()
                .header("Set-Cookie", jwtCookieName + "=" + refreshToken + "; HttpOnly; Max-Age=" + 1000L * 60 * 60 * 24 + "; SameSite=None; Secure")
                .body(reissueResDto);
    }

    @DeleteMapping("/{email}")
    public ResponseEntity<Void> deleteUserByAdmin(@PathVariable(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @GetMapping("/all")
    public ResponseEntity<Void> findUserList(@PathVariable(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

}
