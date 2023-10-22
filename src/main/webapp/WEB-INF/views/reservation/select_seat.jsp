<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<title>기간제 좌석</title>

<jsp:include page="../common/header.jsp"/>

<section style="justify-content: center; display: flex; flex-direction: column; align-items: center;">
    <div style="font-size: 32px; width: 100%; text-align: center; padding: 50px 0;
        border-bottom: 3px solid #8D7B68; border-top: 3px solid #8D7B68; margin-top: 50px;"
         id="selectSeatMent"
    >
        사용하실 좌석을 선택해주세요.
    </div>

    <div>
        <jsp:include page="../common/seatingchart.jsp"/>
    </div>

    <div id="payment_container">
        <table id="paymentbox">
            <tr>
                <td colspan="2"  style="font-size: 25px;">
                    <b style="font-size: 30px" id="selected_title">내가 선택한 좌석</b>
                </td>
            </tr>
            <tr>
                <th style="font-size: 25px;" width="30%" id="seat_info">좌석 :</th>
                <td id="selected_seat" style="font-size: 25px;"></td>
            </tr>
        </table>
        <button type="button" class="btn text-white"
                onclick="submit()" id="payment_button" disabled
        >
            <i class="fa-solid fa-credit-card fa-2xl"
               style="height: 50px; width: 50px; margin-right: 20px;"></i>
            <div>결제하기</div>
        </button>
    </div>

    <%
        String[] map = (String[]) request.getAttribute("seatingMap");
        int i = 0;
    %>

    <%
        for(i = 0; i < map.length; i++){
    %>
    <input class="seatingMap-<%=i%>" value="<%=map[i]%>" type="hidden"/>
    <%
        }
    %>

</section>

<style>
    #payment_container{
        position: fixed; bottom: 0px;
        margin-top: 50px; display: flex; color: #8D7B68; width: 100%; height: 180px; background-color: #C8B6A6;
        text-align: left; min-width: 1280px;
        justify-content: center;
    }

    #paymentbox{
        font-size: 20px;
        padding: 30px;
        color: white;
        width: 500px;
        justify-content: center;
        border-collapse: separate;
        border-spacing:20px;
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

<script>
    $('#selected_title').click(() => {
        if(`${ownSeat}` !== '0'){
            console.log(`${ownSeat}`)
            window.location.href = `${path}/customer/faq?kind=%EC%B7%A8%EC%86%8C%ED%99%98%EB%B6%88`;
        }
    })

    if(`${ownSeat}` !== '0') {
        $('#payment_button').prop("disabled", "true");
        $('#selected_title').text('좌석 변경을 원하시나요?');
        $('#selected_title').css('text-decoration','underline');
        $('#selected_title').css('cursor', 'pointer');
        $('#selectSeatMent').text('이미 사용중인 좌석이 있습니다.')
        $('#seat_info').text('내 좌석:')

        const seat = $('.seatingMap-${ownSeat}').val()
        $('#selected_seat').text(seat.substring(0,2))
    }

    let prevIndex = {
        idx: 0,
        bg_color: 'white'
    };

    let prevClick = {
        idx: 0,
        bg_color: '',
    };

    const mouseEnterIndex = (index, value) => {
        const className = '.seat-' + index;

        prevIndex.idx = index;
        prevIndex.bg_color = $(className).css('background-color');

        if($('.seatingMap-'+index).val().includes('F')){
            $(className).css('background-color', 'lawngreen');
        } else {
            $(className).css('background-color', 'red');
        }

    }

    const mouseLeaveIndex = (index) => {
        if(prevClick.idx != index){
            const className = '.seat-' + prevIndex.idx;
            $(className).css('background-color', prevIndex.bg_color);
        }
    }

    const clickIndex = (current, index) => {
        if ($('.seatingMap-' + index).val().includes('F') &&
            !$('.seatingMap-' + index).val().includes('X')) {
            if(`${ownSeat}` === '0') {
                if (prevClick.idx !== 0) {
                    const prevClassName = '.seat-' + prevClick.idx;
                    $(prevClassName).css('border', '1px solid black');
                    $(prevClassName).css('color', 'black');
                    $(prevClassName).css('font-weight', 'normal');
                }

                prevClick.idx = index;

                const className = '.seat-' + index;
                $(className).css('border', '25px solid blue');
                $(className).css('color', 'white');
                $(className).css('font-weight', 'bold');
                $(className).css('background-color', prevIndex.bg_color);
                $('#selected_seat').text($('.seatingMap-' + index).val())
                $('#payment_button').removeAttr('disabled')
            }
        }
    }

    const submit = () => {
        window.location.href = `${path}/reservation/fixed?seat=` + prevClick.idx
    }

    window.addEventListener('scroll', function() {
        let scrollPosition = window.scrollY;

        let cal = window.innerHeight - 1000;

        if ( scrollPosition > window.innerHeight - cal * 1.5){
            $('#payment_container').css('position', 'relative')
        } else {
            $('#payment_container').css('position', 'fixed')
        }
    })
</script>

<jsp:include page="../common/footer.jsp"/>