package com.sss.studycafe.payment.model.service;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.payid_ticket.model.mapper.PaidTicketMapper;
import com.sss.studycafe.payment.model.mapper.PaymentMapper;
import com.sss.studycafe.payment.model.vo.Payment;
import com.sss.studycafe.ticket.model.mapper.TicketMapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentServiceImpl implements PaymentService{
    @Autowired
    PaymentMapper paymentMapper;
    @Autowired
    TicketMapper ticketMapper;
    @Autowired
    PaidTicketMapper paidTicketMapper;

    @Override
    public int count() {
        return paymentMapper.selectCount();
    }

    @Override
    public List<Payment> getAll(PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return paymentMapper.selectPayments(rowBounds);
    }

    @Override
    public List<Payment> getAllByBeforeThreeMonth() {
        return paymentMapper.selectPaymentsByBeforeThreeMonth();
    }

    @Override
    public List<Payment> getAllByUserId(PageInfo pageInfo, String id) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() - 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return paymentMapper.selectPaymentsByUserId(rowBounds, id);
    }

    @Override
    public int getCountByUserId(String id) {
        return paymentMapper.selectCountByUserId(id);
    }

    @Override
    public Payment getPaymentById(String id) {
        return paymentMapper.selectPaymentById(id);
    }

    @Override
    public void save(Payment payment) {
        try{
            paymentMapper.insert(payment);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
