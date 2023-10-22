package com.sss.studycafe.Customer.model.service;


import com.sss.studycafe.Customer.model.vo.Notice;
import com.sss.studycafe.common.util.PageInfo;

import java.util.List;

public interface NoticeService {
    int getNoticeCount();

    List<Notice> getNoticeList(PageInfo pageInfo);

    Notice getNoticeById(int no);

    void addNotice(Notice notice);

    void editNotice(Notice notice);

    void deleteNotice(int noticeId);
}
