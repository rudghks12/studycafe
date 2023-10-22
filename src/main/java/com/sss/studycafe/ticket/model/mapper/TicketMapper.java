package com.sss.studycafe.ticket.model.mapper;

import com.sss.studycafe.ticket.model.vo.Ticket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TicketMapper {
    Ticket findByName(@Param("ticketName")String ticketName);
}
