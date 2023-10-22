<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>

<section>
    <jsp:include page="components/adminHeader.jsp"/>
    <div>
        <div style="border-top: 2px solid #8D7B68; margin-top: 5px;"></div>
        <div style="text-align: center; margin: 50px 0px; font-size: xxx-large; color: #8D7B68; font-weight: bold;">
            좌석배치 변경
        </div>
    </div>

    <div style="display: flex">
        <div class="col py-3">
            <jsp:include page="./components/remoteController.jsp"/>
            <div style="justify-content: center; display: flex;">
                <jsp:include page="../common/seatingchart.jsp"/>
            </div>
            <div style="justify-content: center; display: flex;">
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

                <button type="button" id="active_save_button">
                    저장
                </button>

                <button disabled id="disabled_save_button" style="display: none">
                    <i class="fa-solid fa-spinner fa-spin-pulse" style="color: #ffffff;"></i>
                </button>
            </div>
        </div>
    </div>
</section>



<style>
    #active_save_button, #disabled_save_button {
        background-color: #8D7B68;
        color: white;
        font-size: 18px;
        margin-bottom: 30px;
        margin-top: 30px;
        border-radius: 10px;
        padding: 14px;
        text-align: center;
        width: 360px;
        border: none;
        transition: background-color 0.3s, transform 0.2s;
    }

    #active_save_button:hover {
        background-color: #654C3E; /* 호버 시 배경색 변경 */
        transform: scale(1.05); /* 호버 시 버튼 확대 효과 */
        cursor: pointer; /* 호버 시 커서 모양 변경 (선택 사항) */
    }

</style>

<script>
    let header = $('meta[name="_csrf_header"]').attr('content');
    let token = $('meta[name="_csrf"]').attr('content');

    $('#active_save_button').on('click', async () => {
        let map = "";

        $('#active_save_button').css('display', 'none');
        $('#disabled_save_button').css('display', 'flow');

        for (let i = 0; i < 504; i++) {
            map += $('.seatingMap-' + i).val() + " ";
            if ((i + 1) % 14 === 0) {
                map += "\n";
            }
        }

        await $.ajax({
            type: 'POST',
            url: '${path}/admin/modseatingchart',
            data: JSON.stringify({map: map}),
            contentType: 'application/json;charset=UTF-8',
            beforeSend: (xhr) => {
                xhr.setRequestHeader(header, token);
            },
            success: (data) => {
                console.log('success');
                setTimeout(function() {
                    window.location.reload();
                }, 5000);
            },
            error: () => {
                console.log('error');
            }
        });
    })


    let selected = "N";

    let prevIndex = {
        idx: 0,
        bg_color: 'white'
    };

    const mouseEnterIndex = (index, value) => {
        if( selected !== 'X'){
            const className = '.seat-' + index;

            prevIndex.idx = index;
            prevIndex.bg_color = $(className).css('background-color');

            if(selected !== "disable"){
                if($('.seatingMap-'+index).val() === "0"){
                    $(className).css('background-color', 'lawngreen');
                } else {
                    $(className).css('background-color', 'red');
                }
            } else {
                if($('.seatingMap-'+index).val() === "0"){
                    $(className).css('background-color', 'red');
                } else {
                    $(className).css('background-color', 'lawngreen');
                }
            }
        }
    }

    const mouseLeaveIndex = (index) => {
        if(selected !== 'X'){
            const className = '.seat-' + prevIndex.idx;
            $(className).css('background-color', prevIndex.bg_color);
        }
    }

    const clickIndex = (current, index) => {
        const newColor = getColor(selected)

        console.log(index);

        if ($('.seatingMap-'+index).val() === "0" && selected !== "erase" && selected !== "disable"){
            const idx = prompt("좌석번호 입력")

            if(isNaN(idx) || idx === null){
                alert("좌석 번호를 입력하세요.")
            } else if(idx < 0 || idx >= 100){
                alert("숫자가 너무 크거나 작습니다. (0~100)")
            }
            else {
                $('.seat-'+index).css('background', newColor)
                $('.seat-'+index).css('border', '1px solid')

                $('.seat-'+index).text(selected + idx);
                $('.seatingMap-'+index).val(selected + idx);
                prevIndex.bg_color = newColor;
            }
        } else if (selected === "erase" && $('.seatingMap-'+index).val() !== "0"
            && current !== 'E' && current !== 'S'){
            $('.seat-'+index).css('background', newColor)
            $('.seat-'+index).css('border', 'none')

            $('.seat-'+index).text("");
            $('.seatingMap-'+index).val("0");
            prevIndex.bg_color = newColor;
        } else if (selected === "disable" && $('.seatingMap-'+index).val() !== "0") {
            const currentValue = $('.seatingMap-'+index).val();

            if(currentValue.includes('X') === true){
                $('.seatingMap-'+index).val(currentValue.substring(0, currentValue.length - 1));
                $('.seat-'+index + '>div').css('visibility', 'hidden');
            } else {
                $('.seatingMap-'+index).val(currentValue + "X");
                if(currentValue.includes('S')){
                    $('.seat-'+index).html('<div style="position: absolute; font-size: xxx-large;">X</div>' +
                        '<span class="material-symbols-outlined book">book_2</span>4p Study Room')
                } else if(currentValue.includes('E')){
                    $('.seat-'+index).html('<div style="position: absolute; font-size: xxx-large;">X</div>' +
                        '<span class="material-symbols-outlined book">book_2</span>8p Study Room')
                } else {
                    $('.seat-'+index).html('<div style="position: absolute; font-size: xxx-large;">X</div>'+currentValue)
                }
                $('.seat-'+index + '>div').css('visibility', 'initial');
            }

            console.log($('.seatingMap-'+index).val());

        }
    }

    const getColor = (value) => {
        switch(value){
            case "N": return "sandybrown"
            case "F": return "rosybrown"
            case "C": return "pink"
            case "erase": return "white"
        }
    }
</script>
<jsp:include page="../common/footer.jsp"/>