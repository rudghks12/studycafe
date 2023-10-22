package com.sss.studycafe.payid_ticket.model.service;

import com.sss.studycafe.history.model.service.HistoryService;
import com.sss.studycafe.history.model.vo.History;
import com.sss.studycafe.payid_ticket.model.mapper.PaidTicketMapper;
import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import com.sss.studycafe.ticket.model.mapper.TicketMapper;
import com.sss.studycafe.ticket.model.vo.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class PaidTicketServiceImpl implements PaidTicketService {
    @Autowired
    PaidTicketMapper paidTicketMapper;
    @Autowired
    TicketMapper ticketMapper;
    @Autowired
    HistoryService historyService;

    @Override
    public List<PaidTicket> findUsageAll() {

        return paidTicketMapper.selectUsageDateSeat();
    }

    @Override
    public List<PaidTicket> selectUserPaidTickets(String userId) {
        return paidTicketMapper.selectUserPaidTickets(userId);
    }

    @Override
    public int save(PaidTicket paidTicket) {
        Ticket ticket = ticketMapper.findByName(paidTicket.getTicket_name());

        try{
            if (ticket.getKind().equals("TIME")) {
                //시간제
                paidTicket.setTime(ticket.getTime() * 60);
                return paidTicketMapper.insert(paidTicket);
            } else if (ticket.getKind().equals("TERM")) {
                //지정석
                Date today = new Date();
                paidTicket.setStart_date(today);

                String numericValue = ticket.getName().replaceAll("[^0-9]", "");

                Calendar cal = Calendar.getInstance();
                cal.setTime(today);
                cal.add(Calendar.MONTH, Integer.parseInt(numericValue));
                Date nextMonth = cal.getTime();

                paidTicket.setEnd_date(nextMonth);

                return paidTicketMapper.insert(paidTicket);
            } else if (ticket.getKind().equals("ROOM")) {
                //스터디룸
                return paidTicketMapper.insert(paidTicket);
            } else if (ticket.getKind().equals("LOCK")) {
                //라커
                Date today = new Date();
                paidTicket.setStart_date(today);

                String numericValue = ticket.getName().replaceAll("[^0-9]", "");

                Calendar cal = Calendar.getInstance();
                cal.setTime(today);
                cal.add(Calendar.WEEK_OF_MONTH, Integer.parseInt(numericValue));
                Date nextMonth = cal.getTime();

                paidTicket.setEnd_date(nextMonth);

                return paidTicketMapper.insert(paidTicket);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public List<PaidTicket> findRoomScheduleByDate(String date, int idx) {
        return paidTicketMapper.findRoomScheduleByDate(date, idx);
    }

    @Override
    public List<Integer> findUsageLockers() {
        return paidTicketMapper.findUsageLockers();
    }

    @Override
    public int getAllTimeByUserId(String id) {
        return paidTicketMapper.getAllTimeByUserId(id);
    }

    @Override
    public void reduceTime(String id) {
        History history = historyService.getHistoryByUserIdNotCheckOut(id);

        Date checkInDate = history.getCheckIn();
        Date currentDate = new Date();

        long diffInMillis = currentDate.getTime() - checkInDate.getTime();
        int diffInMinutes = (int) Math.ceil(diffInMillis / (1000 * 60));

        paidTicketMapper.updateRecentTime(id, diffInMinutes);
    }

    @Override
    public PaidTicket getUserPaidTicket(String userId, String ticketName) {
        List<PaidTicket> paidTickets = paidTicketMapper.findByUserIdAndTicketName(userId, ticketName);

        if (!paidTickets.isEmpty()) {
            return paidTickets.get(0);
        }
        return null;
    }
}
