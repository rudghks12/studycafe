<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="components/myPageHeader.jsp"/>

<title>마이페이지</title>

<style>
    .userInfo {
        width: 800px;
        border-collapse: separate;
        border-spacing: 20px;
        margin: 0 auto;
        margin-top: 60px;
        background-color: #F2F2F2;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .td>input {
        text-align: center;
        width: 400px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .mybtn {
        margin-bottom: 30px;
    }

    .change {
        background-color: #8D7B68;
        color: white;
        font-size: 20px;
        border-radius: 10px;
        padding: 10px 20px;
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
        width: 200px;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
        cursor: pointer;
    }

    .changeImage {
        background-color: #8D7B68;
        color: white;
        font-size: 20px;
        border-radius: 10px;
        padding: 10px 20px;
        text-align: center;
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
        cursor: pointer;
    }

    .change:hover, .changeImage:hover, #checkNickname:hover {
        background-color: #654C3E;
    }

    #checkNickname {
        background-color: #8D7B68;
        color: white;
        font-size: 16px;
        border-radius: 5px;
        border: none;
        padding: 8px 16px;
        cursor: pointer;
    }

    .td > input, button {
        display: inline-block;
        vertical-align: middle;
    }

    #checkNickname:disabled, .changeImage:disabled {
        background-color: #ccc;
        color: #666;
        cursor: not-allowed;
    }
</style>

<section>
    <div>
        <div style="border-top: 2px solid #8D7B68; margin-top: 5px;"></div>
        <div style="text-align: center; margin: 50px 0px; font-size: xxx-large; color: #8D7B68; font-weight: bold;">
            회원 정보 관리
        </div>
    </div>

    <div style="text-align: center;">
        <table class="userInfo" style="margin: 0 auto; margin-top: 70px;">
            <tr>
                <th style=" border: none; width: 150px;">
                    <div style="border: 2px solid #8D7B68; border-radius: 50%; width: 150px; height: 150px; overflow: hidden; margin: 0 auto;">
                            <input type="hidden" value="${user.image}" id="user_image_value">
                            <c:if test= '${user.email.contains("KAKAO_")}'>
                                <img src="${user.image}" style="width: 150px; height: 150px; object-fit: fill">
                            </c:if>
                            <c:if test="${user.email.contains('NAVER_')}">
                                <img src="${user.image}" style="width: 150px; height: 150px; object-fit: fill">
                            </c:if>
                            <c:if test= '${ not user.email.contains("KAKAO_") and not user.email.contains("NAVER_")}'>
                                <img src="${user.image.substring(0, user.image.indexOf('upload/') + 7).concat("c_fill,h_150,w_150/").concat(user.image.substring(user.image.indexOf('upload/') + 7))}">
                            </c:if>
                    </div>
                </th>
            </tr>
            <tr>
                <td style="text-align: center;">
                    <p>회원님을 알릴 수 있는 사진을 등록해주세요.<br>
                        등록된 사진은 회원님의 게시물이나 댓글들에 사용됩니다.
                    </p>
                </td>
            </tr>
            <tr>
                <td style="text-align: center;">
                    <c:if test= '${user.email.contains("KAKAO_")}'>
                        <button class="changeImage" style="border: none; border-radius: 10px; padding: 10px 20px; font-size: 16px;" disabled>
                            이미지 변경
                        </button>
                    </c:if>
                    <c:if test="${user.email.contains('NAVER_')}">
                        <button class="changeImage" style="border: none; border-radius: 10px; padding: 10px 20px; font-size: 16px;" disabled>
                            이미지 변경
                        </button>
                    </c:if>
                    <c:if test= '${ not user.email.contains("KAKAO_") and not user.email.contains("NAVER_")}'>
                        <button class="changeImage" style="border: none; border-radius: 10px; padding: 10px 20px; font-size: 16px;" >
                            이미지 변경
                        </button>
                    </c:if>
                </td>
            </tr>
        </table>
    </div>

    <form action="${ path }/updateUserInfo" method="post">
        <security:csrfInput/>
        <div style="text-align: center; margin-bottom: 80px;">
            <table class="userInfo" style="margin: 0 auto; margin-top: 60px; padding-left: 50px;">
                <tr>
                    <th class="th">이름</th>
                    <td class="td">
                        <input type="text" class="form-control input-field" value="${user.name}" readonly>
                    </td>
                </tr>
                <tr>
                    <th class="th">닉네임</th>
                    <td class="td">
                        <input type="text" class="form-control input-field" id="nicknameInput" name="nickname" value="${user.nickname}">
                        <input type="hidden" id="prevNickNameInput" value="${user.nickname}" />
                    </td>
                    <td><button id="checkNickname" disabled>중복확인</button></td>
                </tr>
                <tr>
                    <th class="th">이메일</th>
                    <td class="td">
                        <c:if test= '${user.email.contains("KAKAO_")}'>
                            <input type="text" class="form-control input-field"
                                   value="카카오 계정" readonly>
                        </c:if>
                        <c:if test="${user.email.contains('NAVER_')}">
                            <input type="text" class="form-control input-field"
                                   value="네이버 계정" readonly>
                        </c:if>
                        <c:if test= '${ not user.email.contains("KAKAO_") and not user.email.contains("NAVER_")}'>
                            <input type="text" class="form-control input-field" value="${user.email}" readonly id="user_email">
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th class="th">전화번호</th>
                    <td class="td">
                        <input type="text" class="form-control input-field" maxlength="13" value="${user.phone}" id="phone" name="phone" placeholder="-는 빼고 입력해주세요." oninput="formatPhoneNumber(this)">

                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; margin-bottom: -30px;">
            <p style="display: inline-block; margin-right: 10px; vertical-align: middle;">정말로 탈퇴하시겠어요?</p>
            <a href="#" style="text-decoration: none; margin-bottom: 15px;  color: red; display: inline-block; vertical-align: middle; cursor: pointer" id="secessionbtn" onclick="handleSecession()">회원탈퇴</a>
        </div>
        <div class="mybtn" style="text-align: center; display: flex; justify-content: space-around; gap: 5px;">
            <button type="button" class="change" id="changePassword" style="margin-right: 5px;">비밀번호 변경</button>
            <button type="submit" class="change" style="margin-left: 5px;">저장</button>
        </div>
    </form>
    <form action="/studycafe/secession" method="post" id="secessionForm"><security:csrfInput/></form>
