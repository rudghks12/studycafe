package com.sss.studycafe.own_coupon.model.service;

import com.sss.studycafe.own_coupon.model.mapper.OwnCouponMapper;
import com.sss.studycafe.own_coupon.model.vo.OwnCoupon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OwnCouponServiceImpl implements OwnCouponService {

    @Autowired
    OwnCouponMapper ownCouponMapper;

    @Override
    public List<OwnCoupon> selectOwnCouponByUserId(String userId) {
        return ownCouponMapper.selectOwnCouponByUserId(userId);
    }

    @Override
    public OwnCoupon selectOwnCouponWithUserAndCoupon(String userId, int couponId) {
        return ownCouponMapper.selectOwnCouponWithUserAndCoupon(userId, couponId);
    }

    @Override
    public void useCoupon(String id, String coupon) {
        ownCouponMapper.useCoupon(id, coupon);
    }

    @Override
    @Transactional
    public void addCouponForNewUser(String  newUserId) {
        Map<String, Object> couponParams = new HashMap<>();
        couponParams.put("newUserId", newUserId);

        ownCouponMapper.insertCouponForNewUser(couponParams);
    }
}
