<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>


<jsp:include page="../common/header.jsp"/>
<jsp:include page="./community_header.jsp"/>

<section class="content-container" style="min-height: 500px;" >
  <div>
    <a href="javascript:history.back(-1)" style="color: black; text-decoration: none;>
      <i class="bi bi-chevron-compact-left"></i>
      <p style="display: inline-block; vertical-align: middle; margin-top: 5px;">돌아가기</p>
    </a>
  </div>

  <div class="board-search">
    <h2 style="font-size: 1.5em; font-weight: bold;">${ keyword }에 대한 검색결과</h2>

    <div class="search"  style="display: inline-block; vertical-align: middle;  position: relative; margin-bottom: 20px; margin-right: 100px;">
                <span class="material-symbols-outlined" style="position: absolute; margin-top: 7.5px; margin-left: 7.5px;">
                    search
                </span>
      <input type="text" name="keyword" id="search-keyword-large" class="search-keyword-large" value="${ keyword }" placeholder="알고 싶은 모든 커뮤니티 정보를 검색해보세요" style="width: 400px;">
    </div>

  </div>


  <div style="display: flex; align-items: center;">
    <span class="material-symbols-outlined" style="margin-bottom: 1rem;">expand_more</span>
    <p style="display: inline-block; vertical-align: middle; font-weight: bold;">${ listCount }개의 검색결과가 있습니다.</p>

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
    <p style="text-align: center; margin-top: 10px; font-size: 24px;">조회된 게시물이 없습니다.</p>
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

            <fmt:formatDate value="${ Community.createdDate }" pattern="yyyy-MM-dd" var="formattedDate" />
            <pre style="color: gray; margin-bottom: 5px;">${ formattedDate }  댓글 ${ Community.comment_cnt }  좋아요 ${ Community.like_cnt } </pre>
            <p style="font-size: 11px; font-weight: bold; margin-top: 7px; margin-bottom: 5px;">${ Community.user.nickname }</p>
          </a>
        </div>
      </div>
    </c:forEach>

    <div style="justify-content: center; display: flex; margin: 30px 0;">
      <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
        <ul class="pagination">
          <li class="page-item"><a class="page-link" onclick="handle_pagination('1', '${param.sortingOption}')">
            <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
          </a></li>
          <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.prevPage }', '${param.sortingOption}')">
            <span class="material-symbols-outlined">keyboard_arrow_left</span>
          </a></li>
          <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
            <c:if test="${empty param.page}">
              <c:if test="${current == 1}">
                <li class="page-item"><a class="page-link active disabled">${current}</a></li>
              </c:if>
              <c:if test="${current != 1}">
                <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }', '${param.sortingOption}')">${current}</a></li>
              </c:if>
            </c:if>
            <c:if test="${not empty param.page}">
              <c:if test="${current == param.page}">
                <li class="page-item"><a class="page-link active disabled">${current}</a></li>
              </c:if>
              <c:if test="${current != param.page}">
                <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }', '${param.sortingOption}')">${current}</a></li>
              </c:if>
            </c:if>
          </c:forEach>
          <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.nextPage }', '${param.sortingOption}')">
            <span class="material-symbols-outlined">keyboard_arrow_right</span>
          </a></li>
          <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.maxPage }', '${param.sortingOption}')">
            <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
          </a></li>
        </ul>
      </nav>
    </div>
  </c:if>

</section>

<script>
  $('.search-keyword-large').keypress(function(event) {
    if (event.which === 13) {
      // 엔터 키를 눌렀을 때 검색 버튼을 클릭하는 코드
      handle_search_button2();
    }
  });

  const handle_search_button2 = () => {
    const keyword = $('.search-keyword-large').val();
    const regex = /^[가-힣a-zA-Z0-9]+$/;

    if (!regex.test(keyword)) {
      $('.search-keyword-large').addClass('required');
      return;
    }

    window.location.href = '/studycafe/community/search?keyword=' + keyword;
  }

  // 정렬
  // URL 파라미터에서 sortingOption 값을 가져오기
  const urlParams = new URLSearchParams(window.location.search);
  const sortingOption = urlParams.get('sortingOption');

  // 정렬 옵션에 해당하는 select 요소를 선택
  $('#sorted-by').val(sortingOption);


  function changeSortingOption() {
    var sortingOption = document.getElementById("sorted-by").value;
    window.location.href = "${path}/community/search?keyword=${keyword}&sortingOption=" + sortingOption;
  }

  const handle_pagination = (page, sortingOption) => {
    console.log(page, sortingOption);

    let path = '/studycafe/community/search?';

    if(page !== ""){
      path += 'page=' + page;
      if(sortingOption !== ""){
        path += '&sortingOption=' + sortingOption;
      }
    }

    window.location.href = path;
  }

</script>

<style>
  .content-container {
    margin: 30px 150px 70px 150px;
  }

  .board-search {
    text-align: center;
    margin-bottom: 30px;
    margin-top: 30px;
  }

  /* 검색 */
  .search {
    position: relative;
  }

  .search input {
    border: 1px solid #bbb;
    border-radius: 8px;
    padding: 10px 12px 10px 35px;
    font-size: 14px;
  }

  .community-move a {
    width: 150px;
    height: 150px;
    background-color: #C8B6A6;
    border: 1px solid #C8B6A6;
    border-radius: 5px;
    margin-left: 10px;
    margin-bottom: 10px;
    display: inline-block;
    overflow: auto;
    text-decoration: none;
    color: black;
    cursor: pointer;
  }


  .community-move span {
    margin: 10px 0px 0px 10px;
    width: 40px;
    height: 40px;
  }

  .community-move h3 {
    font-size: 1.17em;
  }

  .notice-list {
    border-bottom: 1px solid gainsboro;
    padding-top: 20px;
  }

  .notice-list:hover {
    background-color: #eeeeee;
  }

  #sorted-by{
    height: 28px;
    border-radius: 8px;
    margin-bottom: 10px;
  }

  /*  페이지네이션 스타일   */
  .page-link {
    color: black;
    cursor: pointer;
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
