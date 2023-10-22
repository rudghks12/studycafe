package com.sss.studycafe.own_coupon.model.vo;

import com.sss.studycafe.coupon.model.vo.Coupon;
import com.sss.studycafe.user.model.vo.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OwnCoupon {
    private int id;

    private String userId;

    private Date createdate;

    private Date expiredate;

    private String status;

    private int couponId;

    private String name;

    private User user;

    private Coupon coupon;

    public User getUser() {

        return user;
    }

    public void setUser(User user) {

        this.user = user;
    }

    public Coupon getCoupon() {

        return coupon;
    }

    public void setCoupon(Coupon coupon) {

        this.coupon = coupon;
    }
}
