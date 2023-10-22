package com.sss.studycafe.ticket.model.service;

import com.sss.studycafe.ticket.model.vo.Ticket;

public interface TicketService {
    Ticket findByName(String itemName);
}
