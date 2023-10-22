package com.sss.studycafe.ticket.model.service;

import com.sss.studycafe.ticket.model.mapper.TicketMapper;
import com.sss.studycafe.ticket.model.vo.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TicketServiceImpl implements TicketService{
    @Autowired
    private TicketMapper ticketMapper;

    @Override
    public Ticket findByName(String itemName) {
        return ticketMapper.findByName(itemName);
    }
}
