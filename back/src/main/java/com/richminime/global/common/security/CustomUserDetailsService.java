package com.richminime.global.common.security;


import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.exception.UserExceptionMessage;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(username).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
        return CustomUserDetails.builder()
                .email(user.getEmail())
                .password(user.getPassword())
                .nickname(user.getNickname())
                .balance(user.getBalance())
                .userType(user.getUserType())
                .build();
    }

}
