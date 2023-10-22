<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="components/adminHeader.jsp"/>



<section>
    <div>
        <div style="border-top: 2px solid #8D7B68; margin-top: 5px;"></div>
        <div style="text-align: center; margin: 50px 0px; font-size: xxx-large; color: #8D7B68; font-weight: bold;">
            매출 현황
        </div>
        <div>
            <c:forEach begin="0" end="12" varStatus="loop">
                <input type="hidden" id="amount-${loop.index}" value="${amounts[loop.index]}" />
                <input type="hidden" id="week-${loop.index}" value="${weeks[loop.index]}" />
            </c:forEach>

            <c:forEach begin="0" end="4" varStatus="loop">
                <input type="hidden" id="kind-${loop.index}" value="${kinds[loop.index]}" />
            </c:forEach>

            <div style="width: 1280px; justify-content: space-evenly; display: flex; align-items: center;">
                <div style="width: 600px;">
                    <canvas id="Sales_Amount_Chart"></canvas>
                </div>
                <div style="width: 300px;">
                    <canvas id="Sales_Kind_Doughnut"></canvas>
                </div>
            </div>

            <table class="table table-striped" style="margin-top: 50px; border-top: 1px solid #ddd;">
                <thead>
                <tr>
                    <td align="center">결제일</td>
                    <td align="center">이용권</td>
                    <td align="right" style="padding-right: 50px">결제액</td>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="item" items="${list}" varStatus="loop">
                    <tr>
                        <td align="center">
                            <fmt:formatDate value="${item.paidAt}" pattern="yy년 MM월 dd일 HH:mm:ss" />
                        </td>
                        <td align="center">${item.ticketName}</td>
                        <td align="right" style="padding-right: 50px;">
                            <fmt:formatNumber value="${item.cash}" pattern="#,###" />
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div style="justify-content: center; display: flex; margin: 50px 0;">
                <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
                    <ul class="pagination">
                        <li class="page-item"><a class="page-link" href="${path}/admin/salesstatus?page=1">
                            <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                        </a></li>
                        <li class="page-item"><a class="page-link" href="${path}/admin/salesstatus?page=${ pageInfo.prevPage }">
                            <span class="material-symbols-outlined">keyboard_arrow_left</span>
                        </a></li>
                        <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                            <c:if test="${empty param.page}">
                                <c:if test="${current == 1}">
                                    <li class="page-item"><a class="page-link active disabled" href="${path}/admin/salesstatus?page=${current}">${current}</a></li>
                                </c:if>
                                <c:if test="${current != 1}">
                                    <li class="page-item"><a class="page-link" href="${path}/admin/salesstatus?page=${current}">${current}</a></li>
                                </c:if>
                            </c:if>
                            <c:if test="${not empty param.page}">
                                <c:if test="${current == param.page}">
                                    <li class="page-item"><a class="page-link active disabled" href="${path}/admin/salesstatus?page=${current}">${current}</a></li>
                                </c:if>
                                <c:if test="${current != param.page}">
                                    <li class="page-item"><a class="page-link" href="${path}/admin/salesstatus?page=${current}">${current}</a></li>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <li class="page-item"><a class="page-link" href="${path}/admin/salesstatus?page=${ pageInfo.nextPage }">
                            <span class="material-symbols-outlined">keyboard_arrow_right</span>
                        </a></li>
                        <li class="page-item"><a class="page-link" href="${path}/admin/salesstatus?page=${pageInfo.maxPage}">
                            <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                        </a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    const sales_amount = document.getElementById('Sales_Amount_Chart');
    const sales_kind = document.getElementById('Sales_Kind_Doughnut');

    document.addEventListener('DOMContentLoaded', () => {
        let amounts = []; let weeks = [];
        for(let i = 0; i < 12; i++) {
            amounts.push($('#amount-'+i).val());
            weeks.push($('#week-'+i).val());
        }

        new Chart(sales_amount, {
            type: 'line',
            data: {
                labels: weeks.reverse(),
                datasets: [{
                    label: '결제액',
                    data: amounts.reverse(),
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        let kinds = [];
        for(let i = 0; i < 4; i++) {
            kinds.push($('#kind-'+i).val());
        }

        new Chart(sales_kind, {
            type: 'doughnut',
            data: {
                labels: [
                    '일반석',
                    '지정석',
                    '4인룸',
                    '8인룸'
                ],
                datasets: [{
                    data: kinds,
                    backgroundColor: [
                        'orangered',
                        'gold',
                        'lime',
                        'aqua'
                    ],
                    hoverOffset: 4
                }]
            }
        })
    })

</script>

<style>
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
</style>

<jsp:include page="../common/footer.jsp"/>