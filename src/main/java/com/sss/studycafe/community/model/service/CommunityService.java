package com.sss.studycafe.community.model.service;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.community.model.vo.Comment;
import com.sss.studycafe.community.model.vo.Community;
import com.sss.studycafe.community.model.vo.Like;

import java.util.List;

public interface CommunityService {
    // 전체 게시글 수
    int getCommunityCount();

    // 커뮤니티 메인페이지에서 나오게 될 전체 게시글 목록을 가져옴
    List<Community> getCoummunityList(PageInfo pageInfo);

    // 메인페이지 정렬
    List<Community> getCoummunityListByPopular(PageInfo pageInfo);
    List<Community> getCoummunityListByRecommend(PageInfo pageInfo);
    List<Community> getCoummunityListByOldest(PageInfo pageInfo);


    // 게시판 종류에 따른 게시글 수
    int getCommunityCountByKind(String kind);

    // 게시판 종류에 따른 전체 게시글 목록
    List<Community> getCommunityListByKind(String kind, PageInfo pageInfo);

    // 리스트페이지 정렬
    List<Community> getCoummunityListByKindAndPopular(String kind, PageInfo pageInfo);
    List<Community> getCoummunityListByKindAndRecommend(String kind, PageInfo pageInfo);
    List<Community> getCoummunityListByKindAndOldest(String kind, PageInfo pageInfo);

    // 검색페이지 게시물 수, 리스트
    int getCommunityCountByKeyword(String keyword);
    List<Community> getCoummunityByKeywordList(PageInfo pageInfo, String keyword);

    // 검색페이지 정렬
    List<Community> getCoummunityListByKeywordAndPopular(PageInfo pageInfo, String keyword);
    List<Community> getCoummunityListByKeywordAndRecommend(PageInfo pageInfo, String keyword);
    List<Community> getCoummunityListByKeywordAndOldest(PageInfo pageInfo, String keyword);

    // 게시글 상세페이지
    Community getCommunityByNo(int no);

    // 게시글 등록, 수정
    int save(Community community);

    // 게시글 삭제
    int deleteCommunity(int no);

    // 좋아요 개수
    int getLikeCount(int no);


    void toggleLike(String userId, int communityNo);

    String getLikeStatus(String userId, int no);

    // 댓글 개수
    int getCommentCount(int no);

    // 댓글 리스트
    List<Comment> getCommentsByCommunityNo(int no);

    // 댓글 등록, 수정
    int commentsave(Comment comment);

    int getMaxRefByCommunityNo(int no);

    // 댓글 삭제
    int deleteComment(int no);

    // 댓글 리스트
    Comment getCommentByno(int no);
}
