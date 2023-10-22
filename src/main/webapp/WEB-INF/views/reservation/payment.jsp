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

<c:set var="fullUrl" value="${protocol}://${host}:${port}${pageContext.request.contextPath}" />

<c:if test='${kind == "kind"}'>
    <title>이용 시간 구매</title>
</c:if>
<c:if test='${kind == "fixed"}'>
    <title>지정석 구매</title>
</c:if>

<style>
    #paymentPage {
        padding: 5px 80px 5px 80px;
    }

    input[type="checkbox"] {
        width: 20px;
        height: 20px;
    }

    input[type="checkbox"]:checked {
        accent-color: #8D7B68;
    }

    input[type="text"], select {
        height: 40px;
        width: 200px;
        padding: 5px;
    }

    .common_button {
        background: #8D7B68;
        padding: 7.5px 15px;
        color: white;
        font-weight: bold;
        border:none;
        box-shadow: 1px 1px 2px black;
    }

    .common_button:hover {
        background: #685948;
    }

    #payment-button {
        width:90%;
        padding:15px;
        background-color: #8D7B68;
        color:white;
        border-radius:3px;
        border:none;
        margin: 0 auto;
        font-size: 24px; font-weight: bold; margin-bottom: 50px;
    }

    #payment-button:hover {
        background: #685948;
    }

    .title {margin: 0 0 4px; font-size: 24px; font-weight: 600;color: #4e5968;}

    #expected_mil {
        background: bisque;
        padding: 10px;
        border-radius: 10px;
    }

    #expected_mil table tr {
        padding: 10px;
    }
    #expected_mil table td {
        padding: 8px;
    }
</style>

<title>결제</title>

<jsp:include page="../common/header.jsp"/>


<section id="paymentPage" style="justify-content: center; display: flex; flex-direction: column; align-items: center;">
    <c:if test='${kind != "room"}'>
        <div style="width: 100%; min-width: 800px; max-width: 1280px; text-align: left; margin-top: 50px;
                    border-bottom: 3px solid #8D7B68; padding-bottom: 50px; margin-bottom: 50px;">
            <h4 style="font-weight: 900; font-size: 32px; margin-bottom: 50px;">상품 선택</h4>
            <div style="padding: 0px 50px;">
                <c:if test='${kind == "time"}'>
                    <jsp:include page="./components/time.jsp"/>
                </c:if>
                <c:if test='${kind == "fixed"}'>
                    <jsp:include page="./components/fixed.jsp"/>
                </c:if>
                <c:if test='${kind == "locker"}'>
                    <jsp:include page="./components/locker.jsp"/>
                </c:if>
            </div>
        </div>
    </c:if>
    <c:if test='${kind == "room"}'>
        <div style="margin-top: 50px;"></div>
    </c:if>

    <div style="width: 100%; text-align: left; border-bottom: 3px solid #8D7B68; padding-bottom: 50px;
                margin-bottom: 50px;">
        <h4 style="font-weight: 900; font-size: 32px;">상품 구매 정보</h4>
        <div style="width: 100%; padding: 0px 50px;">
            <table style="height: 200px; width: 50%;">
                <tr>
                    <th style="font-size: 20px; font-weight: bold; text-align: left;"
                        width="30%">상품 :
                    </th>
                    <td id="productInfo" style="font-size: 20px;">
                        <c:if test='${kind == "time"}'>1시간 이용권</c:if>
                        <c:if test='${kind == "fixed"}'>지정석 1개월</c:if>
                        <c:if test='${kind == "room"}'>${item_name}</c:if>
                        <c:if test='${kind == "locker"}'>
                            사물함 1주 이용권
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th style="font-size: 20px; font-weight: bold">가격 : </th>
                    <td id="productPrice" style="font-size: 20px;">
                        <c:if test='${kind == "time"}'>3,000원</c:if>
                        <c:if test='${kind == "fixed"}'>200,000원</c:if>
                        <c:if test='${kind == "room"}'>
                            <fmt:formatNumber value="${item_price}" pattern="#,##0" />원
                        </c:if>
                        <c:if test='${kind == "locker"}'>
                            5,000원
                        </c:if>
                    </td>
                </tr>
                <c:if test='${kind == "fixed"}'>
                    <tr>
                        <th style="font-size: 20px;">사용 기간 : </th>
                        <td id="term" style="font-size: 20px;">
                        </td>
                    </tr>
                </c:if>
            </table>
        </div>
    </div>

    <div style="width: 100%; text-align: left; margin-bottom: 65px;">
        <h4 style="font-weight: 900; font-size: 32px">마일리지 및 쿠폰</h4>
        <div style="width: 100%; padding: 0px 50px;">
            <table style="height: 200px; padding: 0px 50px; width: 100%;">
                <tr>
                    <th style="color: #756A6A; font-size: 20px;">
                        보유 마일리지 :
                        <fmt:formatNumber value="${user.mileage}" pattern="#,##0" />
                    </th>
                    <td rowspan="4" style="padding: 45px;">
                        <div id="expected_mil">
                            <table width="500px">
                                <tr>
                                    <td>마일리지 적립예정</td>
                                    <td width="30%" id="getMil">
                                        <c:if test='${kind == "time"}'>30p</c:if>
                                        <c:if test='${kind == "fixed"}'>200p</c:if>
                                        <c:if test='${kind == "room"}'>
                                            <fmt:formatNumber value="${item_price/100}" pattern="#,##0" />p
                                        </c:if>
                                        <c:if test='${kind == "locker"}'>50p</c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td>사용한 마일리지</td>
                                    <td id="usedMil">0p</td>
                                </tr>
                                <tr>
                                    <td>사용한 쿠폰</td>
                                    <td id="usedCoupon">없음</td>
                                </tr>
                                <tr>
                                    <td>최종 결제 금액</td>
                                    <td id="total_cash">
                                        <c:if test='${kind == "time"}'>3,000원</c:if>
                                        <c:if test='${kind == "fixed"}'>200,000원</c:if>
                                        <c:if test='${kind == "room"}'>
                                            <fmt:formatNumber value="${item_price}" pattern="#,##0" />원
                                        </c:if>
                                        <c:if test='${kind == "locker"}'>5,000원</c:if>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="display: flex; align-items: center; gap: 10px">
                        <input type="number"
                               style="height: 40px; width: 150px; padding: 0 7.5px"
                               max="${user.mileage}" min="0" id="mileage"
                               value="0" step="10"
                        >
                        <button class="common_button" id="useAllMil"
                                style="height: 40px; align-items: center; display: flex"
                        >전체사용</button>
                        <button class="common_button" id="resetMil"
                                style="height: 40px; align-items: center; display: flex"
                        >초기화</button>
                    </td>
                </tr>
                <tr>
                    <th style="color: #756A6A; font-size: 20px;">보유한 쿠폰 : </th>
                </tr>
                <tr>
                    <td style="display: flex; align-items: center; gap: 10px">
                        <select id="coupon_selector">
                            <option value="0" >
                                <c:if test="${empty ownCouponList}">
                                    없음
                                </c:if>
                                <c:if test="${ not empty ownCouponList}">
                                    선택 안함
                                </c:if>
                            </option>
                            <c:forEach var="coupon" items="${ownCouponList}">
                                <option value="${coupon.coupon.discount}">${coupon.name}</option>
                            </c:forEach>
                        </select>
                        <button class="common_button" onclick="coupon_selector_reset()">초기화</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style="border-bottom: 3px solid;color: #8D7B68; width: 100%; min-width: 800px; max-width: 1280px;"></div>
