package com.sss.studycafe.history.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class History {
    private int id;

    private Date checkIn;

    private Date checkOut;

    private int seat;

    private String userId;
}
