package com.sss.studycafe.Customer.controller;

import com.sss.studycafe.Customer.model.vo.Event;
import com.sss.studycafe.Customer.model.service.EventService;
import com.sss.studycafe.common.util.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/customer/event")
public class EventController {

    @Autowired
    private EventService eventService;

    @GetMapping("/list")
    public ModelAndView eventList(ModelAndView modelAndView,
                                  @RequestParam(defaultValue = "1") int page,
                                  @RequestParam(required = false) String searchTitle) {
        try {
            int listCount = 0;
            PageInfo pageInfo = null;
            List<Event> list = null;

            // 검색 쿼리가 제공되었는지 확인
            if (searchTitle != null && !searchTitle.isEmpty()) {
                // 검색 기능을 처리합니다.
                // searchTitle을 기반으로 필터링된 목록을 가져오기 위해 서비스 메서드를 사용할 수 있습니다.
                list = eventService.getEventListByTitle(searchTitle);
                // 검색 결과에 따라 검색된 항목 수를 가져옵니다.
                listCount = eventService.getEventCountByTitle(searchTitle);
            } else {
                // 검색 쿼리가 없으면 모든 이벤트를 가져옵니다.
                listCount = eventService.getEventCount();
                int pageSize = 20; // 한페이지에 표시될 게실물 수
                pageInfo = new PageInfo(page, pageSize, listCount, 20);
                list = eventService.getEventList(pageInfo);
            }

            modelAndView.addObject("pageInfo", pageInfo);
            modelAndView.addObject("list", list);
            modelAndView.addObject("msg", "이벤트 목록을 불러왔습니다.");
            modelAndView.setViewName("customer/event/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "이벤트 목록을 불러오는 중 오류가 발생했습니다.");
            modelAndView.addObject("location", "/customer/event/list");
            modelAndView.setViewName("common/msg");
        }

        return modelAndView;
    }
//            // 전체 게시물 수
//            listCount = eventService.getEventCount();
//            // 현재 페이지에 표시할 게시글 목록을 가져옴
//            int pageSize = 20; // 한 페이지에 표시할 게시물 수 (10개로 수정)
//            pageInfo = new PageInfo(page, pageSize, listCount, 20);
//
//            list = eventService.getEventList(pageInfo);

//            modelAndView.addObject("pageInfo", pageInfo);
//            modelAndView.addObject("list", list);
//            modelAndView.addObject("msg", "이벤트 목록을 불러왔습니다."); // 성공 메시지 추가
//            modelAndView.setViewName("customer/event/list");
//        } catch (Exception e) {
//            modelAndView.addObject("msg", "이벤트 목록을 불러오는 중 오류가 발생했습니다."); // 예외 처리 메시지 추가
//            modelAndView.addObject("location", "/customer/event/list"); // 예외 발생 시 이동할 경로 설정
//            modelAndView.setViewName("common/msg");
//        }
//
//        return modelAndView;
//    }

    @GetMapping("/detail/{no}")
    public ModelAndView eventDetail(ModelAndView modelAndView, @PathVariable int no) {
        try {
            Event event = eventService.getEventById(no);
            modelAndView.addObject("event", event);
            modelAndView.addObject("msg", "이벤트 상세 정보를 불러왔습니다.");
            modelAndView.setViewName("customer/event/detail");
        } catch (Exception e) {
            modelAndView.addObject("msg", "이벤트 상세 정보를 불러오는 중 오류가 발생했습니다.");
            modelAndView.addObject("location", "/customer/event/list");
            modelAndView.setViewName("common/msg");
        }
        return modelAndView;
    }

    @GetMapping("/add")
    public ModelAndView addEventForm(ModelAndView modelAndView) {
        modelAndView.setViewName("customer/event/add");
        modelAndView.addObject("event", new Event());
        return modelAndView;
    }

    // 이벤트 추가
    @PostMapping("/add")
    public ModelAndView addEvent(ModelAndView modelAndView,
                                 @RequestParam("kind") String kind,
                                 @ModelAttribute("event") Event event) {
        try {
            event.setKind(kind); // kind 값을 설정
            eventService.addEvent(event);
            modelAndView.addObject("msg", "이벤트가 성공적으로 등록되었습니다.");
            modelAndView.addObject("location", "/customer/event/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "이벤트 등록 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/event/add");
        }
        modelAndView.setViewName("common/msg");
        return modelAndView;
    }

    @GetMapping("/edit/{no}")
    public ModelAndView editEventForm(ModelAndView modelAndView, @PathVariable int no) {
        try {
            // 해당 이벤트를 불러와서 수정하는 폼을 보여줍니다.
            Event event = eventService.getEventById(no);
            modelAndView.addObject("event", event);
            modelAndView.addObject("msg", "이벤트 수정 폼을 불러왔습니다.");
            modelAndView.setViewName("customer/event/edit"); // 수정 폼의 JSP 페이지 경로
        } catch (Exception e) {
            modelAndView.addObject("msg", "이벤트 수정 폼을 불러오는 중 오류가 발생했습니다.");
            modelAndView.addObject("location", "/customer/event/list");
            modelAndView.setViewName("common/msg");
        }
        return modelAndView;
    }

    // Edit Event 수행 (폼에서 수정하기 버튼 클릭 시 호출됨)
    // Edit Event 수행 (폼에서 수정하기 버튼 클릭 시 호출됨)
    @PostMapping("/edit/{no}")
    public ModelAndView editEvent(ModelAndView modelAndView,
                                  @RequestParam("kind") String kind,
                                  @ModelAttribute("event") Event event,
                                  @PathVariable int no) {
        try {
            event.setKind(kind); // kind 값을 설정
            eventService.editEvent(event); // 이벤트 업데이트
            modelAndView.addObject("msg", "이벤트가 성공적으로 수정되었습니다.");
            modelAndView.addObject("location", "/customer/event/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "이벤트 수정 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/event/edit/" + no);
        }
        modelAndView.setViewName("common/msg");
        return modelAndView;
    }
    @GetMapping("/delete/{no}")
    public ModelAndView deleteEvent(ModelAndView modelAndView, @PathVariable int no) {
        try {
            eventService.deleteEvent(no);
            modelAndView.addObject("msg", "이벤트가 성공적으로 삭제되었습니다.");
            modelAndView.addObject("location", "/customer/event/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "이벤트 삭제 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/event/detail/" + no);
        }
        modelAndView.setViewName("common/msg");
        return modelAndView;
    }
}
