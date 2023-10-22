package com.sss.studycafe.community.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Like {
    private int no;
    private String userid;      // 유저ID
    private int community_no;   // 커뮤니티 no
    private String status;      // 상태값(Y/N)

}
