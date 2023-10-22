package com.sss.studycafe.user.controller;

import com.sss.studycafe.common.model.service.CommonService;
import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.history.model.service.HistoryService;
import com.sss.studycafe.history.model.vo.History;
import com.sss.studycafe.own_coupon.model.service.OwnCouponService;
import com.sss.studycafe.own_coupon.model.vo.OwnCoupon;
import com.sss.studycafe.payid_ticket.model.service.PaidTicketService;
import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import com.sss.studycafe.payment.model.service.PaymentService;
import com.sss.studycafe.payment.model.vo.Payment;
import com.sss.studycafe.user.model.service.UserService;
import com.sss.studycafe.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class UserController {

    @Autowired
    private UserService service;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private HistoryService historyService;

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private PaidTicketService paidTicketService;

    @Autowired
    private OwnCouponService ownCouponService;

    @Autowired
    private CommonService commonService;

    @GetMapping("/agree")
    public ModelAndView agree(ModelAndView modelAndView) {

        log.info("agree() 호출 - 이용약관 페이지 요청");

        modelAndView.setViewName("/enroll/agree");

        return modelAndView;
    }

    @GetMapping("/enroll")
    public ModelAndView enroll(ModelAndView modelAndView) {

        log.info("enroll() 호출 - 회원 가입 페이지 요청");

        modelAndView.setViewName("/enroll/enroll");

        return modelAndView;
    }
    @GetMapping("/enrollComplete")
    public ModelAndView enrollComplete(ModelAndView modelAndView, HttpSession session) {

        log.info("enrollComplete() - 회원 가입 완료 페이지 요청");

        String enrollName = (String) session.getAttribute("enroll_name");
        modelAndView.addObject("enroll_name", enrollName);
        modelAndView.setViewName("/enroll/enrollComplete");

        return modelAndView;
    }

    @GetMapping("/myPage")
    public ModelAndView myPage(ModelAndView modelAndView) {

        log.info("myPage() - 마이페이지 요청");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();


        modelAndView.addObject("user", user);

        modelAndView.setViewName("/myPage/myPage");

        return modelAndView;
    }

    @GetMapping("/useHistory")
    public ModelAndView useHistory(
            ModelAndView modelAndView,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "tabIndex", defaultValue = "0") int tabIndex) {


        int itemsPerPage = 10;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        List<History> histories = historyService.selectHistoriesByUserIdWithPaging(user.getId(), page, itemsPerPage);
        List<PaidTicket> paidTickets = paidTicketService.selectUserPaidTickets(user.getId());
        List<OwnCoupon> ownCoupons = ownCouponService.selectOwnCouponByUserId(user.getId());
        System.out.println(ownCoupons);

        int totalCount = historyService.getCountByUserId(user.getId());

        int pagesPerBlock = 10;
        PageInfo pageInfo = new PageInfo(page, itemsPerPage, totalCount, pagesPerBlock);

        modelAndView.addObject("paidTickets", paidTickets);
        modelAndView.addObject("histories", histories);
        modelAndView.addObject("ownCoupons", ownCoupons);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("user", user);
        modelAndView.setViewName("/myPage/useHistory");

        return modelAndView;
    }



    @GetMapping("/paymentHistory")
    public ModelAndView paymentHistory(ModelAndView modelAndView,
                                       @RequestParam(value = "page", defaultValue = "1") int page
    ) {

        log.info("paymentHistory() - 결제내역 요청");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        int listCount = 0;
        PageInfo pageInfo = null;

        listCount = paymentService.getCountByUserId(user.getId());
        pageInfo = new PageInfo(page, 15, listCount, 15);
        List<Payment> list =  paymentService.getAllByUserId(pageInfo, user.getId());

        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("list", list);
        modelAndView.addObject("user", user);
        modelAndView.setViewName("/myPage/paymentHistory");

        return modelAndView;
    }

    @GetMapping("/paymentHistoryById")
    public ResponseEntity<Map<String, Object>> getPaymentHistoryById(@RequestParam("id") String id) {
        Map<String, Object> map = new HashMap<>();

        Payment payment = paymentService.getPaymentById(id);
        log.info(payment.toString());

        map.put("result", payment);
        return ResponseEntity.ok(map);
    }

    @GetMapping("/userSearch")
    public ModelAndView userSearch(ModelAndView modelAndView) {

        log.info("아이디/비밀번호 찾기 호출");

        modelAndView.setViewName("/myPage/userSearch");

        return modelAndView;
    }

    @GetMapping("/checkEmail")
    @ResponseBody
    public ResponseEntity<Map<String, String>> checkEmail(@RequestParam String email) {
        Map<String, String> response = new HashMap<>();

        log.info("이메일 전송 요청");

        boolean emailExists = service.checkEmail(email);

        if (emailExists) {
            response.put("message", "이메일이 존재합니다.");
            return ResponseEntity.ok().body(response);
        } else {
            response.put("message", "일치하는 이메일을 찾을 수 없습니다.");
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/kakaoLogin")
    public ModelAndView kakaoLogin(ModelAndView modelAndView) {
        modelAndView.setViewName("/middleware/kakao_auth");

        return modelAndView;
    }

    @GetMapping("/naverLogin")
    public ModelAndView naverLogin(ModelAndView modelAndView) {
        modelAndView.setViewName("/middleware/naver_auth");

        return modelAndView;
    }

    // 회원가입
    @PostMapping("/enroll")
    public ModelAndView enroll(ModelAndView modelAndView,
                               @RequestParam Map<String, Object> requestMap, HttpSession session) {
        log.info("enroll() 호출 - 회원 가입 요청");

        User user = new User();

        String email1 = (String) requestMap.get("enroll_email");
        String email2 = (String) requestMap.get("enroll_email2");

        user.setEmail(email1 + "@" + email2);
        user.setPassword((String) requestMap.get("enroll_password"));
        user.setName((String) requestMap.get("enroll_name"));
        user.setNickname((String) requestMap.get("enroll_nickname"));

        String phone1 = (String) requestMap.get("enroll_phone");
        String phone2 = (String) requestMap.get("enroll_phone2");
        String phone3 = (String) requestMap.get("enroll_phone3");

        user.setPhone(phone1 + "-" + phone2 + "-" + phone3);

        session.setAttribute("enroll_name", user.getName());

        boolean isEmailDuplicate = service.checkEmailDuplicate(user.getEmail());

        boolean isNicknameDuplicate = service.checkNicknameDuplicate(user.getNickname());

        if (isEmailDuplicate || isNicknameDuplicate) {
            modelAndView.addObject("msg", "중복된 이메일 또는 닉네임이 있습니다.");
            modelAndView.addObject("location", "/enroll");
        } else {
            int result = service.save(user);

            if (result > 0) {
                modelAndView.addObject("msg", "회원 가입 성공");

                User enrollUser = service.findUserById(user.getEmail());
                String newUserId = enrollUser.getId();
                log.info(newUserId);

                ownCouponService.addCouponForNewUser(newUserId);
                modelAndView.addObject("location", "/enrollComplete");
            } else {
                modelAndView.addObject("msg", "회원 가입 실패");
                modelAndView.addObject("location", "/enroll");
            }
        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }

    // 이메일 중복확인
    @PostMapping("/checkEmailDuplicate")
    @ResponseBody
    public Map<String, Object> checkEmailDuplicate(@RequestBody Map<String, String> requestMap) {
        Map<String, Object> resultMap = new HashMap<>();

        log.info("이메일 중복확인 요청");

        String email = requestMap.get("email");
        boolean isDuplicate = service.checkEmailDuplicate(email);

        resultMap.put("isDuplicate", isDuplicate);

        return resultMap;
    }

    // 닉네임 중복확인
    @PostMapping("/checkNicknameDuplicate")
    @ResponseBody
    public Map<String, Object> checkNicknameDuplicate(@RequestBody Map<String, String> requestMap) {
        Map<String, Object> resultMap = new HashMap<>();

        log.info("닉네임 중복확인 요청");

        String nickname = requestMap.get("nickname");
        boolean isDuplicate = service.checkNicknameDuplicate(nickname);

        resultMap.put("isDuplicate", isDuplicate);

        return resultMap;
    }

    // 비밀번호 변경
    @PostMapping("/passwordChange")
    public ModelAndView changePassword(ModelAndView modelAndView,
                                       @RequestParam("currentPassword") String currentPassword,
                                       @RequestParam("newPassword") String newPassword,
                                       @RequestParam("confirmPassword") String confirmPassword) {

        log.info("비밀번호 변경 요청");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            modelAndView.addObject("msg", "현재 비밀번호가 올바르지 않습니다.");
            modelAndView.addObject("location", "/myPage");
            modelAndView.setViewName("common/msg");
            return modelAndView;
        }

        if (!newPassword.equals(confirmPassword)) {
            modelAndView.addObject("msg", "새 비밀번호와 비밀번호 확인 값이 일치하지 않습니다.");
            modelAndView.addObject("location", "/myPage");
            modelAndView.setViewName("common/msg");
            return modelAndView;
        }

        boolean passwordChanged = service.changePassword(user.getEmail(), newPassword);

        if (passwordChanged) {
            modelAndView.addObject("msg", "비밀번호가 변경되었습니다.");
            modelAndView.addObject("location", "/myPage");

        } else {
            modelAndView.addObject("msg", "비밀번호 변경에 실패했습니다.");
            modelAndView.addObject("location", "/myPage");

        }

        modelAndView.setViewName("/common/msg");

        return modelAndView;
    }

    // 회원 탈퇴
    @PostMapping("/secession")
    public RedirectView secession(HttpSession session) {
        log.info("secession() 호출 - 회원 탈퇴 요청");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        if (service.secession(user.getEmail())) {
            session.invalidate();
            SecurityContextHolder.clearContext();

            return new RedirectView("/studycafe");
        } else {
            return new RedirectView("/studycafe/myPage");
        }
    }

    // 회원정보 수정
    @PostMapping("/updateUserInfo")
    public ModelAndView updateUserInfo(ModelAndView modelAndView,
                                       @RequestParam("nickname") String nickname,
                                       @RequestParam("phone") String phone,
                                       HttpSession session) {

        log.info("updateUserInfo() 호출 - 회원 정보 수정 요청");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        if (!nickname.equals(user.getNickname())) {
            boolean isNicknameDuplicate = service.checkNicknameDuplicate(nickname);
            if (isNicknameDuplicate) {
                modelAndView.addObject("msg", "이미 사용 중인 닉네임입니다.");
                modelAndView.addObject("location", "/myPage");
                modelAndView.setViewName("common/msg");
                return modelAndView;
            }
        }

        user.setNickname(nickname);
        user.setPhone(phone);

        int result = service.updateUserInfo(user);

        if (result > 0) {
            modelAndView.addObject("msg", "회원 정보가 성공적으로 수정되었습니다.");
            modelAndView.addObject("location", "/myPage");
        } else {
            modelAndView.addObject("msg", "회원 정보 수정에 실패했습니다.");
            modelAndView.addObject("location", "/myPage");
        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }

    // 이미지 저장
    @RequestMapping(value = "/changeUserImage", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> changeUserImage(ModelAndView modelAndView, @RequestBody Map<String, String> requestData) {
        String email = requestData.get("email");
        String imageUrl = requestData.get("imageUrl");

        try {
            service.changeUserImage(email,imageUrl);

            User updatedUser = service.findUserById(email);
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null) {
                ((User) authentication.getPrincipal()).setImage(updatedUser.getImage());
            }

            return new ResponseEntity<>("이미지가 성공적으로 저장되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            log.error("이미지 저장 중 오류 발생: " + e.getMessage(), e);
            return new ResponseEntity<>("이미지 저장 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 이메일 찾기
    @PostMapping("/findEmail")
    @ResponseBody
    public ResponseEntity<Map<String, String>> findEmail(@RequestParam String name, @RequestParam String phone) {
        String email = service.findEmailByUsernameAndPhone(name, phone);
        Map<String, String> response = new HashMap<>();

        if (email != null) {
            response.put("message", "이메일을 찾았습니다.");
            response.put("email", email);
            return ResponseEntity.ok().body(response);
        } else {
            response.put("message", "일치하는 이메일을 찾을 수 없습니다.");
            return ResponseEntity.notFound().build();
        }
    }

    // 비밀번호 재설정
    @PostMapping("/resetPassword")
    public ModelAndView resetPassword(ModelAndView modelAndView,
                                      @RequestParam(required = true, name = "passwordStep_email") String email,
                                      @RequestParam(required = true) String newPassword) {
        boolean success = service.resetPassword(email, newPassword);
        log.info("비밀번호 재설정 요청");
        log.info(email);

        if (success) {
            modelAndView.addObject("msg", "비밀번호가 성공적으로 변경되었습니다.");
        } else {
            modelAndView.addObject("msg", "비밀번호 변경에 실패했습니다.");
            modelAndView.addObject("location", "/resetPassword");
        }

        System.out.println(success);
        modelAndView.setViewName("/common/msg");

        return modelAndView;
    }

    // 카카오
    @PostMapping("/kakaoLogin")
    ResponseEntity<Map<String, Object>> kakaoLogin(@RequestBody Map<String, Object> requestMap){
        int result = 0;
        Map<String, Object> map = new HashMap<>();

        log.info("카카오 로그인 요청");

        User user = new User();

        String email = "KAKAO_";
        String nickname = "KAKAO_";

        email += requestMap.get("id").toString();
        nickname += requestMap.get("nickname").toString();

        user.setEmail(email);

        boolean isEmailDuplicate = service.checkEmailDuplicate(user.getEmail());

        if(isEmailDuplicate){
            user = service.findUserById(user.getEmail());
            result = 1;

            service.changeUserImage(user.getEmail(), requestMap.get("image").toString());

        } else {
            user.setNickname(nickname);
            user.setImage(requestMap.get("image").toString());
            user.setPassword(requestMap.get("id").toString());
            user.setName("카카오");
            user.setPhone("KAKAO");

            try{
                service.NeKasave(user);
            }catch (Exception e){
                e.printStackTrace();
            }
        }


        map.put("resultCode", result);
        return ResponseEntity.ok(map);
    }

    // 네이버
    @PostMapping("/naverLogin")
    public ResponseEntity<Map<String, Object>> naverLogin(@RequestBody Map<String, Object> requestMap) {
        int result = 0;
        Map<String, Object> map = new HashMap<>();

        log.info("네이버 로그인 요청");

        User user = new User();


        String email = "NAVER_";
        String nickname = "NAVER_";

        email += requestMap.get("id").toString();
        nickname += requestMap.get("nickname").toString();

        user.setEmail(email);

        boolean isEmailDuplicate = service.checkEmailDuplicate(user.getEmail());

        if (isEmailDuplicate) {
            user = service.findUserById(user.getEmail());
            result = 1;

            service.changeUserImage(user.getEmail(), requestMap.get("image").toString());

        } else {
            user.setNickname(nickname);
            user.setImage(requestMap.get("image").toString());
            user.setPassword(requestMap.get("id").toString());
            user.setName(requestMap.get("name").toString());
            user.setPhone(requestMap.get("phone").toString());

            try{
                service.NeKasave(user);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        map.put("resultCode", result);
        return ResponseEntity.ok(map);
    }

    // 지정석 이용권 보유 여부
    @PostMapping("/checkTicket")
    public ResponseEntity<Map<String, Object>> checkFixedTicket(@RequestBody Map<String, String> requestBody) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        String ticketName = requestBody.get("ticketName");
        Map<String, Object> response = new HashMap<>();

        if(ticketName.equals("지정석")){
            PaidTicket paidTicket = paidTicketService.getUserPaidTicket(user.getId(), ticketName);

            String[] seatingMap = commonService.getSeatingChart();

            if (paidTicket != null) {
                response.put("fixedTicket", true);
                response.put("ticketNo", paidTicket.getNo());
                response.put("seatName", seatingMap[paidTicket.getNo()]);
            } else {
                response.put("fixedTicket", false);
            }
        } else if(ticketName.equals("일반석")){
            try{
                int allMin = paidTicketService.getAllTimeByUserId(user.getId());

                if (allMin > 0) {
                    response.put("fixedTicket", true);
                    response.put("allMin", allMin);
                } else {
                    response.put("fixedTicket", false);
                }
            } catch (Exception e) {
                response.put("fixedTicket", false);
            }
        }

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    // 지정석 체크인
    @PostMapping("/checkIn")
    public ResponseEntity<String> checkIn(@RequestParam("ticketNo") int ticketNo,
                                          HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        historyService.checkIn(user.getId(), ticketNo);
        session.setAttribute("checkIn", "fixed");

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    // 지정석 체크아웃
    @PostMapping("/checkOut")
    public ResponseEntity<String> checkOut(@RequestParam("ticketName") String ticketName,
                                           HttpSession session) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();

        log.info("퇴실 요청");

        if(ticketName.equals("일반석")) {
            paidTicketService.reduceTime(user.getId());
        }

        historyService.checkOut(user.getId());
        session.setAttribute("checkIn", "none");

        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    @GetMapping("/selectCheckInSeat")
    public ModelAndView selectCheckInSeat(ModelAndView modelAndView) {
        List<PaidTicket> paidTicketList = paidTicketService.findUsageAll();
        String[] seatingMap = commonService.getSeatingChart();

        for (PaidTicket paidTicket : paidTicketList) {
            if(paidTicket.getNo() < seatingMap.length){
                seatingMap[paidTicket.getNo()] += "U";
            }
        }

        modelAndView.addObject("seatingMap", seatingMap);
        modelAndView.setViewName("/common/selectCheckInSeat");
        return modelAndView;
    }

    @GetMapping("/timeCheckIn")
    public ModelAndView timeCheckIn(ModelAndView modelAndView,
                                    @Param(value = "no") int no,
                                    @AuthenticationPrincipal User user,
                                    HttpSession session) {

        historyService.checkIn(user.getId(), no);
        session.setAttribute("checkIn", "time");

        modelAndView.addObject("msg", "입실하셨습니다.");
        modelAndView.addObject("location", "/");

        modelAndView.setViewName("/common/msg");
        return modelAndView;
    }

    @GetMapping("/defaultCheck")
    public ResponseEntity<String> defaultCheck(@AuthenticationPrincipal User user,
                                     HttpSession session) {

        History history = historyService.getHistoryByUserIdNotCheckOut(user.getId());
        String[] seatingMap = commonService.getSeatingChart();
        String result = "none";

        try {
            if(seatingMap[history.getSeat()].contains("F")) {
                result = "fixed";
            } else {
                result = "time";
            }
        } catch(Exception e) {
            result = "none";
        }

        session.setAttribute("checkIn", result);

        return new ResponseEntity<>(result, HttpStatus.OK);

    }
}
