package com.sss.studycafe.own_coupon.model.mapper;

import com.sss.studycafe.own_coupon.model.vo.OwnCoupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface OwnCouponMapper {

    List<OwnCoupon> selectOwnCouponByUserId(@Param("userId") String userId);
    OwnCoupon selectOwnCouponWithUserAndCoupon(@Param("userId") String userId, @Param("couponId") int couponId);

    void useCoupon(@Param("userId")String id, @Param("coupon") String coupon);

    void insertCouponForNewUser(Map<String, Object> couponParams);
}
