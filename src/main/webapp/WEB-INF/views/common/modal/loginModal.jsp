<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<style>
    #kakao {
        width: 65px;
        height: 65px;
        margin-right: 80px;
        cursor: pointer;
    }

    #naver {
        width: 65px;
        height: 65px;
        cursor: pointer;
    }

    #btn {
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

    #snsImages {
        display: flex;
        justify-content: center;
        margin-bottom: 45px;
    }

    .modal-dialog {
        width: 80%;
        max-height: 90vh;
    }

    .modal-content .form-control {
        padding: 10px;
        font-size: 14px;
        margin-top: 15px;
        margin-bottom: 15px;
        width: 80%;
        justify-content: center;
    }

    .modal-content {
        padding: 20px;
        border-color: #8D7B68;
        border-width: 4px;
    }

    #sns {
        text-align: center;
        color: #757575;
        font-size: 12px;
        margin-bottom: 15px;
    }

    .login_input {
        width: 300px;
        margin-left: auto;
        margin-right: auto;
        display: block;
    }

    .btn-link {
        color: inherit;
        text-decoration: none;
    }

    .btn-link:hover, .btn-link:focus, .btn-link:active {
        color: inherit;
        text-decoration: none;
    }

    #findenroll {
        text-align: center;
    }

    #btn:hover {
        background-color: #685948;
    }

    #remember-me {
        margin-left: 50px;
    }

    .remember-me-checkbox {
        transform: scale(1.5);
        margin-right: 5px;
        cursor: pointer;
    }

    input[type="checkbox"]:checked {
        accent-color: #8D7B68;
    }

    .remember-me-text {
        font-size: 13px;
        color: #555;
        cursor: pointer;
    }
</style>
<section>

    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="LoginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <form action="${ path }/login" method="POST">
                    <security:csrfInput/>
                    <div style="margin-bottom: -10px;">
                        <label for="email" class="form-label"></label>
                        <input type="email" class="form-control mb-1.5 login_input" id="email" name="email" placeholder="이메일" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label"></label>
                        <input type="password" class="form-control mb-3 input-field login_input" id="password" name="password" placeholder="비밀번호" required>
                    </div>

                    <label for="remember-me">
                        <input type="checkbox" id="remember-me" name="remember-me" class="remember-me-checkbox">
                        <span class="remember-me-text">로그인 상태 유지</span>
                    </label>

                    <input id="btn" type=submit value=로그인>

                    <div id="findenroll">
                        <button type="button" class="btn btn-link" onclick="location.href='${ path }/userSearch'">아이디/비밀번호 찾기</button>
                        <button type="button" class="btn btn-link" id="signUp" onclick="location.href='${ path }/agree'">회원가입</button>
                    </div>
                </form>

                <div id="sns">
                    SNS 계정으로 간편 로그인/회원가입
                </div>
                <div id="snsImages">
                    <img id="kakao" src='https://cdn.icon-icons.com/icons2/2429/PNG/512/kakaotalk_logo_icon_147272.png' onclick='kakaoLogin()'/>
                    <img id="naver" src='https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbU1uVm%2FbtqGsLHK8Ha%2Fndkom6FPH3Ld5BXtGd7pt0%2Fimg.png' onclick='naverLogin.authorize();'/>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.4.0/kakao.min.js" integrity="sha384-mXVrIX2T/Kszp6Z0aEWaA8Nm7J6/ZeWXbL8UpGRjKwWe56Srd/iyNmWMBhcItAjH" crossorigin="anonymous"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script>
    window.Kakao.init('b553f7702f0bf39560df0db627b483ef');

    const kakaoLogin = () => {
        Kakao.Auth.authorize({
            redirectUri: 'http://ec2-13-236-136-119.ap-southeast-2.compute.amazonaws.com:8080/studycafe/kakaoLogin',
            state: 'userme',
        })
    }

    let naverLogin = new naver.LoginWithNaverId(
        {
            clientId: "ZYWm89BXkPPOMY9OsjWn",
            callbackUrl: "http://ec2-13-236-136-119.ap-southeast-2.compute.amazonaws.com:8080/studycafe/naverLogin",
            isPopup: false,
        }
    );

    naverLogin.init();

</script>
