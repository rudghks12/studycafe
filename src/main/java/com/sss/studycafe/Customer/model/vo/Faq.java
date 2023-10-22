package com.sss.studycafe.Customer.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Faq {

    private int no;

    private String title;

    private String kind;

    private String content;

    private  char status;
}
