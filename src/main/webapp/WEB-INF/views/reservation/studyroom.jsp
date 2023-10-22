<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>


<title>스터디 룸 예약 </title>

<jsp:include page="../common/header.jsp"/>

<style>
  .form-select {
    border: 1px solid #8D7B68;
  }

  .form-select:focus,
  #date_selector:focus {
    box-shadow: 0 0 0 0.1rem brown; /* Red with transparency */
  }

  #study_room_table th{
    color: #8D7B68; font-size: 24px;
    padding: 20px;
  }

  #date_selector,
  #start_time {
    width: 200px; height: 38px; border-radius: 4px;
    border: 1px solid #8D7B68;
    outline: none; padding: 0 5px;
    align-items: center; display: flex;
    user-select: none;
    background-color: white;
  }

  #start_time:disabled,
  #default_room:disabled,
  #date_selector:disabled {
    color: #bbb;
    background-color: #eee;
  }

  #time_selector {
    position: absolute; left: 0; top: 36px;
    background-color: white;
    width: 420px; height: 350px; border: 1px solid #8D7B68;
    border-radius: 4px; padding: 10px;
    box-shadow: 0px 0px 5px 0.2rem rgba(102, 102, 102, .3);
    justify-content: center; z-index: 10;
    display: none;
  }

  .time-grid-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px; /* 각 그리드 아이템 사이의 간격 */
  }

  .time-grid-item {
    border: 1px solid rosybrown; /* 테두리 설정 */
    padding: 10px 20px; /* 패딩 설정 */
    background-color: #F1DEC9;
    font-weight: bold;
    cursor: pointer;
  }

  #payment_button{
    color: white; font-size: 30px; font-weight: bold;
    background-color: #8D7B68; display: flex;
    margin: 50px 0 0 320px; width: 300px; height: 100px;
    justify-content: center; align-items: center;
  }

  #payment_button:disabled {
    background-color: #ddd;
    color: #eee;
  }
</style>

