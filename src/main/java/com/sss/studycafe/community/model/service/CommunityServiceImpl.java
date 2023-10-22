package com.sss.studycafe.community.model.service;

import com.sss.studycafe.common.util.PageInfo;
import com.sss.studycafe.community.model.mapper.CommunityMapper;
import com.sss.studycafe.community.model.vo.Comment;
import com.sss.studycafe.community.model.vo.Community;
import com.sss.studycafe.community.model.vo.Like;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    private CommunityMapper mapper;

    // 메이페이지
    // 전체 게시글 수
    @Override
    public int getCommunityCount() {

        return mapper.selectCommunityCount();
    }

    // 현재 페이지에 표시할 게시글 목록을 가져옴
    @Override
    public List<Community> getCoummunityList(PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectAll(rowBounds);
    }

    // 메인페이지 정렬
    @Override
    public List<Community> getCoummunityListByPopular(PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectAllByPopular(rowBounds);
    }

    @Override
    public List<Community> getCoummunityListByRecommend(PageInfo pageInfo){
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectAllByRecommend(rowBounds);
    }

    @Override
    public List<Community> getCoummunityListByOldest(PageInfo pageInfo){
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectAllByOldest(rowBounds);
    }

    // 리스트페이지
    // 게시판 종류에 따른 게시글 수
    @Override
    public int getCommunityCountByKind(String kind) {
        return mapper.selectCommunityCountByKind(kind);
    }

    // 게시판 종류에 따른 전체 게시글 목록
    @Override
    public List<Community> getCommunityListByKind(String kind, PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectCommunityListByKind(kind, rowBounds);

    }

    // 리스트페이지 정렬
    @Override
    public List<Community> getCoummunityListByKindAndPopular(String kind, PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectCommunityListByKindAndPopular(kind, rowBounds);

    }
    @Override
    public List<Community> getCoummunityListByKindAndRecommend(String kind, PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectCommunityListByKindAndRecommend(kind, rowBounds);

    }
    @Override
    public List<Community> getCoummunityListByKindAndOldest(String kind, PageInfo pageInfo) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return mapper.selectCommunityListByKindAndOldest(kind, rowBounds);

    }

    // 검색페이지
    // 전체 게시글 수(검색적용)
    @Override
    public int getCommunityCountByKeyword(String keyword) {

        return mapper.selectCommunityCountByKeyword(keyword);
    }

    // 현재 페이지에 표시할 게시글 목록을 가져옴(검색적용)
    @Override
    public List<Community> getCoummunityByKeywordList(PageInfo pageInfo, String keyword) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return  mapper.selectAllByKeyword(keyword,rowBounds);
    }

    // 검색페이지 정렬
    @Override
    public List<Community> getCoummunityListByKeywordAndPopular(PageInfo pageInfo, String keyword) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return  mapper.selectAllByKeywordAndPopular(keyword,rowBounds);
    }

    @Override
    public List<Community> getCoummunityListByKeywordAndRecommend(PageInfo pageInfo, String keyword) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return  mapper.selectAllByKeywordAndRecommend(keyword,rowBounds);
    }

    @Override
    public List<Community> getCoummunityListByKeywordAndOldest(PageInfo pageInfo, String keyword) {
        int limit = pageInfo.getListLimit();
        int offset = (pageInfo.getCurrentPage() -1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);

        return  mapper.selectAllByKeywordAndOldest(keyword,rowBounds);
    }


    // 게시글 상세페이지
    @Override
    public Community getCommunityByNo(int no) {

        return mapper.selectCommunityByNo(no);
    }

    // 게시글 등록, 수정
    @Override
    @Transactional
    public int save(Community community) {
        int result = 0;

        if(community.getNo() > 0) {
            // 게시물 수정
            result = mapper.updateCommunity(community);
        } else {
            // 게시물 등록
            result = mapper.insertCommunity(community);
        }

        return result;
    }

    // 게시글 삭제
    @Override
    @Transactional
    public int deleteCommunity(int no) {

        return mapper.updateStatus(no, "N");
    }

    // 좋아요 개수
    @Override
    public int getLikeCount(int communityNo) {

        return mapper.selectLikeCount(communityNo);
    }

    @Override
    @Transactional
    public void toggleLike(String userId, int communityNo) {
        // 좋아요 상태 조회
        List<Like> likes = mapper.likeCheck(userId, communityNo);

        if (!likes.isEmpty()) {
            for (Like like : likes) {
                if (like.getStatus().equals("Y")) {
                    // 이미 좋아요를 누른 경우 -> 좋아요 취소 (상태값을 'N'으로 업데이트)
                    mapper.updateLikeStatus(userId, communityNo, "N");
                } else {
                    // 좋아요를 누르지 않은 경우 -> 좋아요 등록 (상태값을 'Y'로 업데이트)
                    mapper.updateLikeStatus(userId, communityNo, "Y");
                }
            }
        } else {
            // 좋아요를 누른 적이 없는 경우 -> 좋아요 등록 (상태값을 'Y'로 업데이트)
            mapper.insertLike(userId, communityNo, "Y");
        }
    }

    @Override
    public String getLikeStatus(String userId, int no) {
        // 좋아요 상태 확인을 위한 메서드 호출
        List<Like> likes = mapper.likeCheck(userId, no);

        System.out.println(userId);
        System.out.println(no);
        System.out.println(likes);

        if (!likes.isEmpty()) {
            return likes.get(0).getStatus(); // 첫 번째 좋아요 데이터의 상태값을 반환
        }
        return "N"; // 좋아요 데이터가 없으면 'N'으로 반환
    }

    // 댓글 개수
    @Override
    public int getCommentCount(int communityNo) {
        return mapper.selectCommentCount(communityNo);
    }

    // 댓글 리스트
    @Override
    public List<Comment> getCommentsByCommunityNo(int communityNo) {
        return mapper.selectCommentByNoAndStatus(communityNo);
    }

    // 댓글 등록, 수정
    @Override
    public int commentsave(Comment comment) {

        int result = 0;

        if(comment.getNo() > 0) {
            // 댓글 수정
            result = mapper.updateComment(comment);
        } else {
            // 댓글 등록
            result = mapper.insertComment(comment);
        }

        return result;
    }

    // 커뮤니티의 최대 ref 값을 가져오기
    @Override
    public int getMaxRefByCommunityNo(int communityNo) {
        Integer maxRef = mapper.selectCommunityMaxRef(communityNo);
        return maxRef != null ? maxRef : 0;
    }

    // 댓글 삭제
    @Override
    public int deleteComment(int no) {
        return mapper.updateCommentStatus(no, "N");
    }

    @Override
    public Comment getCommentByno(int no) {
        return mapper.selectCommentByNo(no);
    }


}
