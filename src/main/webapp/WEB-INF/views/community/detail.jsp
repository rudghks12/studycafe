<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>

<section class="community-detail" style="margin: 10px 150px 50px 150px; ">
    <%-- 위에 게시판 이름 나옴  --%>
    <div style="border-bottom: 2px solid #8D7B68;">
        <h3 style="color: #8D7B68; font-size: 24px; font-weight: bold;">${ community.kind }</h3>
    </div>

    <div id="community-detail-content" style="margin: 20px 50px;">
        <%-- 돌아가기  --%>
        <a href="${path}/community/listpage?kind=${community.kind}" style="color: black; text-decoration: none;">
            <i class="bi bi-chevron-compact-left"></i>
            <p style="display: inline-block; vertical-align: middle; margin-top: 5px;">돌아가기</p>
        </a>

        <%-- 상세페이지 내용  --%>
        <div style="border-bottom: 2px solid #8D7B68;">
            <div style="min-height: 400px;">
                <u style="font-size: 16px;">${ community.kind }</u>
                <p style="margin-top: 10px; margin-bottom: 5px; font-size: 28px;">${ community.title }</p>

                <div style="align-items: center; display: flex; margin: 10px 0px 20px 0px;">
                    <c:if test= '${community.user.email.contains("KAKAO_")}'>
                        <img class="community-img" style="width: 100%; height: 100%; object-fit: cover; background-color: white; width: 60px; height: 60px; object-fit: fill" src="${community.user.image}">
                    </c:if>
                    <c:if test="${community.user.email.contains('NAVER_')}">
                        <img class="community-img" style="width: 100%; height: 100%; object-fit: cover; background-color: white; width: 60px; height: 60px; object-fit: fill" src="${community.user.image}">
                    </c:if>
                    <c:if test= '${ not community.user.email.contains("KAKAO_") and not community.user.email.contains("NAVER_")}'>
                        <img class="community-img" src="${community.user.image.substring(0, community.user.image.indexOf('upload/') + 7).concat("c_fill,h_60,w_60/").concat(community.user.image.substring(community.user.image.indexOf('upload/') + 7))}">
                    </c:if>

                    <div style="display: inline-block; margin-left: 10px;">
                        ${ community.user.nickname }
                        <fmt:formatDate value="${ community.createdDate }" pattern="yyyy-MM-dd" var="formattedDate" />
                        <pre style="color: gray; margin-bottom: 5px;">${ formattedDate }</pre>
                    </div>
                </div>

                <p style="font-size: 20px; margin-bottom: 5px;" id="community_content">${ community.content }</p>
            </div>

            <%-- 댓글 좋아요 수  --%>
            <div style="align-items: center; display: flex; margin: 10px 0;">
                <i class="material-symbols-outlined">chat</i>
                <div style="display: inline-block; margin-right: 10px;">댓글 ${ commentCount } </div>

                <c:if test="${ empty user }">
                <button id="btn-like-empty"><i class="fa fa-heart" style="font-size:20px; color: lightgrey;"></i></button>
                <div style="display: inline-block; margin-right: 10px;"> 좋아요 ${ likeCount }</div>
                </c:if>

                <c:if test="${ not empty user }">
                    <c:choose>
                        <c:when test="${likecheck eq 'N' or empty likecheck}">
                            <button id="btn-like" style="color: lightgrey;"><i class="fa fa-heart" style="font-size:20px; "></i></button>
                        </c:when>
                        <c:otherwise>
                            <button id="btn-like" style="color: red;"><i class="fa fa-heart" style="font-size:20px;"></i></button>
                        </c:otherwise>
                    </c:choose>
                    <div style="display: inline-block; margin-right: 10px;"> 좋아요 <span id="like-count">${ likeCount }</span></div>
                </c:if>
            </div>
        </div>

        <%-- 댓글부분  --%>
        <div>
            <p style="margin-top: 10px; font-weight: bold;">댓글</p>
            <div style="margin-bottom: 20px;">
                <%-- 댓글 구현 시작 --%>
                    <c:choose>
                        <c:when test="${not empty comments}">
                            <%-- 댓글 리스트 --%>
                            <div id="comment-list">
                            <c:forEach var="comment" items="${comments}">
                                <c:if test="${comment.step == 0}">
                                <div class="comment-container" style="border-bottom: 1px solid #8D7B68; margin-bottom: 20px;">
                                </c:if>
                                <c:if test="${comment.step != 0}">
                                <div class="comment-container" style="border-bottom: 1px solid #8D7B68; margin-bottom: 20px; margin-left: 30px;">
                                </c:if>
                                    <div style="display: inline-block; vertical-align: middle; margin-right: 10px;">
                                        <c:if test= '${comment.user.email.contains("KAKAO_")}'>
                                            <img class="community-img" style="width: 100%; height: 100%; object-fit: cover; background-color: white; width: 60px; height: 60px; object-fit: fill" src="${comment.user.image}">
                                        </c:if>
                                        <c:if test="${comment.user.email.contains('NAVER_')}">
                                            <img class="community-img" style="width: 100%; height: 100%; object-fit: cover; background-color: white; width: 60px; height: 60px; object-fit: fill" src="${comment.user.image}">
                                        </c:if>
                                        <c:if test= '${ not comment.user.email.contains("KAKAO_") and not comment.user.email.contains("NAVER_")}'>
                                            <img class="community-img" src="${comment.user.image.substring(0, comment.user.image.indexOf('upload/') + 7).concat("c_fill,h_60,w_60/").concat(comment.user.image.substring(comment.user.image.indexOf('upload/') + 7))}">
                                        </c:if>
                                    </div>


                                    <div style="display: inline-block; vertical-align: middle;">
                                        <p style="margin-bottom: 0px; font-weight: bold">${comment.user.nickname}</p>
                                        <span style="margin-bottom: 0px;">
                                            <c:if test="${comment.step != 0}">
                                                <c:set var="pUserId" value="${comment.p_userId}" />
                                                <c:set var="pUser" value="${comments.stream().filter(c -> c.userId == pUserId).findFirst().orElse(null)}" />
                                                <span>${pUser.user.nickname} </span>
                                            </c:if>
                                            <c:if test="${comment.status == 'Y'}">
                                                <span style="font-family: SOYOMapleBoldTTFl; font-weight: 400; ">${comment.content} </span>
                                            </c:if>
                                            <c:if test="${comment.status != 'Y'}">
                                                 <span style="font-family: SOYOMapleBoldTTFl; font-weight: 400; ">삭제된 댓글입니다. </span>
                                            </c:if>
                                        </span>

                                        <div class="comment-last">
                                        <span style="margin-bottom: 0px;">
                                            <fmt:formatDate value="${comment.createdDate}" pattern="yyyy.MM.dd HH:mm" />
                                        </span>
                                            <c:if test="${not empty user && comment.status == 'Y'}">
                                                <a role="button" id="btn-comment-reply" style="font-size: 10px;">답글쓰기</a>
                                                <c:if test="${ user.id == comment.userId }">
                                                    <a role="button" id="btn-comment-edit" data-comment-no="${comment.no}" data-comment-content="${comment.content}" style="font-size: 10px;">수정</a>
                                                    <a role="button" id="btn-comment-delete" data-comment-no="${comment.no}" style="font-size: 10px;">삭제</a>
                                                </c:if>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- 수정 댓글 작성 form -->
                                    <div id="update-form" style="display: none; border: 1px solid darkgray; border-radius: 10px; margin: 20px 0px;">
                                        <div style="margin: 20px;">
                                            <textarea class="comment-text" id="comment-content" name="content"></textarea>

                                            <div class="comment-btn" style="text-align: right;">
                                                <input type="reset" id="btn-comment-edit-cancel" value="취소">
                                                <input type="submit" id="btn-comment-edit-update" value="수정">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 대댓글 작성 form -->
                                    <div id="reply-form" style="display: none; border: 1px solid darkgray; border-radius: 10px; margin: 20px 0px;">
                                        <form action="${path}/comment/write" method="POST">
                                            <security:csrfInput/>
                                            <div style="margin: 20px;">
                                                <p style="font-weight: bold; margin-bottom: 10px;">
                                                        ${user.nickname}
                                                </p>

                                                <input type="hidden" name="community_no" value="${community.no}" />
                                                <input type="hidden" name="p_userId" value="${comment.userId}" />
                                                <input type="hidden" name="ref" value="${comment.ref}" />
                                                <input type="hidden" name="step" value="${comment.step}" />

                                                <!-- 대댓글 내용 입력 필드 -->
                                                <textarea class="comment-text" name="content" placeholder="댓글을 남겨보세요."></textarea>
                                                <br>
                                                <!-- 대댓글 작성 버튼 -->
                                                <div class="comment-btn" style="text-align: right;">
                                                    <input type="reset" value="취소">
                                                    <input type="submit" value="등록">
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                            </div>
                        </c:when>
                    <c:otherwise>
                        <p>입력된 댓글이 없습니다.</p>
                    </c:otherwise>
                    </c:choose>
            </div>

            <%--    댓글 작업        --%>
            <c:if test="${ not empty user }">
                <div style="border: 1px solid darkgray; border-radius: 10px; width: 878px; height: 157px;">

                <form  action="${ path }/comment/write" method="POST" >
                    <security:csrfInput/>
                    <div style="margin: 20px;">
                        <p style="font-weight: bold; margin-bottom: 10px;">
                            <security:authentication property="principal.nickname" />
                        </p>

                        <input type="hidden" name="community_no" value="${community.no}" />

                        <textarea class="comment-text" name="content" placeholder="댓글을 남겨보세요."> </textarea>
                        <br>

                        <div class="comment-btn" style="text-align: right;">
                            <input type="submit" id="btn-comment-save" value="등록">
                        </div>
                    </div>
                </form>
                </div>
            </c:if>
            <c:if test="${ empty user }">
                <div style="border: 1px solid darkgray; border-radius: 10px;">
                    <p style="margin-left: 10px; margin-top: 10px;">로그인 후 댓글에 참여해주세요.</p>
                </div>
            </c:if>
        </div>

        <!-- 댓글 끝  -->
        <div class="Article-Btns" style="display: flex; justify-content: space-between; margin-top: 20px;">
            <div class="left_area">
                <input type="button" onclick="location.href='${ path }/community/write'" value="글쓰기" style="width: 80px;">
            </div>

            <div class="right_area" style="display: flex;">
                <c:if test="${not empty user and user.id == community.userId}">
                    <input type="button" id="btn-rewrite" value="수정" style="margin-right: 10px; width: 50px;">
                    <input type="button" id="btn-delete" value="삭제" style="width: 50px;">
                </c:if>
            </div>
        </div>
    </div>

