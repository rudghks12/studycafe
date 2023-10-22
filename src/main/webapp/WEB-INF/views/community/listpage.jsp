<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>


<jsp:include page="../common/header.jsp"/>
<jsp:include page="./community_header.jsp"/>

<section style="margin-bottom: 70px;">
    <div style="margin-bottom: 30px;">
        <div class="content">
            <c:if test="${kind == '자유게시판'}">
                <span class="material-symbols-outlined">chat</span>
            <p style="font-size: 1.5em; font-weight: bold;">${kind}</p>
            <p style="font-size: 1.33em;">자유롭게 사람들과 소통해 보세요.</p>
            </c:if>
            <c:if test="${kind == '스터디모집'}">
                <span class="material-symbols-outlined">border_color</span>
                <p style="font-size: 1.5em; font-weight: bold;">${kind}</p>
                <p style="font-size: 1.33em;">같이 공부할 친구가 필요하신가요?</p>
            </c:if>
            <c:if test="${kind == '공부법공유'}">
                <span class="material-symbols-outlined">emoji_objects</span>
                <p style="font-size: 1.5em; font-weight: bold;">${kind}</p>
                <p style="font-size: 1.33em;">나만의 특별한 공부법이 있다면 공유해 보세요. </p>
            </c:if>
            <c:if test="${kind == '합격후기'}">
                <span class="material-symbols-outlined">sentiment_satisfied</span>
                <p style="font-size: 1.5em; font-weight: bold;">${kind}</p>
                <p style="font-size: 1.33em;">합격후기를 다른사람들과 공유해보면 어떤가요?</p>
            </c:if>
            <button type="button" id="btn-write" onclick="location.href='${ path }/community/write'">바로 작성해보세요.</button>
        </div>
    </div>

    <div style="margin: 0px 150px;">
        <div style="display: flex; align-items: center;">
            <span class="material-symbols-outlined" style="margin-bottom: 1rem;">expand_more</span>
            <p style="display: inline-block; vertical-align: middle; font-weight: bold;">지금 바로 확인해보세요.</p>

            <div class="select-container" style="margin-left: auto;">
                <select name="sortingOption" id="sorted-by" onchange="changeSortingOption()" style="padding: 0px 5px; height: 30px;">
                    <option value="">정렬기준</option>
                    <option id="latest" value="latest">최신순</option>
                    <option id="recommend" value="recommend">추천순</option>
                    <option id="popular" value="popular">인기순</option>
                    <option id="oldest" value="oldest">오래된순</option>
                </select>
            </div>
        </div>

        <c:if test="${ empty list }">
            <p style="text-align: center;">조회된 게시물이 없습니다.</p>
        </c:if>

        <c:if test="${ not empty list }">
            <c:forEach var="Community" items="${ list }">
                <div class="notice-list">
                    <div>
                        <a href="${ path }/community/detail?no=${ Community.no }" style="text-decoration: none;color: black; cursor: pointer;">
                            <u style="font-size: 13px;">${ Community.kind }</u>
                            <p style="margin-top: 10px; margin-bottom: 5px; font-size: 1.17em; font-weight: bold;">${ Community.title }</p>
                            <%-- 내용 --%>
                            <span style="color: gray;">${fn:substring(Community.content, 0, 30)}</span>
                            <c:if test="${fn:length(Community.content) > 30}">
                                <span style="color: gray; margin-bottom: 5px;">...</span>
                            </c:if>
                            <%-- 날짜 --%>
                            <fmt:formatDate value="${ Community.createdDate }" pattern="yyyy-MM-dd" var="formattedDate" />
                            <pre style="color: gray; margin-bottom: 5px;">${ formattedDate }  댓글 ${ Community.comment_cnt }  좋아요 ${ Community.like_cnt }</pre>
                            <p style="font-size: 11px; font-weight: bold; margin-top: 7px; margin-bottom: 5px;">${ Community.user.nickname }</p>
                        </a>
                    </div>
                </div>
            </c:forEach>

            <div style="justify-content: center; display: flex; margin: 30px 0;">
                <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('1','${param.kind}', '${param.sortingOption}')">
                            <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                        </a></li>
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.prevPage }', '${param.kind}', '${param.sortingOption}')">
                            <span class="material-symbols-outlined">keyboard_arrow_left</span>
                        </a></li>
                        <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                            <c:if test="${empty param.page}">
                                <c:if test="${current == 1}">
                                    <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                                </c:if>
                                <c:if test="${current != 1}">
                                    <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }', '${param.kind}', '${param.sortingOption}')">${current}</a></li>
                                </c:if>
                            </c:if>
                            <c:if test="${not empty param.page}">
                                <c:if test="${current == param.page}">
                                    <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                                </c:if>
                                <c:if test="${current != param.page}">
                                    <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }', '${param.kind}', '${param.sortingOption}')">${current}</a></li>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.nextPage }', '${param.kind}','${param.sortingOption}')">
                            <span class="material-symbols-outlined">keyboard_arrow_right</span>
                        </a></li>
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.maxPage }', '${param.kind}', '${param.sortingOption}')">
                            <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                        </a></li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>

</section>

<script>
    // 정렬
    // URL 파라미터에서 sortingOption 값을 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const sortingOption = urlParams.get('sortingOption');
    console.log(urlParams, sortingOption)

    // 정렬 옵션에 해당하는 select 요소를 선택
    $('#sorted-by').val(sortingOption);

    function changeSortingOption() {
        var sortingOption = document.getElementById("sorted-by").value;
        window.location.href = "${path}/community/listpage?kind=${kind}&sortingOption=" + sortingOption;
    }

    const handle_pagination = (page, kind, sortingOption) => {
        console.log(page, kind, sortingOption);

        let path = '/studycafe/community/listpage?kind=${kind}';

        if(page !== ""){
            path += '&page=' + page;
            if(sortingOption !== ""){
                path += '&sortingOption=' + sortingOption;
            }
        }

        window.location.href = path;
    }

</script>

<style>
    .content {
        height: 230px;
        background-color: #C8B6A6;
        padding: 20px 150px;
        position: relative;
    }
    #btn-write {
        color: white;
        background-color: #8D7B68;
        border-style: none;
        border-radius: 10px;
        width: 200px;
        height: 40px;
        position: absolute;
        right: 150px;
        box-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }

    #sorted-by{
        height: 28px;
        border-radius: 8px;
        margin-bottom: 10px;
    }

    .notice-list {
        border-bottom: 1px solid gainsboro;
        padding-top: 20px;
    }

    .notice-list:hover {
        background-color: #eeeeee;
    }

    /*  페이지네이션 스타일   */
    .page-link {
        color: black;
        cursor: pointer;
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

<jsp:include page="../common/footer.jsp"/>