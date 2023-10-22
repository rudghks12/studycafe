package com.sss.studycafe.payment.model.mapper;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.payid_ticket.model.vo.PaidTicket;
import com.sss.studycafe.payment.model.vo.Payment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface PaymentMapper {
    int selectCount();

    List<Payment> selectPayments(RowBounds rowBounds);

    List<Payment> selectPaymentsByBeforeThreeMonth();

    List<Payment> selectPaymentsByUserId(RowBounds rowBounds, @Param("userId")String userId);

    int selectCountByUserId(@Param("userId") String userId);

    Payment selectPaymentById(@Param("id") String id);

    void insert(Payment payment);
}
