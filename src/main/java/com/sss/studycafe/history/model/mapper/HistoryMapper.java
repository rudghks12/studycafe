package com.sss.studycafe.history.model.mapper;

import com.sss.studycafe.history.model.vo.History;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface HistoryMapper {
    List<History> selectInUseTimeSeat();

    List<History> selectHistoriesByUserIdWithPaging(@Param("userId") String userId, @Param("startRow") int startRow, @Param("itemsPerPage") int itemsPerPage);

    int getCountByUserId(@Param("userId") String userId);

    void insertCheckIn(@Param("userId") String userId, @Param("ticketNo") int ticketNo);

    void updateCheckOut(@Param("userId") String userId);

    History getHistoryByUserIdNotCheckOut(String id);
}
