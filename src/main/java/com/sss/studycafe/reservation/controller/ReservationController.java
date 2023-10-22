package com.sss.studycafe.reservation.controller;

import com.sss.studycafe.common.model.service.CommonService;
import com.sss.studycafe.own_coupon.model.service.OwnCouponService;
import com.sss.studycafe.own_coupon.model.vo.OwnCoupon;
import com.sss.studycafe.payid_ticket.model.service.PaidTicketService;
import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import com.sss.studycafe.payment.model.service.PaymentService;
import com.sss.studycafe.ticket.model.service.TicketService;
import com.sss.studycafe.ticket.model.vo.Ticket;
import com.sss.studycafe.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


@Slf4j
@Controller
@RequestMapping("/reservation")
public class ReservationController {
    @Autowired
    private CommonService commonService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private PaidTicketService paidTicketService;
    @Autowired
    private TicketService ticketService;
    @Autowired
    private OwnCouponService ownCouponService;

    @GetMapping("/reservation")
    public ModelAndView reservationHome(ModelAndView modelAndView) {

        modelAndView.setViewName("/reservation/reservationHome");
        return modelAndView;
    }

    @GetMapping("/time")
    public ModelAndView timeReservation(ModelAndView modelAndView,
                                        @AuthenticationPrincipal User user) {
        List<OwnCoupon> ownCouponList = ownCouponService.selectOwnCouponByUserId(user.getId());

        modelAndView.addObject("ownCouponList", ownCouponList);
        modelAndView.addObject("kind", "time");
        modelAndView.addObject("payment_num", UUID.randomUUID());
        modelAndView.addObject("user", user);

        modelAndView.setViewName("/reservation/payment");
        return modelAndView;
    }

    @GetMapping("/fixed")
    public ModelAndView fixedReservation(ModelAndView modelAndView,
                                         @Param(value = "seat") int seat,
                                         @AuthenticationPrincipal User user) {

        List<OwnCoupon> ownCouponList = ownCouponService.selectOwnCouponByUserId(user.getId());

        modelAndView.addObject("ownCouponList", ownCouponList);
        modelAndView.addObject("seat", seat);
        modelAndView.addObject("kind", "fixed");
        modelAndView.addObject("payment_num", UUID.randomUUID());
        modelAndView.addObject("user", user);

        modelAndView.setViewName("/reservation/payment");
        return modelAndView;
    }

    @GetMapping("/room")
    public ModelAndView roomReservation(ModelAndView modelAndView,
                                        @Param(value = "room") String room,
                                        @Param(value = "date") String date,
                                        @Param(value = "hour") int hour,
                                        @AuthenticationPrincipal User user) {

        String item_name = "";

        try{
            switch(room){
                case "4_room_1": item_name = "스터디룸(4인실) "; break;
                case "8_room"  : item_name = "스터디룸(8인실) "; break;
                case "4_room_2": item_name = "스터디룸(4인실) "; break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        item_name += (hour + "시간");

        Ticket ticket = ticketService.findByName(item_name);

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");

        try {
            Date _date = format.parse(date);
            modelAndView.addObject("date", _date);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        List<OwnCoupon> ownCouponList = ownCouponService.selectOwnCouponByUserId(user.getId());

        modelAndView.addObject("ownCouponList", ownCouponList);
        modelAndView.addObject("item_name", item_name);
        modelAndView.addObject("item_price", ticket.getPrice());
        modelAndView.addObject("kind", "room");
        modelAndView.addObject("payment_num", UUID.randomUUID());
        modelAndView.addObject("user", user);

        modelAndView.setViewName("/reservation/payment");
        return modelAndView;
    }

    @GetMapping("/selectSeat")
    public ModelAndView fixedtermseat(ModelAndView modelAndView,
                                      @AuthenticationPrincipal User user) {

        List<PaidTicket> paidTicketList = paidTicketService.selectUserPaidTickets(user.getId());
        String[] seatingMap = commonService.getSeatingChart();
        int ownSeat = 0;

        for (PaidTicket paidTicket : paidTicketList) {
            if(paidTicket.getNo() != 401 && paidTicket.getNo() != 435 && paidTicket.getNo() != 457
                && paidTicket.getNo() < 900){
                if(ownSeat == 0 && paidTicket.getUserId().equals(user.getId())){
                    ownSeat = paidTicket.getNo();
                }
                if(paidTicket.getNo() < seatingMap.length && paidTicket.getNo() != 0){
                    seatingMap[paidTicket.getNo()] += "U";
                }
            }
        }

        modelAndView.addObject("ownSeat", ownSeat);
        modelAndView.addObject("seatingMap", seatingMap);
        modelAndView.setViewName("/reservation/select_seat");
        return modelAndView;
    }

    @GetMapping("/selectLocker")
    public ModelAndView selectlocker(ModelAndView modelAndView) {
        List<Integer> lockers = paidTicketService.findUsageLockers();
        for (int i = 0; i < lockers.size(); i++) {
            int value = lockers.get(i);
            value -= 900;
            lockers.set(i, value);
        }

        Set<Integer> lockersSet = new HashSet<>(lockers);

        modelAndView.addObject("lockers", lockersSet);
        modelAndView.setViewName("/reservation/select_locker");
        return modelAndView;
    }

    @GetMapping("/paymentcompleted")
    public ModelAndView paymentcompleted(ModelAndView modelAndView,
                                         @AuthenticationPrincipal User user){

        modelAndView.addObject("user", user);
        modelAndView.setViewName("/reservation/paymentcompleted");
        return modelAndView;
    }

    @GetMapping("/selectRoom")
    public ModelAndView studyroomreservation(ModelAndView modelAndView) {

        modelAndView.setViewName("/reservation/studyroom");
        return modelAndView;
    }

    @GetMapping("/payment_confirm")
    public ModelAndView paymentConfirm(ModelAndView modelAndView) {

        modelAndView.setViewName("/middleware/payment_confirm");
        return modelAndView;
    }

    @GetMapping("/getAllByDate")
    public ResponseEntity<Map<String, Object>> getAllByDate(
            @Param(value = "date") String date,
            @Param(value = "room") String room
    ) {
        Map<String, Object> map = new HashMap<>();
        int idx = 0;

        switch (room) {
            case "4_room_1": idx = 401; break;
            case "4_room_2": idx = 457; break;
            case "8_room": idx = 435; break;
        }

        List<PaidTicket> paidTicketList = paidTicketService.findRoomScheduleByDate(date + "%", idx);

        map.put("result", paidTicketList);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/locker")
    public ModelAndView lockerReservation(ModelAndView modelAndView,
                                          @RequestParam(value = "no") int no,
                                          @AuthenticationPrincipal User user) {

        List<OwnCoupon> ownCouponList = ownCouponService.selectOwnCouponByUserId(user.getId());

        modelAndView.addObject("ownCouponList", ownCouponList);
        modelAndView.addObject("kind", "locker");
        modelAndView.addObject("payment_num", UUID.randomUUID());
        modelAndView.addObject("user", user);

        modelAndView.setViewName("/reservation/payment");
        return modelAndView;
    }

}
