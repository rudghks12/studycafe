<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<style>

    #checkInModal .modal-content {
        border-color: #8D7B68;
        border-width: 4px;
        padding: 0px;
        position: relative;
        overflow: hidden;
    }

    #checkInButton:disabled {
        background-color: #ccc;
        color: #666;
        cursor: not-allowed;
    }

    #checkInButton, #checkOutButton, #chargeButton {
        background-color: rgba(0,0,0,0.5);
        color: white;
        font-size: 18px;
        border-radius: 10px;
        padding: 14px;
        text-align: center;
        display: block;
        border: 2px solid white;
        bottom: 10%;
        width: 70%;
        position: absolute;
        font-weight: bold;
        box-shadow: 1px 1px 5px black;
    }

    #checkInModal .img_box{
        width: 50%;
        height: 300px;
        position: relative;
        transition: width 0.3s ease;
    }

    #checkInModal img {
        width: 100%;
        height: 300px;
        object-fit: cover;
    }

    .seat_kind {
        position: absolute;
        justify-content: center; display: flex; align-items: center;
        text-align: center;
        font-weight: bold; font-size: 30px;
    }

    #checkInModal .img_box:hover {
        width: 80%; /* 호버 시 너비가 늘어나는 값 설정 */
    }

    #checkInModal .img_box {
        justify-content: center;
        display: flex;
        align-items: center;
    }

    #inout_buttons {
        position: absolute;
        bottom: -100px;
        width: 100%;
        justify-content: center;
        display: flex;
    }

    .ment {
        background-color: rgba(0,0,0,0.5);
        border-radius: 10px;
        top: 20px; width: 80%;
        color: white; border: 2px solid white;
        position: absolute;
        text-align: center; font-weight: bold;
        box-shadow: 1px 1px 5px black;
    }
</style>

<section id="checkInModal">
    <div class="modal fade" id="fixedModal" tabindex="-1" aria-labelledby="fixedModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div style="display: flex; justify-content: center; position: relative;">

                    <div id="time_seat" class="img_box" onclick="click_imgBox('time')">
                        <img src="${path}/images/inoutModal/time.png" />
                        <div class="seat_kind" style="color: white">
                            일반석
                        </div>
                    </div>
                    <div id="fixed_seat" class="img_box" onclick="click_imgBox('fixed')">
                        <img src="${path}/images/inoutModal/fixed.png" />
                        <div class="seat_kind" style="color: black">
                            지정석
                        </div>
                    </div>

                    <div class="ment">
                        사용하실 좌석을 선택해주세요.
                    </div>

                    <div id="inout_buttons">
                        <button id="checkInButton" disabled>입실</button>
                        <button id="checkOutButton" style="display: none;">퇴실</button>
                        <button id="chargeButton" style="display: none;">이용권 구매하러 가기</button>
                    </div>
                </div>

                <%--                <div class="ment" style="justify-content: center; text-align: center; border: 1px solid; height: 40px; border-radius: 5px; margin-bottom: 30px; padding-top: 7px;">--%>
                <%--                    사용하실 좌석을 선택해주세요.--%>
                <%--                </div>--%>
                <%--                <table style="justify-content: center; text-align: center">--%>
                <%--                    <tr>--%>
                <%--                        <td><button id="timeBtn">일반석</button></td>--%>
                <%--                        <td><button id="fixedBtn">지정석</button></td>--%>
                <%--                    </tr>--%>
                <%--                </table>--%>

                <%--                <button id="checkInButton" disabled>입실</button>--%>
                <%--                <button id="checkOutButton" style="display: none;">퇴실</button>--%>

                <%--                <button id="chargeButton" style="display: none;">이용권 구매하러 가기</button>--%>
            </div>
        </div>
    </div>

</section>

