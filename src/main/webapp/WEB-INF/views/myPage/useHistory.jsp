<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="components/myPageHeader.jsp"/>

<style>
  #useHistoryPage {
    min-height: 750px;
  }

  .tabs {
    list-style: none;
    padding: 0;
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
  }

  .tab-item {
    flex-grow: 1;
    text-align: center;
  }

  .tab-item a {
    text-decoration: none;
    padding: 10px 20px;
    background-color: #eee;
    color: #333;
    border: none;
    display: block;
  }

  .tab-item.active a {
    background-color: #8D7B68;
    color: white;
  }

  .tab-content {
    display: none;
  }

  .tab-content.active {
    display: block;
  }

  #use {
    table-layout: fixed;
  }

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
<section id="useHistoryPage">
  <hr>
  <ul class="tabs">
    <li class="tab-item"><a href="#tab1">이용내역</a></li>
    <li class="tab-item"><a href="#tab2">이용권</a></li>
    <li class="tab-item"><a href="#tab3">쿠폰함</a></li>
  </ul>

  <div id="tab1" class="tab-content">
    <div>
      <c:choose>
        <c:when test="${empty histories}">
          <div style="text-align: center; margin-top: 100px; margin-bottom: 100px;">
            <p style="font-size: 24px; font-weight: bold;">이용내역이 없습니다.</p>
          </div>
        </c:when>
        <c:otherwise>
          <table id="use" class="table table-striped" style="margin-top: 30px; width:100%; text-align: center">
            <thead>
            <tr>
              <td style="font-weight: bold; font-size: 20px;">입실</td>
              <td style="font-weight: bold; font-size: 20px;">퇴실</td>
            </tr>
            </thead>
            <tbody id="historyListContainer">
            <c:forEach var="history" items="${histories}">
              <tr>
                <td style="padding:10px;"><fmt:formatDate value="${history.checkIn}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/></td>
                <td style="padding:10px;"><fmt:formatDate value="${history.checkOut}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/></td>
              </tr>
            </c:forEach>
            </tbody>
          </table>

          <div style="justify-content: center; display: flex; margin: 30px 0;">
            <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
              <ul class="pagination" id="paginationContainer">
                <li class="page-item"><a class="page-link" onclick="handlePagination('1', 0)">
                  <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                </a></li>
                <li class="page-item"><a class="page-link" onclick="handlePagination('${pageInfo.prevPage}', 0)">
                  <span class="material-symbols-outlined">keyboard_arrow_left</span>
                </a></li>
                <c:forEach var="current" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
                  <c:if test="${empty param.page}">
                    <c:if test="${current == 1}">
                      <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                    </c:if>
                    <c:if test="${current != 1}">
                      <li class="page-item"><a class="page-link" onclick="handlePagination('${current}', 0)">${current}</a></li>
                    </c:if>
                  </c:if>
                  <c:if test="${not empty param.page}">
                    <c:if test="${current == param.page}">
                      <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                    </c:if>
                    <c:if test="${current != param.page}">
                      <li class="page-item"><a class="page-link" onclick="handlePagination('${current}', 0)">${current}</a></li>
                    </c:if>
                  </c:if>
                </c:forEach>
                <li class="page-item"><a class="page-link" onclick="handlePagination('${pageInfo.nextPage}', 0)">
                  <span class="material-symbols-outlined">keyboard_arrow_right</span>
                </a></li>
                <li class="page-item"><a class="page-link" onclick="handlePagination('${pageInfo.maxPage}', 0)">
                  <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                </a></li>
              </ul>
            </nav>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab2" class="tab-content">
    <div>
      <c:choose>
        <c:when test="${empty paidTickets}">
          <div style="text-align: center; margin-top: 100px; margin-bottom: 100px;">
            <p style="font-size: 24px; font-weight: bold;">결제한 이용권이 없습니다.</p>
          </div>
        </c:when>
        <c:otherwise>
          <table id="use" class="table table-striped" style="margin-top: 30px; width:100%; text-align: center">
            <thead>
            <tr>
              <th style="font-weight: bold; font-size: 20px;">이용권명</th>
              <th style="font-weight: bold; font-size: 20px;">이용기간</th>
              <th style="font-weight: bold; font-size: 20px;">남은시간</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="ticket" items="${paidTickets}">
              <tr>
                <td style="padding: 30px; vertical-align: middle;">${ticket.ticket_name}</td>
                <td style="padding:30px;">
                  <c:if test="${not empty ticket.start_date}">
                    <fmt:formatDate value="${ticket.start_date}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/><br>
                    ~<br>
                    <fmt:formatDate value="${ticket.end_date}" pattern="yyyy년 MM월 dd일 HH시 mm분" timeZone="Asia/Seoul"/>
                  </c:if>
                  <c:if test="${empty ticket.start_date}">
                    -
                  </c:if>
                </td>
                <td style="padding:30px; vertical-align: middle;">
                  <c:if test="${ticket.time == 0}">
                    -
                  </c:if>
                  <c:if test="${ticket.time != 0}">
                    ${ticket.time}
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab3" class="tab-content" style="text-align: center;">
    <div style="display: inline-block; text-align: left; margin-top: 30px;">
      <c:choose>
        <c:when test="${empty ownCoupons}">
          <div style="text-align: center; margin-top: 100px; margin-bottom: 100px;">
            <p style="font-size: 24px; font-weight: bold;">보유한 쿠폰이 없습니다.</p>
          </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="ownCoupon" items="${ownCoupons}">
              <div style="border: solid 1px; width: 600px; height: 150px; margin-bottom: 50px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);">
                <h5 style="font-weight: bold; margin: 20px;">${ownCoupon.name}</h5>
                <p style="margin: 20px; color: #545454; font-size: 15px;">${ownCoupon.coupon.discount}% 할인</p>
                <p style="margin: 20px;">
                    <fmt:formatDate value="${ownCoupon.createdate}" pattern="yyyy년 MM월 dd일" timeZone="Asia/Seoul"/>
                      ~
                    <fmt:formatDate value="${ownCoupon.expiredate}" pattern="yyyy년 MM월 dd일" timeZone="Asia/Seoul"/>
                </p>
              </div>
            </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

</section>

<script>
  const tabs = document.querySelectorAll('.tabs li');
  const tabContents = document.querySelectorAll('.tab-content');

  const currentPage = [1, 1, 1];
  const isPaginationActive = [true, false, false];

  let currentTab = parseInt(new URL(window.location.href).hash.replace('#tabIndex=', '')) || 0;

  tabs.forEach((tab, index) => {
    tab.addEventListener('click', () => {
      handleTabClick(index);
    });
  });

  function handleTabClick(tabIndex) {
    tabs.forEach((t) => t.classList.remove('active'));
    tabs[tabIndex].classList.add('active');

    tabContents.forEach((content) => {
      content.style.display = 'none';
    });

    tabContents[tabIndex].style.display = 'block';

    if (currentTab !== tabIndex) {
      isPaginationActive[currentTab] = false;
    }

    if (!isPaginationActive[tabIndex]) {
      isPaginationActive[tabIndex] = true;
      handlePagination(currentPage[tabIndex], tabIndex);
    }

    currentTab = tabIndex;

    window.scrollTo(0, 0);
  }

  function handlePagination(page, tabIndex) {
    const url = '/studycafe/useHistory?page='+page+'#tabIndex='+tabIndex;

    window.location.href = url;
  }

  tabs[currentTab].click();
</script>

<jsp:include page="../common/footer.jsp"/>