package com.richminime.global.util;

import com.richminime.global.exception.ForbiddenException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Objects;

public class SecurityUtils {

    public static String getLoggedInUserEmail() {
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

