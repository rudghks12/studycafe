<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<title>결제 완료</title>

<style>
  table {
    width: 80%;
  }

  th, td {
    padding: 10px; /* <th>와 <td> 사이의 간격을 설정합니다. */
  }

  ul{
    color: #8D7B68;
    font-size: 20px;
    font-weight: bolder;
  }

  .li1{
    color: #8D7B68;
    margin-left: 40px;
  }

  #result_info th,
  #result_info tr {
    text-align: center;
    font-size: 20px;
  }

  #payment_chk {
    background-color: #8D7B68; position: absolute; bottom: 50px; right: 200px; color: white; padding: 20px 60px;
    font-size: 36px; border-radius: 10px; box-shadow: 1px 1px 3px black; cursor: pointer;
  }

  #payment_chk:hover {
    background-color: #685948;
  }

</style>

<jsp:include page="../common/header.jsp"/>


<section>
  <div style="justify-content: center; display: flex; width: 100%; border-bottom: 5px solid #8D7B68;
    padding-bottom: 50px; margin-bottom: 50px;"
  >
    <div style="margin-top: 100px;">
      <p style="font-size: 50px"><b>결제 완료</b></p><br>
      <i class="fa-regular fa-circle-check fa-bounce" id="enroll_icon"
         style="color: #8D7B68; font-size: 70px; margin-left: 75px;">
      </i>
    </div>
  </div>

  <div style="width: 800px; text-align: left; padding: 0 150px;">
    <div style="font-weight: 900; font-size: 36px;">결제 정보</div>
  </div>

  <div style="justify-content: center; display: flex; width: 100%;">
    <table id="result_info">
      <tr>
        <th>결제 방식</th>
        <td id="method"></td>
      </tr>
      <tr>
        <th>카드 번호</th>
        <td id="card"></td>
      </tr>
      <tr>
        <th>결제 금액</th>
        <td id="cash"></td>
      </tr>
      <tr>
        <th>사용한 쿠폰</th>
        <td id="coupon"></td>
      </tr>
      <tr>
        <th>사용한 마일리지</th>
        <td id="mileage"></td>
      </tr>
      <tr>
        <th>상품유형</th>
        <td id="kind"></td>
      </tr>
      <tr>
        <th>상품</th>
        <td id="item"></td>
      </tr>
      <tr>
        <th id="term_title">사용기간</th>
        <td id="term_value"></td>
      </tr>
      <tr>
        <th>보유 마일리지</th>
        <td id="own_mileage"></td>
      </tr>
    </table>
  </div>

  <div style="width: 1280px; text-align: left; border-top: 3px solid #8D7B68; margin: 50px 0; padding: 0 150px;">
    <h4 style="font-weight: 900; margin-top: 50px;">환불 안내</h4>
  </div>

  <div style="text-align: left; padding: 0px 150px; position: relative">
    <ul><b>|  사물함 환불 규정 |</b></ul>
    <li class="li1"> 전체 결제금액 위약금 10% 및 경과기간 요금 차감 ex) 1일마다  해당금액차감  할인율 적용 x 기존금액 o</li><br><br>
    <ul><b>| 일반석 환불 규정 |</b></ul>
    <li class="li1">전체 결제금액 위약금 10% 및 경과기간 요금 차감 ex) 1일마다  해당금액차감  할인율 적용 x 기존금액 o</li><br><br>
    <ul><b>| 고정석 환불 규정 |</b></ul>
    <li class="li1">전체 금액 위약금 20%  및 경과기간 요금 차감 </li><br><br>
    <ul><b>| 스터디룸 환불 규정 |</b></ul>
    <li class="li1">이용일 2일전 : 결제금액의 100% 환불 가능</li>
    <li class="li1">이용일 1일전 : 결제금액의 50% 환불</li>
    <li class="li1">이용일 당일 : 환불 불가능</li><br><br>
    <ul><b>| 그 외 환불 규정 |</b></ul>
    <li class="li1">이용수칙 미준수에 의한 이용제한은 환불이 불가능합니다.</li>
    <li class="li1">이용자의 과실로 인한 잔여기간 손실은 환불이 불가능합니다.</li><br><br>
    <div id="payment_chk">
      결제 확인
    </div>
  </div>

</section>

<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>

<script>
  $('#payment_chk').click(() => {
    window.location.href = "${path}/paymentHistory"
  });

  const formatDate = (num, gap) => {
    let result = '';
    const date = dayjs();
    if(gap === 'month') {
      result += date.year() + "-" + (date.month() + 1) + "-" + date.date() + " ~ ";
      const endDate = date.add(num, 'month');
      result += endDate.year() + "-" + (endDate.month() + 1) + "-" + endDate.date();
    } else if (gap === 'week') {
      result += date.year() + "-" + (date.month() + 1) + "-" + date.date() + " ~ ";
      const endDate = date.add(num, 'week');
      result += endDate.year() + "-" + (endDate.month() + 1) + "-" + endDate.date();
    }


    return result;
  }

  fetch(`https://api.tosspayments.com/v1/payments/${param.orderId}`, {
    method: 'GET',
    headers: {
      'Authorization': 'Basic dGVzdF9za19aNjFKT3hSUVZFMTlsRWVwR2p5VlcwWDliQXF3Og=='
    }
  }).then(response => response.json())
    .then(data => {
      console.log(data);
      let orderName = data.orderName;
      let coupon = '';

      if(orderName.includes('@@')){
        orderName = data.orderName.substring(0, data.orderName.indexOf("@@"));
        coupon = data.orderName.substring(data.orderName.indexOf("@@") + 2)
      }

      $('#method').text(data.method);
      $('#card').text(data.method === '카드' ? data.card.number : '-');
      $('#cash').text(parseInt(data.totalAmount).toLocaleString() + "원");
      $('#kind').text(data.orderName.includes('시간') ? '시간제 상품' : '기간제 상품');
      if(data.orderName.includes('스터디룸')) {
        $('#item').text(orderName.substring(0, 13));
      } else if(data.orderName.includes('시간')) {
        $('#item').text(orderName);
      } else if(data.orderName.includes('사물함')) {
        $('#item').text(orderName.substring(0, orderName.length-2));
      } else if(data.orderName.includes('지정석')) {
        $('#item').text(orderName.substring(0, orderName.length-3));
      }
      $('#term_title').text(data.orderName.includes('시간') && !data.orderName.includes('스터디룸')
              ? '충전된 시간 :' : data.orderName.includes('스터디룸') ? '사용 시간' : '사용 기간 :');
      if(data.orderName.includes('스터디룸')) {
        $('#term_value').text(data.orderName.substring(10, 13));
      } else if(data.orderName.includes('시간')) {
        $('#term_value').text(data.orderName.match(/\d+/g) + '시간');
      } else if(data.orderName.includes('지정석')) {
        const fixed_term = parseInt(data.orderName.match(/\d+/g)[0]);
        $('#term_value').text(formatDate(fixed_term, 'month'));
      } else if(data.orderName.includes('사물함')) {
        const fixed_term = parseInt(data.orderName.match(/\d+/g)[0]);
        $('#term_value').text(formatDate(fixed_term, 'week'));
      }
      $('#mileage').text(parseInt(data.taxFreeAmount).toLocaleString() + "p")
      $('#own_mileage').text(parseInt(`${user.mileage}`).toLocaleString() + "p")
      $('#coupon').text(coupon === '' ? '없음' : coupon)
    })
    .catch(error => {
      console.error(error);
    });

</script>

<jsp:include page="../common/footer.jsp"/>