<section style="justify-content: center; display: flex; flex-direction: column; align-items: center;">
  <div style="width: 100%; text-align: left; height: 50px; border-bottom: 2px solid rosybrown;
    margin-bottom: 50px;">
  </div>
  <table width="600px" id="study_room_table">
    <tr>
      <th>스터디 룸</th>
      <td>
        <select id="room_selector" class="form-select form-select-sm"
                style="width: 200px; font-size: 16px;"
        >
          <option value="default_room" selected>룸 선택</option>
          <option value="4_room_1">스터디룸1 (4인실)</option>
          <option value="4_room_2">스터디룸2 (4인실)</option>
          <option value="8_room">스터디룸 (8인실)</option>
        </select>
      </td>
    </tr>
    <tr>
      <th>예약 일자</th>
      <td>
        <input type="date" id="date_selector" disabled>
      </td>
    </tr>
    <tr>
      <th>시작 시간</th>
      <td>
        <button id="start_time" style="position: relative" disabled>
          <span id="selected_time">시간 선택</span>
          <div id="time_selector">
            <div>
              <div style="text-align: center; margin-bottom: 10px;">오전</div>
              <div class="time-grid-container">
                <c:forEach var="idx" begin="1000" end="1150" step="50">
                  <div class="time-grid-item item-${idx}" onclick="select_time(${idx})">
                      ${idx.toString().substring(0,2)}:<fmt:formatNumber value="${idx % 100 / 100 * 60}" pattern="00"/>
                  </div>
                </c:forEach>
              </div>
              <div style="text-align: center; margin: 10px 0;">오후</div>
              <div class="time-grid-container">
                <c:forEach var="idx" begin="0" end="750" step="50">
                  <div class="time-grid-item item-${idx}" onclick="select_time(${idx})">
                    <fmt:formatNumber value="${idx / 101}" pattern="00"/>:<fmt:formatNumber value="${idx % 100 / 100 * 60}" pattern="00"/>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </button>
      </td>
    </tr>
    <tr>
      <th>이용 시간</th>
      <td>
        <select id="default_room" class="form-select form-select-sm" disabled
                style="width: 200px; font-size: 16px;"
        >
          <option value="0" selected>이용 시간</option>
        </select>
        <select id="4_room" class="form-select form-select-sm"
                style="width: 200px; font-size: 16px; display: none"
        >
          <option value="0" selected>시간 선택</option>
          <option value="1">1 시간 - 20,000원</option>
          <option value="2">2 시간 - 38,000원</option>
          <option value="4">4 시간 - 75,000원</option>
          <option value="6">6 시간 - 110,000원</option>
        </select>

        <select id="8_room" class="form-select form-select-sm"
                style="width: 200px; font-size: 16px; display: none"
        >
          <option value="0" selected>시간 선택</option>
          <option value="1">1 시간 - 40,000원</option>
          <option value="2">2 시간 - 76,000원</option>
          <option value="4">4 시간 - 140,000원</option>
          <option value="6">6 시간 - 200,000원</option>
        </select>
      </td>
    </tr>
  </table>

  <div style="margin-top: 50px; display: flex; color: #8D7B68; width: 1280px; height: 180px;
    background-color: #C8B6A6;text-align: left; justify-content: center;">
    <table style="justify-content: center; border-collapse: separate;
      font-size: 20px; padding: 30px; color: white; width: 500px;">
      <tr>
        <td colspan="2"  style="font-size: 25px;"><b style="font-size: 26px">
          내가 선택한 스터디룸
        </b></td>
      </tr>
      <tr>
        <th style="font-size: 20px;">스터디룸 :</th>
        <td id="result_room" style="font-size: 20px; text-align: left"></td>
      </tr>
      <tr>
        <th style="font-size: 20px;">이용 시작 시간 :</th>
        <td id="result_time" style="font-size: 20px; text-align: left">
        </td>
      </tr>
    </table>
    <button type="button" class="btn text-white"
            id="payment_button" disabled
            onclick="submit()"
    >
      <i class="fa-solid fa-credit-card fa-2xl"
         style="height: 50px; width: 50px; margin-right: 20px;"></i>
      <div>결제하기</div>
    </button>
  </div>

</section>

