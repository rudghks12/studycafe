package com.sss.studycafe.history.model.service;

import com.sss.studycafe.history.model.mapper.HistoryMapper;
import com.sss.studycafe.history.model.vo.History;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HistoryServiceImpl implements HistoryService{
    @Autowired
    HistoryMapper historyMapper;

    @Override
    public List<History> getInUseSeat() {

        return historyMapper.selectInUseTimeSeat();
    }

    @Override
    public List<History> selectHistoriesByUserIdWithPaging(String userId, int page, int itemsPerPage) {
        int startRow = (page - 1) * itemsPerPage;
        return historyMapper.selectHistoriesByUserIdWithPaging(userId, startRow, itemsPerPage);
    }

    @Override
    public int getCountByUserId(String userId) {
        return historyMapper.getCountByUserId(userId);
    }

    // 사용자의 체크인 기록을 저장합니다.
    @Override
    public void checkIn(String userId, int ticketNo) {
        try {
            historyMapper.insertCheckIn(userId, ticketNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 사용자의 체크아웃 시간을 업데이트합니다.
    public void checkOut(String userId) {
        try {
            historyMapper.updateCheckOut(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public History getHistoryByUserIdNotCheckOut(String id) {
        return historyMapper.getHistoryByUserIdNotCheckOut(id);
    }
}
