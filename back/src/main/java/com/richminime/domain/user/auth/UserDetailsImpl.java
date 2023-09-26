package com.richminime.domain.user.auth;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.richminime.domain.user.domain.User;
import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Arrays;
import java.util.Collection;
import java.util.Objects;

@Getter
public class UserDetailsImpl implements UserDetails {

    private Long userId;
    private String email;
    @JsonIgnore
    private String password;
    private String authority;

    public UserDetailsImpl(Long userId, String email, String password, String authority) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.authority = authority;
    }

    public static BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public static String encoding(String userId) {
        return passwordEncoder.encode(userId);
    }

    public static UserDetailsImpl buildFromUser(User user) {

        return new UserDetailsImpl(
                user.getUserId(),
                user.getEmail(),
                encoding(user.getNickname()),
                user.getUserType().name()
        );
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Arrays.asList(new SimpleGrantedAuthority(authority));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        UserDetailsImpl user = (UserDetailsImpl) o;
        return Objects.equals(userId, user.userId);
    }
}
