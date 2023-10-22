package com.sss.studycafe.community.model.mapper;

import com.sss.studycafe.community.model.vo.Comment;
import com.sss.studycafe.community.model.vo.Community;
import com.sss.studycafe.community.model.vo.Like;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface CommunityMapper {

    // 메인페이지
    // 전체 게시글 수 조회
    int selectCommunityCount();

    // 전체 게시글 조회
    List<Community> selectAll(RowBounds rowBounds);

    // 메인페이지 정렬
    List<Community> selectAllByPopular(RowBounds rowBounds);
    List<Community> selectAllByRecommend(RowBounds rowBounds);
    List<Community> selectAllByOldest(RowBounds rowBounds);


    // 게시판 종류에 따른 게시글 수 조회
    int selectCommunityCountByKind(String kind);

    // 게시판 종류에 따른 전체 게시글 조회
    List<Community> selectCommunityListByKind(String kind, RowBounds rowBounds);

    // 리스트페이지 정렬
    List<Community> selectCommunityListByKindAndPopular(String kind, RowBounds rowBounds);
    List<Community> selectCommunityListByKindAndRecommend(String kind, RowBounds rowBounds);
    List<Community> selectCommunityListByKindAndOldest(String kind, RowBounds rowBounds);

    // 검색페이지
    // 전체 게시글 수(검색적용)
    int selectCommunityCountByKeyword(@Param("keyword") String keyword);

    // 현재 페이지에 표시할 게시글 목록을 가져옴(검색적용)
    List<Community> selectAllByKeyword(@Param("keyword") String keyword, RowBounds rowBounds);

    // 검색페이지 정렬
    List<Community> selectAllByKeywordAndPopular(@Param("keyword") String keyword, RowBounds rowBounds);
    List<Community> selectAllByKeywordAndRecommend(@Param("keyword") String keyword, RowBounds rowBounds);
    List<Community> selectAllByKeywordAndOldest(@Param("keyword") String keyword, RowBounds rowBounds);

    // 게시글 상세페이지
    Community selectCommunityByNo(@Param("no") int no);

    // 게시글 등록
    int insertCommunity(Community community);

    // 게시글 수정
    int updateCommunity(Community community);

    // 게시글 삭제
    int updateStatus(@Param("no") int no, @Param("status") String status);

    // 좋아요 개수
    int selectLikeCount(int communityNo);

    // 좋아요 상태 확인
    List<Like> likeCheck(@Param("userId") String userId, @Param("communityNo") int communityNo);

    // 좋아요 상태 업데이트
    void updateLikeStatus(@Param("userId") String userId, @Param("communityNo") int communityNo, @Param("status") String status);

    // 좋아요 추가
    void insertLike(@Param("userId") String userId, @Param("communityNo") int communityNo, @Param("status") String status);

    // 댓글 개수
    int selectCommentCount(int communityNo);

    // 댓글 리스트
    List<Comment> selectCommentByNoAndStatus(int communityNo);

    // 댓글 등록
    int insertComment(Comment comment);

    // 댓글 수정
    int updateComment(Comment comment);

    // 커뮤니티별 최대 ref 값 조회
    Integer selectCommunityMaxRef(int communityNo);

    // 댓글 삭제
    int updateCommentStatus(@Param("no") int no, @Param("status") String status);

    Comment selectCommentByNo(int no);
}
