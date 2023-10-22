package com.sss.studycafe.Customer.model.service;

import com.sss.studycafe.Customer.model.vo.Faq;

import java.util.List;

public interface FaqService {

    List<Faq> getAllFaq();

    List<Faq> getFaqByKind(String kind);

}
