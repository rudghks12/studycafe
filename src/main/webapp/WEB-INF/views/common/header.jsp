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
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<c:set var="fullUrl" value="${protocol}://${host}:${port}${pageContext.request.contextPath}" />

<html>
<head>
    <title>집중할 곳 없스카</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://use.fontawesome.com/releases/v6.4.2/js/all.js"></script>

</head>

<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<style>
    @font-face {
        font-family: 'SOYOMapleBoldTTF';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2310@1.0/SOYOMapleBoldTTF.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }

    *{
        font-family: 'SOYOMapleBoldTTF';
    }

    #header {
        background-color: rgba(8, 21, 28, 0.48);
    }
    .navbar {
        height: 5rem !important; /* 원하는 높이 값으로 설정 */
    }

    #mainNav {
        min-height: 2.5rem;
        background-color: rgba(8, 21, 28, 0.48) ;
        box-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }
    #mainNav .navbar-toggler {
        padding: 0.75rem;

        border: 1px solid #ffffff;
    }
    #mainNav .navbar-toggler:focus {
        outline: none;
    }
    #mainNav .navbar-brand {
        font-weight: 700;
        padding: 0.9rem 0;
    }
    #mainNav .navbar-nav .nav-item:hover {
        outline: none;
        background-color: transparent;
    }
    #mainNav .navbar-nav .nav-item:active,
    #mainNav .navbar-nav .nav-item:focus {
        outline: none;
        background-color: transparent;
    }
    @media (min-width: 992px) {
        #mainNav {
            padding-top: 0;
            padding-bottom: 0;
            border-bottom: none;
            background-color: transparent;
            transition: background-color 0.3s ease-in-out;
        }
        #mainNav .navbar-brand {
            padding: 0.5rem 0;
        }
        #mainNav .nav-link {
            transition: none;
            padding: 2rem 1.5rem;
        }
        #mainNav .nav-link:active {
        }
        #mainNav.navbar-shrink {
            background-color: rgba(8, 21, 28, 0.48);
        }
        #mainNav.navbar-shrink .navbar-brand {
        }
        /*바뀌는구간*/
        #mainNav.navbar-shrink .nav-link {
            /*color: #000;*/
            /*padding: 1.5rem 1.5rem 1.25rem;*/
            /*border-bottom: 0.25rem solid transparent;*/
        }
        #mainNav.navbar-shrink .nav-link:hover {
        }
        #mainNav.navbar-shrink .nav-link:active {
        }
        #mainNav.navbar-shrink .nav-link.active {
            outline: none;
            border-bottom: 0.25rem solid #ffffff;
        }
    }
    .masthead {
        position: relative;
        width: 100%;
        height: auto;
        min-height: 35rem;
        padding: 15rem 0;
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3) 0%, rgba(0, 0, 0, 0.7) 90%, #000 100%), url('${path}/images/mainbanner1.png');
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: scroll;
        background-size: cover;
    }
    .masthead h1, .masthead .h1 {
        font-family: "Varela Round", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
        font-size: 2.5rem;
        line-height: 2.5rem;
        letter-spacing: 0.8rem;
        background: linear-gradient(rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0));
        -webkit-text-fill-color: transparent;
        -webkit-background-clip: text;
        background-clip: text;
    }
    .masthead h2, .masthead .h2 {
        max-width: 20rem;
        font-size: 1rem;
    }
    /* 추가된 CSS: Dropdown을 hover하면 떨어지도록 설정 */
    .nav-item.dropdown:hover .dropdown-menu {
        display: block;
    }
    #mainNav .navbar-nav .nav-item a.nav-link {
        font-size: 20px; /* 여기에 원하는 글자 크기를 설정하세요. */
    }


    /* 입퇴실 버튼 */
    #fixed {
        display: flex; justify-content: center; align-items: center;
        position: fixed;
        top: 75%;
        right: 5%;
        width: 100px;
        height: 100px;
        border-radius: 100%;
        color: white;
        font-size: 25px;
        text-align: center;
        z-index: 999999999;
        box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.2);
        /* 호버 효과 추가 */
        transition: background-color 0.3s ease-in-out; /* 배경 색상 변화를 부드럽게 만들기 위한 트랜지션 효과 */

        /* 기본 배경 색상 */
        background-color: #8D7B68;
    }
    #fixed:hover {
        /* 호버 상태에서의 배경 색상 */
        background-color: #685948; /* 원하는 호버 배경 색상을 지정하세요 */
        cursor: pointer;
    }
    #scrollUp {
        position: fixed;
        /*position: sticky;*/
        display: flex; justify-content: center; align-items: center;
        top: 90%;
        right: 6%;
        width: 60px;
        height: 60px;
        border-radius: 100%;
        color: white;
        font-size: 25px;
        text-align: center;
        z-index: 999999999;
        box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.2);
        /* 호버 효과 추가 */
        transition: background-color 0.3s ease-in-out; /* 배경 색상 변화를 부드럽게 만들기 위한 트랜지션 효과 */

        /* 기본 배경 색상 */
        background-color: #8D7B68;
    }

    #scrollUp:hover {
        /* 호버 상태에서의 배경 색상 */
        background-color: #685948; /* 원하는 호버 배경 색상을 지정하세요 */
        cursor: pointer;
    }

    /* 메뉴 부분 스타일 */
    .ui-menu {
        width: 800px;
        height: 80px;
    }

    .menu {
        list-style-type: none;
        height: 100%;
    }


    .menu > li {
        position: relative;
        float: left;
        width: 20%;
        height: 50px;
        text-align: center;
        margin-top: 20px;
        padding-bottom: 56px;
    }

    .menu > li > a {
        position: relative;
    }

    .menu-top {
        text-decoration: none;
        color: white;
        font-size: 1.5em;
        font-weight: bold;
        height: 100%;
        display: block;
        vertical-align: middle;
    }

    .menu > li > div > ul {
        list-style-type: none;
        padding: 0;
        display: none;
        position: absolute;
        top: 100%;
        text-align: center;
        width: 100%;
    }

    .menu > li:hover .sub-menu {
        display: block;
    }

    /* 하위메뉴 */
    .menu > li > div > ul.sub-menu {
        position: absolute;
        left: 0;
        width: 100%;
        height: 250px;
        text-align: center;
        z-index: 999;
    }

    .menu > li > div > ul.sub-menu a {
        color: white;
        text-decoration: none;
    }

    .menu > li > div > ul.sub-menu li {
        color: white;
        text-decoration: none;
        font-size: 20px;
        margin-bottom: 30px;
    }

    .sub-menu-div {
        width: 100%;
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease-in-out;
    }

    .sub-menu li {
        cursor: pointer;
    }


    /* 로그인 했을때 나오는 form */
    #after-login-form {
        background-color: white;
        width: 100px;
        height: 60px;
        border-radius: 15px;
        box-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        cursor: pointer;
        align-items: center;
        display: block;
    }

    /* 회원 이미지 스타일 */
    #user-image {
        border: 1px solid black;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        overflow: hidden;
        margin-top: 10px;
    }

    /* 로그인 했을때 나오는 form */
    .mypage-dropdown-menu {
        box-shadow: 1px 1px 5px black;
        background-color: white;
        border-radius: 15px;
        width: 150px;
        margin-top: 10px;
        overflow: hidden;
    }

    .mypage-menu a {
        padding: 7.5px;
        border-bottom: 1px solid gray;
    }

    .mypage-menu a:hover{
        background-color: #eeeeee;
    }

    .mypage-menu a:last-child {
        border-bottom: none;
    }

