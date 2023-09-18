package com.richminime.domain.user.api;

import com.richminime.domain.user.dto.request.AddUserRequest;
import com.richminime.domain.user.dto.request.GenerateConnectedIdRequest;
import com.richminime.domain.user.dto.request.LoginRequest;
import com.richminime.domain.user.dto.response.CheckEmailResponse;
import com.richminime.domain.user.dto.response.GenerateConnectedIdResponse;
import com.richminime.domain.user.dto.response.LoginResponse;
import com.richminime.domain.user.service.UserService;
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
    public ResponseEntity<Void> addUser(@RequestBody AddUserRequest addUserRequest) {
        userService.addUser(addUserRequest);
        return ResponseEntity.ok().build();
    }

    /**
     * 이메일 중복 검사
     * @param email
     * @return
     */
    @GetMapping("/check-login-email")
    public ResponseEntity<CheckEmailResponse> checkEmail(@RequestParam(name = "email") String email) {
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
    public ResponseEntity<GenerateConnectedIdResponse> generateConnectedId(@RequestBody GenerateConnectedIdRequest generateConnectedIdRequest) {
        return ResponseEntity.status(HttpStatus.CREATED).body(userService.generateConnectedId(generateConnectedIdRequest));
    }

    @PostMapping("/password")
    public ResponseEntity<Void> findPassword(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest loginRequest) {
        LoginResponse loginResponse = userService.login(loginRequest);
        return ResponseEntity.ok().body(loginResponse);
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestParam(name = "email") String email) {

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
