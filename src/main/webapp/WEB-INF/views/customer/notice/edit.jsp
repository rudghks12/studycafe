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
    .edit-button {
        background-color: #8D7B68;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 5px 20px;
        font-size: 18px;
        cursor: pointer;
        text-decoration: none;
    }

    /* 이전으로 버튼 스타일 */
    .back-button {
        background-color: #8D7B68;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 18px;
        cursor: pointer;
        text-decoration: none;
    }

    .back-button:hover, .edit-button:hover {
        background-color: #685948; /* 마우스 호버 시 배경색 변경 */
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

<section style="margin: 0 auto; max-width: 1280px; width: 100%; padding: 0 20px;">
    <div>
        <div style="position: relative;">
            <img src="${path}/images/notice2.png.jpg" alt="공지 이미지">
            <div class="image-text">공지사항</div>
            <div style="width: 80%; margin: 0 auto;">
            <div style="display: inline-block; vertical-align: middle; margin: 20px;">
                <span class="material-symbols-outlined custom-icon">shield_person</span>
                <p style="color: #9D6529; font-size: 2.17em; font-weight: bold;  margin-left: 10px; display: inline;">공지사항 수정</p>
            </div>

        <form action="${path}/customer/notice/edit/${notice.no}" method="post"> <!-- 수정 컨트롤러의 URL로 변경 -->
            <security:csrfInput/>
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" value="${notice.title}" required>
            </div>
            <br>

            <div class="form-group">
                <label for="kind">글종류:</label>
                <select id="kind" name="kind" required>
                    <option value="교육콘텐츠" ${notice.kind == '교육콘텐츠' ? 'selected' : ''}>교육콘텐츠</option>
                    <option value="필독공지" ${notice.kind == '필독공지' ? 'selected' : ''}>필독공지</option>
                    <option value="기타사항" ${notice.kind == '기타사항' ? 'selected' : ''}>기타사항</option>
                </select>
            </div>
            <br>
            <div class="form-group">
                <label for="editor">내용:</label>
                <textarea name="content" class="editor" id="editor" style="height: 800px; ">${notice.content}</textarea>
            </div>
            <br>
            <div class="form-group">
                <button type="submit" onclick="return confirm('정말로 수정하시겠습니까?')" class="edit-button">수정하기</button>
                <a href="${path}/customer/notice/detail/${notice.no}" class="back-button">이전으로</a>
            </div>
            <input type="hidden" name="no" value="${notice.no}">
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
