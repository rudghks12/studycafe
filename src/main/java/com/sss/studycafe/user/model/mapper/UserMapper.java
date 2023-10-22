package com.sss.studycafe.user.model.mapper;

import com.sss.studycafe.user.model.vo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@Mapper
public interface UserMapper {
    User selectUserById(@Param("email") String email);

    List<User> selectUsers(RowBounds rowBounds);
    List<User> selectUsersByKeywordAndKind(@Param("keyword") String keyword,
                                           @Param("kind") String kind,
                                           RowBounds rowBounds);

    int selectUsersCount();
    int selectUsersCountByKeywordAndKind(@Param("keyword") String keyword,
                                         @Param("kind") String kind);

    int releaseUsers(List<String> targetUsers);

    int suspendUsers(@Param("targetUsers") List<String> targetUsers, @Param("releaseDate") Timestamp releaseDate);

    int insertUser(@Param("user") User user);

    int insertNeKaUser(@Param("user") User user);

    int checkEmailDuplicate(@Param("email") String email);

    int checkNicknameDuplicate(@Param("nickname") String nickname);

    int updatePassword(Map<String, String> paramMap);

    int updateUserStatus(@Param("email") String email, @Param("status") String status);

    int updateUserInfo(User user);

    void changeUserImage(@Param("email")String email, @Param("imageUrl")String imageUrl);

    String findEmailByUsernameAndPhone(Map<String, String> params);

    int checkEmail(String email);

    int resetPassword(@Param("email") String email, @Param("newPassword") String newPassword);

    void changeMileage(@Param("email") String email, @Param("mileage") int remainMil);
}
