<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<jsp:include page="../common/header.jsp"/>

<style>
    #agreeSection {
        min-height: 900px;
        padding: 0 50px 0 50px;
    }

    .step-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 50px;
        margin-bottom: 30px;
    }

    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 150px;
        height: 120px;
    }

    .step-number {
        width: 60px;
        height: 60px;
        background-color: #ccc;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 30px;
    }

    .step1 {
        background-color: #8D7B68;
        color: white;
    }

    .step-text {
        margin-top: 10px;
        font-weight: bold;
    }

    #agree_btn {
        background-color: #8D7B68;
        color: white;
        font-size: 20px;
        border-radius: 10px;
        padding: 14px;
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
        width: 200px;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
    }

    #agree_btn:hover {
        background-color: #685948;
    }

    #agree_btn:disabled {
        background-color: #ccc;
        color: #666;
        cursor: not-allowed;
        opacity: 0.7;
        font-size: 20px;
        border-radius: 10px;
        padding: 14px;
        text-align: center;
        margin-top: 30px;
        margin-bottom: 30px;
        width: 200px;
        margin-left: auto;
        margin-right: auto;
        display: block;
        border: none;
    }

    .custom-checkbox {
        display: inline-block;
        position: relative;
        padding-left: 30px;
        cursor: pointer;
        font-size: 18px;
        margin-bottom: 10px;
    }

    .custom-checkbox input[type="checkbox"] {
        opacity: 0;
        cursor: pointer;
        height: 0;
        width: 0;
    }

    .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 25px;
        width: 25px;
        border: 2px solid #ccc;
        border-radius: 3px;
        background-color: #fff;
    }

    .custom-checkbox input[type="checkbox"]:checked ~ .checkmark {
        border: 2px solid #8D7B68;
        background-color: #8D7B68;
    }

    .checkmark:after {
        content: "";
        position: absolute;
        display: none;
    }

    .custom-checkbox input[type="checkbox"]:checked ~ .checkmark:after {
        display: block;
        left: 7px;
        top: 4px;
        width: 6px;
        height: 12px;
        border: solid #fff;
        border-width: 0 3px 3px 0;
        transform: rotate(45deg);
    }

    .agree-content {
        margin-top: 20px;
    }

    .agree-content h4 {
        font-weight: bold;
    }


</style>


