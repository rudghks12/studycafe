package com.sss.studycafe.community.controller;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.community.model.service.CommunityService;
import com.sss.studycafe.community.model.vo.Comment;
import com.sss.studycafe.community.model.vo.Community;
import com.sss.studycafe.user.model.vo.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


import java.util.List;


@Slf4j
@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService service;

    @GetMapping("/mainpage")
    public ModelAndView mainpage(ModelAndView modelAndView,
                                 @RequestParam(defaultValue = "1") int page,
                                 @RequestParam(value = "sortingOption", defaultValue = "") String sortingOption,
                                 Community community) {
        int listCount = 0;
        PageInfo pageInfo = null;
        List<Community> list = null;

        if (sortingOption.equals("") || sortingOption.equals("latest")) {
            // 기본 정렬(최신순)
            listCount = service.getCommunityCount();
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityList(pageInfo);

        } else if (sortingOption.equals("popular")) {
            // 인기순 정렬(좋아요 수가 많은 순)
            listCount = service.getCommunityCount();
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByPopular(pageInfo);

        } else if (sortingOption.equals("recommend")) {
            // 추천순 정렬 (댓글이 많은 순)
            listCount = service.getCommunityCount();
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByRecommend(pageInfo);

        } else if (sortingOption.equals("oldest")) {
            // 오래된 순 정렬(등록일자 기준으로 오래된 순)
            listCount = service.getCommunityCount();
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByOldest(pageInfo);
        }

        int likeCount = service.getLikeCount(community.getNo());
        int commentCount = service.getCommentCount(community.getNo());

        modelAndView.addObject("likeCount", likeCount);
        modelAndView.addObject("commentCount", commentCount);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("list", list);
        modelAndView.setViewName("community/mainpage");

        return modelAndView;
    }

    @GetMapping("/search")
    @ResponseBody
    public ModelAndView searchCommunity(ModelAndView modelAndView,
                                           @RequestParam(defaultValue = "1") int page,
                                           @RequestParam(value = "keyword",defaultValue = "") String keyword,
                                           @RequestParam(value = "sortingOption", defaultValue = "") String sortingOption,
                                           Community community) {
        int listCount = 0;
        PageInfo pageInfo = null;
        List<Community> list = null;

        if (sortingOption.equals("") || sortingOption.equals("latest")) {
            // 기본 정렬(최신순)
            listCount = service.getCommunityCountByKeyword(keyword);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityByKeywordList(pageInfo, keyword);

        } else if (sortingOption.equals("popular")) {
            // 인기순 정렬(좋아요 수가 많은 순)
            listCount = service.getCommunityCountByKeyword(keyword);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByKeywordAndPopular(pageInfo, keyword);

        } else if (sortingOption.equals("recommend")) {
            // 추천순 정렬 (댓글이 많은 순)
            listCount = service.getCommunityCountByKeyword(keyword);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByKeywordAndRecommend(pageInfo, keyword);

        } else if (sortingOption.equals("oldest")) {
            // 오래된 순 정렬(등록일자 기준으로 오래된 순)
            listCount = service.getCommunityCountByKeyword(keyword);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByKeywordAndOldest(pageInfo, keyword);
        }


        int likeCount = service.getLikeCount(community.getNo());
        int commentCount = service.getCommentCount(community.getNo());

        System.out.println("커뮤니티 번호: " + community.getNo());

        modelAndView.addObject("likeCount", likeCount);
        modelAndView.addObject("commentCount", commentCount);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("list", list);
        modelAndView.addObject("keyword", keyword);
        modelAndView.addObject("listCount", listCount);
        modelAndView.setViewName("community/search");

        return modelAndView;
    }

    @GetMapping("/listpage")
    public ModelAndView list(ModelAndView modelAndView,
                             @RequestParam(defaultValue = "자유게시판") String kind,
                             @RequestParam(value = "sortingOption", defaultValue = "") String sortingOption,
                             @RequestParam(defaultValue = "1") int page) {
        int listCount = 0;
        PageInfo pageInfo = null;
        List<Community> list = null;

        if (sortingOption.equals("") || sortingOption.equals("latest")) {
            // 기본 정렬(최신순)
            // 게시판 종류에 따른 게시글 수
            listCount = service.getCommunityCountByKind(kind);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCommunityListByKind(kind, pageInfo);

        } else if (sortingOption.equals("popular")) {
            // 인기순 정렬(좋아요 수가 많은 순)
            listCount = service.getCommunityCountByKind(kind);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByKindAndPopular(kind, pageInfo);

        } else if (sortingOption.equals("recommend")) {
            // 추천순 정렬 (댓글이 많은 순)
            listCount = service.getCommunityCountByKind(kind);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByKindAndRecommend(kind, pageInfo);

        } else if (sortingOption.equals("oldest")) {
            // 오래된 순 정렬(등록일자 기준으로 오래된 순)
            listCount = service.getCommunityCountByKind(kind);
            pageInfo = new PageInfo(page, 10, listCount, 10);
            list = service.getCoummunityListByKindAndOldest(kind, pageInfo);
        }

        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("list", list);
        modelAndView.addObject("kind", kind);

        modelAndView.setViewName("community/listpage");

        return modelAndView;
    }

    // 게시글 상세페이지
    @GetMapping("/detail")
    public ModelAndView detail(ModelAndView modelAndView,
                               @RequestParam int no,
                               @AuthenticationPrincipal User user) {

        Community community = service.getCommunityByNo(no);
        int likeCount = service.getLikeCount(no);

        String likeCheck = null;

        if (user != null) {
            likeCheck = service.getLikeStatus(user.getId(), no);
        }

        // 댓글 개수 가져옴
        int commentCount = service.getCommentCount(no);

        // 댓글 리스트 가져옴
        List<Comment> comments = service.getCommentsByCommunityNo(no);
        community.setComments(comments);

        modelAndView.addObject("community", community);
        modelAndView.addObject("likeCount", likeCount);
        modelAndView.addObject("likeCheck", likeCheck);
        modelAndView.addObject("commentCount", commentCount);
        modelAndView.addObject("comments", comments);
        modelAndView.addObject("user", user);
        modelAndView.setViewName("community/detail");

        return modelAndView;
    }
    
    // 사용자의 ID와 게시물 번호를 받아와서 해당 게시물에 대한 좋아요 상태를 토글하는 역할
    @PostMapping("/toggle-like")
    @ResponseBody
    public ResponseEntity<String> toggleLike(@RequestParam("userId") String userId,
                                             @RequestParam("communityNo") int communityNo,
                                             @AuthenticationPrincipal User user) {
        try {
            // 로그인 사용자의 ID와 게시물 번호를 받아와서 해당 게시물에 대한 좋아요 상태를 토글하는 역할을 하는 메서드 호출
            service.toggleLike(userId, communityNo);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            log.error("좋아요 토글 중 오류 발생: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error occurred");
        }

    }


    // 게시글 작성페이지
    @RequestMapping(value = "/write" , method = {RequestMethod.GET})
    public void write() {

    }

    @RequestMapping(value = "/write" , method = {RequestMethod.POST})
    public ModelAndView write(ModelAndView modelAndView,
                              @AuthenticationPrincipal User user,
                              Community community) {
        int result = 0;

        community.setUserId(user.getId());

        // 글쓰기에서 작성한 글 DB에 저장
        result = service.save(community);

        if(result > 0) {
            modelAndView.addObject("msg", "게시글 등록 성공");
            modelAndView.addObject("location" , "/community/detail?no=" + community.getNo());
        } else {
            modelAndView.addObject("msg", "게시글 등록 실패");
            modelAndView.addObject("location" , "/community/write");
        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }

    // 게시글 수정
    @RequestMapping(value = "/update" , method = {RequestMethod.GET})
    public ModelAndView update(ModelAndView modelAndView,
                               @RequestParam int no,
                               @AuthenticationPrincipal User user) {

        Community community = null;

        community = service.getCommunityByNo(no);

        if(community != null && community.getUserId().equals(user.getId())) {
            modelAndView.addObject("community", community);
            modelAndView.setViewName("/community/update");
        } else {
            modelAndView.addObject("msg", "잘못된 접근입니다.");
            modelAndView.addObject("location" , "/community/mainpage");
            modelAndView.setViewName("common/msg");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/update" , method = {RequestMethod.POST})
    public ModelAndView update(ModelAndView modelAndView,
                               @AuthenticationPrincipal User user,
                               @RequestParam int no,
                               @RequestParam String kind,
                               @RequestParam String title,
                               @RequestParam String content){

        Community community = null;

        community = service.getCommunityByNo(no);

        if(community != null && community.getUserId().equals(user.getId())) {

            community.setKind(kind);
            community.setTitle(title);
            community.setContent(content);

            int result = service.save(community);

            if(result > 0) {
                modelAndView.addObject("msg", "게시글 등록 성공");
                modelAndView.addObject("location" , "/community/detail?no=" + community.getNo());
            } else {
                modelAndView.addObject("msg", "게시글 등록 실패");
                modelAndView.addObject("location" , "/community/update?no=" + community.getNo());
            }
        } else {
            modelAndView.addObject("msg", "잘못된 접근입니다.");
            modelAndView.addObject("location" , "/community/mainpage");
        }
        modelAndView.setViewName("common/msg");

        return modelAndView;
    }

    // 게시글 삭제
    @GetMapping("/delete")
    public ModelAndView delete(ModelAndView modelAndView,
                               @RequestParam int no,
                               @AuthenticationPrincipal User user) {
        int result = 0;
        Community community = null;

        community = service.getCommunityByNo(no);


        if(community != null && community.getUserId().equals(user.getId())) {
            result = service.deleteCommunity(community.getNo());

            if(result > 0) {
                modelAndView.addObject("msg", "게시글 삭제 성공");
                modelAndView.addObject("location", "/community/mainpage");
            } else {
                modelAndView.addObject("msg", "게시글 삭제 실패");
                modelAndView.addObject("location" , "/community/detail?no=" + community.getNo());
            }
        } else {
            modelAndView.addObject("msg", "잘못된 접근입니다.");
            modelAndView.addObject("location" , "/community/mainpage");
        }

        modelAndView.setViewName("common/msg");

        return modelAndView;
    }



}
