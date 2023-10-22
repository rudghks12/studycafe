package com.sss.studycafe.payid_ticket.model.service;

import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;

import java.util.Date;
import java.util.List;

public interface PaidTicketService {
    List<PaidTicket> findUsageAll();

    List<PaidTicket> selectUserPaidTickets(String userId);

    int save(PaidTicket paidTicket);

    PaidTicket getUserPaidTicket(String id, String ticketName);
    List<PaidTicket> findRoomScheduleByDate(String date, int idx);

    List<Integer> findUsageLockers();

    int getAllTimeByUserId(String id);

    void reduceTime(String id);
}
