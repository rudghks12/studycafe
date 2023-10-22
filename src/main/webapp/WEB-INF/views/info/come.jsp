<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css'>



<jsp:include page="../common/header.jsp"/>
<style>
    .headname {
        color: #8D7B68;
        margin: 50px auto;
        width: 80%;

        /*margin-left: 50px;*/
        border-bottom: 2px solid #8D7B68;
        text-align: left;
    }


    /* 테이블 */
    .info-tran tr {
        display: flex;
        align-items: center;
        margin: 100px;
        border-bottom: 2px solid #8D7B68;
    }

    /* 테이블 아이콘 */
    .info-tran svg {
        width: 150px;
        height: 150px;
        color: #8D7B68;
    }

    /* 테이블 P 태그 */
    .info-tran p {
        margin-left: 20px;
        margin-top: 10px; /* 상단 여백 추가 */
    }

    /* 추가된 스타일 */
    .info-box {
        background-color: #ffffff; /* 흰색 배경색 */
        padding: 20px; /* 내용과 테두리 사이의 여백 */
        border: 3px solid #888; /* 테두리 굵기를 3px로 설정하고 회색으로 설정 */
        border-radius: 10px; /* 둥근 테두리 */
        margin-top: 20px; /* 위쪽 여백 추가 */
        min-height: 150px; /* 박스의 최소 높이 설정 (고정 높이) */
        width: 750px; /* 박스의 가로 길이 설정 (고정 가로 길이) */
        display: flex;
        align-items: center;
    }

    /* 아이콘과 텍스트를 감싸는 div */
    .icon-text-container {
        display: flex;
        align-items: center;
    }

    /* 아이콘 위치 조정 */
    .icon-container {
        margin-right: 20px; /* 아이콘 오른쪽 여백 추가 */
    }
    /* .info-text-container에 스타일 적용 */
    .info-text-container {
        display: flex;
        flex-direction: column; /* 요소들을 세로로 배치 */
        align-items: flex-start; /* 왼쪽 정렬 */
        margin-top: -60px; /* 텍스트와 박스를 위로 올림 */
        margin-bottom: 40px;
        font-weight: bold;
    }
</style>

<section style="display:flex; width:1280px; margin:auto; flex-direction:column;">

    <div class='headname'>
        <h1><i class='fas fa-lightbulb' style='color:#8D7B68'></i> INFO - 오시는길 </h1>
    </div>
    <div id="map" style="width:860px;height:500px; margin: 0 auto; "></div>
    <table class="info-tran" style="margin: 0px 50px;">
    <tr>
        <td>
            <div class="icon-text-container">
                <div class="icon-container">
                    <i class="fa-solid fa-car fa-lg" style="margin-bottom: 50px;"></i>
                </div>
                <div class="info-text-container">
                    <h4 style="font-weight: bold; color:#8D7B68;" >자가 안내</h4>
                    <div class="info-box">
                        <p>신촌역 방면에서  6번출구 우측으로  200m 직진 하시면 됩니다.</p>
                    </div>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="icon-text-container">
                <div class="icon-container">
                    <i class="fa-solid fa-bus fa-lg" style="width: 160px; margin-bottom: 50px; margin-left: -10px;"  ></i>
                </div>
                <div class="info-text-container">
                    <h4 style="font-weight: bold; color:#8D7B68;">버스 안내</h4>
                    <div class="info-box">
                        <p><span style="color: #602be7">(58번 77번 171번 173번)</span> 등 [신촌오거리. 2호선신촌역(중)]에 내려서 200m 오시면 됩니다.</p>
                    </div>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="icon-text-container">
                <div class="icon-container">
                    <i class="fa-solid fa-train-subway fa-lg" style="margin-bottom: 50px;"></i>
                </div>
                <div class="info-text-container">
                    <h4 style="font-weight: bold; color:#8D7B68;">지하철 안내</h4>
                    <div class="info-box">
                        <div style="display: flex; align-items: center;">
                                <span class="material-symbols-outlined" style="color: green;">
                                    counter_2
                                </span>
                                <span style="font-weight: bold; margin-left: 5px;">
                                    호선
                                </span>
                        </div>
                        <p style="margin-top: 15px">
                            6번 출구로 나오셔서 150m 아래로 내려오시면 됩니다.
                        </p>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>


</section>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6de09c99aa19f2a6836f30b3ce2f0cd1"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.55394, 126.9373), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커가 표시될 위치입니다
    var markerPosition  = new kakao.maps.LatLng(37.55394, 126.9373);

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
    // marker.setMap(null);
</script>


<jsp:include page="../common/footer.jsp"/>
