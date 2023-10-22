package com.sss.studycafe.Customer.model.mapper;

import com.sss.studycafe.Customer.model.vo.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface NoticeMapper {
    // 게시물 수 조회
    int selectNoticeCount();

    // 전체 게시물 조회
    List<Notice> getAllNotices(RowBounds rowBounds);

    Notice getNoticeById(@Param("no") int no);

    void insertNotice(Notice notice);

    void editNotice(Notice notice);

    void deleteNotice(int noticeId);
}


