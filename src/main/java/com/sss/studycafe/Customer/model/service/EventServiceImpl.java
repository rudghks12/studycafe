package com.sss.studycafe.Customer.model.service;

import com.sss.studycafe.Customer.model.mapper.EventMapper;
import com.sss.studycafe.Customer.model.vo.Event;
import com.sss.studycafe.common.util.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventMapper eventMapper;

    @Override
    public int getEventCount() {
        return eventMapper.selectEventCount();
    }

    @Override
    public List<Event> getEventList(PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return eventMapper.getAllEvents(rowBounds);
    }

    @Override
    public int getEventCountByTitle(String searchTitle) {
        return eventMapper.selectEventCountByTitle(searchTitle);
    }
    @Override
    public List<Event> getEventListByTitle(String searchTitle) {
        return eventMapper.getEventListByTitle(searchTitle);
    }


    @Override
    public Event getEventById(int no) {
        return eventMapper.getEventById(no);
    }

    @Override
    public void addEvent(Event event) {
        eventMapper.insertEvent(event);
    }

    @Override
    public void editEvent(Event event) {
        eventMapper.editEvent(event);
    }

    @Override
    public void deleteEvent(int eventId) {
        eventMapper.deleteEvent(eventId);
    }
}
