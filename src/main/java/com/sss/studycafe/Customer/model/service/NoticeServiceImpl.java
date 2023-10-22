package com.sss.studycafe.Customer.model.service;

import com.sss.studycafe.Customer.model.mapper.NoticeMapper;
import com.sss.studycafe.Customer.model.vo.Notice;
import com.sss.studycafe.common.util.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    @Override
    public int getNoticeCount() {
        return noticeMapper.selectNoticeCount();
    }

    // 현재 페이지에 표시할 게시글 목록을 가져옴
    @Override
    public List<Notice> getNoticeList(PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return  noticeMapper.getAllNotices(rowBounds);
    }

    @Override
    public Notice getNoticeById(int no) {
        return noticeMapper.getNoticeById(no);
    }

    @Override
    public void addNotice(Notice notice) {
        noticeMapper.insertNotice(notice);
    }

    @Override
    public void editNotice(Notice notice) {
        noticeMapper.editNotice(notice);
    }

    @Override
    public void deleteNotice(int noticeId) {
        noticeMapper.deleteNotice(noticeId);
    }
}
