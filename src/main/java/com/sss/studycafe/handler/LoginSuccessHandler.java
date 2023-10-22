package com.sss.studycafe.handler;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String email = userDetails.getUsername();

        String prevPrevPage = (String) request.getSession().getAttribute("prevPrevPage");

        String refererUrl = request.getHeader("Referer");

        if(email.startsWith("NAVER") || email.startsWith("KAKAO")) {
            response.sendRedirect(prevPrevPage != null ? prevPrevPage : "/studycafe");
        } else {
            response.sendRedirect(refererUrl != null ? refererUrl : "/studycafe");
        }
    }
}
