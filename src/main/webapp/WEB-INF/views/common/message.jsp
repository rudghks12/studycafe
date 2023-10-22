<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
</head>
<body>
<script>
  // 알림메세지를 띄움
  alert("${ message }");

  // 실행시켜야할 스크립트가 있으면 실행
  if(${ not empty script }) {
    ${ script }
  }

  history.go(-1);

</script>
</body>
</html>

<body>