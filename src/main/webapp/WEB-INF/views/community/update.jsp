<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
  input {
    border-style: none;
    border-bottom: 1px solid gainsboro;
    width: 850px;
    height: 40px;
    font-size: larger;
  }
  select {
    height: 30px;
    border-radius: 5px;
    margin-bottom: 5px;
  }

  #btn-insert, #btn-cancel {
    color: white;
    background-color: #8D7B68;
    border-style: none;
    border-radius: 5px;
    width: 100px;
    height: 30px;
  }

  .ck.ck-editor {
    margin: 0 auto;
  }

  .ck-editor__editable {
    height: 500px;
  }

</style>

<jsp:include page="../common/header.jsp"/>


<section style="margin: 50px 150px;">
  <security:authorize access="isAuthenticated()">
    <div style="border-bottom: 1px solid;">
      <h3 style="color: #8D7B68; font-size: 1.17em; font-weight: bold;">커뮤니티 글쓰기</h3>
    </div>

    <div style="display: flex; justify-content: center; align-items: center; min-width: 800px; max-width: 1280px;">
      <form action="${ path }/community/update" method="POST">
        <input type="hidden" name="no" value="${ community.no }">
        <security:csrfInput/>

        <a href="javascript:history.back(-1)" style="color: black; text-decoration: none;">
          <i class="bi bi-chevron-compact-left"></i>
          <p style="display: inline-block; vertical-align: middle; margin-top: 5px;">돌아가기</p>
        </a>

        <div>
          <select name="kind" id="sorted-by" style="margin-bottom: 5px;">
            <option value="">게시판을 선택해주세요.</option>
            <option value="자유게시판" ${community.kind == '자유게시판' ? 'selected' : ''}>자유게시판</option>
            <option value="스터디모집" ${community.kind == '스터디모집' ? 'selected' : ''}>스터디모집</option>
            <option value="공부법공유" ${community.kind == '공부법공유' ? 'selected' : ''}>공부법공유</option>
            <option value="합격후기" ${community.kind == '합격후기' ? 'selected' : ''}>합격후기</option>
          </select>

          <div style="width: 850px">
            <input type="text" name="title" id="title" value="${ community.title }">
            <br>
            <textarea name="content" id="editor" class="editor">${ community.content }</textarea>
          </div>

          <div style="display: flex; flex-direction: column; align-items: center; margin-top: 20px;">
            <div style="display: flex; justify-content: space-around;">
              <button type="reset" id="btn-cancel" onclick="location.replace('${ path }/community/detail?no=${ community.no }')">취소</button>
              <button type="submit" id="btn-insert" style="margin-left: 10px;">수정</button>
            </div>
          </div>

        </div>
      </form>
    </div>
  </security:authorize>

  <security:authorize access="isAnonymous()">
    <p>로그인 후에 글을 작성할 수 있습니다.</p>
    <a href="${path}/login">로그인 페이지로 이동</a>
  </security:authorize>

</section>

<link rel="stylesheet" href="${path}/css/ckeditor.css">
<script src="${path}/js/ckeditor.js"></script>
<script src="${path}/js/ckeditor_mybuild.js"></script>

<script>

</script>


<jsp:include page="../common/footer.jsp"/>