package com.sss.studycafe.user.model.service;

import com.sss.studycafe.user.model.mapper.UserMapper;
import com.sss.studycafe.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Slf4j
public class userDetailsService implements UserDetailsService {

    @Autowired
    private UserMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = mapper.selectUserById(email);

        if (user == null) {
            throw new UsernameNotFoundException(email + "not found");
        }

        log.info("email : " + user.getEmail());
        log.info("passworrd : " + user.getPassword());
        log.info("status : " + user.getStatus());

        return user;
    }



}
