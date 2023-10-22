<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<section>
    <div id="seatingchart">
        <c:forEach var="item" items='${seatingMap}' varStatus="loop">
            <c:choose>
                <c:when test="${item == '1'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;"
                         class="seat-${loop.index}">
                        <div style="top: 25px; left: 20px; width: 30px; height: 25px; border-top: 5px solid; border-left: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '2'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="top: 25px; left: 0px; width: 50px; border-top: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '3'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="left: 0px; top: 25px; width: 25px; height: 25px; border-top: 5px solid; border-right: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '4'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="left: 0px; top: 0px; width: 25px; height: 50px; border-right: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '5'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;"
                         class="seat-${loop.index}">
                        <div style="left: 20px; top: 0px; width: 30px; height: 30px; border-left: 5px solid; border-bottom: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '6'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="left: 0px; top: 0px; width: 25px; height: 30px; border-right: 5px solid; border-bottom: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '7'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="left: 0px; top: 0px; width: 25px; height: 50px; border-right: 5px solid; position: absolute;"></div>
                        <div style="left: 25px; top: 5px; width: 25px; height: 25px; border-bottom: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '8'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="left: 0px; top: 0px; width: 25px; height: 50px; border-right: 5px solid; position: absolute;"></div>
                        <div style="left: 0px; top: 5px; width: 25px; height: 25px; border-bottom: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == '9'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="top: 25px; left: 0px; width: 50px; border-top: 5px solid; position: absolute;"></div>
                        <div style="top: 25px; left: 20px; height: 25px; border-left: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == 'T'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <div style="top: 25px; left: 0px; width: 50px; border-top: 5px solid; position: absolute;"></div>
                        <div style="top: 0px; left: 20px; height: 25px; border-left: 5px solid; position: absolute;"></div>
                    </div>
                </c:when>
                <c:when test="${item == 'D'}">
                    <div style="left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;" class="seat-${loop.index}">
                        <span class="material-symbols-outlined" style="font-size: xxx-large">sensor_door</span>
                    </div>
                </c:when>
                <c:when test="${item.contains('N')}">

                    <div style="background: sandybrown; border: 1px solid; left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px; cursor: pointer;"
                         class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                         onclick="clickIndex('N', ${loop.index})"
                    >
                        <c:if test="${item.contains('X')}">
                            <div style="position: absolute; font-size: xxx-large;">X</div>
                            ${item.substring(0, item.length() - 1)}
                        </c:if>
                        <c:if test="${!item.contains('X')}">
                            ${item}
                            <c:forEach var="history" items="${histories}">
                                <c:if  test="${history.seat == loop.index}">
                                    <div style="color: white; background: black; width: 100%; height: 100%; position: absolute;
                                    justify-content: center; align-items: center; display: flex;">
                                        ${item}
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:when>
                <c:when test="${item.contains('F')}">
                    <div style="background: rosybrown; border: 1px solid; left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px; cursor: pointer"
                         class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                         onclick="clickIndex('F', ${loop.index})"
                    >
                        <c:if test="${item.contains('X')}">
                            <div style="position: absolute; font-size: xxx-large;">X</div>
                            ${item.substring(0, item.length() - 1)}
                        </c:if>
                        <c:if test="${!item.contains('X')}">
                            ${item}
                            <c:if test="${item.contains('U')}">
                                <div class="inUse">
                                    ${item.substring(0, item.length() - 1)}
                                </div>
                            </c:if>
                        </c:if>
                    </div>
                </c:when>
                <c:when test="${item.contains('C')}">
                    <div style="background: pink; border: 1px solid; left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px; cursor: pointer"
                         class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                         onclick="clickIndex('C', ${loop.index})"
                    >
                        <c:if test="${item.contains('X')}">
                            <div style="position: absolute; font-size: xxx-large;">X</div>
                            ${item.substring(0, item.length() - 1)}
                        </c:if>
                        <c:if test="${!item.contains('X')}">
                            ${item}
                            <c:forEach var="history" items="${histories}">
                                <c:if  test="${history.seat == loop.index}">
                                    <div style="color: white; background: black; width: 100%; height: 100%; position: absolute;
                                    justify-content: center; align-items: center; display: flex;">
                                            ${item}
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>
                </c:when>
                <c:when test="${item == 'R'}">
                    <div style="background: whitesmoke; left:${loop.index % 14 * 50 + 5 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50 + 5}px;
                            width: 240px; height:240px; cursor: pointer" class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                    >
                        <span class="material-symbols-outlined happy">mood</span>Rest Area
                    </div>
                </c:when>
                <c:when test="${item == 'P'}">
                    <div style="background: whitesmoke; left:${loop.index % 14 * 50 + 5 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50 + 5}px;
                            width: 240px; height:90px; cursor: pointer" class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                    >
                        <span class="material-symbols-outlined">print</span>Print Area
                    </div>
                </c:when>
                <c:when test="${item == 'L'}">
                    <div style="background: whitesmoke; left:${loop.index % 14 * 50 + 5 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50 + 5}px;
                            width: 190px; height:40px; cursor: pointer" class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                    >
                        <span class="material-symbols-outlined">lock</span>Locker
                    </div>
                </c:when>
                <c:when test="${item == 'K'}">
                    <div style="background: whitesmoke; left:${loop.index % 14 * 50 + 5 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50 + 5}px;
                            width: 90px; height:40px; cursor: pointer" class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                    >
                        <span class="material-symbols-outlined kiosk">smartphone</span>Kiosk
                    </div>
                </c:when>
                <c:when test="${item.contains('E')}">
                    <div style="background: whitesmoke; left:${loop.index % 14 * 50 + 5 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50 + 5}px;
                            width: 240px; height:190px; cursor: pointer" class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                         onclick="clickIndex('E', ${loop.index})"
                    >
                        <c:if test="${item.contains('X')}">
                            <div style="position: absolute; font-size: xxx-large;">X</div>
                        </c:if>
                        <c:if test="${item.contains('U')}">
                            <div class="inUse">
                                <span class="material-symbols-outlined book" style="color: white">book_2</span>8p Study Room
                            </div>
                        </c:if>
                        <span class="material-symbols-outlined book">book_2</span>8p Study Room
                    </div>
                </c:when>
                <c:when test="${item.contains('S')}">
                    <div style="background: whitesmoke; left:${loop.index % 14 * 50 + 5 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50 + 5}px;
                            width: 190px; height:140px; cursor: pointer" class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                         onclick="clickIndex('S', ${loop.index})"
                    >
                        <c:if test="${item.contains('X')}">
                            <div style="position: absolute; font-size: xxx-large;">X</div>
                        </c:if>
                        <c:if test="${item.contains('U')}">
                            <div class="inUse">
                                <span class="material-symbols-outlined book" style="color: white">book_2</span>4p Study Room
                            </div>
                        </c:if>
                        <span class="material-symbols-outlined book">book_2</span>4p Study Room
                    </div>
                </c:when>
                <c:when test="${item == 'B'}">
                    <div class="seat-${loop.index}"></div>
                </c:when>
                <c:otherwise>
                    <div style="background: white; left:${loop.index % 14 * 50 - 350}px; top:${((loop.index / 14) - (loop.index / 14) % 1) * 50}px;
                            cursor: pointer"
                         class="seat-${loop.index}"
                         onmouseenter="mouseEnterIndex(${loop.index}, '${item}')"
                         onmouseleave="mouseLeaveIndex(${loop.index})"
                         onclick="clickIndex('0', ${loop.index})"
                    >
                    </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</section>

<style>
    #seatingchart{
        position: relative;
        height: 1800px;
    }
    #seatingchart>div {
        width: 50px;
        height: 50px;
        position: absolute;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .material-symbols-outlined.happy{
        color: yellowgreen;
    }

    .material-symbols-outlined.kiosk{
        color: rosybrown;
    }

    .material-symbols-outlined.book{
        color: blue;
    }

    .inUse{
        position: absolute;
        width: 100%;
        height: 100%;
        background: black;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white
    }
</style>
