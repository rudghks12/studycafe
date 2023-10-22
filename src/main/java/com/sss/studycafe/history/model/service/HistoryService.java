package com.sss.studycafe.history.model.service;

import com.sss.studycafe.history.model.vo.History;

import java.util.List;

public interface HistoryService {
    List<History> getInUseSeat();

    List<History> selectHistoriesByUserIdWithPaging(String userId, int page, int itemsPerPage);

    int getCountByUserId(String userId);

    void checkIn(String userId, int ticketNo);

    void checkOut(String id);

    History getHistoryByUserIdNotCheckOut(String id);
}