<script>
  let start_time, end_time

  var today = new Date();
  today.setDate(today.getDate() + 1); // add one day

  var dd = String(today.getDate()).padStart(2, '0');
  var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
  var yyyy = today.getFullYear();

  tomorrow = yyyy + '-' + mm + '-' + dd;

  document.getElementById("date_selector").setAttribute("min", tomorrow);

  $('#start_time, #selected_time').on('click', (e) => {
    $('#time_selector').css('display', 'flow');
  })

  $(document).on('click', (e) => {
    if (!$(e.target).is('#start_time')) {
      $('#time_selector').css('display', 'none');
    }
  });

  $('#4_room, #8_room').on('change', (e) => {
    $('#payment_button').removeAttr('disabled');
  })

  $('#room_selector').on('change', (e) => {
    $('#date_selector').removeAttr('disabled');
    $('#date_selector').val('');

    $('#default_room').css('display', 'flow');
    $('#4_room').css('display', 'none');
    $('#8_room').css('display', 'none');

    $('#start_time').attr('disabled', 'true')
    $('#selected_time').text('시간 선택')

    const room = $('#room_selector').val()

    switch (room){
      case 'default_room': $('#result_room').text(''); break;
      case '4_room_1': case '4_room_2':
        $('#result_room').text('스터디룸 (4인실)'); break;
      case '8_room': $('#result_room').text('스터디룸 (8인실)'); break;
    }

    $('#payment_button').attr('disabled');
  })

  const select_time = (time) => {
    if($('.item-'+time).css('cursor') === 'not-allowed'){
      return;
    }

    let AMPM = "";
    time > 1000 ? AMPM += "오전" : AMPM += "오후";
    if(time % 100 !== 0) time -= 20;

    let formattedTime = time.toString().padStart(4, '0');
    formattedTime = formattedTime.slice(0, 2) + ':' + formattedTime.slice(2);

    $('#selected_time').text(AMPM + ' ' + formattedTime);

    $('#default_room').css('display', 'none');
    $('#4_room').css('display', 'none');
    $('#8_room').css('display', 'none');

    let room = $('#room_selector').val();
    if(room.includes('4_room')) {
      $('#4_room').css('display', 'flow'); room = '4_room';
    } else {
      $('#'+room).css('display', 'flow');
    }

    const prev_time = $('#result_time').text().toString();

    if(prev_time.includes(':')){
      $('#result_time').text( prev_time.substring(0, prev_time.length - 8)
              + AMPM + ' ' + formattedTime)
    } else {
      $('#result_time').text( prev_time + ' ' + AMPM + ' ' + formattedTime)
    }
    $('#payment_button').attr('disabled');
  }

  $('#date_selector').on('change', (e) => {
    $('#start_time').removeAttr('disabled')
    $('#result_time').text(e.target.value)

    $('#default_room').css('display', 'flow');
    $('#4_room').css('display', 'none');
    $('#8_room').css('display', 'none');

    $('#selected_time').text('시간 선택')

    $('#payment_button').attr('disabled');
    filter(e.target.value);
  })

  const submit = () => {
    const room = $('#room_selector').val()
    const result_time = $('#result_time').text().replaceAll(' ','-')
    let hour = "";

    if(room.includes('4_room')) {
      hour = $('#4_room').val().at(0);
    } else {
      hour = $('#8_room').val().at(0);
    }

    window.location.href = `${path}/reservation/room?room=` + room
            + '&date=' + result_time + '&hour=' + hour;
  }

  const filter = async (date) => {
    const room = $('#room_selector').val()

    $('.time-grid-item:hover').css('background-color', 'rosybrown')
    for(let time = start_time-50; time <= end_time; time += 50) {
      if(time < 0) {
        const AMTime = time + 1200;
        $('.item-'+AMTime).css('background-color', '#F1DEC9');
        $('.item-'+AMTime).css('border', '1px solid rosybrown');
        $('.item-'+AMTime).css('color', 'black');
        $('.item-'+AMTime).css('cursor', 'pointer');
      } else {
        $('.item-'+time).css('background-color', '#F1DEC9');
        $('.item-'+time).css('border', '1px solid rosybrown');
        $('.item-'+time).css('color', 'black');
        $('.item-'+time).css('cursor', 'pointer');
      }
    }

    await fetch(`${path}/reservation/getAllByDate?date=` + date
            + '&room=' + room)
            .then(response => {
              if (!response.ok) {
                throw new Error('HTTP 오류 발생: ' + response.status);
              }
              return response.json();
            })
            .then(data => {
              for(item of data.result){
                const start_date = new Date(item.start_date);
                const end_date = new Date(item.end_date);

                const start_hour = (start_date.getHours() > 10 ?
                        start_date.getHours() - 12 : start_date.getHours()) * 100;
                const end_hour = (end_date.getHours() > 10 ?
                        end_date.getHours() - 12 : end_date.getHours()) * 100;

                console.log(start_hour, end_hour)

                start_time = start_hour + (start_date.getMinutes() === 30 ? 50 : 0 )
                end_time = end_hour + (end_date.getMinutes() === 30 ? 50 : 0 )

                for(let time = start_time-50; time <= end_time; time += 50) {
                  if(time < 0) {
                    const AMTime = time + 1200;
                    $('.item-'+ AMTime).css('background-color', '#bbb');
                    $('.item-'+ AMTime).css('border', '1px solid #bbb');
                    $('.item-'+ AMTime).css('color', '#ddd');
                    $('.item-'+ AMTime).css('cursor', 'not-allowed');

                  } else {
                    $('.item-'+time).css('background-color', '#bbb');
                    $('.item-'+time).css('border', '1px solid #bbb');
                    $('.item-'+time).css('color', '#ddd');
                    $('.item-'+time).css('cursor', 'not-allowed');
                  }
                }
              }
            })
            .catch(error => {
              console.error('오류 발생:', error);
            });
  }
</script>

<jsp:include page="../common/footer.jsp"/>