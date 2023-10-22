<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>
        #userSearch {
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #fff;
            height: 66.75vh;
            min-height: 750px;
        }

        #userSearch .container {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #userSearch .form-group {
            margin-bottom: 30px;
            display: inline-block;
            margin-right: 20px;
        }

        #userSearch .form-check-label {
            margin-top: 3px;
        }

        #userSearch label {
            font-weight: bold;
        }

        #userSearch .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        #userSearch .btn-primary {
            background-color: #8D7B68;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }

        #userSearch .btn-primary:hover {
            background-color: #685948;
        }

        #userSearch .form-check-label {
            margin-left: 10px;
        }

        #userSearch .form-check-input[type="checkbox"] {
            margin-right: 5px;
        }

        #userSearch #findEmailbtn {
            margin-bottom: 30px;
        }

        #userSearch #resultContainer {
            font-size: 18px;
            font-weight: bold;
        }

        #userSearch .form-check-input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-right: 5px;
            border: 1px solid #5E4D3E;
            border-radius: 5px;
            cursor: pointer;
        }

        #userSearch .form-check-input[type="checkbox"]:checked {
            background-color: #5E4D3E;
        }

        #userSearch .form-check-label {
            font-weight: normal;
        }

        #userSearch #findEmailForm, #forgotPasswordForm, #emailStep, #verificationStep {
            margin-left: 30px;
        }

        #userSearch #numberBtn, #verifyBtn, #resetPasswordBtn {
            margin-top: 30px;

        }

        #userSearch #passwordlabel {
            margin-top: 10px;
        }
</style>

<jsp:include page="../common/header.jsp"/>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<section id="userSearch">
    <div class="container">
        <h2 class="text-center" style="margin-top: 20px; margin-bottom: 30px;">아이디/비밀번호 찾기</h2>
        <div class="form-group checkbox" style="margin-left: 35px;">
            <input class="form-check-input" type="checkbox" id="findIdCheckbox" value="findId">
            <label class="form-check-label" for="findIdCheckbox">아이디 찾기</label>
        </div>

        <div class="form-group checkbox">
            <input class="form-check-input" type="checkbox" id="forgotPasswordCheckbox" value="forgotPassword">
            <label class="form-check-label" for="forgotPasswordCheckbox">비밀번호 찾기</label>
        </div>

        <form id="findEmailForm" action="${ path }/findEmail" method="POST" style="display: none;">
            <security:csrfInput/>
            <div class="form-group">
                <label for="search_name">이름</label>
                <input type="text" class="form-control input-field" id="search_name" name="name" required>
                <br>
                <label for="search_phone">전화번호</label>
                <input type="text" class="form-control input-field" id="search_phone" name="phone" required>
            </div>
            <button type="submit" class="btn btn-primary" id="findEmailbtn">아이디 찾기</button>
            <div id="resultContainer" style="display: none;">
                <c:choose>
                    <c:when test="${not empty emailResponse.email}">
                        <p class="findEmailP">찾은 이메일: ${emailResponse.email}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="findEmailP">${emailResponse.message}</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
        <div id="findPasswordbox" style="display: none;">
                <div class="form-group" id="emailStep">
                    <label for="search_email">이메일</label>
                    <input type="email" class="form-control input-field" id="search_email" name="search_email" required>
                    <button type="button" class="btn btn-primary" id="numberBtn" onclick="sendEmail()">인증번호 받기</button>
                </div>

                <div class="form-group" id="verificationStep" style="display: none;">
                    <label for="verificationCode">인증번호</label>
                    <input type="text" class="form-control input-field" id="verificationCode" name="verificationCode" required>
                    <button type="button" class="btn btn-primary" id="verifyBtn" onclick="verifyCode()">확인</button>
                </div>

            <form id="forgotPasswordForm" action="${ path }/resetPassword" method="POST">
                <security:csrfInput/>
                <div class="form-group" id="resetPasswordStep" style="display: none;">
                    <input type="hidden" name="passwordStep_email" id="passwordStep_email" value="">
                    <label for="newPassword">새 비밀번호</label>
                    <input type="password" class="form-control input-field" id="newPassword" name="newPassword" pattern="^(?=.*[a-z])(?=.*[A-Z]?)(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,16}$"
                           required>
                    <label for="confirmNewPassword" id="passwordlabel">새 비밀번호 확인</label>
                    <input type="password" class="form-control input-field" id="confirmNewPassword" oninput="checkPassword()"  name="confirmNewPassword" required>
                    <span id="passwordMatch" style="color:red; margin-bottom: 20px;"></span><br>
                    <button type="submit" class="btn btn-primary" id="resetPasswordBtn">재설정</button>
                </div>
            </form>
        </div>
    </div>

