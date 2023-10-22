package com.sss.studycafe.handler;

import org.springframework.security.authentication.*;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginFailuerHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

        if (exception instanceof UsernameNotFoundException) {
            request.setAttribute("message", "존재하지 않는 사용자입니다.");
        } else if (exception instanceof BadCredentialsException) {
            request.setAttribute("message", "아이디 또는 비밀번호가 틀립니다.");
        } else if (exception instanceof LockedException) {
            request.setAttribute("message", "잠긴 계정입니다.");
        } else if (exception instanceof DisabledException) {
            request.setAttribute("message", "삭제된 계정입니다.");
        } else if (exception instanceof AccountExpiredException) {
            request.setAttribute("message", "만료된 계정입니다.");
        } else if (exception instanceof CredentialsExpiredException) {
            request.setAttribute("message", "비밀번호가 만료된 계정입니다.");
        }
        String prevPrevPage = (String) request.getSession().getAttribute("prevPrevPage");
        request.getSession().setAttribute("prevPrevPage", prevPrevPage);

        request.getRequestDispatcher("/WEB-INF/views/common/message.jsp").forward(request, response);
    }
}
