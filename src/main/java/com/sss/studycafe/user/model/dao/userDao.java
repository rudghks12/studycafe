package com.sss.studycafe.user.model.dao;

import com.sss.studycafe.user.model.vo.User;
import org.apache.ibatis.session.SqlSession;

public class userDao {
    public User findUserById(SqlSession session, String email) {

        return session.selectOne("userMapper.selectUserById", email);
    }
}
