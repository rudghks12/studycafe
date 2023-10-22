package com.sss.studycafe.own_coupon.model.service;

import com.sss.studycafe.own_coupon.model.vo.OwnCoupon;

import java.util.List;

public interface OwnCouponService {

    List<OwnCoupon> selectOwnCouponByUserId(String userId);
    OwnCoupon selectOwnCouponWithUserAndCoupon(String userId, int couponId);

    void useCoupon(String id, String coupon);

    void addCouponForNewUser(String newUserId);
}
