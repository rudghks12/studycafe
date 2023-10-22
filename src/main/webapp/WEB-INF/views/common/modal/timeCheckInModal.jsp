<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<section>
    <div class="modal fade" id="timeCheckInModal" tabindex="-1" aria-labelledby="LockerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <input type="hidden" id="seatNo"/>
                <div id="timeCheckInModalTitle"
                     style="font-size: 32px; font-weight: bold; text-align: center;">
                </div>
                <div id="possibleCheckInContent"
                     style="font-size: 24px; text-align: center; color: #756A6A;
                    display: none"
                >
                    <div>입실하시겠습니까?</div>
                    <div
                         style="justify-content: space-between; display: flex;
                        padding: 30px 15px;
                    ">
                        <div class="button" onclick="timeCheckInModalCancel()">취소</div>
                        <div class="button" onclick="timeCheckInModalSubmit()">입실</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    #timeCheckInModal .button {
        padding: 20px 50px;
        color: #59A4CE; cursor: pointer; user-select: none;
        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
    }

    #timeCheckInModal .button:hover {
        background-color: #F5EAEA;
    }
</style>

<script>
    const timeCheckInModalCancel = () => {
        $('#timeCheckInModal').modal('hide');
    }

    const timeCheckInModalSubmit = () => {
        window.location.href = `${path}/timeCheckIn?no=` + $('#seatNo').val();
    }
</script>