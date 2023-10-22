<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>

<section style="justify-content: center; display: flex; flex-direction: column; align-items: center;">
    <div style="font-size: 32px; width: 100%; text-align: center; padding: 50px 0;
        border-bottom: 3px solid #8D7B68; border-top: 3px solid #8D7B68; margin-top: 50px;"
    >
        사용하실 좌석을 선택해주세요.
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

    <div>
        <jsp:include page="./seatingchart.jsp"/>
    </div>
    <jsp:include page="./modal/timeCheckInModal.jsp"/>
</section>

<script>
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

        
        if(($('.seatingMap-'+index).val().includes('N')
        || $('.seatingMap-'+index).val().includes('C'))
        && !$('.seatingMap-'+index).val().includes('X')){
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
        if(($('.seatingMap-'+index).val().includes('N')
        || $('.seatingMap-'+index).val().includes('C'))
        && !$('.seatingMap-'+index).val().includes('X')){
            $('#timeCheckInModalTitle').text($('.seatingMap-'+index).val() +'번 좌석')
            $('#possibleCheckInContent').css('display', 'flow')
            $('#seatNo').val(index);

            $('#timeCheckInModal').modal('show');
        }
    }

</script>

<jsp:include page="../common/footer.jsp"/>

