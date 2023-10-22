<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<html>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
    <title>Naver Login</title>
    <script src="${ path }/js/jquery-3.7.0.js"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
</head>
<body>
    <form method="post" action="${path}/login" id="login_form" style="display: none">
        <security:csrfInput/>
        <input type="email" id="email" name="email">
        <input type="password" id="password" name="password">
    </form>


<script type="text/javascript">
    var naverLogin = new naver.LoginWithNaverId(
        {
            clientId: "ZYWm89BXkPPOMY9OsjWn",
            callbackUrl: "http://ec2-13-236-136-119.ap-southeast-2.compute.amazonaws.com:8080/studycafe/naverLogin",
            isPopup: false,
        }
    );
    naverLogin.init();

    window.addEventListener('load', function () {
        naverLogin.getLoginStatus(function (status) {
            let header = $('meta[name="_csrf_header"]').attr('content');
            let token = $('meta[name="_csrf"]').attr('content');

            if (status) {
                console.log(naverLogin.user);
                let id = naverLogin.user.getId();
                let name = naverLogin.user.getName();
                let nickname = naverLogin.user.getNickName();
                let image = naverLogin.user.getProfileImage();
                let phone = naverLogin.user.getMobile();

                console.log(id);
                console.log(name);
                console.log(nickname);
                console.log(image);
                console.log(phone);

                $.ajax({
                    type: "POST",
                    url: "/studycafe/naverLogin",
                    data: JSON.stringify({
                        id: id,
                        name: name,
                        nickname: nickname,
                        phone: phone,
                        image: image
                    }),
                    contentType: 'application/json;charset=UTF-8',
                    beforeSend: (xhr) => {
                        xhr.setRequestHeader(header, token);
                    },
                    success: function(data) {
                        $('#email').val('NAVER_' + id);
                        $('#password').val(id);
                        $('#login_form').submit();
                    },
                    error: function(result) {
                        console.log(result)
                    }
                })

            } else {
                console.log("callback 처리에 실패하였습니다.");
            }
        });
    });
</script>

</body>
</html>
