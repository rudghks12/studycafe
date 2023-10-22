package com.sss.studycafe.info.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
@RequestMapping("/info")
public class InfoController {
    @GetMapping("/seat")
    public ModelAndView seat(ModelAndView modelAndView) {

        modelAndView.setViewName("/info/seat");
        return modelAndView;
    }

    @GetMapping("/price")
    public ModelAndView price(ModelAndView modelAndView) {

        modelAndView.setViewName("/info/price");
        return modelAndView;
    }
    @GetMapping("/come")
    public ModelAndView come(ModelAndView modelAndView) {

        modelAndView.setViewName("/info/come");
        return modelAndView;
    }
}



