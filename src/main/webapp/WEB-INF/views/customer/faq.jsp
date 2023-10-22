<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">



<style>
    .faq-section {
        background-color: #fff;
        border: 1px solid #9fa4a8;
        border-radius: 10px;
        padding: 10px;
        margin: 15px 0;
        font-size: 16px;


    }


    .button {
        display: inline-block;
        padding: 10px 170px;
        border-radius: 20px;
        margin: 10px auto;
        background-color: #8D7B68;
        color: white;
        text-decoration: none;
    }
    .button:hover {
        background-color: #685948;
    }


    .faq-list {
        list-style-type: none;
    }
    /*!* 미디어 쿼리 추가 - 화면 너비가 768px 미만일 때 *!*/
    /*@media (max-width: 768px) {*/
    /*    .faq-containers {*/
    /*        flex-direction: column;*/
    /*        align-items: stretch; !* 추가된 속성 *!*/
    /*    }*/
    /*}*/
    .faq-containers {
        display: flex;
        justify-content: space-between;
        align-items: start;
        gap: 20px;
        width: 1100px; /* 고정된 너비 */
        padding: 30px 30px -20px 30px; /* Top, Right, Bottom, Left padding */
        margin-left: 70px;
    }



    .faq-section, .contact-section {
        flex: 1;
        height: 350px;
        padding: 50px; /* 두 섹션 모두에 대해 패딩을 동일하게 설정 */
    }

    .faq-section {
        background-color: #fff;
        border: 1px solid #9fa4a8;
        border-radius: 10px;
        padding: 25px;
        margin: 15px 0;
        font-size: 16px;

        margin-left: 60px; /* Adjust the margin as needed */
    }

    .faq-section ul {
        text-align: center;
        margin-left: 32px;
    }
    .contact-section {

        padding-top: 20px; /* 원하는 값으로 조절하세요 */
        margin-top: 15px;
        background-color: #f0f0f0;
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 20px;

    }
    button.rounded {
        border-radius: 15px;

        margin-bottom: 15px;
        background-color: #8D7B68 ;
        color: white;
        padding: 5px 20px;
        cursor: pointer;
        transition: background-color 0.6s, color 0.3s;
    }
    .button.rounded:hover {
        background-color: #685948;
        color: white;

    }
    .button-wrapper {
        text-align: center;
    }
    .button-container {
        text-align: center;
    }
    .button-container a {
        display: inline-block;  /* 버튼 모양을 만들기 위해 필요합니다. */
        padding: 10px 20px;  /* 내부 패딩을 추가합니다. */
        background-color: lightgrey;  /* 배경색을 회색으로 설정합니다. */
        color: black;  /* 글씨 색상을 검은색으로 설정합니다. */
        text-decoration: none;  /* 링크 밑줄 제거 */
        border-radius: 10px;  /* 모서리를 둥글게 깍습니다. */
        transition: background-color 0.3s, color 0.3s;   /* 부드러운 전환 효과를 위한 속성입니다.*/

    }

    .button-container a:hover {
        background-color: #9D6529;   /* 마우스 오버시 배경색을 갈색으로 변경합니다.*/
        color:white;   /* 마우스 오버시 글자 색상은 흰색으로 변경합니다.*/
    }
    .faq-toggle {
        font-size: 20px;
        cursor: pointer;
        float: right;
        margin-top: 70px;
    }
    .faq-content {
        display: none;
        background-color: whitesmoke; /* 배경색을 회색으로 설정 */
        padding: 20px; /* 콘텐츠 주변에 패딩 추가 */
        border-radius: 20px; /* 모서리를 둥글게 깍습니다 */
    }

    .faq-content.active {
        display: block;
    }
    .faq-item .title {
        color: black;
        font-weight: bold;
        margin-top: -18px;
    }

    .faq-item .content {
        color: #9D6529;
    }
    .faq-item p {
        color: black;
    }

    .active .faq-content {
        display: block;
    }
    .faq-item {
        font-size: 16px;  /* 글자 크기를 키웁니다. */
        border-bottom: 1px solid #888;  /* 하단에 회색 선을 추가합니다. */
        padding: 10px 0;  /* 위아래 패딩을 추가하여 공간을 만듭니다. */

        margin-right: 36px;
        margin-left: 65px;
        text-align: left;  /* 텍스트를 왼쪽으로 정렬합니다. */
    }
    .faq-item a {
        text-decoration: none;
        color: black;
        cursor: pointer;
    }

    .faq-item p {
        color: gray;
    }

    .faq-link{
        color: black;
        text-decoration: none;

    }
    .button.rounded {
        margin-bottom: 80px; /* 원하는 여백 크기로 조절하세요 */
        border: none;

    }
</style>



