
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="">
<head>
    <meta charSet="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사물함 예약</title>
    <script src="https://js.tosspayments.com/v1/payment-widget"></script>



    <style>
        input[type="checkbox"] {
            /* 여기에 원하는 스타일을 추가합니다 */
            margin-right: 5px; /* 체크박스 오른쪽에 여백을 추가합니다 */
        }

        /* 선택된 체크박스의 스타일 */
        input[type="checkbox"]:checked {
            /* 여기에 선택된 체크박스의 스타일을 추가합니다 */

        }

        /* 라벨과 체크박스를 가로로 정렬 */
        label {
            display: flex;
            align-items: center;
        }
        th{
            padding: 10px;
        }
        #payment-button{
            width:100%; padding:15px; background-color:#3065AC; color:white; border-radius:3px; font-size:16px; border:none; margin-top:10px
        }
        .title {margin: 0 0 4px; font-size: 24px; font-weight: 600;color: #4e5968;}

    </style>
</head>
<jsp:include page="../common/header.jsp"/>


<section style="justify-content: center; display: flex; flex-direction: column; align-items: center;">
    <div style="width: 100%; min-width: 800px; max-width: 1280px; text-align: left;">
        <h4 style="font-weight: 900;">상품 선택</h4>
    </div>
    <table style="height: 200px;">
        <tr>

            <th style="color: #8D7B68; padding: 75px;">사물함</th>
            <th style="padding: 75px">
                <label><input type="checkbox"> &nbsp;1개월 이용원 &nbsp;&nbsp;<b style="color: #757575; font-size: 14px">200,000 원</b></label><br>
                <label><input type="checkbox"> &nbsp;3개월 이용원 &nbsp;&nbsp;<b style="color: #757575; font-size: 14px">500,000 원</b></label><br>
                <label><input type="checkbox"> &nbsp;6개월 이용원 &nbsp;&nbsp;<b style="color: #757575; font-size: 14px">1,000,000 원</b></label><br>
                <label><input type="checkbox">12개월 이용원 &nbsp;&nbsp;<b style="color: #757575; font-size: 14px">1,500,000 원</b></label><br>
            </th>

        </tr>
    </table>
</section>
<section style="justify-content: center;display: flex;">
    <div style="border-bottom: 3px solid;color: #8D7B68;width: 100%; min-width: 800px; max-width: 1280px;"></div>
</section>

<section style="justify-content: center;display: flex; margin-top: 50px;">
    <div style="width: 100%; min-width: 800px; max-width: 1280px; text-align: left;">
        <h4 style="font-weight: 900;">날짜 선택</h4>
        <table style="height: 150px; justify-content: center;display: flex;">
            <tr>
                <br><br>
                <td style="font-size: 20px; font-weight: 600;">시작일</td>
                <td style="font-size: 20px; font-weight: 600;">종료일</td>
            </tr><tr>
            <td><input type="date">&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;</td>
            <td><input type="date"></td>

        </tr>
        </table>
    </div>
</section>

<section style="justify-content: center;display: flex; margin-top: 50px;">
    <div style="border-bottom: 3px solid;color: #8D7B68;width: 100%; min-width: 800px; max-width: 1280px;"></div>
</section>


<section style="justify-content: center; display: flex; flex-direction: column; align-items: center; margin-top: 50px;">
    <div style="width: 100%; min-width: 800px; max-width: 1280px; text-align: left;">
        <h4 style="font-weight: 900;">상품 구매 정보</h4>
    </div>
    <table style="height: 200px;">
        <tr>
            <td>락커 번호</td>
            <td id="productnumber"></td>
        </tr>
        <tr>
            <td>상품</td>
            <td id="productInfo"></td>
        </tr>
        <tr>
            <td>가격</td>
            <td id="productPrice"></td>
        </tr>
        <tr>
            <td>사용 기간</td>
            <td></td>
        </tr>


    </table>

</section>
<br><br>
<section style="justify-content: center;display: flex;">
    <div style="border-bottom: 3px solid;color: #8D7B68;width: 100%; min-width: 800px; max-width: 1280px;"></div>
</section>

<section style="justify-content: center; display: flex; flex-direction: column; align-items: center; margin-top: 50px;">
    <div style="width: 100%; min-width: 800px; max-width: 1280px; text-align: left;">
        <h4 style="font-weight: 900;">마일리지 및 쿠폰</h4>
    </div>
    <table style="height: 200px; padding: 30px;">
        <tr>
            <th style="color: #8D7B68">보유 마일리지 : </th>
            <td rowspan="4" style="padding: 45px;">
                마일리지 적립예정 : <br><br>
                사용한 마일리지 : <br><br>
                사용한 쿠폰 : 없음 <br><br>
                최종 결제 금액 :
            </td>
        </tr>
        <tr>
            <td>
                <input type="text"> <button>전체사용</button> <button>초기화</button>
            </td>
        </tr>
        <tr>
            <th style="color: #8D7B68">보유한 쿠폰 : </th>
        </tr><tr>
        <td><select>
            <option>선택 안함</option>
            <option>------------------------</option>
        </select>
            <button>초기화</button>
        </td>
    </tr>

    </table>


</section>

<br><br><br><br>

<section style="justify-content: center;display: flex;">
    <div style="border-bottom: 3px solid;color: #8D7B68;width: 100%; min-width: 800px; max-width: 1280px;"></div>
</section>






<!-- 결제 방법 영역-->
<div  class="title" style="width: 100%; min-width: 800px; max-width: 1280px; text-align: left;">
    <h4 style="font-weight: 900;"></h4>
</div>
<br>
<div id="payment-method"></div>
<div id="agreement"></div>
<button id="payment-button" style="background-color: #8D7B68">결제하기</button>


<br><br><br><br><br><br>
<jsp:include page="../common/footer.jsp"/>
</html>
<script>
    $(document).ready(function() {



        $('input[type="checkbox"]').click(function(){

            if($(this).prop('checked')){

                $('input[type="checkbox"]').prop('checked',false);

                $(this).prop('checked',true);

            }

        });

    });




    const clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq' // 상점을 특정하는 키
    const customerKey = 'YbX2HuSlsC9uVJW6NMRMj' // 결제 고객을 특정하는 키
    const amount = 15_000 // 결제 금액
    const couponAmount = 5_000 // 할인 쿠폰 금액

    /*결제위젯 영역 렌더링*/
    const paymentWidget = PaymentWidget(clientKey, customerKey) // 회원 결제
    // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS) // 비회원 결제
    paymentMethods = paymentWidget.renderPaymentMethods('#payment-method', amount)

    /*약관 영역 렌더링*/
    const paymentAgreement = paymentWidget.renderAgreement('#agreement')

    /*결제창 열기*/
    $("#payment-button").on("click",()=>{
        paymentWidget.requestPayment({
            orderId: 'ffff4f4f44f4',
            orderName: '토스 티셔츠',
            successUrl: 'http://localhost:8090/studycafe/reservation/paymentcompleted',
            failUrl: 'http://localhost:8090/studycafe/fail',
            customerEmail: 'customer123@gmail.com',
            customerName: '김토스'
        }).catch(function (error) {
            if (error.code === 'USER_CANCEL') {
                // 결제 고객이 결제창을 닫았을 때 에러 처리
            } if (error.code === 'INVALID_CARD_COMPANY') {
                // 유효하지 않은 카드 코드에 대한 에러 처리
            }
        })
    })

    /*할인 쿠폰 적용*/
    document.querySelector("#coupon").addEventListener("click", applyDiscount)

    function applyDiscount(e) {
        if (e.target.checked) {
            paymentMethods.updateAmount(amount - couponAmount, "쿠폰")
        } else {
            paymentMethods.updateAmount(amount)
        }
    }



    $(document).ready(function() {
        // localStorage에서 가져오기
        var selectedLocker = window.localStorage.getItem('selectedLocker');
        if (selectedLocker) {
            document.getElementById('productnumber').innerText = selectedLocker + "번";
            // 다른 페이지에 영향을 주지 않도록 localStorage의 값을 지웁니다.
            window.localStorage.removeItem('selectedLocker');
        }
    });

</script>