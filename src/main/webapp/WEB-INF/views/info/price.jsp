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
        margin: 20px auto 0;
        /*margin-left: 50px;*/
        border-bottom: 2px solid #8D7B68;

    }

    .spantext {
        font-size: 22px;
        color: #8D7B68;

    }

    .custom-table {
        border-collapse: collapse;
        width: 100%; /* 테이블 가로 너비를 조절 */
        font-size: 15px; /* 글꼴 크기 조절 */
    }

    .custom-table th, .custom-table td {
        border: 2px solid #8D7B68;
        padding: 8px;
        text-align: center; /* 가운데 정렬 추가 */
    }

    .custom-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .custom-table th {
        background-color: #8D7B68;
        color: white;
        font-weight: bold;
    }

    .custom-table caption {
        caption-side: top; /* caption을 표의 상단에 배치 */
        font-weight: bold;
        font-size: 23px;
    }

    .flex-container {
        display: flex;
        flex-direction: column; /* 세로로 나열로 변경 */
        justify-content: space-around; /* 테이블 간격을 조절 */
    }

    #buy_ticket {
        display: inline-block; margin-bottom: 40px;
        cursor: pointer;
        padding: 15px 300px; background-color: #8D7B68; color: white;
        border-radius: 10px; text-decoration: none; font-size: 20px; font-weight: bold;
    }

    #buy_ticket:hover {
        background-color: #685948;
    }

    /* 기존 스타일 유지 */

</style>


<section style="display:flex; width:1280px; margin:auto; flex-direction:column;">
    <div style="margin: 30px;">
        <div class='headname'>
            <h1><i class='fas fa-lightbulb' style='color:#8D7B68'></i> INFO -가격정보 </h1>
        </div>
        <div style="padding: 5px; margin: 20px; " >
