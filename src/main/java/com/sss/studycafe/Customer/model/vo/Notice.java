package com.sss.studycafe.Customer.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {

    private int  no;
    private String kind;
    private String title;
    private String content;
    private Date createDate;
    private Date updateDate;
    private char status;
}