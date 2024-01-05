package com.richminime.global.common.security;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.richminime.domain.user.domain.UserType;
import lombok.Builder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

public class CustomUserDetails implements UserDetails {

    Long userId;

    String email;

    String password;

    String nickname;

    String authority;

    Long balance;

    @Builder
    public CustomUserDetails(Long userId, String email, String password, String nickname, String userType, Long balance) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.authority = userType;
        this.balance = balance;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> auth = new ArrayList<>();
        if(authority.equals(UserType.ROLE_USER.getValue())){
            authority = "ROLE_USER";
        }
        if(authority.equals(UserType.ROLE_ADMIN.getValue())){
            authority = "ROLE_ADMIN";
        }
        auth.add(new SimpleGrantedAuthority(authority));
        return auth;
    }

    public Long getUserId() {
        return userId;
    }

    @JsonIgnore
    @Override
    public String getPassword() {
        return null;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return false;
    }

}
