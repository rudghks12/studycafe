package com.sss.studycafe.admin.controller;

import com.sss.studycafe.admin.model.service.AdminService;
import com.sss.studycafe.common.model.service.CommonService;
import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.history.model.service.HistoryService;
import com.sss.studycafe.history.model.vo.History;
import com.sss.studycafe.payid_ticket.model.service.PaidTicketService;
import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import com.sss.studycafe.payment.model.service.PaymentService;
import com.sss.studycafe.payment.model.vo.Payment;
import com.sss.studycafe.user.model.service.UserService;
import com.sss.studycafe.user.model.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private CommonService commonService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private PaidTicketService paidTicketService;

    @Autowired
    private HistoryService historyService;

    @Autowired
    private UserService userService;

    @Autowired
    private PaymentService paymentService;

    public static final long WEEK = 604800000;

    @GetMapping("/modseatingchart")
    public ModelAndView ModSeatingChart(ModelAndView modelAndView) {

        modelAndView.addObject("seatingMap", commonService.getSeatingChart());
        modelAndView.setViewName("admin/modseatingchart");

        return modelAndView;
    }

    @PostMapping("/modseatingchart")
    public ResponseEntity<Map<String, Object>> ModSeatingChart(@RequestBody Map<String, Object> requestMap){
        int result = 0;
        Map<String, Object> map = new HashMap<>();

        String seatingMap = (String) requestMap.get("map");

        adminService.saveSeatMap(seatingMap);

        map.put("resultCode", result);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/usagestatus")
    public ModelAndView UsageStatus(ModelAndView modelAndView) {
        List<PaidTicket> paidTicketList = paidTicketService.findUsageAll();
        String[] seatingMap = commonService.getSeatingChart();
        List<Integer> lockers = new ArrayList<Integer>();

        for (PaidTicket paidTicket : paidTicketList) {
            if(paidTicket.getNo() != 401 && paidTicket.getNo() != 435 && paidTicket.getNo() != 457){
                if(paidTicket.getNo() < seatingMap.length){
                    seatingMap[paidTicket.getNo()] += "U";
                } else {
                    lockers.add(paidTicket.getNo() - 900);
                }
            }
        }

        List<History> histories = historyService.getInUseSeat();

        modelAndView.addObject("lockers", lockers);
//        modelAndView.addObject("paidTicketList", paidTicketList);
        modelAndView.addObject("seatingMap", seatingMap);
        modelAndView.addObject("histories", histories);

        modelAndView.setViewName("admin/usagestatus");

        return modelAndView;
    }

    @GetMapping("/usermanage")
    public ModelAndView UserManagement(ModelAndView modelAndView,
                                       @RequestParam(value = "page", defaultValue = "1") int page,
                                       @RequestParam(value = "keyword",defaultValue = "") String keyword,
                                       @RequestParam(value = "kind", defaultValue = "") String kind) {
        int listCount = 0;
        PageInfo pageInfo = null;
        List<User> list = null;

        System.out.println(keyword);
        System.out.println(kind);

        if(keyword.equals("")){
            listCount = userService.getUsersCount();
            pageInfo = new PageInfo(page, 20, listCount, 20);
            list = adminService.getUsers(pageInfo);
        } else {
            listCount = userService.getUsersCount(keyword, kind);
            pageInfo = new PageInfo(page, 20, listCount, 20);
            list = adminService.getUsers(pageInfo, keyword, kind);
        }

        String[] seatingMap = commonService.getSeatingChart();

        modelAndView.addObject("seatingMap", seatingMap);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("users", list);
        modelAndView.addObject("count", listCount);

        modelAndView.setViewName("admin/usermanage");
        return modelAndView;
    }

    @PostMapping("/ReleaseUser")
    public ResponseEntity<Map<String, Object>> ReleaseUser(@RequestBody Map<String, Object> requestMap){
        int result = 0;
        Map<String, Object> map = new HashMap<>();

        List<String> targetUsers = (List<String>)requestMap.get("selected");

        adminService.releaseUser(targetUsers);

        map.put("resultCode", result);
        return ResponseEntity.ok(map);
    }

    @PostMapping("/SuspendUser")
    public ResponseEntity<Map<String, Object>> SuspendUser(@RequestBody Map<String, Object> requestMap){
        int result = 0;
        int suspend_day = 0;
        Map<String, Object> map = new HashMap<>();

        List<String> targetUsers = (List<String>)requestMap.get("selected");

        System.out.println(targetUsers);

        try{
            suspend_day = Integer.parseInt(requestMap.get("suspend_day").toString());
        }catch(NumberFormatException e){
            e.printStackTrace();
        }

        adminService.suspendUser(targetUsers, suspend_day);

        map.put("resultCode", result);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/salesstatus")
    public ModelAndView SalesStatus(ModelAndView modelAndView,
                                    @RequestParam(value = "page", defaultValue = "1") int page) {
        int listCount = 0;
        PageInfo pageInfo = null;
        List<Payment> list = null;
        List<Payment> chart_datas = null;

        int[] amounts = new int[12];
        int[] kinds = new int[4];

        listCount = paymentService.count();
        pageInfo = new PageInfo(page, 15, listCount, 15);
        list = paymentService.getAll(pageInfo);


        chart_datas = paymentService.getAllByBeforeThreeMonth();

        Date current = new Date();

        modelAndView.addObject("weeks", adminService.calWeeks(current));

        current.setTime(current.getTime() - WEEK);
        int i = 0;

        for (Payment payment : chart_datas) {
            if(payment.getTicketName().contains("이용권")){
                kinds[0]++;
            }else if(payment.getTicketName().contains("지정석")){
                kinds[1]++;
            }else if(payment.getTicketName().contains("4인실")){
                kinds[2]++;
            }else if(payment.getTicketName().contains("8인실")){
                kinds[3]++;
            }

            while (current.after(payment.getPaidAt())){
                current.setTime(current.getTime() - WEEK); i++;
            }
            amounts[i] += payment.getCash();
        }

        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("kinds", kinds);
        modelAndView.addObject("amounts", amounts);
        modelAndView.addObject("list", list);

        modelAndView.setViewName("admin/salesstatus");
        return modelAndView;
    }
}
