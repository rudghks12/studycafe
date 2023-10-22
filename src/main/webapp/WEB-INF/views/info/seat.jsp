<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

<style>
    .myptext{
        margin: 15px;
        text-align: center;
        color: gray;
        font-weight: bold;
    }
    .swiper-slide {
        background-size: cover; /* 이미지를 화면에 맞게 조절 */
        background-repeat: no-repeat; /* 배경 이미지 반복 제거 */
        background-position: center; /* 배경 이미지 중앙 정렬 */
        height: 100vh; /* 화면 높이의 100%로 설정하여 화면을 꽉 채우도록 함 */
        width: 100vw;
        background-size: 50%;
    }

    .imgtext{
        background: rgba(0, 0, 0, 0.5); /* 검정색에 투명도 50% 적용 */
        padding: 20px; /* 내부 여백 설정 */
        border-radius: 10px; /* 모서리 둥글게 처리 */
        color: white;
        font-size: 40px;
        margin-top: 650px;
        margin-left: 50px;
        width: 600px; /* 가로 길이 설정 */
    }
    .imgtext > p{
        font-size: 60px;
        text-align: left;
        color: white;
        position: relative;
    }
    /* 스와이퍼 pagination 스타일 */
    .swiper-pagination {
        text-align: -webkit-right;  /* 페이지네이션을 오른쪽으로 정렬 */
        position: absolute;
        top: 170px !important;
    }
    /* .swiper-pagination에 속한 .swiper-pagination-bullet의 스타일 수정 (for .swiper-pagination) */
    .swiper-pagination .swiper-pagination-bullet {
        width: 20px; /* 원하는 너비로 조정 */
        height: 20px; /* 원하는 높이로 조정 */
        background-color: whitesmoke;
        margin: 5px 0px; /* 원하는 상하 간격 조정 */
        cursor: pointer;
        top: 0; /* 페이지네이션을 화면 상단에 배치 */
        display: block; /* 변경된 부분 - bullet을 세로 방향으로 배열하기 위해 display:block 설정 */
        text-align: right;
        border-radius: 50%; /* 원 모양으로 보이도록 설정 */
        color: transparent;
        opacity: 0.8;
        position: relative; /* 추가된 부분 - 상대 위치 설정 */
        transition: all 0.3s; /* 원 확대/축소 애니메이션을 위한 트랜지션 효과 추가 */

    }
    .swiper-pagination .swiper-pagination-bullet.last::after {
        display:none;
    }


    /* .swiper-pagination-bullet::before 가상 요소의 스타일 수정 */
    .swiper-pagination .swiper-pagination-bullet::before {
        content: attr(data-text);
        width: auto; /* 텍스트의 길이에 따라 크기가 조절되도록 함 */
        height: auto; /* 텍스트의 높이에 따라 크기가 조절되도록 함 */
        position: absolute;
        opacity: 0.8;
        top: 50%;
        right: 150%; /* 텍스트를 원의 중앙에 위치시킵니다. */
        transform: translateY(-50%);
        white-space: nowrap; /* 텍스트가 한 줄로 나타나도록 함 */
        color: black; /* 텍스트 색상 지정 */
        font-weight: bold;
    }

    /* 활성화된 원의 스타일 */
    .swiper-pagination .swiper-pagination-bullet-active {
        width: 25px; /* 크기 조절 */
        height: 25px; /* 크기 조절 */
        font-weight: bold;
        background-color: white;  // 활성화 된 원은 여전히 하얗게 유지합니다.
    }

    /* 활성화된 원의 텍스트 스타일 */
    .swiper-pagination .swiper-pagination-bullet-active::before {
        font-size: 1.5em; /* 폰트 사이즈 조절 */
        font-weight: bold;
        color: white; // 활성화 된 텍스트는 여전히 하얗게 유지합니다.

    }

    /* .swiper-pagination2에 속한 .swiper-pagination-bullet의 스타일 수정 (for .swiper-pagination2) */
    .swiper-pagination2 .swiper-pagination-bullet {
        /* .swiper-pagination2 내부의 .swiper-pagination-bullet에 대한 스타일 */
        width: 80px;
        height: 6px;
        background-color: white;
        margin: 0 50px;
        cursor: pointer;
        display:block;
        text-align: left;
        border-radius: 0;
        color: transparent;
        top :0;
    }

    .swiper-horizontal>.swiper-pagination-bullets .swiper-pagination-bullet,
    .swiper-pagination-horizontal.swiper-pagination-bullets .swiper-pagination-bullet {
        margin: 40px;
    }
    .swiper-pagination .swiper-pagination-bullet::after {
        content: '';
        position: absolute;
        top: 100%;
        left: 50%;
        width: 1px;
        height: 40px;
        background-color: white;
        transform: translateX(-50%);
    }
    .swiper-horizontal>.swiper-pagination-bullets, .swiper-pagination-bullets.swiper-pagination-horizontal, .swiper-pagination-custom, .swiper-pagination-fraction {
        left: 0;
        width: 97%;
    }

</style>


