package com.sss.studycafe.Customer.controller;


import com.sss.studycafe.Customer.model.service.FaqService;
import com.sss.studycafe.Customer.model.vo.Faq;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Slf4j
@Controller
public class FaqController {

    @Autowired
    private FaqService faqService;

    @GetMapping("/customer/faq")
    public ModelAndView faq(@RequestParam(name = "kind", required = false) String kind) {
        ModelAndView modelAndView = new ModelAndView("/customer/faq");

        List<Faq> faqList;
        if (kind == null || kind.equals("전체")) {
            // '전체' 버튼은 모든 FAQ를 가져옵니다.
            faqList = faqService.getAllFaq();
        } else {
            // 그 외의 경우, kind 값에 맞는 FAQ만 가져옵니다.
            faqList = faqService.getFaqByKind(kind);
        }

        modelAndView.addObject("faqList", faqList);

        return modelAndView;
    }
}

