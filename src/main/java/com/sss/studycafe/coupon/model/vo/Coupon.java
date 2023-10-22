package com.sss.studycafe.coupon.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Coupon {
    private int id;

    private String name;

    private int discount;

    private int expiredate;
}