</section>

<%@ include file="/WEB-INF/views/common/modal/passwordChange.jsp"%>
<script src="https://widget.cloudinary.com/v2.0/global/all.js" type="text/javascript"></script>

<style>
    .userInfo {
        width: 800px;
        border-collapse: separate;
        border-spacing: 20px;
        margin: 0 auto;
        margin-top: 60px;
        background-color: #F2F2F2;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .td {
        width: 200px;
        padding: 10px;
        text-align: center;
    }

    .th {
        width: 100px;
        text-align: center;
        color: #8D7B68;
        font-weight: bold;
        padding: 10px;
    }

    .td>input {
        text-align: center;
        width: 400px;
        padding: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .mybtn {
        margin-bottom: 30px;
    }

    .change {
        background-color: #8D7B68;
        color: white;
        font-size: 20px;
        border-radius: 10px;
        padding: 10px 20px;
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
        width: 200px;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
        cursor: pointer;
    }

    .changeImage {
        background-color: #8D7B68;
        color: white;
        font-size: 20px;
        border-radius: 10px;
        padding: 10px 20px;
        text-align: center;
        width: 100%;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
        cursor: pointer;
    }

    .change:hover, .changeImage:hover, #checkNickname:hover {
        background-color: #685948;
    }

    #checkNickname {
        background-color: #8D7B68;
        color: white;
        font-size: 16px;
        border-radius: 5px;
        border: none;
        padding: 8px 16px;
        cursor: pointer;
    }

    .td > input, button {
        display: inline-block;
        vertical-align: middle;
    }

    #checkNickname:disabled, .changeImage:disabled {
        background-color: #ccc;
        color: #666;
        cursor: not-allowed;
    }
</style>

<script>
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        }
    });

    $(document).ready(function() {
        $("#changePassword").click(function() {
            $("#passwordChange").modal("show");
        });

        document.getElementById("secessionForm").onsubmit = function(e) {
            if (!confirm("정말로 탈퇴하시겠어요?")) {
                e.preventDefault();
            }
        };

            $("#confirmSecession").click(function() {
                showConfirmationDialog();
            });


        $('.changeImage').on('click', () => {
            const email = $('#user_email').val();

            cloudinary.openUploadWidget({
                cloudName: 'dosqqxim0',
                uploadPreset: 'i3tkucch',
                sources: ['local', 'url', 'camera', 'image_search'],
            }, (error, result) => {
                if (!error && result && result.event === 'success') {
                    const imageUrl = result.info.secure_url;
                    console.log(imageUrl)
                    // 이미지 URL을 Spring 컨트롤러로 전송
                    $.ajax({
                        type: "POST",
                        url: "${path}/changeUserImage",
                        data: JSON.stringify({ imageUrl: imageUrl, email: email }),
                        contentType: "application/json",
                        success: function(response) {
                            alert("이미지가 성공적으로 저장되었습니다.");
                            location.reload();
                        },
                        error: function() {
                            alert("이미지 저장 중 오류가 발생했습니다.");
                        }
                    });
                }
            });

        });

        $("#nicknameInput").on("input", function() {
            const currentNickname = $(this).val();
            const previousNickname = $("#prevNickNameInput").val();

            console.log(previousNickname);

            if (currentNickname !== previousNickname) {
                $("#checkNickname").prop("disabled", false);
            } else {
                $("#checkNickname").prop("disabled", true);
            }
        });

        $("#checkNickname").on("click", function(e) {
            e.preventDefault();
            const currentNickname = $("#nicknameInput").val();

            if (currentNickname === '') {
                alert('닉네임을 입력해주세요.');
                return;
            }

            $.ajax({
                type: "POST",
                url: "${ path }/checkNicknameDuplicate",
                data: JSON.stringify({ nickname: currentNickname }),
                contentType: "application/json",
                success: function(response) {
                    console.log(response)
                    if (response.isDuplicate === true) {
                       alert("이미 사용 중인 닉네임입니다.");
                    } else {
                        alert("사용 가능한 닉네임입니다.");
                    }
                },
                error: function() {
                    alert("중복 확인 중 오류가 발생했습니다.");
                }
            });
        });

    });

    function formatPhoneNumber(input) {
        let phoneNum = input.value.replace(/[^0-9]/g, '');

        if (phoneNum.length >= 4 && phoneNum.length <= 7) {
            phoneNum = phoneNum.replace(/(\d{3})(\d{1,4})/, '$1-$2');
        } else if (phoneNum.length >= 8) {
            phoneNum = phoneNum.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
        }

        input.value = phoneNum;
    }

    const handleSecession = () => {
        $('#secessionForm').submit();
    }
</script>

<jsp:include page="../common/footer.jsp"/>