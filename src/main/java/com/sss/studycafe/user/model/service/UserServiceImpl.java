package com.sss.studycafe.user.model.service;

import com.sss.studycafe.user.model.mapper.UserMapper;
import com.sss.studycafe.user.model.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    @Override
    public User findUserById(String email) {

        return mapper.selectUserById(email);
    }

    @Override
    public int getUsersCount() {
        return mapper.selectUsersCount();
    }

    @Override
    public int getUsersCount(String keyword, String kind) {
        return mapper.selectUsersCountByKeywordAndKind(keyword, kind);
    }

    @Override
    public User login(String email, String password) {
        User user = null;

        user = this.findUserById(email);

        if(user == null || !passwordEncoder.matches(password, user.getPassword())) {
            return null;
        }

        return user;
    }

    @Override
    @Transactional
    public int save(User user) {
        int result = 0;

        if(user.getId() != null) {
            // update
        } else {
            // insert
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            result = mapper.insertUser(user);
        }

        return result;
    }

    @Override
    @Transactional
    public int NeKasave(User user) {
        int result = 0;

        if(user.getId() != null) {
            // update
        } else {
            // insert
            user.setPassword(passwordEncoder.encode(user.getPassword()));

            result = mapper.insertNeKaUser(user);
        }

        return result;
    }

    public boolean checkEmailDuplicate(String email) {

        int count = mapper.checkEmailDuplicate(email);

        return count > 0;
    }

    public boolean checkNicknameDuplicate(String nickname) {

        int count = mapper.checkNicknameDuplicate(nickname);

        return count > 0;
    }

    // 비밀번호 변경
    public boolean changePassword(String email, String newPassword) {
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("email", email);

        paramMap.put("newPassword", passwordEncoder.encode(newPassword));

        int updatedRows = mapper.updatePassword(paramMap);

        return updatedRows > 0;
    }

    // 회원 탈퇴
    @Override
    @Transactional
    public boolean secession(String email) {
        int result = mapper.updateUserStatus(email, "N");

        if (result <= 0) {
            return false;
        }
        SecurityContextHolder.clearContext();

        return true;
    }

    // 회원정보 수정
    @Override
    @Transactional
    public int updateUserInfo(User user) {

        return mapper.updateUserInfo(user);
    }

    public void changeUserImage(String email, String imageUrl) {
        try {
            System.out.println("정보: " + email + "," + imageUrl);
            mapper.changeUserImage(email, imageUrl);
        } catch (Exception e) {
            throw new RuntimeException("이미지 저장 중 오류가 발생했습니다.", e);
        }
    }

    // 이메일 찾기
    @Override
    public String findEmailByUsernameAndPhone(String name, String phone) {
        Map<String, String> params = new HashMap<>();
        params.put("name", name);
        params.put("phone", phone);

        return mapper.findEmailByUsernameAndPhone(params);
    }

    @Override
    public boolean checkEmail(String email) {

        int count = mapper.checkEmail(email);

        return count > 0;
    }

    @Override
    public boolean resetPassword(String email, String newPassword) {
        try {
            User user = mapper.selectUserById(email);
            if (user != null) {
                String hashedPassword = passwordEncoder.encode(newPassword);

                user.setPassword(hashedPassword);

                int updateResult = mapper.resetPassword(email, hashedPassword);

                if (updateResult == 1) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void updateMileage(String email, int remainMil) {
        mapper.changeMileage(email, remainMil);
    }
}
