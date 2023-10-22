<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="request" value="<%= request %>" />
<c:set var="protocol" value="${request.scheme}" />
<c:set var="host" value="${request.serverName}" />
<c:set var="port" value="${request.serverPort}" />

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<c:set var="fullUrl" value="${protocol}://${host}:${port}${pageContext.request.contextPath}" />

<section>
    <div class="modal fade" id="lockerModal" tabindex="-1" aria-labelledby="LockerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div style="position: relative">
                    <div id="lockerModalTitle"
                        style="font-size: 32px; font-weight: bold; text-align: center;"
                    >
                    </div>
                    <div id="lockerModal_content"
                        style="font-size: 24px; text-align: center; color: #756A6A; margin: 50px 0;">

                    </div>

                    <div id="lockerModal_normal_buttons"
                        style="display: none; justify-content: space-between;
                        padding: 0 30px;
                    ">
                        <div class="button" onclick="locker_cancel()">취소</div>
                        <div class="button" onclick="locker_submit()">확인</div>
                    </div>

                    <div id="lockerModal_error_buttons"
                         style="display: none; justify-content: center;
                         margin-top: -30px;
                    ">
                        <div class="button" onclick="locker_cancel()">취소</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    #lockerModal {
        display: none;
    }

    #lockerModal .modal-content {
        width: 400px;
        height: 300px;
    }

    #lockerModal .button {
        padding: 20px 50px;
        color: #59A4CE; cursor: pointer; user-select: none;
        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
    }

    #lockerModal .button:hover {
        background-color: #F5EAEA;
    }
</style>

<script>
    const locker_cancel = () => {
        $('#lockerModal').modal("hide")
    }
    const locker_submit = () => {
        const locker_num = $('#lockerModalTitle').text().match(/\d+/)[0];
        <%--console.log(`${fullUrl}/reservation/locker&no=` + locker_num)--%>
        window.location.href = `${path}/reservation/locker?no=` + locker_num
    }
</script>