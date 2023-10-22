package com.sss.studycafe.user.model.service;

import com.sss.studycafe.user.model.vo.User;

public interface UserService {

    User login(String email, String password);

    User findUserById(String email);

    int getUsersCount();

    int save(User user);

    int NeKasave(User user);

    int getUsersCount(String keyword, String kind);

    boolean checkEmailDuplicate(String email);

    boolean checkNicknameDuplicate(String nickname);

    boolean changePassword(String email, String newPassword);

    boolean secession(String email);

    int updateUserInfo(User user);

    void changeUserImage(String email, String imageUrl);

    String findEmailByUsernameAndPhone(String name, String phone);

    boolean checkEmail(String email);

    boolean resetPassword(String email, String newPassword);

    void updateMileage(String email, int remainMil);
}
