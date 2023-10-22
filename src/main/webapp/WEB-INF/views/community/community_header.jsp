<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
    /* 검색 */
    .search {
        position: relative;
        width: 300px;
    }
    .search input {
        border: 1px solid #bbb;
        border-radius: 8px;
        padding: 10px 12px 10px 35px;
        font-size: 14px;
    }

    .search img {
        position : absolute;
        width: 17px;
        top: 10px;
        left: 12px;
        margin: 0;
    }
</style>

<section style="margin: 10px 150px 0px 150px;">
    <div style="border-bottom: 2px solid #8D7B68;">
        <span class="material-symbols-outlined" style="width: 28px; height: 28px;">group</span>
        <div style="display: inline-block; vertical-align: middle;">
            <a href="${path}/community/mainpage" style="text-decoration: none; color: inherit;">
                <p style="color: #8D7B68; font-size: 24px; font-weight: bold;">커뮤니티</p>
            </a>
        </div>

        <div class="search"  style="display: inline-block; vertical-align: middle;  position: relative; margin-bottom: 20px; margin-left: 10px;">
                <span class="material-symbols-outlined" style="position: absolute; margin-top: 7.5px; margin-left: 7.5px;">
                    search
                </span>
            <input type="text" name="keyword" id="search-keyword-small" class="search-keyword-small"  value="${ keyword }" placeholder="어떤 정보를 알고 싶으신가요?"  style="width: 240px;">
        </div>
    </div>
</section>

<script>
    $('.search-keyword-small').keypress(function(event) {
        if (event.which === 13) {
            // 엔터 키를 눌렀을 때 검색 버튼을 클릭하는 코드
            handle_search_button();
        }
    });

    const handle_search_button = () => {
        const keyword = $('.search-keyword-small').val();
        const regex = /^[가-힣a-zA-Z0-9]+$/;

        if (!regex.test(keyword)) {
            $('.search-keyword-small').addClass('required');
            return;
        }

        window.location.href = '/studycafe/community/search?keyword=' + keyword;
    }

</script>
