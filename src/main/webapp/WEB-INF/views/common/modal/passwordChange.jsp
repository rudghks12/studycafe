<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<html>
<head>
    <title>비밀번호 변경</title>
</head>
<script src="${ path }/js/jquery-3.7.0.js"></script>
<script src="https://use.fontawesome.com/releases/v6.4.2/js/all.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<style>
    .modal-header p {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .modal-header .material-symbols-outlined {
        margin-right: 5px;
        text-align: center;
        font-size: 24px;
    }

    .modal-footer {
        display: flex;
        justify-content: center;
    }

    .modal-title {
        font-size: 24px;
        text-align: center;
        flex-grow: 1;
        font-weight: bold;
    }

    .modal_button:hover {
        background-color: #654C3E;
        color: white;
    }

    .modal_button {
        background-color: #8D7B68;
        color: white;
        font-size: 16px;
        border-radius: 5px;
        border: none;
        padding: 8px 16px;
        cursor: pointer;
    }
</style>
<section>
    <security:authentication property="principal" var="authority"/>
    <div class="modal fade" id="passwordChange" tabindex="-1" role="dialog" aria-labelledby="passwordChangeLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="modal-title">
                        <span class="material-symbols-outlined">lock</span>비밀번호 변경
                    </p>
                </div>
                <div class="modal-body">
                    <form id="passwordChangeForm" action="${ path }/passwordChange" method="POST">
                        <security:csrfInput/>
                        <div class="form-group">
                            <label for="currentPassword">현재 비밀번호</label>
                            <input type="password" class="form-control input-field" id="currentPassword" name="currentPassword" required>
                        </div>
                        <div class="form-group">
                            <label for="newPassword">새 비밀번호</label>
                            <input type="password" class="form-control input-field" pattern="^(?=.*[a-z])(?=.*[A-Z]?)(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,16}$"
                                   id="newPassword" name="newPassword" oninput="checkPassword()" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">비밀번호 확인</label>
                            <input type="password" class="form-control input-field" id="confirmPassword" oninput="checkPassword()" name="confirmPassword" required>
                            <span id="passwordMatch" style="color:red;"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="modal_button" id="cancelButton" data-dismiss="modal">취소</button>
                            <button type="submit"  class="modal_button" id="submitPasswordChange">변경</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    function checkPassword() {
        var password = document.getElementById("newPassword").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var matchMessage = document.getElementById("passwordMatch");

        if (password === confirmPassword) {
            matchMessage.textContent = "일치";
            matchMessage.style.color = "green";
        } else {
            matchMessage.textContent = "불일치";
            matchMessage.style.color = "red";
        }
    }

    function closeModal() {
        $('#passwordChange').modal('hide');
    }

    document.getElementById('cancelButton').addEventListener('click', closeModal); function closeModal() {
        $('#passwordChange').modal('hide');
    }

    document.getElementById('cancelButton').addEventListener('click', closeModal);
</script>
</html>
