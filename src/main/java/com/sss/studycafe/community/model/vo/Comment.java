package com.sss.studycafe.community.model.vo;

import com.sss.studycafe.user.model.vo.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
    private int no;
    private String userId;     // 유저ID
    private int community_no;   // 커뮤니티 no
    private String content;    // 게시글 내용
    private String status;     // 상태값(Y/N)
    private Date createdDate;  // 생성일시
    private Date updatedDate;  // 수정일시
    private int ref;
    private int step;
    private String p_userId;

    private Community Community;

    public Community getCommunity() {
        return Community;
    }

    public void setCommunity(Community community) {
        this.Community = community;
    }

    private User user;

    public User getUser() {

        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    // 부모 댓글 작성자 정보
    private User parentUser;

    public User getParentUser() {
        return parentUser;
    }

    public void setParentUser(User parentUser) {
        this.parentUser = parentUser;
    }

}
