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

  .custom-icon {
    color: #8B4513; /* 원하는 색상으로 변경하세요 */
    font-size: 2em; /* 원하는 크기로 변경하세요 */
  }

  .submit-button {
    background-color: #8D7B68;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 10px 300px;
    font-size:15px;
    display:block; /* 블록 요소로 만들어 줍니다. */
    margin-left:auto; /* 왼쪽 마진을 자동으로 설정하여 오른쪽 정렬 효과를 줍니다. */
    margin-right:auto; /* 오른쪽 마진도 자동으로 설정합니다. */
    margin-bottom :50px ;/* 푸터와의 간격을 조절합니다.*/
  }
  .form-group input[type="text"] {
    height: 30px; /* 높이를 조절할 수 있는 값으로 변경하세요 */
    width: 1050px;
  }
  .ck.ck-editor {
    margin: 0; /* Remove any margin to align it to the left */
    padding: 0; /* Remove any padding if necessary */
    width: 1050px;

  }

  .ck-editor__editable {
    width: 1050px; /* Adjust the width to 100% for better alignment */
    min-height: 600px;
  }
</style>

<section>
  <div>
    <div style="position: relative;">
      <img src="${path}/images/notice2.png.jpg" alt="공지 이미지">
      <div class="image-text">이벤트</div>
      <div style="width: 80%; margin: 0 auto;">
      <div style="display: inline-block; vertical-align: middle; margin: 20px;">
        <span class="material-symbols-outlined custom-icon">shield_person</span>
        <p style="color: #9D6529; font-size: 2.17em; font-weight: bold; margin-left: 10px; display: inline;">관리자 이벤트 글쓰기</p>
      </div>


    <form action="${path}/customer/event/add" method="post">
      <security:csrfInput/>
      <div class="form-group">
        <label for="title" style="font-weight: bold; margin-bottom: 10px">제목</label>
        <input type="text" id="title" name="title" required>
      </div>
      <br>

        <div class="form-group">
          <label for="kind" style="font-weight: bold">글종류:</label>
          <select id="kind" name="kind" required>
            <option value="진행중" ${event.kind == '진행중' ? 'selected' : ''}>진행중</option>
            <option value="종료됨" ${event.kind == '종료됨' ? 'selected' : ''}>종료됨</option>
          </select>
        </div>

      <br>
      <div class="form-group"  >
        <label for="editor" style="margin-bottom: 10px; font-weight: bold">내용 작성</label>
        <textarea name="content" id="editor" class="editor "></textarea>
      </div>
      <br>

      <br>

      <button type="submit" class="submit-button">글쓰기</button>

    </form>
      </div>
    </div>
  </div>
</section>

<link rel="stylesheet" href="${path}/css/ckeditor.css">
<script src="${path}/js/ckeditor.js"></script>
<script src="${path}/js/ckeditor_mybuild.js"></script>

<script>

</script>

<jsp:include page="../../common/footer.jsp"/>
