<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<style>

    #footer {
        min-width: 1280px;
        background-color: #8D7B68;
        height: 150px;
        display: flex;
        justify-content: center;
    }

    #footer .div1 {
        font-size: 32px;
        color: white;
        vertical-align: middle;
        margin-top: 80px;
        font-weight: bold;
    }

    #footer .logo {
        margin-left: -30px;
    }

    #footer p {
        font-size: 22px;
        color: #DDDDDD;
        margin-top: 15px;
    }

    #footer .footertext {
        margin-left: 140px;
        margin-top: 15px;
    }

</style>

    </div>
    </div>
<section id="footer">
        <footer style="display: flex; justify-content: center; background-color: #8D7B68;">
            <div class="logo">
                <img style="width: 80px; height: 110px; margin-top: 25px;" src="${path}/images/logowhite.png">
            </div>
            <div class="div1">
                <span>집중할곳 없스카</span>
            </div>
            <div class="footertext">
                <p>이용약관·개인정보처리방침·이메일주소무단수집거부</p>
                <p style="margin-top: -10px;">
                    <b style="color: white">(주)SSS</b> | 대표자: 신성식 | 사업자등록번호: 110-234-56789<br>
                    TEL: 010-1111-2222 | E-mail: sss222@gmail.com
                </p>
            </div>
        </footer>
</section>
</body>
</html
