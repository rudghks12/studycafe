<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<section>
    <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="LoginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div style="justify-content: center; display: flex;">
                    <img id="logo" src="${path}/images/logoblack.jpg"
                         style="width: 50px; height: 60px">
                    <div style="font-size: 36px; font-weight: bold">&nbsp;결제내역</div>
                </div>
                <hr>
                <table id="payment_object">
                    <tr>
                        <td>결제방식</td>
                        <td id="payment_method"></td>
                    </tr>
                    <tr>
                        <td>카드번호</td>
                        <td id="payment_card"></td>
                    </tr>
                    <tr>
                        <td>결제금액</td>
                        <td id="payment_cash"></td>
                    </tr>
                    <tr>
                        <td>상품명</td>
                        <td id="payment_name"></td>
                    </tr>
                    <tr>
                        <td>사용한 쿠폰</td>
                        <td id="payment_used_coupon"></td>
                    </tr>
                </table>
                <button id="payment_modal_close">닫기</button>
            </div>
        </div>
    </div>
</section>

<style>
    #payment_object {
        margin: 30px 50px;
    }
    #payment_object td {
        text-align: center;
    }

    #payment_object tr td:first-child {
        color: #8E6424;
        padding: 5px 0;
    }

    #payment_modal_close {
        background-color: #8D7B68;
        color: white;
        padding: 5px 0;
        border-radius: 5px;
        font-size: 24px;
        border: none;
    }

    #payment_modal_close:hover {
        background-color: #685948;
    }
</style>

<script>
    $('#payment_modal_close').on('click', () => {
        $('#paymentModal').modal("hide");
    })

</script>