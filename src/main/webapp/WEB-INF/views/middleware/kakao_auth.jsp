<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kakao Login</title>

    <script src="${ path }/js/jquery-3.7.0.js"></script>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.4.0/kakao.min.js" integrity="sha384-mXVrIX2T/Kszp6Z0aEWaA8Nm7J6/ZeWXbL8UpGRjKwWe56Srd/iyNmWMBhcItAjH" crossorigin="anonymous"></script>

</head>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<body>

    <form method="post" action="${path}/login" id="login_form" style="display: none">
        <security:csrfInput/>
        <input type="email" id="email" name="email">
        <input type="password" id="password" name="password">
    </form>

<script>
    window.Kakao.init('b553f7702f0bf39560df0db627b483ef');

    function getParameterByName(name) {
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(window.location.href);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    window.onload = () => {
        let header = $('meta[name="_csrf_header"]').attr('content');
        let token = $('meta[name="_csrf"]').attr('content');

        console.log(header, token)

        $.ajax({
            type: "POST",
            url: "https://kauth.kakao.com/oauth/token",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            data: {
                "grant_type": "authorization_code",
                "client_id": '9f70b50c5675182dd2979ee77f24d9cd',
                "redirect_uri": 'http://ec2-13-236-136-119.ap-southeast-2.compute.amazonaws.com:8080/studycafe/kakaoLogin',
                "code": getParameterByName('code')
            },
            success: function (data) {
                // console.log("액세스 토큰:", data.access_token);
                Kakao.Auth.setAccessToken(data.access_token);

                Kakao.API.request({
                    url: '/v2/user/me',
                })
                .then(function(response) {
                    console.log(response)
                    $.ajax({
                        type: "POST",
                        url: "/studycafe/kakaoLogin",
                        data:  JSON.stringify({
                            id: response.id,
                            nickname: response.properties.nickname,
                            image: response.properties.thumbnail_image,
                        }),
                        contentType: 'application/json;charset=UTF-8',
                        beforeSend: (xhr) => {
                            xhr.setRequestHeader(header, token);
                        },
                        success: function (data) {
                            console.log(data.resultCode)
                            $('#email').val('KAKAO_' + response.id);
                            $('#password').val(response.id);
                            $('#login_form').submit();
                        },
                        error: function (error) {
                            console.error("오류3:", error);
                        }
                    });
                })
                .catch(function(error) {
                    console.log("오류2:", error);
                });
            },
            error: function (error) {
                console.error("오류1:", error);
            }
        });
    }


    <%--location.replace("${ pageContext.request.contextPath }${ location }");--%>
</script>
</body>
</html>


