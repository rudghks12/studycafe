package com.sss.studycafe.payment.model.service;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.payment.model.vo.Payment;

import java.util.List;

public interface PaymentService {
    int count();

    List<Payment> getAll(PageInfo pageInfo);

    List<Payment> getAllByBeforeThreeMonth();

    List<Payment> getAllByUserId(PageInfo pageInfo, String id);

    int getCountByUserId(String id);

    Payment getPaymentById(String id);
    void save(Payment payment);
}
