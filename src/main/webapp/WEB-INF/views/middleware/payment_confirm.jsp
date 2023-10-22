<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="request" value="<%= request %>" />
<c:set var="protocol" value="${request.scheme}" />
<c:set var="host" value="${request.serverName}" />
<c:set var="port" value="${request.serverPort}" />
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<c:set var="fullUrl" value="${protocol}://${host}:${port}${pageContext.request.contextPath}" />


<html>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
    <script src="${ path }/js/jquery-3.7.0.js"></script>
</head>
<body>

<script>
    let header = $('meta[name="_csrf_header"]').attr('content');
    let token = $('meta[name="_csrf"]').attr('content');

    const savePayment = (data) => {
        console.log(header, token)
        fetch(`${fullUrl}/payment/save`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json;charset=UTF-8',
                [header]: token
            },
            body: JSON.stringify({
                data
            })
        }).then(response => response.json())
        .then(data => {
            window.location.href = `${path}/reservation/paymentcompleted?orderId=${param.paymentKey}`;
        })
    }

    fetch(`https://api.tosspayments.com/v1/payments/confirm`, {
        method: 'POST',
        headers: {
            'Authorization': 'Basic dGVzdF9za19aNjFKT3hSUVZFMTlsRWVwR2p5VlcwWDliQXF3Og==',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            amount:`${param.amount}`,
            orderId: `${param.orderId}`,
            paymentKey: `${param.paymentKey}`
        })
    }).then(response => response.json())
    .then(data => {
        savePayment(data);
    })
    .catch(error => {
        console.error(error);
    });
</script>
</body>
</html>