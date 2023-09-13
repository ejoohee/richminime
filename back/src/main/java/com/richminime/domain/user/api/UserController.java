package com.richminime.domain.user.api;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    @GetMapping("/check-login-email")
    public ResponseEntity<Void> checkEmail(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
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
    public ResponseEntity<Void> generateConnectedId(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @PostMapping("/password")
    public ResponseEntity<Void> findPassword(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
    }

    @PostMapping("/login")
    public ResponseEntity<Void> login(@RequestParam(name = "email") String email) {

        return ResponseEntity.ok().build();
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
