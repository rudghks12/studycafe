package com.sss.studycafe.Customer.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@Controller
public class AskController {

        @GetMapping("/customer/ask")
        public String faq() {

            return "/customer/ask";
        }
    }

