<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="../../common/header.jsp"/>

<style>
    img {
        max-width: 1280px;
        height: auto;
    }
    .image {
        text-align: center;
    }

    .image-text {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: rgba(255, 255, 255, 0.001); /* 텍스트 배경의 투명도 설정 */
        padding: 20px; /* 원하는 크기로 설정합니다. */
        font-size: 36px; /* 원하는 글꼴 크기로 설정합니다. */
        font-weight: bold; /* 글씨를 굵게 설정합니다. */
        color: white; /* 글씨색을 흰색으로 설정합니다. */
    }

    .content-container {
        position: relative;
        max-width: 1280px;
        width: 100%;
        padding: 0 20px;
         /* 원하는 최소 높이 값으로 설정하세요 */
    }


    /*!* 목록으로 버튼 스타일 추가 *!*/
    .back-button {
        background-color: #8D7B68;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px; /* Adjust the padding for both top/bottom and left/right */
        width: 600px;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
        text-decoration: none;
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        text-align: center;
        margin-top:-50px; /* Use 'top' instead of 'margin-top' to create space from the top */
    }


    .button-container {
        display: flex;
        justify-content: flex-end; /* 오른쪽 정렬 */
        gap: 8px; /* 버튼 사이의 간격 설정 */
        margin-bottom: 60px; /* 푸터와의 간격 설정 */
        margin-top: 100px; /* 버튼과 상세 내용 사이의 간격을 늘립니다. */
        margin-right: 100px;
    }
    .back-button:hover {
        background-color: #685948; /* 마우스 호버 시 배경색 변경 */
    }
    .edit-delete-button{
        background-color: #8D7B68;
        color: white;
        border-radius: 5px;
        padding: 10px 18px;
        font-size: 14px;
        cursor: pointer;
        text-decoration: none;
    }
    .edit-delete-button:hover {
        background-color: #685948; /* 마우스 호버 시 배경색 변경 */
    }
    .noticeh2{
        /*margin-top: 40px ;*/
        /*margin-bottom: 40px;*/
        margin: 40px;
        border-bottom: 2px solid #8D7B68 ;
    }
    /* 스타일 추가 */
    .notice-details {
        border: 2px solid whitesmoke;
        padding: 20px;
        margin-bottom: 20px;
        margin: 40px;
        min-height: 600px;
    }

    .notice-details h4 {
        font-size: 30px;
        font-weight: bold;
        color: black;


    }

    .notice-details span {
        color: gray;
    }

    .notice-content {
        border: 1px solid #8D7B68;
        padding: 60px;
        margin: 40px;
    }
</style>

<section style="margin: auto; max-width:1280px;">
    <div class="content-container">
        <div>
            <div style="position: relative;">
                <img src="${path}/images/notice2.png.jpg" alt="공지 이미지">
                <div class="image-text">공지사항</div>
            </div>
            <div class="notice-details">
                <h4> ${notice.title}</h4>
                <br>
                <span style="color: gray; margin-left: 2px; margin-bottom: 50px">
                    등록일 :  <fmt:formatDate value="${notice.createDate}" pattern="yyyy.MM.dd" />
                </span>

                <hr style="border: 2px solid #8D7B68; margin: 10px 0; margin-top: 20px;">
                <p style="font-size: 18px; ">${notice.content}</p>
            </div>
        </div>

        </div>
    <div>
<%--        <div class="button-container">--%>
<%--            <div style="flex-grow: 1;"></div> <!-- 공간을 채우기 위한 빈 div -->--%>
<%--            <a href="${path}/customer/notice/list" class="back-button">목록으로</a>--%>
<%--            <security:authorize access="hasRole('ROLE_ADMIN')">--%>
<%--                <!-- 관리자로 로그인한 경우에만 아래 버튼들이 표시됩니다. -->--%>
<%--                <a href="${path}/customer/notice/edit/${notice.no}" class="edit-delete-button">수정</a>--%>
<%--                <a href="${path}/customer/notice/delete/${notice.no}"--%>
<%--                   onclick="return confirm('정말로 삭제하시겠습니까?')" class="edit-delete-button">삭제</a>--%>
<%--            </security:authorize>--%>
<%--        </div>--%>

        <a href="${path}/customer/notice/list" class="back-button">목록으로</a>
        <div class="button-container">

        <security:authorize access="hasRole('ROLE_ADMIN')">
            <!-- 관리자로 로그인한 경우에만 아래 버튼들이 표시됩니다. -->
            <a href="${path}/customer/notice/edit/${notice.no}" class="edit-delete-button"  >수정</a>
            <a href="${path}/customer/notice/delete/${notice.no}"
               onclick="return confirm('정말로 삭제하시겠습니까?')" class="edit-delete-button">삭제</a>
        </security:authorize>
    </div>
    </div>
</section>

<jsp:include page="../../common/footer.jsp"/>