<section id="seat" style="justify-content: center; display: flex; width: 100%; height: 100vh;">
    <div style="width: 100%; height: 100%; justify-content: center; display: flex;">
        <div style="width: 100%; height: 100%;">
            <div style="justify-content: center; display:flex; width : 100%; height : 100%;">
                <div class="swiper">
                    <div class="swiper mySwiper1">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide" style="background-image: url('${path}/images/info/front4.png'); background-size: cover;">
                                    <div class="imgtext">
                                        <p class="myptext">Front Door</p>
                                        <p class="myptext" style="font-size: 40px">집중할 곳 없스카 입장</p>
                                        <p class="myptext" style="font-size: 15px">문앞에서 부터 따듯한 분위기와 집중이 잘 될 것 같은 분위기를 느낄 수 있습니다.</p>
                                    </div>
                            </div>

                            <div class="swiper-slide" style="background-image: url('${path}/images/info/info1r1.png'); background-size: cover;">
                                <div class="imgtext">
                                    <p class="myptext">Economy Class</p>
                                    <p class="myptext" style="font-size: 40px">일반석(개방형)</p>
                                    <p class="myptext"  style="font-size: 15px">개방형 학습 공간으로 여러 사람들과 마주앉아 <br> 경쟁의식을 느끼며 학습할 수 있는 공간</p>
                                </div>
                            </div>
                            <div class="swiper-slide" style="background-image: url('${path}/images/info/infos1r1.png'); background-size: cover;">
                                <div class="imgtext">
                                    <p class="myptext" >Economy Class</p>
                                    <p class="myptext" style="font-size: 40px">일반석(반밀폐형)</p>
                                    <p class="myptext" style="font-size: 15px">반 밀폐형 학습 공간으로 혼자 집중이 필요할때 <br>학습 프라이빗을 보장받는 공간</p>
                                </div>
                            </div>
                            <div class="swiper-slide" style="background-image: url('${path}/images/info/info7r7.png'); background-size: cover;">
                                <div class="imgtext">
                                    <p class="myptext">Economy Class</p>
                                    <p class="myptext" style="font-size: 40px">일반석(2인석)</p>
                                    <p class="myptext" style="font-size: 15px">친구, 동료, 연인과 함께 학습할 수 있는 공간</p>
                                </div>
                            </div>
                            <div class="swiper-slide" style="background-image: url('${path}/images/info/infos2rs.png'); background-size: cover;">
                                <div class="imgtext">
                                    <p class="myptext">Harvard Class</p>
                                    <p class="myptext" style="font-size: 40px">지정석(1인실)</p>
                                    <p class="myptext" style="font-size: 15px">자신이 원하는 좌석을 변동없이 유지하며 학습에 방해가 될 수 있는  <br> 모든 요소를완벽하게 차단한 완전몰입이 가능한 좌석</p>
                                </div>
                            </div>
                            <div class="swiper-slide" style="background-image: url('${path}/images/info/info2r2.png'); background-size: cover;">
                                <div class="imgtext">
                                    <p class="myptext" >Study Class</p>
                                    <p class="myptext" style="font-size: 40px">스터디룸(4인실)</p>
                                    <p  class="myptext" style="font-size: 15px">화이트보드와 모니터가 구비되어있는 <br>공간으로 그룹스터디에 적합한 공간</p>
                                </div>
                            </div>

                            <div class="swiper-slide" style="background-image: url('${path}/images/info/info3r3.png'); background-size: cover;">
                                <div class="imgtext">
                                    <p class="myptext" >Study Class</p>
                                    <p class="myptext" style="font-size: 40px">스터디룸(8인실)</p>
                                    <p class="myptext" style="font-size: 15px">공통된 목표를 갖고 있는 <br>그룹 학습자들을 위한 공간</p>
                                </div>
                            </div>

                            <div class="swiper-slide" style="background-image: url('${path}/images/info/info6r6.png'); background-size: cover;">
                                    <div class="imgtext">
                                        <p class="myptext" >Cafeteria</p>
                                        <p class="myptext" style="font-size: 40px">카페테리아(휴식공간)</p>
                                        <p class="myptext" style="font-size: 15px">고급진 커피와 사람들과의 가벼운 소통  <br>기분좋고 맛있는 간식들이 준비되어 있습니다. </p>
                                    </div>
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>

<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
    var paginationTexts = ['없스카 정문','일반석(개방형)', '일반석(반밀폐형)','일반석(2인석)', '지정석', '스터디룸(4인룸)', '스터디룸(8인룸)','카페테리아' ];
    var swiper1 = new Swiper(".mySwiper1", {
        slidesPerView: 1,
        spaceBetween: 30,
        loop: true,
        centeredSlides: true,
        autoplay: {
            delay: 4000,
            disableOnInteraction: false,
        },
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
            renderBullet: function (index, className) {
                return '<span class="' + className + '" data-text="' + paginationTexts[index] + '"></span>';
            }
        },


        on:{
            slideChange:function(){
                var activeIndex = this.activeIndex % paginationTexts.length;
                var bullets = document.querySelectorAll('.swiper-pagination-bullet');
                bullets.forEach(function(bullet, index) {
                    // Remove last class from all bullets
                    bullet.classList.remove('last');
                    // If it's the last bullet, add 'last' class
                    if(index === paginationTexts.length - 1) {
                        bullet.classList.add('last');
                    }
                });

                activeIndex = this.activeIndex % 5;
                var texts = document.querySelectorAll('.swiper-pagination-texts > div');
                texts.forEach(function(textDiv, index) {
                    if (index === activeIndex) textDiv.classList.add('active');
                    else textDiv.classList.remove('active');

                    // Add style to adjust the font size of the text in the active bullet.
                    if (bullet.querySelector('::before')) {
                        if (bullet.classList.contains('active')) {
                            bullet.querySelector('::before').style.fontSize = "2em";
                        } else {
                            bullet.querySelector('::before').style.fontSize = "1em";
                        }
                    }

                });
            }
        }

    });
    document.addEventListener('DOMContentLoaded', function() {
        var bullets = document.querySelectorAll('.swiper-pagination-bullet');
        bullets[bullets.length - 1].classList.add('last');
    });


</script>


<jsp:include page="../common/footer.jsp"/>