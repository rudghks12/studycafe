<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="components/myPageHeader.jsp"/>

<title>마이페이지</title>

<section id="paymentPage">
    <div>
        <div style="border-top: 2px solid #8D7B68; margin-top: 5px;"></div>
        <div style="text-align: center; margin: 50px 0px; font-size: xxx-large; color: #8D7B68; font-weight: bold;">
            결제 내역
        </div>
    </div>
    <c:choose>
    <c:when test="${empty list}">
        <div style="text-align: center; margin-top: 100px; margin-bottom: 100px;">
            <p style="font-size: 24px; font-weight: bold;">결제내역이 없습니다.</p>
        </div>
    </c:when>
    <c:otherwise>
            <table class="table table-striped" style="margin-top: 30px; width:100%; text-align: center">
                <thead>
                <tr>
                    <td>결제일시</td>
                    <td>결제상태</td>
                    <td>결제수단</td>
                    <td>결제액</td>
                    <td>구매상품</td>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${list}" varStatus="loop">
                        <tr id="payment-${loop.index}" style="cursor: pointer;" onclick="showPaymentModal(`${item.id}`)">
                            <td><fmt:formatDate value="${item.paidAt}" pattern="yy년 MM월 dd일 HH:mm:ss"/></td>
                            <td>${not empty item.paidAt ? "결제완료" : "결제중"}</td>
                            <td>${item.method}</td>
                            <td><fmt:formatNumber value="${item.cash}" groupingUsed="true"/>원</td>
                            <td>${item.ticketName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div style="justify-content: center; display: flex; margin: 30px 0;">
                <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('1')">
                            <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                        </a></li>
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.prevPage }')">
                            <span class="material-symbols-outlined">keyboard_arrow_left</span>
                        </a></li>
                        <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                            <c:if test="${empty param.page}">
                                <c:if test="${current == 1}">
                                    <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                                </c:if>
                                <c:if test="${current != 1}">
                                    <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }')">${current}</a></li>
                                </c:if>
                            </c:if>
                            <c:if test="${not empty param.page}">
                                <c:if test="${current == param.page}">
                                    <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                                </c:if>
                                <c:if test="${current != param.page}">
                                    <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }')">${current}</a></li>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.nextPage }')">
                            <span class="material-symbols-outlined">keyboard_arrow_right</span>
                        </a></li>
                        <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.maxPage }')">
                            <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                        </a></li>
                    </ul>
                </nav>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<style>
    #paymentPage {
        min-height: 750px;
    }

    .page-link {
        color: black;
        cursor: pointer;
        /*font-weight: bold;*/
    }

    .page-link.disabled {
        color: white;
        background-color: #8D7B68;
        border-color: #8D7B68;
    }

    .page-link:hover:not(.page-link.active) {
        color: #8D7B68;
    }

    .page-link:focus {
        box-shadow: none;
    }

    .table {
        border-top: 1px solid #ddd;
    }

    [id^="payment-"]:hover td {
        background-color: rosybrown;
    }
</style>

<script>
    const showPaymentModal = (orderId) => {
        fetch(`https://api.tosspayments.com/v1/payments/` + orderId, {
            method: 'GET',
            headers: {
                'Authorization': 'Basic dGVzdF9za19aNjFKT3hSUVZFMTlsRWVwR2p5VlcwWDliQXF3Og=='
            }
        })
        .then(response => response.json())
        .then(data => {
            $('#payment_method').text(data.method);
            $('#payment_card').text(data.method.includes('카드') ? data.card.number : '없음');
            $('#payment_cash').text(data.totalAmount.toLocaleString() + '원');

            if(data.orderName.includes('시간 이용권')) {
                $('#payment_name').text(data.orderName.substring(0, data.orderName.indexOf("@@")))
            } else if(data.orderName.includes('스터디룸')) {
                $('#payment_name').text(data.orderName.substring(0, 13));
            } else if(data.orderName.includes('지정석')) {
                $('#payment_name').text(data.orderName.substring(0, data.orderName.indexOf("개월")+2));
            } else if(data.orderName.includes('사물함')) {
                $('#payment_name').text(data.orderName.substring(0, data.orderName.indexOf("이용권")+3));
            }

            if(data.orderName.indexOf("@@") + 2 !== data.orderName.length) {
                $('#payment_used_coupon').text(data.orderName.substring(data.orderName.indexOf("@@") + 2))
            } else {
                $('#payment_used_coupon').text('없음');
            }

            $("#paymentModal").modal("show");
        })
        .catch(error => {
            console.error('오류 발생:', error);
        });
    }


    const handle_pagination = (page) => {
        let path = '/studycafe/paymentHistory?';

        if(page !== ""){
            path += 'page=' + page;
        }

        window.location.href = path;
    }
</script>

<jsp:include page="./components/paymentModal.jsp"/>
<jsp:include page="../common/footer.jsp"/>
