package com.sss.studycafe.Customer.model.mapper;

import com.sss.studycafe.Customer.model.vo.Faq;

import java.util.List;


    public interface FaqMapper {
        List<Faq> getAllFaq();
        List<Faq> getFaqByKind(String kind);


    }
