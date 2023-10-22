<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="../common/header.jsp"/>
<style>

    .field {
        margin-bottom: 10px;
        text-align: center;
        width: 80%;
        margin-left: auto;
        margin-right: auto;
    }

    .field label {
        display: block;
        font-size: 14px;
        color:#555;
        margin-bottom :10px;
        font-weight: bold;
        text-align: left;
        margin-top: 20px;
    }

    .field input[type=text],
    .field input[type=tel]{
        width :100%;
        padding :10px;
        border-radius :5px;
        border :1px solid #ddd;
    }

    .email-container {
        display:flex; /* Flexbox 사용 */
        align-items: stretch; /* 모든 자식 요소들의 세로 크기를 부모와 같게 만듭니다 */
    }

    .email-container input,
    .email-container select {
        flex-grow:1; /* 필요한 경우 너비 조정 */
        flex-basis:0; /* 기본 크기 설정 */
    }

    .button-container {
        text-align: center;
        margin-top: 50px;
    }

    /* 버튼 배경색 및 글자색 변경 */
    .button-container input[type="submit"],
    .home-button {
        display: inline-block;
        padding: 10px 145px;
        font-size: 15px;
        background-color: #8D7B68;
        color: white;
        border-radius: 5px;
        border: none; /* 테두리 제거 */
        margin-bottom: 20px;
    }

    #button:disabled {
        background-color: #ccc;
        color: #666;
        cursor: not-allowed;
    }


    #Atsign {
        margin-top: 8px;
        color: #a9a9a9;
    }

    #askSection #form {
        width: 100%;
        max-width: 550px;
        border: solid 4px #8D7B68;
        border-radius: 15px;
        background-color: white;
    }

    #askSection {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin-top: 30px;
        margin-bottom: 30px;
    }

    #askSection #message {
        height: 200px;
    }
</style>


<section id="askSection" style="">

    <form id="form">
        <div class="field">
            <div style="display: flex; align-items: center; justify-content: center; margin-bottom: -15px;">
                <span class="material-symbols-outlined" style="font-size: 50px; margin-bottom: 20px; color: #8D7B68; margin-top: 15px;" >live_help</span>
                <span style="color: #8D7B68; font-size: 30px; margin-left: 10px; font-weight: bold;">이메일 문의하기</span>
            </div>
            <br>
            <label for="name">이름(name)</label>
            <input type="text" name="name" id="name" class="form-control input-field">
        </div>

        <div class="field">
            <label for="phone">연락처(phone)</label>
            <input
                    type="tel"
                    name="phone"
                    id="phone"
                    class="form-control input-field"
                    placeholder="예)010-1234-5678"
                    pattern="010-[0-9]{4}-[0-9]{4}"
                    required
                    oninput="formatPhoneNumber(this)"
            >
        </div>
        <div class="field">
            <label for="email_id">이메일(email)</label>
            <div class="email-container">
                <input type="text" id="email_id" class="form-control input-field" value="" title="이메일" placeholder="이메일" maxlength="36"/>
                <input type="hidden" name="email" id="hidden_email"/>
                &nbsp;<span id="Atsign">@</span>&nbsp;
                <select class="select form-control input-field" title="이메일 도메인 주소 선택" onchange="setEmailDomain(this.value);">
                    <option value="">-선택-</option>
                    <option value="naver.com">naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="nate.com">nate.com</option>
                    <option value="yahoo.com">yahoo.com</option>
                </select>
                <input type="hidden" name="email_domain" id="email_domain">
            </div>
        </div>


        <div class="field">
            <label for="message" >문의내용(message)</label>
            <input type="text" name="message" id="message" class="form-control input-field">
        </div>

        <div class="button-container">
            <input type="submit" id="button" value="문의하기">
        </div>
    </form>
</section>


<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>

<script type="text/javascript">
    emailjs.init('mIPf9-Txj-B317v30')

    // isClicked 변수 정의 및 초기화
    let isClicked = false;

    const btn = document.getElementById('button');

    document.getElementById('form').addEventListener('submit', function(event) {
        event.preventDefault();

        // 클릭된 경우 버튼 비활성화
        if (!isClicked) {
            isClicked = true;
            const btn = document.getElementById('button');
            btn.value = '잠시만 기다려주세요..';
            btn.disabled = true;
        }


        const serviceID = 'default_service';
        const templateID = 'template_rq0nxlr';

        var email_rule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        var email_id = $("#email_id").val();
        var email_domain = $("#email_domain").val();
        var mail = email_id;

        if (!email_id) {
            alert("이메일을 입력해주세요");
            $("#email_id").focus();
            return false;
        }


        emailjs.sendForm(serviceID, templateID, this)
            .then(() => {
                btn.value = '문의완료';
                alert('문의하기 완료되었습니다!');
            }, (err) => {
                btn.value = 'Send Email';
                alert(JSON.stringify(err));
            });
    });

    function setEmailDomain(domain) {
        $("#email_domain").val(domain);
        updateEmail(); // 이메일 주소 업데이트
        // 이메일 선택란을 숨김
    }


    // 이메일 주소 업데이트 함수

    function updateEmail() {
        const email_id = $("#email_id").val().replace(/\s+/g, '');
        const email_domain = $("#email_domain").val();
        if (email_id && email_domain) { // 둘 다 값이 있는 경우에만 이메일 주소를 업데이트합니다.
            const email = email_id + "@" + email_domain;
            $("#hidden_email").val(email);
        }
    }

    function formatPhoneNumber(input) {
        let phoneNum = input.value.replace(/[^0-9]/g, '');

        if (phoneNum.length >= 4 && phoneNum.length <= 7) {
            phoneNum = phoneNum.replace(/(\d{3})(\d{1,4})/, '$1-$2');
        } else if (phoneNum.length >= 8) {
            phoneNum = phoneNum.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
        }

        input.value = phoneNum;
    }
</script>
<jsp:include page="../common/footer.jsp"/>



