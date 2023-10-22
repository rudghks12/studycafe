<%@ page import="java.util.Date" %>
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
            유저 관리
        </div>
    </div>
    <div style="margin-left: 25px;">
        <div style="padding-left: 20px; font-size: 16px;">전체사용자 ${count}명</div>
        <div style="display: flex; align-items: center; margin: 10px 0; padding: 0 20px;">
            <div style="position: relative;">
                <span class="material-symbols-outlined" style="position: absolute; margin-top: 7.5px; margin-left: 7.5px;">
                    search
                </span>
                <input type="text" class="form-control" placeholder="검색어 입력" style="padding-left: 33px;"
                       id="search-keyword"
                >
            </div>
            <div style="margin-left: 10px;">
                <select class="form-select" aria-label="search select" id="search-kind"
                        style="width: 130px"
                >
                    <option value="NAME" selected>이름</option>
                    <option value="PHONE">전화번호</option>
                    <option value="EMAIL">이메일</option>
<%--                    <option value="recent">최근이용권</option>--%>
<%--                    <option value="locker">사물함</option>--%>
                </select>
            </div>
            <div style="margin-left: 10px;">
                <button type="button" class="btn btn-custom btn-sm" id="search_button"
                        onclick="handle_search_button()">검색</button>
            </div>
            <div style="align-items:center; justify-content: end; display: flex; width: 100%">
                <div style="display: flex; margin-right: 10px;">
                    <input type="number" class="form-control" placeholder="정지일" min="1" max="9999" id="suspend_day">
                </div>
                <button type="button" class="btn btn-custom btn-sm" onclick="handle_button('SuspendUser', ${users.size()})">
                    정지
                </button>
                <button type="button" class="btn btn-custom btn-sm"
                        style="width: 100px; margin-left: 10px;"
                        onclick="handle_button('ReleaseUser', ${users.size()})"
                >
                    정지해제
                </button>
            </div>
        </div>
        <div>
            <table class="table table-striped" style="margin-top: 30px;">
                <thead>
                    <tr>
                        <td>이름</td>
                        <td>전화번호</td>
                        <td>이메일</td>
                        <td>지정석</td>
                        <td>사물함</td>
                        <td style="text-align: right; padding-right: 25px;">
                            <input id="users-table-checkbox" class="form-check-input" type="checkbox"
                                   onchange="users_checkbox(${users.size()})">
                        </td>
                    </tr>
                </thead>
                <c:set var="currentDate" value="<%= new Date() %>" />
                <tbody>
                    <c:forEach var="user" items="${users}" varStatus="loop">
                        <input type="hidden" id="user-id${loop.index}" value="${user.id}" />
                        <c:if test="${not empty user.releaseDate and user.releaseDate.after(currentDate) }">
                            <tr id="user-data-${user.id}" class="suspended">
                                <td>${user.name}</td>
                                <td>${user.phone}</td>
                                <td>${user.email}</td>
                                <td>${user.fixed == 0 ? "없음" : seatingMap[user.fixed]}</td>
                                <td>${user.locker == 0 ? "없음" : (user.locker - 900)}</td>
                                <td style="text-align: right; padding-right: 25px;">
                                    <input class="form-check-input" type="checkbox" id="user-checkbox${loop.index}"
                                           onclick="user_checkbox(${users.size()}, ${loop.index})">
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${empty user.releaseDate or user.releaseDate.before(currentDate)}">
                            <tr id="user-data-${user.id}">
                                <td>${user.name}</td>
                                <td>${user.phone}</td>
                                <td>${user.email}</td>
                                <td>${user.fixed == 0 ? "없음" : seatingMap[user.fixed]}</td>
                                <td>${user.locker == 0 ? "없음" : (user.locker - 900)}</td>
                                <td style="text-align: right; padding-right: 25px; ">
                                    <input class="form-check-input" type="checkbox" id="user-checkbox${loop.index}"
                                           onclick="user_checkbox(${users.size()}, ${loop.index})">
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <div style="justify-content: center; display: flex; margin: 30px 0;">
        <nav aria-label="Page navigation example" style="justify-content: center; display: flex">
            <ul class="pagination">
                <li class="page-item"><a class="page-link" onclick="handle_pagination('1', '${param.keyword}', '${param.kind}')">
                    <span class="material-symbols-outlined">keyboard_double_arrow_left</span>
                </a></li>
                <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.prevPage }', '${param.keyword}', '${param.kind}')">
                    <span class="material-symbols-outlined">keyboard_arrow_left</span>
                </a></li>
                <c:forEach var="current" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                    <c:if test="${empty param.page}">
                        <c:if test="${current == 1}">
                            <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                        </c:if>
                        <c:if test="${current != 1}">
                            <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }', '${param.keyword}', '${param.kind}')">${current}</a></li>
                        </c:if>
                    </c:if>
                    <c:if test="${not empty param.page}">
                        <c:if test="${current == param.page}">
                            <li class="page-item"><a class="page-link active disabled">${current}</a></li>
                        </c:if>
                        <c:if test="${current != param.page}">
                            <li class="page-item"><a class="page-link" onclick="handle_pagination('${ current }', '${param.keyword}', '${param.kind}')">${current}</a></li>
                        </c:if>
                    </c:if>
                </c:forEach>
                <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.nextPage }', '${param.keyword}', '${param.kind}')">
                    <span class="material-symbols-outlined">keyboard_arrow_right</span>
                </a></li>
                <li class="page-item"><a class="page-link" onclick="handle_pagination('${ pageInfo.maxPage }', '${param.keyword}', '${param.kind}')">
                    <span class="material-symbols-outlined">keyboard_double_arrow_right</span>
                </a></li>
            </ul>
        </nav>
    </div>
