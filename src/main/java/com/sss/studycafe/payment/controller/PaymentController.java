package com.sss.studycafe.payment.controller;

import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.sss.studycafe.own_coupon.model.service.OwnCouponService;
import com.sss.studycafe.payid_ticket.model.service.PaidTicketService;
import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import com.sss.studycafe.payment.model.service.PaymentService;
import com.sss.studycafe.payment.model.vo.Payment;
import com.sss.studycafe.user.model.service.UserService;
import com.sss.studycafe.user.model.vo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/payment")
public class PaymentController {
    @Autowired
    private PaymentService paymentService;

    @Autowired
    private PaidTicketService paidTicketService;

    @Autowired
    private UserService userService;

    @Autowired
    private OwnCouponService ownCouponService;

    @PostMapping("/save")
    public ResponseEntity<Map<String, Object>> payment_save(@RequestBody Map<String, Object> requestMap,
                                                            @AuthenticationPrincipal User user){
        Map<String, Object> map = new HashMap<>();
        int seat = 0;

        Payment payment = new Payment();

        String orderId = (String) ((Map<String, Object>) requestMap.get("data")).get("paymentKey");
        payment.setId(orderId);

        Integer totalAmount = (Integer) ((Map<String, Object>) requestMap.get("data")).get("totalAmount");
        payment.setCash(totalAmount);

        String method = (String) ((Map<String, Object>) requestMap.get("data")).get("method");
        payment.setMethod(method);

        if(method.equals("카드")){
            Map<String, Object> card = (Map<String, Object>) ((Map<String, Object>) requestMap.get("data")).get("card");
            String card_number = (String) card.get("number");
            payment.setCard(card_number);
        }

        String requestedAt = (String) ((Map<String, Object>) requestMap.get("data")).get("requestedAt");
        OffsetDateTime offsetDateTime = OffsetDateTime.parse(requestedAt, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
        payment.setOrderedAt(Date.from(offsetDateTime.toInstant()));

        String approvedAt = (String) ((Map<String, Object>) requestMap.get("data")).get("approvedAt");
        if (approvedAt != null){
            offsetDateTime = OffsetDateTime.parse(approvedAt, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
            payment.setPaidAt(Date.from(offsetDateTime.toInstant()));
        }

        payment.setUser_id(user.getId());

        PaidTicket paidTicket = new PaidTicket();

        String orderName = (String) ((Map<String, Object>) requestMap.get("data")).get("orderName");
        if(orderName.contains("@@")) {
            String coupon = orderName.substring(orderName.indexOf("@@") + 2);
            payment.setUsed_coupon(coupon);
            orderName = orderName.substring(0, orderName.indexOf("@@"));

            ownCouponService.useCoupon(user.getId(), coupon);
        }

        if(orderName.contains("지정석")) {
            seat = Integer.parseInt(orderName.substring(orderName.length()-3));
            orderName = orderName.substring(0,orderName.length()-3);
        } else if(orderName.contains("스터디룸")) {
            if(orderName.contains("4인")){
                seat = orderName.charAt(orderName.length() - 1) == '1' ? 401 : 457;
                orderName = orderName.substring(0,orderName.length()-1);
            } else {
                seat = 435;
            }

            int hour = Integer.parseInt(orderName.substring(orderName.length() - 1));
            String datetime = orderName.substring(orderName.indexOf("시간") + 2, orderName.length() - 2);

            orderName = orderName.substring(0, orderName.indexOf("시간") + 2);

            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");

            try {
                Date date = format.parse(datetime);

                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                calendar.add(Calendar.HOUR_OF_DAY, hour);

                Date endDate = calendar.getTime();

                paidTicket.setStart_date(date);
                paidTicket.setEnd_date(endDate);

            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else if (orderName.contains("사물함")) {
            seat = Integer.parseInt(orderName.substring(orderName.length()-2)) + 900;
            orderName = orderName.substring(0,orderName.length()-2);
        }

        paidTicket.setTicket_name(orderName.replace("\n","").trim());
        paidTicket.setUserId(user.getId());

        if(orderName.contains("지정석") || orderName.contains("스터디룸") || orderName.contains("사물함")) {
            paidTicket.setNo(seat);
        }

        paidTicketService.save(paidTicket);
        payment.setTicket_id(paidTicket.getId());

        paymentService.save(payment);

        Integer mileage = (Integer) ((Map<String, Object>) requestMap.get("data")).get("taxFreeAmount");
        int remain_mil = user.getMileage() - mileage + (int)Math.ceil(totalAmount/100);
        user.setMileage(remain_mil);
        userService.updateMileage(user.getEmail(), user.getMileage());

        map.put("result", "success");
        return ResponseEntity.ok(map);
    }

}