</section>

<script>
    $(document).ready(() => {
        $('#btn-delete').on('click', () => {
            if (confirm('게시글을 삭제 하시겠습니까?')) {
                location.replace('${ path }/community/delete?no=${ community.no }');
            }
        });

        $('#btn-rewrite').on('click', () => {
            if (confirm('게시글을 수정 하시겠습니까?')) {
                location.replace('${ path }/community/update?no=${ community.no }');
            }
        });

        // 좋아요
        let likeCheck = '${likeCheck}';
        let likeCount = ${likeCount}; // 현재 좋아요 개수

        updateLikeButton(likeCheck); // 좋아요 버튼 초기 상태 설정
        updateLikeCount(likeCount); // 좋아요 개수 초기 설정

        $('#btn-like-empty').on('click', function() {
            alert('로그인 후 이용 가능합니다');
        });

        let header = $('meta[name="_csrf_header"]').attr('content');
        let token = $('meta[name="_csrf"]').attr('content');

        console.log(header, token);
        console.log('Like 상태:', likeCheck);

        $('#btn-like').on('click', function() {
            $.ajax({
                type: 'POST',
                url: `${path}/community/toggle-like`,
                data: {
                    userId: '${user.id}',
                    communityNo: '${community.no}',
                    status: likeCheck === 'Y' ? 'N' : 'Y'
                },
                beforeSend: (xhr) => {
                    xhr.setRequestHeader(header, token);
                },
                success: function(response) {
                    likeCheck = likeCheck === 'Y' ? 'N' : 'Y'; // 상태 업데이트
                    updateLikeButton(likeCheck); // 좋아요 버튼 업데이트
                    if (likeCheck === 'Y') {
                        likeCount += 1; // 좋아요 수 증가
                    } else {
                        likeCount -= 1; // 좋아요 수 감소
                    }
                    updateLikeCount(likeCount); // 좋아요 개수 업데이트
                },
                error: function(err) {
                    console.log(err);
                }
            });
        });

        function updateLikeButton(status) {
            if (status === 'Y') {
                $('#btn-like').css('color', 'red');
            } else {
                $('#btn-like').css('color', 'lightgrey');
            }
        }

        function updateLikeCount(count) {
            $('#like-count').text(count); // 좋아요 개수 업데이트
        }

        // 댓글
        // 댓글 등록시 내용 있나 확인
        $(document).on('submit', 'form', function(event) {
            // 댓글 내용을 가져옵니다.
            var commentContent = $(this).find('textarea[name="content"]').val().trim();

            // 댓글 내용이 비어있을 경우 알림창을 띄웁니다.
            if (commentContent === '') {
                alert('댓글을 입력해주세요.');
                event.preventDefault();
            }
        });

        // 댓글 삭제
        $(document).on('click', '#btn-comment-delete', function() {
            if (confirm('댓글을 삭제 하시겠습니까?')) {

                var commentNo = $(this).data('comment-no');

                $.ajax({
                    type: 'POST',
                    url: '${path}/comment/delete',
                    data: {
                        no: commentNo
                    },
                    beforeSend: (xhr) => {
                        xhr.setRequestHeader(header, token);
                    },
                    success: function(response) {
                        location.reload();
                    },
                    error: function(err) {
                        console.log(err);
                    }
                });
            }
        });

        // 답글쓰기 버튼을 클릭했을 때 대댓글 form 토글
        $(document).on('click', '#btn-comment-reply', function() {
            // 클릭한 답글쓰기 버튼이 속한 부모 댓글의 하위에 있는 대댓글 form 토글
            $(this).closest('.comment-container').find('#reply-form').toggle();
        });

        $(document).on('click', '#reply-form input[type="reset"]', function() {
            $(this).closest('#reply-form').hide();
        });

        // 댓글 수정
        // 댓글에서 수정 버튼 눌렀을때  form 나오도록 하는 스크립트
        $(document).on('click', '#btn-comment-edit', function() {
            // 클릭한 수정 버튼이 속한 부모 요소인 .comment-container를 찾습니다.
            var commentContainer = $(this).closest('.comment-container');
            // 댓글 번호 가져오기
            var commentNo = $(this).data('comment-no');
            // 기존의 내용을 가져옵니다.
            var content = $(this).data('comment-content');
            // 기존의 내용을 update-form 안의 textarea에 설정합니다.
            commentContainer.find('#update-form textarea').val(content);
            // update-form을 표시합니다.
            commentContainer.find('#update-form').show();
            // 댓글 번호를 데이터로 추가
            commentContainer.find('#btn-comment-edit-update').data('comment-no', commentNo);
        });


        // 댓글 수정 form에서 취소 버튼 눌렀을 경우
        $(document).on('click', '#btn-comment-edit-cancel', function() {
            $(this).closest('#update-form').hide();
        });

        // 댓글 수정 form에서 수정 버튼 눌렀을 경우
        $(document).on('click', '#btn-comment-edit-update', function() {
            if (confirm('댓글을 수정 하시겠습니까?')) {

                var commentNo = $(this).data('comment-no');
                var updatedContent = $(this).closest('#update-form').find('#comment-content').val();

                $.ajax({
                    type: 'POST',
                    url: '${path}/comment/update',
                    data: {
                        no: commentNo,
                        content: updatedContent
                    },
                    beforeSend: (xhr) => {
                        xhr.setRequestHeader(header, token);
                    },
                    success: function(response) {
                        location.reload();
                    },
                    error: function(err) {
                        console.log(err);
                    }
                });
            }
        });

    });


</script>

<style>
    .Article-Btns input {
        color: white;
        background-color: #8D7B68;
        border-style: none;
        border-radius: 5px;
        height: 30px;
    }

    .comment-text {
        width: 100%;
        border: none;
        resize: none;
        overflow-wrap: break-word;
        word-wrap: break-word;
        margin-bottom: 5px;
    }

    .comment-btn input{
        border-style: none;
        background-color: white;
    }

    .comment-last {
        color: gray;
        font-size: 13px;
    }

    .community-img {
        border-radius: 50%;
        width: 60px;
        height: 60px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }

    #btn-like, #btn-like-empty {
        border-style: none;
        background-color: white;
    }

    .image {
      text-align: center;
    }

    .table table {
        border-collapse: collapse;
    }

    .table table td {
        border: 1px solid lightgray;
        padding: 10px;
    }

</style>

<jsp:include page="../common/footer.jsp"/>