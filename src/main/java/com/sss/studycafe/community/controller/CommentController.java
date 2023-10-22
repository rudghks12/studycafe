package com.sss.studycafe.community.controller;

import com.sss.studycafe.community.model.service.CommunityService;
import com.sss.studycafe.community.model.vo.Comment;
import com.sss.studycafe.community.model.vo.Community;
import com.sss.studycafe.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommunityService service;

    // 댓글 등록
    @RequestMapping(value = "/write" , method = {RequestMethod.GET})
    public void write() {

    }

    // 댓글 등록
    @RequestMapping(value = "/write" , method = {RequestMethod.POST})
    public ModelAndView write(ModelAndView modelAndView,
                              @AuthenticationPrincipal User user,
                              Comment comment) {

        comment.setUserId(user.getId());

        if (comment.getP_userId() == null) {
            // 일반 댓글인 경우
            // 해당 communityNo에 대한 최대 ref 값을 가져와서 1을 더한 값을 ref 값으로 설정
            // 특정 커뮤니티에 대한 최대 ref 값을 조회
            comment.setRef(service.getMaxRefByCommunityNo(comment.getCommunity_no()) + 1);
            comment.setStep(0);
        } else {
            // 대댓글인 경우
            comment.setStep(comment.getStep() + 1);
            comment.setRef(comment.getRef());
        }

        int result = 0;

        result = service.commentsave(comment);

        if (result > 0) {
            modelAndView.addObject("msg", "댓글 등록 성공");
            modelAndView.addObject("location" , "/community/detail?no=" + comment.getCommunity_no());
        } else {
            modelAndView.addObject("msg", "댓글 등록 실패");
            modelAndView.addObject("location" , "/community/mainpage");
        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }

    // 댓글 수정
    @PostMapping("/update")
    public ModelAndView updateComment(ModelAndView modelAndView,
                                      @AuthenticationPrincipal User user,
                                      Community community,
                                      @RequestParam("no") int no,
                                      @RequestParam("content") String updatedContent) {

        Comment comment = null;

        comment = service.getCommentByno(no);

        if(comment != null && comment.getUserId().equals(user.getId())) {

            comment.setContent(updatedContent);

            int result = service.commentsave(comment);

            if (result > 0) {
                modelAndView.addObject("msg", "댓글이 성공적으로 수정되었습니다.");
                modelAndView.addObject("location", "/community/detail?no="+ community.getNo());
            } else {
                modelAndView.addObject("msg", "댓글 수정 중 오류가 발생했습니다.");
                modelAndView.addObject("location","/community/detail?no="+ community.getNo());
            }

        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }

    // 댓글 삭제
    @PostMapping("/delete")
    public ModelAndView deleteComment(ModelAndView modelAndView,
                                      @RequestParam("no") int no,
                                      Community community) {

        int result = service.deleteComment(no);

        if (result > 0) {
            modelAndView.addObject("msg", "댓글이 성공적으로 삭제되었습니다.");
            modelAndView.addObject("location", "/community/detail?no=" + community.getNo());
        } else {
            modelAndView.addObject("msg", "댓글 삭제 중 오류가 발생했습니다.");
            modelAndView.addObject("location", "/community/detail?no=" + community.getNo());
        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }


}