<section>
        <br><br><br>
        <h1>무엇을 도와드릴까요?</h1>

        <div class="faq-containers">

            <div class="faq-section">
                <h4 style="text-align: center" >자주 묻는 질문 (FAQ)</h4>
                <br>
                <ul class="faq-list">
                    <c:forEach var="faq" items="${faqList}" begin="0" end="4">
                    <li style="margin-bottom: 20px; display: flex; align-items: center;"><i class="fa-regular fa-circle-question"
                                                         style="background-color: white; color: burlywood; margin-right: 10px; font-size: 21px;">

                    </i>
                        <a href="${pageContext.request.contextPath}/customer/faq?kind=${faq.kind}&no=${faq.no}"
                           class="faq-link" style="font-size: 16px; "> ${faq.title}</a>
                    </li>
                    </c:forEach>
            </div>


            <div class="contact-section">
                <p>
                    <p style="font-weight: bold; font-size: 30px; text-align: center">고객센터 <span style="font-weight: bold; font-size: 28px; color: #81582D">09:00 ~ 18:00</span> </p>

                </p>
                <br/>
               <li style="font-size: 18px; color: #9D6529;" > 평일 / 전체 문의상담가능<br/></li>
                <br>
                <li style="font-size: 18px; color: #9D6529;">주말 / 오전 10:00 ~ 오후 02:00까지만 상담가능</li><br/>
                </h4>

                <p>
                    <i class="fa-solid fa-phone fa-2x" style="color: #9D6529; margin-left: 10px; margin-right: 20px" ></i><span style="font-size: 22px; font-weight: bold; color: #9D6529" > 1757-7777</span>
                </p>


                <div class="button-wrapper">
                    <a href="ask" class="button">이메일 문의하기</a>
                </div>
            </div>
        </div>

        <br><br><br>
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/customer/faq">전체</a>
            <a href="${pageContext.request.contextPath}/customer/faq?kind=결제" data-category="결제">결제</a>
            <a href="${pageContext.request.contextPath}/customer/faq?kind=취소환불" data-category="취소환불">취소/환불</a>
            <a href="${pageContext.request.contextPath}/customer/faq?kind=로그인회원정보" data-category="로그인회원정보">로그인/회원정보</a>
            <a href="${pageContext.request.contextPath}/customer/faq?kind=기타서비스" data-category="기타서비스">기타서비스</a>

        </div>



            <!-- 선택한 kind에 해당하는 FAQ의 제목(title)만 여기에 표시합니다. -->


            <div style="width: 90%; margin: 0 auto; margin-bottom: 120px;">

            <c:forEach var="faq" items="${faqList}">
                <div class="faq-item" data-no="${faq.no}">
                    <div>
                        <p class="title"  style="cursor: pointer;">
                            <i class="fa-regular fa-circle-question fa-2x" style="background-color: white; color: burlywood; margin-right: 10px; margin-top: 55px; font-size: 20px; text-align: center"></i>
                            ${faq.title}
                            <i class="fas fa-chevron-down faq-toggle"></i></p>
                        <div class="content faq-content">${faq.content}</div>
                    </div>
                </div>
            </c:forEach>
<%--                <div class="faq-item" >--%>
<%--                    <div>--%>
<%--                        <p class="title">${faq.title}<i class="fas fa-chevron-down faq-toggle"></i></p>  <!-- 'title' 필드를 참조하여 출력 -->--%>
<%--                        <div class="content faq-content">${faq.content}</div>  <!-- 'content' 필드를 참조하여 출력 -->--%>
<%--                    </div>--%>
<%--                </div>--%>

    </div>

<div style="text-align: center" >
    <button class="button rounded"  onclick="loadMoreFaq()">더 보기</button>
</div>

</section>
<script>
    // 모든 .faq-item 요소에 대해 반복합니다.
    document.querySelectorAll('.faq-item').forEach(function(item) {
        // 각 .faq-item 요소에 클릭 이벤트 리스너를 추가합니다.
        const title = item.querySelector('.title');
        const content = item.querySelector('.content');

        title.addEventListener('click', function() {
            // 클릭된 .faq-item 요소의 .content를 토글합니다.
            content.classList.toggle('active');
        });
    });

    window.onload = function() {
        var no = new URL(window.location.href).searchParams.get("no");
        if(no) {
            var content = document.querySelector(".faq-item[data-no='" + no + "'] .content");
            if(content) {
                content.classList.add("active");
            }
        }

    let currentPage = 0;
    const ITEMS_PER_PAGE = 10;

    // 처음엔 첫번째 페이지까지만 보여줍니다.
    showItems(currentPage);

    document.querySelector('.button.rounded').addEventListener('click', function() {
        currentPage++;
        showItems(currentPage);
    });

    function showItems(pageIndex) {
        const startIdx = pageIndex * ITEMS_PER_PAGE;
        const endIdx = startIdx + ITEMS_PER_PAGE;

        const faqItems= Array.from(document.querySelectorAll(".faq-item"));

        faqItems.forEach((item, index) => {
            if(index >= startIdx && index < endIdx){
                item.style.display= "";
            } else if(index >= endIdx){
                item.style.display= "none";
            }
        });

        if(endIdx >= faqItems.length){
            document.querySelector('.button.rounded').style.display= 'none';
        }
    }
    };



</script>






<jsp:include page="../common/footer.jsp"/>
