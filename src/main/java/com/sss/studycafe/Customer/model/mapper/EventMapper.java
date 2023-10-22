package com.sss.studycafe.Customer.model.mapper;

import com.sss.studycafe.Customer.model.vo.Event;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface EventMapper {
    // 이벤트 게시물 수 조회
    int selectEventCount();

    List<Event> getAllEvents(RowBounds rowBounds);

    Event getEventById(@Param("no") int no);

    void insertEvent(Event event);

    void editEvent(Event event);

    void deleteEvent(int eventId);

    List<Event> getEventListByTitle(String searchTitle);

    int selectEventCountByTitle(String searchTitle);
}