</style>
<body>

<%--principal 로그인된 사용자 가져옴--%>
<security:authentication property="principal" var="authority"/>

<div id="header">
    <div style="position: fixed; background-color: rgba(0,0,0,0.5);
        height: 250px; top: 80px; width: 100%; z-index: 100; display: none;"
         id="submenu-background"
    >
    </div>
    <header class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
        <div class="container px-4 px-lg-5" style="min-width: 1280px;">
            <a class="navbar-brand" href="#page-top">
                <li class="nav-item" style=" list-style-type: none;">
                    <a class="nav-link" href="${ path }/">
                        <c:if test="${pageContext.request.requestURL != fullUrl.concat('/WEB-INF/views/home.jsp')
                            && pageContext.request.requestURL != fullUrl.concat('/WEB-INF/views//info/seat.jsp')}"
                        >
                            <img id="logo" src="${path}/images/logoblack.jpg" style="width: 40px; cursor: pointer;">
                        </c:if>
                        <c:if test="${pageContext.request.requestURL == fullUrl.concat('/WEB-INF/views/home.jsp')
                            || pageContext.request.requestURL == fullUrl.concat('/WEB-INF/views//info/seat.jsp')}"
                        >
                            <img id="logo" src="${path}/images/logowhite.png" style="width: 40px; cursor: pointer;">
                        </c:if>
                    </a>
                </li>
            </a>

            <!-- 메뉴 부분 -->
            <div class="ui-menu">
                <ui class="menu">
                    <!-- INFO 메뉴 -->
                    <li >
                        <a class="menu-top" href="${ path }/info/seat" > INFO </a>

                        <div class="sub-menu-div">
                            <ul class="sub-menu">
                                <li><a href="${ path }/info/seat">좌석 정보</a></li>
                                <li><a href="${ path }/info/come">오시는길</a></li>
                                <li><a href="${ path }/info/price">가격 정보</a></li>
                            </ul>
                        </div>
                    </li>

                    <!-- 예약 메뉴 -->
                    <li>
                        <a class="menu-top" onclick="needLoginPage(`${path}/reservation/time`)"
                           style="cursor: pointer">
                            이용권
                        </a>

                        <div class="sub-menu-div">
                            <ul class="sub-menu">
                                <li><a onclick="needLoginPage(`${path}/reservation/time`)">시간제</a></li>
                                <li><a onclick="needLoginPage(`${path}/reservation/selectSeat`)">기간제</a></li>
                                <li><a onclick="needLoginPage(`${path}/reservation/selectRoom`)">스터디룸</a></li>
                                <li><a onclick="needLoginPage(`${path}/reservation/selectLocker`)">사물함</a></li>
                            </ul>
                        </div>
                    </li>

                    <li>
                        <a class="menu-top" href="${ path }/community/mainpage">커뮤니티</a>

                        <div class="sub-menu-div">
                            <ul class="sub-menu">
                                <li><a href="${ path }/community/listpage?kind=자유게시판">자유게시판</a></li>
                                <li><a href="${ path }/community/listpage?kind=스터디모집">스터디 모임</a></li>
                                <li><a href="${ path }/community/listpage?kind=공부법공유">공부법 공유</a></li>
                                <li><a href="${ path }/community/listpage?kind=합격후기">합격 후기</a></li>
                            </ul>
                        </div>
                    </li>

                    <li>
                        <a class="menu-top" href="${ path }/customer/faq">고객센터</a>
                        <div class="sub-menu-div">
                            <ul class="sub-menu">
                                <li><a href="${ path }/customer/faq">자주 묻는 질문</a></li>
                                <li><a href="${ path }/customer/notice/list">공지사항</a></li>
                                <li><a href="${ path }/customer/ask">문의하기</a></li>
                                <li><a href="${ path }/customer/event/list">이벤트</a></li>
                            </ul>
                        </div>
                    </li>
                </ui>
            </div>


            <!-- 로그인, 회원가입 부분 -->
            <div>
                <!-- 로그인 안했을 경우 -->
                <security:authorize access="isAnonymous()">
                    <div id="login_div" style="color: white; justify-content: end;">
                        <span id="login" style="cursor: pointer; font-size: 12px;">로그인</span>
                        &nbsp; | &nbsp;
                        <span id="signUp" style="cursor: pointer; font-size: 12px;" onclick="location.href='${ path }/agree'">회원가입</span>
                    </div>
                </security:authorize>

                <!-- 로그인 했을 경우 -->
                <security:authorize access="isAuthenticated()">
                    <div id="after-login-form">
                        <div id="dropdown-trigger" style="display: flex; align-items: center; margin: 0px 15px;">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" aria-hidden="true"
                                 role="presentation" focusable="false" id="ham_menu"
                                 style="display: block; fill: none; height: 16px; width: 16px;
                                 stroke: currentcolor; stroke-width: 3; overflow: visible;
                                 margin-right: 10px; margin-top: 10px;">
                                <g fill="none"><path d="M2 16h28M2 24h28M2 8h28"></path></g></svg>
                            <!-- 회원 이미지 정보 -->
                            <div id="user-image">
                                <input type="hidden" value="${authority.image}" id="user_image_value">
                                <c:if test= '${authority.email.contains("KAKAO_")}'>
                                    <img style="width: 100%; height: 100%; object-fit: cover; background-color: white;" src="${authority.image}" style="width: 150px; height: 150px; object-fit: fill">
                                </c:if>
                                <c:if test="${authority.email.contains('NAVER_')}">
                                    <img style="width: 100%; height: 100%; object-fit: cover; background-color: white;" src="${authority.image}" style="width: 150px; height: 150px; object-fit: fill">
                                </c:if>
                                <c:if test= '${ not authority.email.contains("KAKAO_") and not authority.email.contains("NAVER_")}'>
                                    <img style="width: 100%; height: 100%; object-fit: cover; background-color: white;" src="${authority.image.substring(0, authority.image.indexOf('upload/') + 7).concat("c_fill,h_150,w_150/").concat(authority.image.substring(authority.image.indexOf('upload/') + 7))}">
                                </c:if>
                            </div>
                        </div>

                        <!-- 마이페이지 메뉴 -->
                        <div id="dropdown-menu" class="mypage-dropdown-menu" style="display:none;">
                            <li class="mypage-menu" style="list-style-type: none; cursor: pointer;">
                                <!-- 회원들한테 보이는 메뉴 -->
                                <a class="dropdown-item" href="${ path }/myPage">회원 정보 관리</a>

                                <security:authorize access='hasRole("ROLE_USER")'>
                                    <a class="dropdown-item" href="${ path }/useHistory">이용 내역</a>
                                    <a class="dropdown-item" href="${ path }/paymentHistory">결제 내역</a>
                                </security:authorize>

                                <!-- 관리자한테 보이는 메뉴 -->
                                <security:authorize access='hasRole("ROLE_ADMIN")'>
                                    <a class="dropdown-item" href="${ path }/admin/modseatingchart">좌석배치</a>
                                    <a class="dropdown-item" href="${ path }/admin/usagestatus">이용현황</a>
                                    <a class="dropdown-item" href="${ path }/admin/usermanage">유저관리</a>
                                    <a class="dropdown-item" href="${ path }/admin/salesstatus">매출현황</a>
                                </security:authorize>


                                <a class="dropdown-item" href="#" onclick="handleLogout()">로그아웃</a>
                            </li>
                        </div>
                    </div>
                    <security:csrfInput/>
                </security:authorize>
            </div>
        </div>
    </header>
