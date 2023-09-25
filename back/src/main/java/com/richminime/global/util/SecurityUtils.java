package com.richminime.global.util;

import com.richminime.global.exception.ForbiddenException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.Objects;

@Component
public class SecurityUtils {

    public String getLoggedInUserEmail() {
        try {
            Authentication authentication = Objects.requireNonNull(SecurityContextHolder
                    .getContext()
                    .getAuthentication());

            if (authentication instanceof AnonymousAuthenticationToken) {
                authentication = null;
            }
            //이메일정보
            return authentication.getName();
        } catch (NullPointerException e) {
            throw new ForbiddenException();
        }
    }
}