</section>









<!-- 결제 방법 영역-->
<div  class="title" style="text-align: left;">
    <h4 style="font-weight: 900;"></h4>
</div>

<div id="payment-method" style="padding: 10px 80px 10px 80px;"></div>
<div id="agreement" style="padding: 0px 80px 5px 80px;"></div>
<div style="justify-content: center; display: flex">
    <button id="payment-button">
        결제하기
    </button>
</div>



<script src="https://js.tosspayments.com/v1/payment-widget"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>

<script>
    $(document).ready(function() {
        const formatDate = (num) => {
            let result = '';
            const date = dayjs();
            result += date.year() + "-" + (date.month() + 1) + "-" + date.date() + " ~ ";

            const endDate = date.add(num, 'month');
            result += endDate.year() + "-" + (endDate.month() + 1) + "-" + endDate.date();

            return result;
        }

        $('input[type="checkbox"]').click(function () {
            if ($(this).prop('checked')) {
                $('input[type="checkbox"]').prop('checked', false);
                $(this).prop('checked', true);

                $('#term').text(formatDate($(this)[0].id));
            }
        });

        $('#term').text(formatDate(1));

        const clientKey = 'test_ck_nRQoOaPz8L9L6wyynbW3y47BMw6v' // 상점을 특정하는 키
        const customerKey = '${user.id}' // 결제 고객을 특정하는 키

        const paymentWidget = PaymentWidget(clientKey, customerKey) // 회원 결제
        paymentMethods = paymentWidget.renderPaymentMethods('#payment-method', 3000)
        const paymentAgreement = paymentWidget.renderAgreement('#agreement')

        /*결제창 열기*/
        $("#payment-button").on("click",()=>{
            // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS) // 비회원 결제
            let selectedText = $('#coupon_selector option:selected').text().toString();

            if(selectedText.includes('없음') || selectedText.includes('선택 안함')) {
                selectedText = '';
            }

            console.log($('#productInfo').text().trim()
                + (`${param.seat}` === `` ? '' : `${param.seat}`.padStart(3, '0'))
                + (`${param.room}`.includes('room') ? `${param.date}+${param.hour}` : '')
                + (`${param.room}`.includes('4_room') ? `${param.room}`.at(-1) : '')
                + (`${param.no}` === '' ? '' : `${param.no}`.padStart(2, '0'))
                + '@@' + selectedText)

            console.log(parseInt($('#total_cash').text().replaceAll(",","")))

            paymentMethods.updateAmount(
                parseInt($('#total_cash').text().replaceAll(",",""))
            );

            paymentWidget.requestPayment({
                orderId: `${payment_num}`,
                orderName: $('#productInfo').text().trim()
                    + (`${param.seat}` === `` ? '' : `${param.seat}`.padStart(3, '0'))
                    + (`${param.room}`.includes('room') ? `${param.date}+${param.hour}` : '')
                    + (`${param.room}`.includes('4_room') ? `${param.room}`.at(-1) : '')
                    + (`${param.no}` === '' ? '' : `${param.no}`.padStart(2, '0'))
                    + '@@' + selectedText
                ,
                successUrl: `${fullUrl}/reservation/payment_confirm`,
                failUrl: `${fullUrl}/fail`,
                customerEmail: `${user.email}`,
                customerName: `${user.name}`,
                customerMobilePhone: `${user.phone.replace("-","")}`,
                taxFreeAmount:  $('#mileage').val(),
            }).catch(function (error) {
                if (error.code === 'USER_CANCEL') {
                    // 결제 고객이 결제창을 닫았을 때 에러 처리
                } if (error.code === 'INVALID_CARD_COMPANY') {
                    // 유효하지 않은 카드 코드에 대한 에러 처리
                }
            })
        })
    });


    $('#useAllMil').on('click', () => {
        let mil = parseInt(`${user.mileage}`);

        if(mil > parseInt($('#productPrice').text().replaceAll(",","")))
            mil = parseInt($('#productPrice').text().replaceAll(",",""))

        mil -= mil%10;

        $('#mileage').val(mil);
        $('#usedMil').text(mil.toLocaleString()+"p");

        const total_cash = parseInt($('#productPrice').text().replaceAll(",","")) - parseInt($('#mileage').val());
        $('#total_cash').text(total_cash.toLocaleString() + "원");
        $('#getMil').text((Math.floor(total_cash/100)).toLocaleString() + "p");
    })

    $('#resetMil').on('click', () => {
        $('#mileage').val(0);
        $('#usedMil').text("0p");

        let total_cash = parseInt($('#productPrice').text().replaceAll(",",""));
        total_cash = total_cash / 100 * (100-$('#coupon_selector').val());

        $('#total_cash').text(total_cash.toLocaleString() + "원");
        $('#getMil').text((Math.floor(total_cash/100)).toLocaleString() + "p");
    })

    $('#mileage').on('change', function() {
        this.value = parseInt(`${user.mileage}`) < this.value ? parseInt(`${user.mileage}`) : this.value;
        if(this.value > parseInt($('#productPrice').text().replaceAll(",","")))
            this.value = parseInt($('#productPrice').text().replaceAll(",",""))
        this.value -= this.value % 10;

        $('#usedMil').text(this.value + "p");

        let total_cash = parseInt($('#productPrice').text().replaceAll(",",""))
        total_cash -= this.value;

        $('#total_cash').text(total_cash.toLocaleString() + "원");
        $('#getMil').text((Math.floor(total_cash/100)).toLocaleString() + "p");
    });

    $('#coupon_selector').on('change', function() {
        let total_cash = parseInt($('#productPrice').text().replaceAll(",","")) - $('#mileage').val();
        total_cash = Math.floor(total_cash / 100 * (100-this.value));

        $('#usedCoupon').text($('#coupon_selector option[value="' + this.value + '"]').text())
        $('#total_cash').text(total_cash.toLocaleString() + "원");
        $('#getMil').text((Math.floor(total_cash/100)).toLocaleString() + "p");
    })

    const coupon_selector_reset = () => {
        let total_cash = parseInt($('#productPrice').text().replaceAll(",","")) - $('#mileage').val();
        $('#total_cash').text(total_cash.toLocaleString() + "원");
        $('#getMil').text((Math.floor(total_cash/100)).toLocaleString() + "p");

        $('#coupon_selector').val(0);
        $('#usedCoupon').text("없음")
    }

</script>

<jsp:include page="../common/footer.jsp"/>