<%--        <h3 style="font-weight: bold; margin: 15px"> 집중할 곳 없스카 스터디카페</h3>--%>


            <div style="margin-bottom: 10px; display: flex; align-items: center; margin-left: 5px" >
                <i class="fa-solid fa-location-dot" style="margin-right: 20px; color: #8D7B68; font-size: 40px;"></i>
                <span class="spantext">서울특별시 서대문구 연세로 8-81</span>
            </div>

            <br>

            <div style="margin-bottom: 10px; display: flex; align-items: center;">
                <i class="fa-regular fa-clock" style="margin-right: 16px; color: #8D7B68; font-size: 40px;"></i>
                <span class="spantext">운영시간: 24시 / 연중무휴</span>
            </div>

            <br>

            <div style="margin-bottom: 10px; display: flex; align-items: center;">
                <i class="fa-regular fa-face-smile-wink" style="margin-right: 16px; color: #8D7B68; font-size: 40px;"></i>
                <span class="spantext">편의시설 및 기타시설</span>
            </div>

        <div style="width: 65%;  margin-left: 200px;  ">
            <img src="${path}/images/rest3.png" alt="휴식이미지" style="max-width: 100%; height: auto; ">
        </div>
        </div>


    </div>
    <div style="padding: 30px; border-top: solid 2px #8D7B68; margin: 20px; ">
    <h3 style="margin-bottom: 40px; font-weight: bold;">가격 정보</h3>
    <div class="flex-container"> <!-- 두 개의 표를 나란히 배치하는 컨테이너 -->
        <figure>
            <table class="custom-table">
                <caption style="margin-bottom: 20px";>  <i class="fa-solid fa-square-caret-right"></i>  일반석 가격 정보</caption>
                <tr>
                    <th>이용권</th>
                    <th>가격</th>
                    <th>이용권</th>
                    <th>가격</th>
                </tr>
                <tr>
                    <td>1시간 이용권</td>
                    <td>3,000원</td>
                    <td>20시간 이용권</td>
                    <td>22,000원</td>
                </tr>
                <tr>
                    <td>3시간 이용권</td>
                    <td>6,000원</td>
                    <td>40시간 이용권</td>
                    <td>41,000원</td>
                </tr>
                <tr>
                    <td>6시간 이용권</td>
                    <td>10,000원</td>
                    <td>60시간 이용권</td>
                    <td>58,000원</td>
                </tr>
                <tr>
                    <td>12시간 이용권</td>
                    <td>15,000원</td>
                    <td>80시간 이용권</td>
                    <td>74,000원</td>
                </tr>
            </table>
            <br>
            <figcaption style="color: grey">
                *  가격표는 물가상승으로 변동 될 수 있습니다.
            </figcaption>
        </figure>

        <!-- 새로운 표 추가 -->
        <figure>
            <table class="custom-table">
                <caption style="margin-bottom: 20px";><i class="fa-solid fa-square-caret-right"></i>  지정석 가격정보</caption>

                <tr>
                    <th> 이용권</th>
                    <th>가격</th>
                    <th> 이용권</th>
                    <th>가격</th>
                </tr>
                <tr>
                    <td> 1시간 이용권</td>
                    <td> 3,000원</td>
                    <td> 20시간 이용권</td>
                    <td> 22,000원</td>
                </tr>
                <tr>
                    <td> 3시간 이용권</td>
                    <td> 6,000원</td>
                    <td> 40시간 이용권</td>
                    <td> 41,000원</td>
                </tr>
                <tr>
                    <td> 6시간 이용권</td>
                    <td> 10,000원</td>
                    <td> 60시간 이용권</td>
                    <td> 58,000원</td>
                </tr>
                <tr>
                    <td> 12시간 이용권</td>
                    <td> 15,000원</td>
                    <td> 80시간 이용권</td>
                    <td> 74,000원</td>
                </tr>
            </table>
            <br>
            <figcaption style="color: grey">
                *  가격표는 물가상승으로 변동 될 수 있습니다.
            </figcaption>
        </figure>
    </div>

    <!-- 두 번째 쌍의 표 -->
    <div class="flex-container">
        <!-- 세 번째 표 추가 -->
        <figure>
            <table class="custom-table">
                <caption style="margin-bottom: 20px";>  <i class="fa-solid fa-square-caret-right"></i>  스터디룸 (4인실) 가격정보</caption>
                <tr>
                    <th> 이용권</th>
                    <th> 가격</th>

                </tr>
                <tr>
                    <td> 1시간 이용권</td>
                    <td> 20,000원</td>

                </tr>
                <tr>
                    <td> 2시간 이용권</td>
                    <td> 38,000원</td>

                </tr>
                <tr>
                    <td> 4시간 이용권</td>
                    <td> 75,000원</td>

                </tr>
                <tr>
                    <td> 6시간 이용권</td>
                    <td> 110,000원</td>

                </tr>
            </table>
            <br>
            <figcaption style="color: grey">
                *  가격표는 물가상승으로 변동 될 수 있습니다.
            </figcaption>
        </figure>

        <!-- 네 번째 표 추가 -->
        <figure>
            <table class="custom-table">
                <caption style="margin-bottom: 20px";>  <i class="fa-solid fa-square-caret-right"></i>  스터디룸 (8인실) 가격정보</caption>
                <tr>
                    <th> 이용권</th>
                    <th> 가격</th>

                </tr>
                <tr>
                    <td> 1시간 이용권</td>
                    <td> 40,000원</td>

                </tr>
                <tr>
                    <td> 2시간 이용권</td>
                    <td> 76,000원</td>

                </tr>
                <tr>
                    <td> 4시간 이용권</td>
                    <td> 140,000원</td>

                </tr>
                <tr>
                    <td> 6시간 이용권</td>
                    <td> 200,000원</td>

                </tr>
            </table>
            <br>
            <figcaption style="color: grey">
                *  가격표는 물가상승으로 변동 될 수 있습니다.
            </figcaption>
        </figure>
    </div>

    <!-- 마지막 테이블을 가운데로 위치하고 크기를 조정 -->
    <figure class="custom-table">
        <table class="custom-table">
            <caption style="margin-bottom: 20px";>  <i class="fa-solid fa-square-caret-right"></i>  사물함 가격 정보</caption>
            <tr>
                <th>이용권</th>
                <th>가격</th>
                <th>이용권</th>
                <th>가격</th>
            </tr>
            <tr>
                <td>1주 이용권</td>
                <td>5,000원</td>
                <td>6주 이용권</td>
                <td>30,000원</td>
            </tr>
            <tr>
                <td>2주 이용권</td>
                <td>10,000원</td>
                <td>8주 이용권</td>
                <td>40,000원</td>
            </tr>
            <tr>
                <td>3주 이용권</td>
                <td>15,000원</td>
                <td>10주 이용권</td>
                <td>60,000원</td>
            </tr>
            <tr>
                <td>4주 이용권</td>
                <td>20,000원</td>
                <td>12주 이용권</td>
                <td>90,000원</td>
            </tr>
        </table>
        <br>
        <figcaption style="color: grey;" >
            *  가격표는 물가상승으로 변동 될 수 있습니다.
        </figcaption>
    </figure>
    </div>
    <!-- 좌석 예매 버튼 추가 -->
    <div style="text-align: center; margin: 20px;">
        <div onclick="needLoginPage('${path}/reservation/time')" id="buy_ticket">
            이용권 구매
        </div>
    </div>

</section>

<script>

</script>

<jsp:include page="../common/footer.jsp"/>
