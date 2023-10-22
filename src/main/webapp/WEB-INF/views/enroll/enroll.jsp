<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="../common/header.jsp"/>


<style>
    .step-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 50px;
        margin-bottom: 30px;
    }

    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 150px;
        height: 120px;
    }

    .step-number {
        width: 60px;
        height: 60px;
        background-color: #ccc;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 30px;
    }

    .step2 {
        background-color: #8D7B68;
        color: white;
    }

    .step-text {
        margin-top: 10px;
        font-weight: bold;
    }

    #enroll_style {
        width: 600px;
        margin-top: 30px;
        justify-content: center;
        justify-items: center;
        margin-left: 300px;
    }

    #enroll{
        width: 100%;
        justify-items: center;
    }

    #enroll_email2, #enroll_phone {
        display: none;
    }

    #enrollPage label {
        margin-bottom: 5px;
        font-weight: bold;
    }

    .input-field {
        width: 100%;
    }

    #enroll_input {
        width: 350px;
    }

    #span {
        color: #757575;
        font-size: 12px;
    }

    .phone_input {
        width: 100px;
    }

    .email_input {
        width: 160px;
    }

    #enroll_naver {
        margin-right: 30px;
    }

    #submit_button {
        background-color: #8D7B68;
        color: white;
        font-size: 18px;
        border-radius: 10px;
        padding: 14px;
        text-align: center;
        margin-top: 20px;
        margin-bottom: 20px;
        width: 360px;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
    }

    #submit_button:hover {
        background-color: #685948;
    }

    .nickname-input {
        width: 350px;
        height: 38px;
    }

    .Check {
        height: 40px;
        margin-left: 10px;
        background-color: #8D7B68;
        border: none;
        color: white;
        border-radius: 10px;
        font-weight: bolder;
    }

    .Check:hover {
        background-color: #685948;
    }

    #enroll_form {
        margin-left: 30px;
    }
</style>



<section id="enrollPage">
    <div class="step-container">
        <div class="step">
            <div class="step-number">01</div>
            <div class="step-text">이용약관동의</div>
        </div>
        <div class="step">
            <div class="step-number step2">02</div>
            <div class="step-text">회원가입</div>
        </div>
        <div class="step">
            <div class="step-number">03</div>
            <div class="step-text">가입완료</div>
        </div>
    </div>
    <div style="border-top: 2px solid #8D7B68; margin-bottom: 50px;"></div>

    <div id="enroll">
        <div id="enroll_style">
            <h4>회원가입</h4>
            <div style="border-top: 2px solid #8D7B68; margin-top: 5px; margin-bottom: 30px;"></div>
            <div>
                <div id="sns">
                    SNS 계정으로 간편 로그인/회원가입
                </div>
                <div>
                    <img src="${ path }/images/Naver.png" id="enroll_naver" style="cursor: pointer" onclick='naverLogin.authorize();'>
                    <img src="${ path }/images/Kakao.png" style="cursor: pointer" onclick='kakaoLogin()'>
                </div>
            </div>

            <div style="border-top: 2px solid #8D7B68; margin-top: 30px; margin-bottom: 20px;"></div>
            <form action="${ path }/enroll" method='post' id="enroll_form">
                <security:csrfInput/>
                <div>
                    <div class="d-inline-block email_input">
                        <label for="enroll_email">이메일</label><br>
                        <input class='emailstyle form-control input-field' type='text' id="enroll_email" name='enroll_email' placeholder="이메일" required>
                    </div>
                    @
                    <div class="d-inline-block email_input">
                        <input class="form-control input-field" type="text" list="enroll_email2" id="selfEmail" name="enroll_email2">
                        <datalist class='emailstyle form-control input-field' id="enroll_email2" name="enroll_email2" required>
                            <option value="naver.com"/>
                            <option value="hanmail.net"/>
                            <option value="gmail.com"/>
                            <option value="nate.com"/>
                            <option value="yahoo.com"/>
                        </datalist>
                    </div>
                    <button type="button" id="emailDuplicateCheck" class="Check">중복 확인</button>
                </div>
                <br>

                <div id="enroll_input" class="d-inline-block">
                    <label for="enroll_password" title="8~16자의 영문자와 숫자 그리고 특수문자를 포함하여 입력해주세요.">비밀번호</label><br>
                    <span id="span">8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.</span><br>
                    <input class="form-control input-field enroll_input" type='password' id="enroll_password" name="enroll_password"
                           pattern="^(?=.*[a-z])(?=.*[A-Z]?)(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,16}$" placeholder="비밀번호" required><br>

                    <label for="confirm_password">비밀번호 확인</label>
                    <input class="form-control input-field enroll_input" type ='password' id="confirm_password" placeholder="비밀번호 확인" name ="confirm_password" required>
                    <span id="passwordMatch" style="color:red;"></span><br>

                    <label for="enroll_name">이름</label>
                    <input class="form-control input-field enroll_input" type="text" id="enroll_name" name="enroll_name" placeholder="이름" required><br>

                </div>
                <div class="input-group" style="width: 350px;">
                    <input class="form-control nickname-input rounded" type="text" placeholder="닉네임" id="enroll_nickname" name="enroll_nickname" required>
                    <div class="input-group-append" style="margin-left: 10px;">
                        <button type="button" class="Check" id="nicknameDuplicateCheck">중복 확인</button>
                    </div>
                </div>

                <br>
                <div class="d-inline-block phone_input">
                    <label for="selfPhone">전화번호</label>
                    <input class="form-control input-field" type="text" list="enroll_phone" id="selfPhone" name="enroll_phone" maxlength="3">
                    <datalist class='emailstyle form-control input-field' id="enroll_phone" name="enroll_phone" maxlength="3" required>
                        <option value="010" selected/>
                        <option value="011"/>
                        <option value="016"/>
                        <option value="017"/>
                        <option value="018"/>
                        <option value="019"/>
                    </datalist>
                </div>
                -
                <div class="d-inline-block phone_input">
                    <input class="form-control input-field phone" type="text" id="enroll_phone2" name="enroll_phone2" maxlength="4" required>
                </div>
                -
                <div class="d-inline-block phone_input">
                    <input class="form-control input-field phone" type="text" id="enroll_phone3" name="enroll_phone3" maxlength="4" required>
                </div>
                <br>
                <div style="margin-left: -30px; border-top: 2px solid #8D7B68; margin-top: 30px; margin-bottom: 30px;"></div>
                <div>
                    <button type='submit' id="submit_button">회원가입</button>
                </div>
            </form>
        </div>
    </div>
