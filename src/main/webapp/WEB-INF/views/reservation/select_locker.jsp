<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<title>사물함 선택</title>

<jsp:include page="../common/header.jsp"/>

<section>
    <div style="width: 1280px; margin-top: 50px;">
        <div style="font-weight: 900; text-align: center; font-size: 30px;
            padding: 30px 0; border-top: 3px solid #964B00;
            border-bottom: 3px solid #964B00;
        ">
            사물함 선택
        </div>
    </div>

    <jsp:include page="components/modals/LockerModal.jsp"/>
    <jsp:include page="../common/lockers.jsp"/>

</section>

<script>
    const select_locker = (num) => {
        $('#lockerModalTitle').text('L'+num+' 사물함')

        if( $('#locker-'+num).text().includes('\n') ) {
            $('#lockerModal_content').html('사용중인 사물함입니다.<br>다시 확인 후 이용해 주세요')
            $('#lockerModal_normal_buttons').css('display', 'none')
            $('#lockerModal_error_buttons').css('display', 'flex')
        } else {
            $('#lockerModal_content').text('결제를 진행하시겠습니까?')
            $('#lockerModal_normal_buttons').css('display', 'flex')
            $('#lockerModal_error_buttons').css('display', 'none')
        }

        $('#lockerModal').modal("show")
    }
</script>

<jsp:include page="../common/footer.jsp"/>