</div>


<form action="/studycafe/logout" method="post" id="logoutForm"><security:csrfInput/></form>


<!-- 입퇴실, top 버튼  -->
<div id="fixed">입퇴실</div>
<div id="scrollUp">▲</div>

<!-- 영근오빠꺼  -->
<c:if test="${pageContext.request.requestURL != fullUrl.concat('/WEB-INF/views/home.jsp')
             && pageContext.request.requestURL != fullUrl.concat('/WEB-INF/views//info/seat.jsp')}"
>
<div style="justify-content: center; display: flex;">
    <div style="width: 1280px;">

        </c:if>

        <%@ include file="/WEB-INF/views/common/modal/loginModal.jsp"%>
        <%@ include file="/WEB-INF/views/common/modal/fixedModal.jsp"%>

        <script>
            console.log(`${path}`)
            console.log(`${pageContext.request.requestURL}`)

            if(`${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views/home.jsp')}` &&
                `${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views//info/seat.jsp')}`){
                $('#mainNav').css('background-color', 'rgba(255,255,255,1)');
                $('.menu-top').css('color', 'black');
                $('.sub-menu li a').css('color', 'black');
                $('#submenu-background').css('background-color', 'white');
                $('#login_div').css('color', 'black');
                document.body.style.marginTop = '110px';
            }

            $(window).scroll(function() {
                if(`${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views/home.jsp')}` &&
                    `${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views//info/seat.jsp')}`){

                } else {
                    if ($(this).scrollTop() > 0) {
                        $('#mainNav').css('background-color', 'rgba(0,0,0,0.5)');
                    } else {
                        $('#mainNav').css('background-color', 'rgba(0,0,0,0');
                    }
                }
            })

            window.addEventListener('DOMContentLoaded', event => {
                // 헤더 색 변경 시켜줌  => 홈페이지나 좌석페이지가 아닌 경우
                const header = $('#mainNav');
                const subMenus = $('.menu > li > div > ul.sub-menu');

                header.mouseenter(function() {
                    if(`${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views/home.jsp')}` &&
                        `${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views//info/seat.jsp')}`){
                    } else {
                        header.css('background-color', 'rgba(0,0,0,0.5');
                    }
                    header.css('box-shadow', 'none');
                    $('#submenu-background').css('box-shadow', '2px 2px 4px rgba(0,0,0,0.5)');
                })

                header.mouseleave(function() {
                    if(`${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views/home.jsp')}` &&
                        `${pageContext.request.requestURL}` !== `${fullUrl.concat('/WEB-INF/views//info/seat.jsp')}`){
                    } else {
                        header.css('background-color', 'rgba(0,0,0,0');
                    }
                    header.css('box-shadow', '2px 2px 4px rgba(0,0,0,0.5)');
                    $('#submenu-background').css('box-shadow', 'none');
                })

                $('.ui-menu').mouseenter(function() {
                    subMenus.css('display', 'flow')
                    $('#submenu-background').css('display', 'flow')
                })

                $('.ui-menu').mouseleave(function() {
                    subMenus.css('display', 'none')
                    $('#submenu-background').css('display', 'none')
                })


                // 로그인, 로그아웃 모달
                $(document).ready(function() {
                    $("#login").click(function() {
                        $("#loginModal").modal("show");
                    });

                    $("#fixed").click(async function () {
                        let result = "";

                        if (`${authority}` !== 'anonymousUser') {
                            await $.ajax({
                                type: 'GET',
                                url: '${path}/defaultCheck',
                                contentType: 'application/json;charset=UTF-8',
                                beforeSend: (xhr) => {
                                    xhr.setRequestHeader($('meta[name="_csrf_header"]').attr('content'),
                                                        $('meta[name="_csrf"]').attr('content'));
                                },
                                success: (data) => {
                                    console.log(data);
                                    result = data;
                                },
                                error: () => {
                                    console.log('error');
                                    result = "none";
                                }
                            });

                            // console.log(result)

                            if (result === "none")
                                $('#fixedModal .ment').text('사용하실 좌석을 선택해주세요.')
                            else {
                                if (result === 'time') {
                                    $('.ment').text('일반석 이용중')
                                    $('#time_seat').css('width', '100%');
                                    $('#fixed_seat').css('display', 'none');
                                    $('#inout_buttons').animate({bottom: '30px'}, 500);

                                } else if (result === "fixed") {
                                    $('.ment').text('지정석 이용중')
                                    $('#fixed_seat').css('width', '100%');
                                    $('#time_seat').css('display', 'none');
                                    $('#inout_buttons').animate({bottom: '30px'}, 500);
                                }

                                $("#checkInButton").hide();
                                $("#checkOutButton").show();
                            }
                            $("#fixedModal").modal("show");
                        } else
                            $("#loginModal").modal("show");
                    });
                });

                // 상단으로 이동하는 스크립트
                document.getElementById('scrollUp').addEventListener('click', function() {
                    window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                });

                // 부모메뉴 마우스 올라갔을때 하위메뉴 보이는 스크립트
                $(document).ready(function() {
                    $('.ui-menu').hover(function() {
                        $(this).find('.sub-menu-div').show();
                    }, function() {
                        $(this).find('.sub-menu-div').hide();
                    });
                });

            });

            const handleLogout = () => {
                $('#logoutForm').submit();
            }

            const needLoginPage = (link) => {
                if(`${authority}` !== 'anonymousUser')
                    window.location.href = link;
                else
                    $("#loginModal").modal("show");
            }

            $('#dropdown-trigger').click(function() {
                if($('#dropdown-menu').css('display') === 'block')
                    $('#dropdown-menu').css('display', 'none' );
                else
                    $('#dropdown-menu').css('display', 'block');
            });

            $(document).on('click', function(event) {
                if (!$(event.target).closest('#dropdown-menu, #user-image, #ham_menu').length && !$(event.target).is('#dropdown-trigger')) {
                    $('#dropdown-menu').css('display', 'none');
                }
            });

        </script>