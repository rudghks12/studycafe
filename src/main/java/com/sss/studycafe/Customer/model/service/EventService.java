package com.sss.studycafe.Customer.model.service;

import com.sss.studycafe.Customer.model.vo.Event;
import com.sss.studycafe.common.util.PageInfo;

import java.util.List;

public interface EventService {
    int getEventCount();

    List<Event> getEventList(PageInfo pageInfo);

    int getEventCountByTitle(String searchTitle);

    Event getEventById(int no);

    void addEvent(Event event);

    void editEvent(Event event);

    void deleteEvent(int eventId);

    List<Event> getEventListByTitle(String searchTitle);
}