<script src="${ path }/js/jquery-3.7.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    let ticketNo;

    const click_imgBox = (kind) => {
        $('#'+kind+'_seat').css('width','88%');
        $('#inout_buttons').animate({ bottom: '30px' }, 500);

        if(kind === 'time'){
            $('#fixed_seat').css('width','12%');
            $('#checkInButton, #checkOutButton, #chargeButton, .ment').css('border-color','white')
            $('#checkInButton, #checkOutButton, #chargeButton, .ment').css('color','white')
            $('#checkInButton, #checkOutButton, #chargeButton, .ment').css('background-color','rgba(0,0,0,0.5)')

            $.ajax({
                url: '/studycafe/checkTicket',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ "ticketName": "일반석" }),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function (response) {
                    console.log(response);
                    if (response.fixedTicket) {
                        ticketNo = 0;

                        $("#fixedModal .ment").text('남은 시간: ' + Math.floor(response.allMin/60) + '시간 ' + response.allMin%60 + '분');
                        $("#timeBtn").addClass("clicked");
                        $("#fixedBtn").removeClass("clicked");
                        $("#checkInButton").prop("disabled", false);
                    } else {
                        $("#checkInButton").prop("disabled", true);
                        $("#checkInButton").css("display", "none");
                        $("#chargeButton").css("display","flow")
                        $(".ment").text("이용 시간이 부족합니다.")
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error(textStatus, errorThrown);
                }
            });
        } else if(kind === 'fixed') {
            $('#time_seat').css('width','12%');
            $('#checkInButton, #checkOutButton, #chargeButton, .ment').css('border-color','black')
            $('#checkInButton, #checkOutButton, #chargeButton, .ment').css('color','black')
            $('#checkInButton, #checkOutButton, #chargeButton, .ment').css('background-color','rgba(255,255,255,0.5)')

            $.ajax({
                url: '/studycafe/checkTicket',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ "ticketName": "지정석" }),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function (response) {
                    if (response.fixedTicket) {
                        ticketNo = response.ticketNo;
                        console.log("Ticket NO: ", ticketNo);

                        $("#checkInButton").prop("disabled", false);
                        $("#fixedModal .ment").text('좌석 번호: ' + response.seatName);

                        $("#timeBtn").removeClass("clicked");
                        $("#fixedBtn").addClass("clicked");
                    } else {
                        $("#checkInButton").prop("disabled", true);
                        $("#checkInButton").css("display", "none");
                        $("#chargeButton").css("display","flow")
                        $(".ment").text("지정석 이용권이 없습니다.")
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error(textStatus, errorThrown);
                }
            });
        }
    }

    $("#checkInButton").click(function () {
        if(ticketNo !== 0){
            $.ajax({
                url: '/studycafe/checkIn',
                method: 'POST',
                data: { ticketNo: ticketNo },
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function (response) {
                    if (response === "success") {
                        $("#checkInButton").hide();
                        $("#checkOutButton").show();

                        alert('입실 하셨습니다.');
                        window.location.reload();
                    } else {
                        alert('입실이 실패하였습니다.');
                    }
                }
            });
        } else {
            window.location.href = `${path}/selectCheckInSeat`
        }
    });

    $("#checkOutButton").click(function () {
        $.ajax({
            url: '/studycafe/checkOut',
            method: 'POST',
            data: { "ticketName": $(".ment").text().includes('일반석') ? '일반석' : '지정석' },
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (response) {
                if (response === 'success') {
                    $("#checkOutButton").hide();
                    $("#checkInButton").show();

                    $("#timeBtn").removeClass("clicked");
                    $("#fixedBtn").removeClass("clicked");

                    $('#fixedModal .ment').text('사용하실 좌석을 선택해주세요.')

                    $('#timeBtn').prop('disabled', false);
                    $('#fixedBtn').prop('disabled', false);

                    alert('퇴실 하셨습니다.');
                    window.location.reload()
                } else {
                    alert('퇴실에 실패하였습니다.');
                }
            }
        });
    });

    $("#chargeButton").click(() => {
        const ment = $(".ment").text().toString();
        if(ment.includes("시간")){
            window.location.href = `${path}/reservation/time`;
        } else {
            window.location.href = `${path}/reservation/selectSeat`;
        }
    })
</script>