<section id="agreeSection">
    <div class="step-container">
        <div class="step">
            <div class="step-number step1">01</div>
            <div class="step-text">이용약관동의</div>
        </div>
        <div class="step">
            <div class="step-number">02</div>
            <div class="step-text">회원가입</div>
        </div>
        <div class="step">
            <div class="step-number">03</div>
            <div class="step-text">가입완료</div>
        </div>
    </div>
    <div style="border-top: 2px solid #8D7B68; margin-bottom: 50px;"></div>
    <div>
        <div id="agree-div" class="agree-div">
            <div class="argee-content">
                <h2 style="font-weight: bold">약관동의</h2>
                <br>
                <div class="custom-checkbox">
                    <label>
                        <input type="checkbox" id="AllCheckbox">
                        <span class="checkmark"></span>
                        <span>전체동의</span>
                    </label>
                </div>

                <br><br>

                <div class="custom-checkbox">
                    <label>
                        <input type="checkbox" name="Checkbox">
                        <span class="checkmark"></span>
                        <span>회원가입 약관(필수)</span>
                    </label>
                </div>

                <div style="border:1px solid #cdcdcd">
                    <div style="height:120px; overflow:scroll; overflow-x:hidden; font-size:.95em; padding:20px; text-align: left;">
                        제1조 (목적)
                        <br>
                        <br>
                        본 약관은 집중할 곳 없스카가 운영하는 홈페이지에서 제공하는 서비스(이하 합하여 “서비스”라 한다)를 하나의 회원 아이디와 비밀번호로 동시에 각 사이트에 가입하여 이용함에 있어 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
                        <br>
                        <br>
                        제2조 (정의)
                        <br>
                        <br>
                        ① “이용자” 란 사이트에 접속하거나 방문하여 이 약관에 따라 회사가 제공하는 모든 서비스를 받는 회원 및 비회원을 말합니다. <br>
                        ② “회원” 이란 회사에 개인정보를 제공하고 개인정보취급방침 및 이용약관을 동의한 후에 회원등록을 한 자로서 서비스를 지속적으로 이용하는 자를 말합니다.<br>
                        ③ “비회원” 이란 회원등록을 하지 않고 회사에서 제공하는 서비스를 이용하는 자를 말합니다.
                        <br>
                        <br>
                        제3조 (약관의 효력과 개정)
                        <br>
                        <br>
                        ① 본 약관은 사이트에서 약관에 동의하고 가입 신청한 모든 회원에게 효력이 발생합니다.<br>
                        ② 회사는 서비스 운영상 필요할 경우 관련법에 위배되지 않는 범위 내에서 본 약관을 개정할 수 있습니다. 또한 개정 이후의 약관에 대한 효력은 개정 이전의 회원에게도 적용됩니다.<br>
                        ③ 회사는 약관을 개정함에 있어 적용일 7일전에 온라인상의 공지나 전자우편 등의 방법을 통해 회원에게 공지되고 적용일부터 효력이 발생합니다. 단, 중대한 사유로 인한 긴급한 약관개정이 요구될 때에는 약관을 즉시 개정할 수 있으며, 이러한 경우 중대한 약관변경의 사유를 함께 공지합니다.<br>
                        ④ 회원이 약관 개정에 대해 동의하지 않을 경우 서비스 이용을 중단하고 탈퇴할 수 있습니다. 약관이 개정된 이후에도 지속적으로 서비스를 이용하는 경우에는 약관 변경에 동의한 것으로 간주합니다.
                        <br>
                        <br>
                        제4조 (약관 외 준칙)
                        <br>
                        <br>
                        ① 회사는 약관 이외에 개별서비스에 대한 세부적인 사항을 정할 수 있으며 그 내용은 해당서비스의 이용안내, 별도 약관을 통해 공지합니다.<br>
                        ② 본 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.
                        <br>
                        <br>
                        제5조 (회원가입)
                        <br>
                        <br>
                        ① 만 12세 이상에 한해 사이트가 정한 이용약관 및 개인정보취급방침을 동의한 후 개인정보를 기입함으로써 회원가입 신청이 가능하며 회사가 이를 허락하는 것으로 회원이 됩니다.<br>
                        ② 회원가입 신청의 양식에 기재된 모든 정보는 반드시 실제정보와 동일해야 하며 실제정보와 동일하지 않거나 사실과 다른 정보를 입력한 회원은 법적인 보호를 받을 수 없습니다.<br>
                        ③ 사이트는 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 아래의 경우에 해당되는 경우 승낙을 거부하거나 취소할 수 있습니다.<br>
                        - 실명이 아닌 경우<br>
                        - 본인의 주민번호가 아닌 경우<br>
                        - 신청 시 필요정보를 허위로 기재하는 경우<br>
                        - 사회의 안녕 질서 및 미풍약속을 저해할 목적으로 신청할 경우<br>
                        - 전기통신기본법, 전기통신사업법, 정보통신 윤리강령, 정보통신 윤리위원회 심의규정, 프로그램 보호법 및 기타관련 법령과 약관이 금지하는 행위를 한 경우<br>
                        - 기타 회원으로 등록하는 것이 사이트의 기술상 현저히 지장이 있다고 판단되는 경우
                        <br>
                        <br>
                        제6조 (회원의 의무)
                        <br>
                        <br>
                        ① 회원은 기재하는 회원정보를 실제사항으로 입력해야 하며 변경이 있을 경우 즉시 변경사항을 수정하여야 합니다.<br>
                        ② 회원은 본인이 아닌 타인의 아이디나 개인정보를 이용하여서는 안됩니다.<br>
                        ③ 회원은 약관 및 관계법령에서 규정한 사항을 반드시 준수해야 하며 아이디, 비밀번호, 개인정보를 부주의하게 관리하여 발생하는 모든 책임을 감수합니다.<br>
                        ④ 회원은 자신의 아이디가 타인에 의해 도용 당하고 있는 지 수시로 확인하여야 하며, 도용 또는 부정사용의 가능성을 발견할 경우 지체 없이 회사에 신고하여야 합니다.<br>
                        ⑤ 회원은 서비스 이용을 마친 후 정상적으로 종료하지 않아서 (로그아웃 하지 않아서) 발생하는 모든 책임을 감수해야 하며 회사가 인정한 공식적인 방법 이외의 방법을 이용하여 회사에서 제공하는 서비스를 회원이 이용하여서는 안됩니다.<br>
                        ⑥ 서비스이용 도중 서비스의 버그나 결함을 발견할 경우 회원은 이를 지체 없이 회사에 신고하여야 하며, 이를 악용하여서는 안됩니다.
                        <br>
                        <br>
                        제7조 (회사의 의무)
                        <br>
                        <br>
                        ① 회사는 관계법령 및 이 약관에서 금지하는 행위를 하지 않는다.<br>
                        ② 회사는 지속적이고 안정적인 서비스를 제공하기 위해 노력한다.<br>
                        ③ 회사는 서비스를 이용하는 회원이 제기하는 의견이나 불만사항이 정당하다고 인정되면 즉시 처리한다. 다만, 즉시 처리가 불가능한 경우에는 회원에게 그 사유와 처리되는 일정을 통지하여야 한다.
                        <br>
                        <br>
                        제8조 (회원탈퇴)
                        <br>
                        <br>
                        ① 회원은 언제든지 탈퇴메뉴를 통하여 이용계약 해지 신청을 할 수 있으며 “회사”는 이를 즉시 처리하여야 합니다.<br>
                        ② 회사는 탈퇴한 회원의 개인정보를 즉시삭제 처리하며 동일한아이디로 가입차단을 위하여 아이디만 기록을 남깁니다.<br>
                        ③ 탈퇴회원의 재가입은 동일 아이디로 재가입을 할 수 없으며, 새로운 아이디로 재가입하셔야 합니다.<br>
                        ④ 다음 아래의 경우에 해당되는 경우 회사는 사전통보 없이 강제탈퇴를 하거나 서비스 이용을 중지할 수 있습니다.<br>
                        - 가입 신청 시 허위내용을 기재한 경우<br>
                        - 타인의 아이디, 비밀번호, 주민등록번호 등을 도용한 경우<br>
                        - 회사, 다른 회원 또는 제3자의 지적재산권을 침해하는 경우<br>
                        - 사회의 안녕과 질서, 미풍양속을 해지는 행위를 하는 경우<br>
                        - 타인 또는 회사의 명예를 손상시키거나 불이익을 주는 행위를 한 경우<br>
                        - 정보통신망에 장애를 일으킬 수 있는 행위를 하는 경우<br>
                        - 회사의 허락 없이 서비스를 이용해 영리행위를 하는 경우<br>
                        - 회사가 허락하지 않는 방법으로 회사가 운영, 관리하는 포인트를 취득한 경우<br>
                        - 전기통신기본법, 전기통신사업법, 정보통신 윤리강령, 정보통신 윤리위원회 심의규정, 프로그램 보호법 및 기타관련 법령과 약관이 금지하는 행위를 한 경우
                        <br>
                        <br>
                        제9조 (회원에 대한 통지)
                        <br>
                        <br>
                        ① 회사가 회원에게 통지를 하는 경우 회원이 서비스에 기재한 e-mail 주소로 통보하며 그 e-mail 주소가 허위이거나 회원이 확인하지 못한 경우, 혹은 회원이 기재한 e-mail 주소를 관리하는 업체의 문제로 e-mail 이 제대로 전송되지 않았을 경우 회사는 통지의 의무에 대한 책임을 지지 않습니다.<br>
                        ② 회사는 불특정다수 회원에 대한 통지의 경우 1주일 이상 서비스에 이를 게시하며 회원이 게시된 통지를 확인하지 못해 발생하는 피해에 대해서는 회사가 책임지지 않습니다.<br>
                        ③ 회사는 회원에게 유용하다고 판단되는 정보나 광고를 e-mail 의 방법으로 전달할 수 있으며 회원은 이를 원하지 않을 경우 개인정보 관리메뉴에서 수신을 거부할 수 있습니다. 다만, e-mail 수신을 거부한 경우에도 회원약관, 개인정보취급방침, 기타 중대한 영업정책의 변경 등 회원이 반드시 알고 있어야 하는 공지사항이 있는 경우 수신 거부와 관계없이 e-mail 을 발송할 수 있습니다.
                        <br>
                        <br>
                        제10조 (서비스 제한)
                        <br>
                        <br>
                        ① 회원은 성명, 주민등록번호, 주소, 전화번호, 휴대폰번호, e-mail 에 관한 사항을 허위 기재할 경우 회원에게 발생한 어떠한 손해도 감수합니다.또한 회사는 회원의 성명과 주민등록번호를 조회하여 실명으로 확인되지않을 경우 서비스의 일부 혹은 전부를 제한할 수 있습니다.<br>
                        ② 회원의 서비스 이용에 대해 별도의 인증이 필요할 경우 회사는 서비스제공에 앞서 별도의 인증절차를 요구할 수 있습니다.<br>
                        ③ 다음 아래의 경우에 해당되는 경우 회사는 사전통보 없이 회원의 서비스 이용을 제한 또는 중지할 수 있습니다.<br>
                        - 회원이 아이디 및 주민등록번호를 도용 또는 허위기재 할 경우<br>
                        - 비정상적 행위 및 규정 위반의 경우<br>
                        - 게시판이나 기타 온라인 공간에 욕설 등으로 회사 또는 타인에게 불쾌감이나 피해를 줄 경우<br>
                        - 서비스의 버그나 결함을 악용하는 경우
                        <br>
                        <br>
                        제11조 (저작권의 귀속 및 이용제한)
                        <br>
                        <br>
                        ① 회사가 작성한 저작물에 대한 저작권 및 기타 지적재산권은 회사에 귀속되며 회원은 서비스를 이용 하며 얻은 정보를 회사의 사전 승낙 없이 가공, 복제, 출판, 배포, 방송, 판매하는 행위 등 기타 방법에 의하여 영리 목적으로 이용하거나 제3자에게 이용 또는 제공하여서는 안됩니다.<br>
                        ② 회원이 작성한 게시물에 대한 권리와 책임은 게시한 회원에게 있으며 회사는 게시한 회원의 동의 없이 이를 서비스 내에서 영리적인 목적으로 사용할 수 없습니다. 다만, 회사가 회원의 게시물을 이용해 출판 등을 하고자 할 경우 전화, 우편, e-mail 등의 절차를 통해 사전에 회원의 동의를 얻어야 합니다.<br>
                        ③ 회사는 회원이 작성한 게시물이 내용, 문장, 도형, 상징 등을 통해 다음 각호에 해당하는 경우 사전통지 없이 삭제할 수 있습니다.<br>
                        - 타 회원 또는 회사를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우<br>
                        - 공공질서 및 미풍양속에 위반되는 내용인 경우<br>
                        - 범죄적 행위에 결부된다고 인정되는 내용인 경우<br>
                        - 회사의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우<br>
                        - 확인되지 않은 미확인 정보나 거짓된 정보일 경우<br>
                        - 광고의 목적으로 게시물을 게시한 경우<br>
                        - 회사의 운영자 혹은 관계자를 사칭하는 경우<br>
                        - 게시판의 성격에 부합하지 않는 게시물의 경우<br>
                        - 기타 관계법령에 위반된다고 판단되는 경우<br>
                        ④ 회원이 게시하는 게시물 및 정보로 인해 발생하는 손실이나 문제는 회원 개인의 책임이며 회사는 이에 대하여 책임을 지지 않습니다.<br>
                        ⑤ 회원의 게시물로 인하여 제3자가 회사에 대한 청구, 소송, 기타 일체의 분쟁이 발생한 경우 회원은 그 해결에 소요되는 비용을 부담하고 회사를 위하여 분쟁을 처리해야 하며 회사가 제3자에게 배상하거나 회사에 손해가 발생한 경우 회원은 회사에 배상하여야 합니다.
                        <br>
                        <br>
                        제12조 (개인정보 취급방침)
                        <br>
                        <br>
                        ① 회사는 회원의 개인정보를 보호하며 회사는 그 내용을 별도의 ‘개인정보취급방침’ 이란 이름으로 공지하며 그에 의거하여 회원의 개인정보 보호를 위해 노력합니다.
                        <br>
                        <br>
                        제13조 (손해배상과 면책)
                        <br>
                        <br>
                        ① 회사는 무료 서비스 이용과 관련하여 회사의 고의 또는 중과실이 없는 한 회원 에게 발생한 어떠한 손해에 대해서도 배상 및 보상의 책임을 지지 않습니다.<br>
                        ② 회사가 천재지변, 비상사태 또는 이에 준하는 불가피한 사정으로 서비스를 중단할 경우 서비스 중단으로 회원에게 발생되는 문제에 대한 책임이 면제되며 회원의 귀책사유로 인한 서비스 이용의 장애에 대해서도 책임을 지지 않습니다.<br>
                        ③ 회사는 회원이 게시한 게시물의 적합성, 정확성, 시의성, 신빙성에 관한 보증 또는 담보책임을 지지 않으며 회원이 회사가 제공한 서비스를 통해 취득한 정보나 서비스에 게시된 다른 회원의 게시물을 통해 법률적 또는 의학적, 기타 재정적 사항에 관하여 필요한 결정을 하고자 할 때에는 반드시 사전에 전문가와 상의하기를 권고합니다.<br>
                        ④ 회사는 서비스 운영을 위해 회원에게 다양한 광고활동을 할 수 있습니다. 이 때 회사가 아닌 광고주로 인해 회원에게 발생하는 피해는 회사가 책임지지 않습니다.<br>
                        ⑤ 회원이 직거래 등 본 약관이나 관계법령을 어기고 이용함으로 인해 발생하는 피해와 이용방법 미숙지, 공지사항 미확인, 부정확한 정보입력 등 명백한 회원의 과실로 인해 발생하는 피해에 대해서는 회사가 책임지지 않습니다.
                        <br>
                        <br>
                        제14조 (분쟁해결 및 관할법원)
                        <br>
                        <br>
                        ① 회사는 개인정보 관리, 서비스 이용 등에 대한 회원들의 불편 및 불만사항, 기타 의견을 홈페이지, e-mail, 전화, 서면 등을 통해 접수하고 처리합니다.<br>
                        ② 회사 및 회원은 개인정보에 관한 분쟁이 있는 경우 신속하고 효과적인 분쟁해결을 위하여 개인정보분쟁조정위원회에 분쟁의 조정을 신청할 수 있습니다.<br>
                        ③ 서비스 이용으로 발생한 분쟁에 대해 소송이 제기될 경우 회사의 본사 소재지를 관할하는 법원 또는 대한민국의 민사소송법에 따른 법원을 관할법원으로 합니다.
                        <br>
                        <br>
                        부 칙<br>
                        본 약관은 2023. 8. 23 부터 적용하고, 종전의 약관은 본 약관으로 대체합니다.
                    </div>
                </div>

                <br>
                <div class="custom-checkbox">
                    <label>
                        <input type="checkbox" name="Checkbox">
                        <span class="checkmark"></span>
                        <span>개인정보 수집 및 이용(필수)</span>
                    </label>
                </div>

                <div style="border:1px solid #cdcdcd">
                    <div style="height:120px; overflow:scroll; overflow-x:hidden; font-size:.95em; padding:20px; text-align: left;">
                        개인정보보호법에 따라 집중할 곳 없스카에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
                        <br>
                        <br>
                        1. 수집하는 개인정보
                        <br>
                        <br>
                        이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
                        <br>
                        회원가입 시점에 네이버가 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>
                        - 회원 가입 시 필수항목으로 아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호를, 선택항목으로 본인확인 이메일주소를 수집합니다. 실명 인증된 아이디로 가입 시, 암호화된 동일인 식별정보(CI), 중복가입 확인정보(DI), 내외국인 정보를 함께 수집합니다. 만14세 미만 아동의 경우, 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.<br>
                        - 비밀번호 없이 회원 가입 시에는 필수항목으로 아이디, 이름, 생년월일, 휴대전화번호를, 선택항목으로 비밀번호를 수집합니다.<br>
                        - 단체 회원가입 시 필수 항목으로 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를, 선택항목으로 단체 대표자명을 수집합니다.<br>
                        서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.<br>
                        - 회원정보 또는 개별 서비스에서 프로필 정보(별명, 프로필 사진)를 설정할 수 있습니다. 회원정보에 별명을 입력하지 않은 경우에는 마스킹 처리된 아이디가 별명으로 자동 입력됩니다.<br>
                        - 네이버 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.
                        <br>
                        <br>
                        서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 생성되어 수집될 수 있습니다. 또한 이미지 및 음성을 이용한 검색 서비스 등에서 이미지나 음성이 수집될 수 있습니다.<br>
                        구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다.<br>
                        서비스 이용 과정에서 위치정보가 수집될 수 있으며,
                        네이버에서 제공하는 위치기반 서비스에 대해서는 '네이버 위치기반서비스 이용약관'에서 자세하게 규정하고 있습니다.<br>
                        이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.
                        <br>
                        <br>
                        2. 수집한 개인정보의 이용
                        <br>
                        <br>
                        네이버 및 네이버 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발・제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.<br>

                        - 회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.<br>
                        - 콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다. 신규 서비스 요소의 발굴 및 기존 서비스 개선 등에는 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 생성·제공·추천, 상품 쇼핑 등에서의 인공지능(AI) 기술 적용이 포함됩니다.<br>
                        - 법령 및 네이버 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.<br>
                        - 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.<br>
                        - 이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.<br>
                        - 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.<br>
                        - 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
                        <br>
                        <br>
                        3. 개인정보의 보관기간
                        <br>
                        <br>
                        회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.<br>
                        단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.<br>
                        이용자에게 개인정보 보관기간에 대해 회원가입 시 또는 서비스 가입 시 동의를 얻은 경우는 아래와 같습니다.<br>
                        - 부정 가입 및 이용 방지<br>
                        부정 이용자의 가입인증 휴대전화번호 또는 DI (만14세 미만의 경우 법정대리인DI) : 탈퇴일로부터 6개월 보관<br>
                        탈퇴한 이용자의 휴대전화번호(복호화가 불가능한 일방향 암호화(해시처리)) : 탈퇴일로부터 6개월 보관<br>
                        - QR코드 복구 요청 대응<br>
                        QR코드 등록 정보:삭제 시점으로부터6개월 보관<br>
                        - 스마트플레이스 분쟁 조정 및 고객문의 대응<br>
                        휴대전화번호:등록/수정/삭제 요청 시로부터 최대1년<br>
                        - 네이버 플러스 멤버십 서비스 혜택 중복 제공 방지<br>
                        암호화처리(해시처리)한DI :혜택 제공 종료일로부터6개월 보관<br>
                        - 네이버 엑스퍼트 재가입 신청 및 부정 이용 방지<br>
                        네이버 엑스퍼트 서비스 및 네이버 엑스퍼트 센터 가입 등록정보&판매자 이름 : 신청일로부터 6개월(등록 거절 시, 거절 의사 표시한 날로부터 30일) 보관<br>
                        - 전자서명 인증 업무<br>
                        개인정보: 네이버 인증서 서비스 해지 시까지 보관<br>
                        인증서와 인증 업무에 관한 기록: 인증서 효력 상실일로부터 5년 보관<br>
                        전자상거래 등에서의 소비자 보호에 관한 법률, 전자문서 및 전자거래 기본법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. 네이버는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.<br>
                        - 전자상거래 등에서 소비자 보호에 관한 법률<br>
                        계약 또는 청약철회 등에 관한 기록: 5년 보관<br>
                        대금결제 및 재화 등의 공급에 관한 기록: 5년 보관<br>
                        소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관<br>
                        - 전자문서 및 전자거래 기본법<br>
                        공인전자주소를 통한 전자문서 유통에 관한 기록 : 10년 보관<br>
                        - 통신비밀보호법<br>
                        로그인 기록: 3개월<br>

                        참고로 네이버는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리하고 있습니다.
                        <br>
                        <br>
                        4. 개인정보 수집 및 이용 동의를 거부할 권리
                        <br>
                        <br>
                        이용자는 개인정보의 수집 및 이용 동의를 거부할 권리가 있습니다. 회원가입 시 수집하는 최소한의 개인정보, 즉, 필수 항목에 대한 수집 및 이용 동의를 거부하실 경우, 회원가입이 어려울 수 있습니다.
                    </div>
                </div>
                <div>
                    <button id="agree_btn" class="agree" onclick="location.href='${ path }/enroll'" disabled>동의</button>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    const AllCheckbox = document.getElementById('AllCheckbox');
    const modalCheckboxes = document.querySelectorAll('input[name="Checkbox"]');
    const agreeBtn = document.querySelector('.agree');

    // 이용약관 및 개인정보 약관 동의 여부 확인 함수
    function checkTermsAgreement() {
        const allChecked = Array.from(modalCheckboxes).every(checkbox => checkbox.checked);
        AllCheckbox.checked = allChecked;

        if (allChecked) {
            agreeBtn.disabled = false;
        } else {
            agreeBtn.disabled = true;
        }
    }

    // 전체동의 체크박스 클릭 시 이벤트 처리
    AllCheckbox.addEventListener('change', function () {
        modalCheckboxes.forEach(function (checkbox) {
            checkbox.checked = AllCheckbox.checked;
        });
        checkTermsAgreement();
    });

    // 각 약관 동의 체크박스 클릭 시 이벤트 처리
    modalCheckboxes.forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            checkTermsAgreement();
        });
    });

    // URL 파라미터 추출 함수
    function getUrlParameter(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }
</script>
<jsp:include page="../common/footer.jsp"/>
