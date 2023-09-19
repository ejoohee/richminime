package com.richminime.domain.user.api;

import com.richminime.domain.user.dto.request.AddUserReqDto;
import com.richminime.domain.user.dto.request.GenerateConnectedIdReqDto;
import com.richminime.domain.user.dto.request.LoginReqDto;
import com.richminime.domain.user.dto.response.CheckEmailResDto;
import com.richminime.domain.user.dto.response.GenerateConnectedIdResDto;
import com.richminime.domain.user.dto.response.LoginResDto;
import com.richminime.domain.user.service.UserService;
import com.richminime.global.dto.ResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    /**
     * 회원 가입
     * @param addUserRequest
     * @return
     */
    @PostMapping
    public ResponseEntity<ResponseDto<Void>> addUser(@RequestBody AddUserReqDto addUserRequest) {
        userService.addUser(addUserRequest);
        return ResponseEntity.ok().build();
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

        return ResponseEntity.ok().build();
    }

    @PostMapping("/check-email-code")
    public ResponseEntity<Void> checkEmailCode(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
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
     * @param loginRequest
     * @return
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResDto> login(@RequestBody LoginReqDto loginRequest) {
        LoginResDto loginResponse = userService.login(loginRequest);
        return ResponseEntity.ok().body(loginResponse);
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestParam(name = "email") String email, @RequestHeader("Authorization") String accessToken) {
        userService.logout(email, accessToken);
        return ResponseEntity.ok().build();
    }

    @PutMapping
    public ResponseEntity<Void> updateUser(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @PutMapping("/password")
    public ResponseEntity<Void> updatePassword(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteUser(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<Void> findUser(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @GetMapping("/balance")
    public ResponseEntity<Void> findBalance(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @PatchMapping("/balance")
    public ResponseEntity<Void> updateBalance(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @PostMapping("/reissue-token")
    public ResponseEntity<Void> reissueToken(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
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
