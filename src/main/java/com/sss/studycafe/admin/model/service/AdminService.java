package com.sss.studycafe.admin.model.service;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.user.model.vo.User;

import java.util.Date;
import java.util.List;

public interface AdminService {
    void saveSeatMap(String map);

    List<User> getUsers(PageInfo pageInfo);
    List<User> getUsers(PageInfo pageInfo, String keyword, String kind);

    int releaseUser(List<String> targetUsers);

    int suspendUser(List<String> targetUsers, int suspendDay);

    String[] calWeeks(Date current);

}
