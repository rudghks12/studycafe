package com.sss.studycafe.payid_ticket.model.mapper;

import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface PaidTicketMapper {
    List<PaidTicket> selectUsageDateSeat();

    List<PaidTicket> selectUserPaidTickets();

    List<PaidTicket> selectUserPaidTickets(@Param("userId") String userId);

    int insert(PaidTicket paidTicket);

    List<PaidTicket> findByUserIdAndTicketName(@Param("userId") String userId, @Param("ticketName") String ticketName);
    List<PaidTicket> findRoomScheduleByDate(@Param("date") String date,@Param("seat") int seat);

    List<Integer> findUsageLockers();

    int getAllTimeByUserId(String id);

    void updateRecentTime(@Param("id")String id, @Param("min") int min);
}