</section>


<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
<script>
    const findIdCheckbox = document.getElementById("findIdCheckbox");
    const forgotPasswordCheckbox = document.getElementById("forgotPasswordCheckbox");
    const findForm = document.getElementById("findEmailForm");
    const forgotPasswordForm = document.getElementById("findPasswordbox");

    $('#search_phone').on('input', function () {
        formatPhoneNumber(this);
    });

    findIdCheckbox.addEventListener("click", function () {
        if (findIdCheckbox.checked) {
            findForm.style.display = "block";
            forgotPasswordForm.style.display = "none";
            forgotPasswordCheckbox.checked = false;
        } else {
            findForm.style.display = "none";
        }
    });

    forgotPasswordCheckbox.addEventListener("click", function () {
        if (forgotPasswordCheckbox.checked) {
            forgotPasswordForm.style.display = "block";
            findForm.style.display = "none";
            findIdCheckbox.checked = false;
        } else {
            forgotPasswordForm.style.display = "none";
        }
    });

    $('#findEmailForm').submit(function (e) {
        e.preventDefault();

        var name = $('#search_name').val();
        var phone = $('#search_phone').val();

        $.ajax({
            type: 'POST',
            url: '/studycafe/findEmail',
            data: {
                name: name,
                phone: phone
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (data) {
                if (data.email) {
                    $('#resultContainer').html("찾은 이메일: " + data.email);
                } else {
                    $('#resultContainer').html("일치하는 이메일을 찾을 수 없습니다.");
                }
                $('#resultContainer').show();

            },
            error: function () {
                console.error('오류 발생');
                $('#resultContainer').html("일치하는 이메일을 찾을 수 없습니다.");
                $('#resultContainer').show();
            }
        });
    });

    function formatPhoneNumber(input) {
        let phoneNum = input.value.replace(/[^0-9]/g, '');

        if (phoneNum.length >= 4 && phoneNum.length <= 7) {
            phoneNum = phoneNum.replace(/(\d{3})(\d{1,4})/, '$1-$2');
        } else if (phoneNum.length >= 8) {
            phoneNum = phoneNum.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
        }

        input.value = phoneNum;
    }

    function checkPassword() {
        var password = document.getElementById("newPassword").value;
        var confirmPassword = document.getElementById("confirmNewPassword").value;
        var matchMessage = document.getElementById("passwordMatch");

        if (password === confirmPassword) {
            matchMessage.textContent = "일치";
            matchMessage.style.color = "green";
        } else {
            matchMessage.textContent = "불일치";
            matchMessage.style.color = "red";
        }
    }

    document.getElementById("resetPasswordBtn").addEventListener("click", function(e) {
        e.preventDefault();

        document.getElementById("forgotPasswordForm").submit();
    });

    emailjs.init('7KAljoGeu0Sm_M-yA');

    let verificationCode = null;

    function generateRandomCode() {
        verificationCode = Math.floor(1000 + Math.random() * 9000);

        return verificationCode;
    }

    function sendEmail() {
        const userEmail = document.getElementById("search_email").value;

        document.getElementById("passwordStep_email").value = userEmail;

        console.log(passwordStep_email);
        $.ajax({
            type: 'GET',
            url: '/studycafe/checkEmail',
            data: {
                email: userEmail
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (data) {
                if (data.message === "이메일이 존재합니다.") {
                    emailjs.send('service_e1nagfc', 'template_xrx9f1f', {
                        to_email: userEmail,
                        verification_code: generateRandomCode()
                    }).then(function(response) {
                        console.log('이메일 전송 성공:', response);
                        alert('인증 코드를 이메일로 전송했습니다.');

                        document.getElementById("emailStep").style.display = "none";
                        document.getElementById("verificationStep").style.display = "block";
                    }, function(error) {
                        console.error('이메일 전송 실패:', error);
                        alert('이메일 전송 중 오류가 발생했습니다.');
                    });
                } else {
                    alert('일치하는 이메일을 찾을 수 없습니다. 다시 입력해주세요.');
                }
            },
            error: function () {
                console.error('오류 발생');
                alert('일치하는 이메일을 찾을 수 없습니다. 다시 입력해주세요.');
            }
        });
    }

    function verifyCode() {
        const enteredCode = document.getElementById("verificationCode").value;

        if (enteredCode === verificationCode.toString()) {
            alert('인증 성공!');

            document.getElementById("verificationStep").style.display = "none";
            document.getElementById("resetPasswordStep").style.display = "block";
        } else {
            alert('인증 코드가 일치하지 않습니다.');
        }
    }
</script>

<jsp:include page="../common/footer.jsp"/>
