package com.sss.studycafe.payment.model.vo;

import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
    private String id;

    private int cash;

    private String card;

    private String method;

    private Date orderedAt;

    private Date paidAt;

    private int ticket_id;

    private String user_id;

    private String ticketName;

    private String used_coupon;
}
