<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="../../common/header.jsp"/>

<style>
  /* 이미지 스타일 */
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
  /* 스타일 추가 */
  .event-details {
    border: 2px solid whitesmoke;
    padding: 20px;
    margin-bottom: 20px;
    margin: 40px;
    min-height: 600px;
  }

  .event-details h4 {
    font-size: 30px;
    font-weight: bold;
    color: black;


  }

  .event-details span {
    color: gray;
  }

  .event-content {
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
        <div class="image-text">이벤트</div>
      </div>

      <div class="event-details">
        <c:choose>
          <c:when test="${event.kind == '종료됨'}">
            <h4 style="color: gray;">종료된 이벤트입니다.</h4>
          </c:when>
          <c:otherwise>
            <h4 style="text-align: center">${event.title}</h4>
          </c:otherwise>
        </c:choose>
        <div style="text-align: right;">
        <span style="color: gray; text-align: right;">
        등록일 : <fmt:formatDate value="${event.createDate}" pattern="yyyy.MM.dd" />
      </span>
        </div>
      <hr style="border: 2px solid #8D7B68; margin: 10px 0; margin-top: 20px;">
      <p style="font-size: 18px;"> ${event.content}</p>
    </div>
    </div>
  </div>


    <div class="button-container">
      <a href="${path}/customer/event/list" class="back-button"  >목록으로</a>
      <security:authorize access="hasRole('ROLE_ADMIN')">
        <!-- 관리자로 로그인한 경우에만 아래 버튼들이 표시됩니다. -->
        <a href="${path}/customer/event/edit/${event.no}" class="edit-delete-button">수정</a>
        <a href="${path}/customer/event/delete/${event.no}"
           onclick="return confirm('정말로 삭제하시겠습니까?')" class="edit-delete-button">삭제</a>
      </security:authorize>

    </div>
  </div>
</section>

<jsp:include page="../../common/footer.jsp"/>
