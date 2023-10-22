<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../../common/header.jsp"/>

<style>
    <%--  글쓰기 버튼  --%>
    .listbutton {
        background-color: #8D7B68;
        color: white;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 18px;
        border: none; /* 테두리 없앰 */
        margin: 20px 0px;
        margin-right: 30px;
    }
    .listbutton:hover{
        background-color: #685948;
    }


    .custom-link {
        text-decoration: none;
        color: black;
        cursor: pointer;
    }
    /* 이미지 스타일 */
    img {
        max-width: 1280px;
        height: auto;
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
    /*  페이지네이션 스타일   */
    .page-link {
        color: black;
        /*font-weight: bold;*/
    }

    .page-link.disabled {
        color: white;
        background-color: #8D7B68;
        border-color: #8D7B68;
    }

    .page-link:hover:not(.page-link.active) {
        color: #8D7B68;
    }

    .page-link:focus {
        box-shadow: none;
    }


</style>

<section style="margin: auto; max-width:1280px;">
    <div>
        <div style="position: relative;">
            <img src="${path}/images/notice2.png.jpg" alt="공지 이미지">
            <div class="image-text">공지사항</div>
        </div>



        <c:if test="${ empty list }">
            <h3>조회된 게시물이 없습니다.</h3>
        </c:if>

        <c:if test="${not empty list}">
            <c:forEach var="notice" items="${list}">
        <div style="border-bottom: 2px solid gainsboro;  width: 80%; margin: 0 auto; margin-top: 40px; ">
            <a href="${path}/customer/notice/detail/${notice.no}" class="custom-link" style="display: flex; align-items: center;">

                <div style="flex: 1; margin-right: 20px;">
            <span style="font-size: 14px; font-weight: bold; color: #323030F8;">
                [${notice.kind}]
            </span>
                </div>
                <div style="flex: 6;">
            <span style="font-size: 18px; font-weight: bold; text-align: center;">
                    ${notice.title}
            </span>
                </div>
                    <div style="flex: 1; text-align: right;">
            <span style="color: gray;">
                <fmt:formatDate value="${notice.createDate}" pattern="yyyy.MM.dd" />
            </span>

                </div>
            </a>
        </div>
            </c:forEach>
        </c:if>

        <div style="justify-content: center; display: flex; margin: 30px 0;">
            <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="${path}/customer/notice/list?page=1">
                        <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                    </a></li>
                    <li class="page-item"><a class="page-link" href="${path}/customer/notice/list?page=${pageInfo.prevPage}">
                        <span class="material-symbols-outlined">keyboard_arrow_left</span>
                    </a></li>
                    <c:forEach var="current" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                        <c:if test="${empty param.page}">
                            <c:if test="${current == 1}">
                                <li class="page-item"><a class="page-link active disabled" href="${path}/customer/notice/list?page=${current}">${current}</a></li>
                            </c:if>
                            <c:if test="${current != 1}">
                                <li class="page-item"><a class="page-link" href="${path}/customer/notice/list?page=${current}">${current}</a></li>
                            </c:if>
                        </c:if>
                        <c:if test="${not empty param.page}">
                            <c:if test="${current == param.page}">
                                <li class="page-item"><a class="page-link active disabled" href="${path}/customer/notice/list?page=${current}">${current}</a></li>
                            </c:if>
                            <c:if test="${current != param.page}">
                                <li class="page-item"><a class="page-link" href="${path}/customer/notice/list?page=${current}">${current}</a></li>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <li class="page-item"><a class="page-link" href="${path}/customer/notice/list?page=${pageInfo.nextPage}">
                        <span class="material-symbols-outlined">keyboard_arrow_right</span>
                    </a></li>
                    <li class="page-item"><a class="page-link" href="${path}/customer/notice/list?page=${pageInfo.maxPage}">
                        <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                    </a></li>
                </ul>
            </nav>
        </div>


        <security:authorize access="hasRole('ROLE_ADMIN')">
        <div style="position: relative;">
            <a href="${path}/customer/notice/add" class="custom-link" style="position: absolute; top: -100px; right: 100px;">
                <button class="listbutton">글쓰기</button>
            </a>
        </div>
        </security:authorize>

</section>
<script>

</script>


<jsp:include page="../../common/footer.jsp"/>