<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<section>
    <div style="justify-content: center; display: flex; margin: 50px 0">
        <div>
            <c:forEach begin="1" end="4" varStatus="x">
                <div style="display: flex;">
                    <c:forEach begin="1" end="7" varStatus="y">
                        <div class="locker" id="L${(x.index-1)*7 + y.index}"
                             onclick="select_locker(${(x.index-1)*7 + y.index})"
                        >
                            L${(x.index-1)*7 + y.index}
                            <c:forEach var="locker" items="${lockers}">
                                <c:if  test="${locker == (x.index-1)*7 + y.index}">
                                    <div id="locker-${((x.index-1)*7 + y.index)}" style="color: white; background: black; width: 100%; height: 100%; position: absolute;
                                    justify-content: center; align-items: center; display: flex; border-radius: 10px">
                                        L${(x.index-1)*7 + y.index}
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
    </div>
</section>



<style>
    .locker {
        width: 120px;
        height: 170px;
        margin: 5px;
        background: #8D7B68;
        border-radius: 10px;

        font-size: xx-large;
        color: white;

        justify-content: center;
        align-items: center;
        display: flex;
        position: relative;
        cursor: pointer; /* 마우스 커서 모양 변경 (선택사항) */
    }

    .locker:hover {
        background-color: #685948;
    }
</style>
