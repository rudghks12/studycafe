<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<section>
    <div id="remocon">
        <div>
            <div class="N selected" onclick="changeSelect('N')">
                <div style="background: sandybrown;">
                    N
                </div>
                <div>일반석</div>
            </div>
        </div>
        <div>
            <div class="F" onclick="changeSelect('F')">
                <div style="background: rosybrown">
                    F
                </div>
                <div>지정석</div>
            </div>
        </div>
        <div>
            <div class="C" onclick="changeSelect('C')">
                <div style="background: pink">
                    C
                </div>
                <div>2&nbsp;인석</div>
            </div>
        </div>
        <div>
            <div class="disable" onclick="changeSelect('disable')">
                <div>
                    <span class="material-symbols-outlined">disabled_by_default</span>
                </div>
                <div>
                    사용불가
                </div>
            </div>
        </div>
        <div>
            <div class="erase" onclick="changeSelect('erase')">
                <div>
                    <span class="material-symbols-outlined">delete</span>
                </div>
                <div>지우개</div>
            </div>
        </div>
    </div>
</section>

<style>
    #remocon {
        width: 200px;
        height: 300px;
        box-shadow: 2px 2px 4px black;
        position: fixed;
        border-radius: 10px;
        justify-content: center;
        padding: 30px 0px;
        background: white;
        z-index: 1;
        right: 5%;
    }
    #remocon>div{
        justify-content: center;
        display: flex;
    }
    #remocon>div>div {
        display: flex;
        justify-content: space-between;
        padding: 10px 5px;
        width: 120px;
    }
    #remocon>div>div:hover {
        cursor: pointer;
        background: aliceblue;
        border-radius: 10px;
    }
    #remocon>div>div>div:nth-child(1) {
        width: 25px;
        height: 25px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .selected {
        border: 2px solid black;
        border-radius: 10px;
    }
</style>

<script>
    const changeSelect = (newSelected) => {
        $('.'+selected).removeClass('selected');
        $('.'+newSelected).addClass('selected');

        selected = newSelected;
    }
</script>