</section>


<script>
    $(document).ready(function() {
        $('#confirm_password').on('keyup', function() {
            var password = $('#enroll_password').val();
            var confirmPassword = $(this).val();
            var matchMessage = $('#passwordMatch');

            if (password === confirmPassword) {
                matchMessage.text('일치');
                matchMessage.css('color', 'green');
            } else {
                matchMessage.text('불일치');
                matchMessage.css('color', 'red');
            }
        });
    });

    $(document).ready(function() {
        $('#emailDuplicateCheck').on('click', function() {
            var email1 = $('#enroll_email').val();
            var email2 = $('#selfEmail').val();

            if (email1 === '' || email2 === '') {
                alert('이메일을 입력해주세요.');
                return;
            }

            var email = email1 + "@" + email2;

            $.ajax({
                type: 'POST',
                url: '${path}/checkEmailDuplicate',
                contentType: 'application/json',
                data: JSON.stringify({ email: email }),
                success: function(data) {
                    if (data.isDuplicate) {
                        alert('이미 사용 중인 이메일입니다.');
                    } else {
                        alert('사용 가능한 이메일입니다.');
                    }
                },
                error: function() {
                    alert('이메일 중복 확인 중 오류가 발생했습니다.');
                }
            });
        });

        $('#nicknameDuplicateCheck').on('click', function() {
            var nickname = $('#enroll_nickname').val();

            if (nickname === '') {
                alert('닉네임을 입력해주세요.');
                return;
            }

            $.ajax({
                type: 'POST',
                url: '${path}/checkNicknameDuplicate',
                contentType: 'application/json',
                data: JSON.stringify({ nickname: nickname }),
                success: function(data) {
                    if (data.isDuplicate) {
                        alert('이미 사용 중인 닉네임입니다.');
                    } else {
                        alert('사용 가능한 닉네임입니다.');
                    }
                },
                error: function() {
                    alert('닉네임 중복 확인 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>
<jsp:include page="../common/footer.jsp"/>
