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

    #btn-insert {
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

    .table td {
        color: red;
    }

</style>

<jsp:include page="../common/header.jsp"/>

<section style="margin: 10px 150px 50px 150px;">
    <security:authorize access="isAuthenticated()">
        <div style="border-bottom: 1px solid;">
            <h3 style="color: #8D7B68; font-size: 24px;; font-weight: bold;">커뮤니티 글쓰기</h3>
        </div>

        <div style="display: flex; justify-content: center; align-items: center; min-width: 800px; max-width: 1280px;">
            <form action="${ path }/community/write" method="POST" >
                <security:csrfInput/>

                <a href="javascript:history.back(-1)" style="color: black; text-decoration: none;">
                    <i class="bi bi-chevron-compact-left"></i>
                    <p style="display: inline-block; vertical-align: middle; margin-top: 5px;">돌아가기</p>
                </a>

                <div>
                    <select name="kind" id="sorted-by" style="margin-bottom: 5px;" required>
                        <option value="">게시판을 선택해주세요.</option>
                        <option value="자유게시판">자유게시판</option>
                        <option value="스터디모집">스터디모집</option>
                        <option value="공부법공유">공부법공유</option>
                        <option value="합격후기">합격후기</option>
                    </select>

                    <div style="width: 850px">
                        <input type="text" name="title" id="title" placeholder="제목을 입력하세요." required>
                        <br>
                        <textarea name="content" id="content" class="editor"></textarea>
                    </div>

                    <div style="display: flex; flex-direction: column; align-items: center; margin-top: 20px;">
                        <button type="submit" id="btn-insert">등록</button>
                    </div>

                </div>
            </form>
        </div>
    </security:authorize>

    <security:authorize access="isAnonymous()">

        <a href="javascript:history.back(-1)" style="color: black; text-decoration: none;">
            <i class="bi bi-chevron-compact-left"></i>
            <p style="display: inline-block; vertical-align: middle; margin-top: 5px;">돌아가기</p>
        </a>

        <div style="text-align: center; min-height: 550px;">
            <p>로그인 후에 글을 작성할 수 있습니다.</p>
            <a class="login" >로그인 페이지로 이동</a>
        </div>
    </security:authorize>

</section>

<jsp:include page="../common/footer.jsp"/>

<link rel="stylesheet" href="${path}/css/ckeditor.css">
<script src="${path}/js/ckeditor.js"></script>
<script src="${path}/js/ckeditor_mybuild.js"></script>

<script>
    $(document).ready(function() {
        $(".login").click(function() {
            $("#loginModal").modal("show");
        });
    });

    // 게시판 선택요소
    var selectElement = document.getElementById('sorted-by');

    // 선택이 변경될 때 실행되는 함수
    selectElement.addEventListener('change', function() {
        // 선택된 값 가져오기
        var selectedValue = selectElement.value;

        // 만약 "게시판을 선택해주세요."가 선택된 경우 필수 속성 제거
        if (selectedValue === '') {
            selectElement.removeAttribute('required');
        } else {
            selectElement.setAttribute('required', true);
        }
    });

</script>


