package com.sss.studycafe.Customer.controller;

import com.sss.studycafe.Customer.model.vo.Notice;
import com.sss.studycafe.Customer.model.service.NoticeService;
import com.sss.studycafe.common.util.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/customer/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @GetMapping("/list")
    public ModelAndView noticeList(ModelAndView modelAndView,
                                   @RequestParam(defaultValue = "1") int page ) {
        int listCount = 0;
        PageInfo pageInfo = null;
        List<Notice> list = null;

        // 전체 게시물 수
        listCount = noticeService.getNoticeCount();
        // 현재 페이지에 표시할 게시글 목록을 가져옴
        int pageSize = 10; // 한 페이지에 표시할 게시물 수 (10개로 수정)
        pageInfo = new PageInfo(page, pageSize, listCount, 10);

        list = noticeService.getNoticeList(pageInfo);

        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("list", list);
        modelAndView.setViewName("customer/notice/list");

        return modelAndView;
    }

    @GetMapping("/detail/{no}")
    public ModelAndView noticeDetail(ModelAndView modelAndView, @PathVariable int no) {
        Notice notice = noticeService.getNoticeById(no);
        modelAndView.addObject("notice", notice);
        modelAndView.setViewName("customer/notice/detail");
        return modelAndView;
    }

    @GetMapping("/add")
    public ModelAndView addNoticeForm(ModelAndView modelAndView) {
        modelAndView.setViewName("customer/notice/add");
        modelAndView.addObject("notice", new Notice());
        return modelAndView;
    }

    // 공지사항 추가
    @PostMapping("/add")
    public ModelAndView addNotice(ModelAndView modelAndView, @ModelAttribute("notice") Notice notice) {
        try {
            noticeService.addNotice(notice);
            modelAndView.addObject("msg", "공지사항이 성공적으로 등록되었습니다.");
            modelAndView.addObject("location", "/customer/notice/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "공지사항 등록 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/notice/add");
        }
        modelAndView.setViewName("common/msg");
        return modelAndView;
    }

    @GetMapping("/edit/{no}")
    public ModelAndView editNoticeForm(ModelAndView modelAndView, @PathVariable int no) {
        // 해당 공지사항을 불러와서 수정하는 폼을 보여줍니다.
        Notice notice = noticeService.getNoticeById(no);
        modelAndView.addObject("notice", notice);
        modelAndView.setViewName("customer/notice/edit"); // 수정 폼의 JSP 페이지 경로
        return modelAndView;
    }

    // Edit Notice 수행 (폼에서 수정하기 버튼 클릭 시 호출됨)
    @PostMapping("/edit/{no}")
    public ModelAndView editNotice(ModelAndView modelAndView, @ModelAttribute("notice") Notice notice, @PathVariable int no) {
        try {
            noticeService.editNotice(notice);
            modelAndView.addObject("msg", "공지사항이 성공적으로 수정되었습니다.");
            modelAndView.addObject("location", "/customer/notice/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "공지사항 수정 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/notice/edit/" + no);
        }
        modelAndView.setViewName("common/msg");
        return modelAndView;
    }

    @GetMapping("/delete/{no}")
    public ModelAndView deleteNotice(ModelAndView modelAndView, @PathVariable int no) {
        try {
            noticeService.deleteNotice(no);
            modelAndView.addObject("msg", "공지사항이 성공적으로 삭제되었습니다.");
            modelAndView.addObject("location", "/customer/notice/list");
        } catch (Exception e) {
            modelAndView.addObject("msg", "공지사항 삭제 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/notice/detail/" + no);
        }
        modelAndView.setViewName("common/msg");
        return modelAndView;
    }
    @PostMapping("/delete/{no}/confirmed")
    public ModelAndView confirmDelete(ModelAndView modelAndView, @PathVariable int no) {
        try {
            noticeService.deleteNotice(no);
            modelAndView.addObject("msg", "공지사항이 성공적으로 삭제되었습니다.");
            modelAndView.addObject("location", "/customer/notice/list");
            modelAndView.setViewName("common/msg");
        } catch (Exception e) {
            modelAndView.addObject("msg", "공지사항 삭제 중 오류가 발생하였습니다.");
            modelAndView.addObject("location", "/customer/notice/detail/" + no);
            modelAndView.setViewName("common/msg");
        }
        return modelAndView;
    }
}

