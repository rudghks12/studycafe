package com.sss.studycafe.community.model.vo;

import com.sss.studycafe.user.model.vo.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Community {
    private int no;
    private String userId;     // 유저ID
    private String kind;       // 커뮤니티 이름
    private String title;      // 게시글 제목
    private String content;    // 게시글 내용
    private Date createdDate;  // 생성일시
    private Date updatedDate;  // 수정일시
    private String status;     // 상태값(Y/N)

    private int comment_cnt;
    private int like_cnt;

    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    private int likeCount; // 좋아요 개수를 저장할 필드

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    // 댓글 관련
    private List<Comment> comments;

    // 생성자, 게터, 세터 등을 정의하세요...

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

}