</section>

<script>
    let header = $('meta[name="_csrf_header"]').attr('content');
    let token = $('meta[name="_csrf"]').attr('content');

    const user_checkbox = (count, index) => {
        const value = $('#user-checkbox'+index).prop("checked")

        for(i = 0; i < count; i++) {
            if($('#user-checkbox' + i).prop("checked") === false) {
                $('#users-table-checkbox').prop("checked", false);
                return;
            }
        }

        $('#users-table-checkbox').prop("checked", true);

    }

    const users_checkbox = (count) => {
        const isChecked = $('#users-table-checkbox').prop("checked");

        for (let i = 0; i < count; i++) {
            $('#user-checkbox' + i).prop("checked", isChecked);
        }
    }

    const handle_button = (kind, count) => {
        let selected = [];

        for(let i = 0; i < count; i++) {
            if ($('#user-checkbox' + i).prop("checked") === true) {
                selected.push($('#user-id'+i).val());
            }
        }

        if(selected.length === 0) {
            console.log('체크해라')
            return
        }

        if(kind === 'ReleaseUser'){
            $.ajax({
                type: 'POST',
                url: '/studycafe/admin/'+kind,
                data: JSON.stringify({selected: selected}),
                contentType: 'application/json;charset=UTF-8',
                beforeSend: (xhr) => {
                    xhr.setRequestHeader(header, token);
                },
                success: (data) => {
                    console.log('success');
                    for (const s of selected) {
                        $('#user-data-'+s).removeClass('suspended');
                    } deSelectAll();

                },
                error: () => {
                    console.log('error');
                }
            });
        } else if(kind === 'SuspendUser') {
            const suspend_day = $('#suspend_day').val();

            if (suspend_day === null || suspend_day.trim() === '') {
                $('#suspend_day').addClass('required');
                return;
            }

            console.log(selected, kind)

            $.ajax({
                type: 'POST',
                url: '/studycafe/admin/'+kind,
                data: JSON.stringify({selected: selected, suspend_day: suspend_day}),
                contentType: 'application/json;charset=UTF-8',
                beforeSend: (xhr) => {
                    xhr.setRequestHeader(header, token);
                },
                success: (data) => {
                    console.log('success');
                    for (const s of selected) {
                        $('#user-data-'+s).addClass('suspended');
                    } deSelectAll();
                },
                error: () => {
                    console.log('error');
                }
            });
        }
    }

    const deSelectAll = () => {
        for(i = 0; i < 20; i++) {
            $('#user-checkbox' + i).prop("checked", false)
        }
    }

    $('#suspend_day').on('click', (e) => {
        $('#suspend_day').removeClass('required');
    })

    const handle_search_button = () => {
        const keyword = $('#search-keyword').val()
        const regex = /^[가-힣a-zA-Z0-9]+$/;

        if (!regex.test(keyword)) {
            $('#search-keyword').addClass('required');
            return;
        }

        const kind = $('#search-kind').val()

        if(kind === 'locker' || kind === 'recent'){
            console.log('미구현')
            return;
        }

        window.location.href = '/studycafe/admin/usermanage?keyword='+keyword+'&kind='+kind;
    }

    const handle_pagination = (page, keyword, kind) => {
        console.log(page, keyword, kind);

        let path = '/studycafe/admin/usermanage?';

        if(page !== ""){
            path += 'page=' + page;
            if(keyword !== ""){
                path += '&keyword=' + keyword + '&kind=' + kind;
            }
        }

        window.location.href = path;
    }

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

    .table {
        border-top: 1px solid #ddd;
    }

    .form-control,
    .form-select {
        border-color: #B9B3B3;
    }

    .form-control:focus,
    .form-select:focus {
        border-color: #B9B3B3;
        box-shadow: 0px 0px 5px saddlebrown;
    }

    .btn-custom {
        background: #8D7B68;
        color: white;
        width: 55px;
        height: 35px;
    }

    .btn-custom:active {
        scale: 1.1;
    }

    .btn:hover {
        background: #654C3E;
        color: white;
    }

    .btn-custom.btn-sm:active {
        background-color: #4B3900; /* 원하는 배경색으로 변경 */
        color: #FFFFFF; /* 원하는 텍스트 색상으로 변경 */
    }

    .form-check-input:focus {
        border-color: #8D7B68;
        box-shadow: 0px 0px 5px saddlebrown;
    }

    .form-check-input:checked {
        /*background: #8D7B68;*/
        background-color: #8D7B68;
        border-color: #8D7B68;
    }

    .form-check-input:checked::before {
        color: white; /* V 표시의 색상을 변경합니다. */
    }

    .suspended>td {
        color: #ddd;
    }

    td {
        text-align: center;
    }

    .required {
        box-shadow: 0px 0px 10px red;
    }

</style>


<jsp:include page="../common/footer.jsp"/>