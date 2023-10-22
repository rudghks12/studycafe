package com.sss.studycafe.payid_ticket.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaidTicket {
    private int id;

    private Date end_date;

    private int no;

    private String ticket_name;

    private String userId;

    private int time;

    private Date start_date;
}
