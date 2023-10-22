package com.sss.studycafe.Customer.model.service;

import com.sss.studycafe.Customer.model.mapper.FaqMapper;
import com.sss.studycafe.Customer.model.vo.Faq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaqServiceImpl implements FaqService {

    @Autowired
    private FaqMapper faqMapper;

    @Override
    public List<Faq> getAllFaq() {
        return faqMapper.getAllFaq();
    }

    @Override
    public List<Faq> getFaqByKind(String kind) {
        if (kind == null) {
            return getAllFaq();
        } else {
            return faqMapper.getFaqByKind(kind);
        }
    }
}