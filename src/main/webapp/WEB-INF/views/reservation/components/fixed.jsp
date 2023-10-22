<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<table style="height: 200px; width: 80%;">
    <tr>
        <th style="color: #756A6A; position: relative; width: 20%; font-size: 24px;
                        position: relative" rowspan="5"
        >
            <div style="position: absolute; top: 10px; left: 0px;">지정석 기간</div>
        </th>
    </tr>
    <tr>
        <td style="width: 3%;">
            <input type="checkbox" id="1" checked>
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold;">
            <span for="1">1개월 이용권</span>
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold; color: #888">
            <label for="1" id="1_price">200,000원</label>
        </td>
    </tr>
    <tr>
        <td style="width: 3%;">
            <input type="checkbox" id="3">
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold;">
            <label for="3">3개월 이용권</label>
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold; color: #888">
            <label for="3" id="3_price">500,000원</label>
        </td>
    </tr>
    <tr>
        <td style="width: 3%;">
            <input type="checkbox" id="6">
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold;">
            <label for="6">6개월 이용권</label>
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold; color: #888">
            <label for="6" id="6_price">1,000,000원</label>
        </td>
    </tr>
    <tr>
        <td style="width: 3%;">
            <input type="checkbox" id="12">
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold;">
            <label for="12">12개월 이용권</label>
        </td>
        <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold; color: #888">
            <label for="12" id="12_price">1,500,000원</label>
        </td>
    </tr>
    <tr>

    </tr>
</table>

<script>
    $(document).ready(function() {
        $('input[type="checkbox"]').click(function () {
            if ($(this).prop('checked')) {
                $('input[type="checkbox"]').prop('checked', false);
                $(this).prop('checked', true);

                let price = parseInt($('#' + $(this)[0].id + '_price').text().replaceAll(",", ""));

                $('#total_cash').text(price.toLocaleString() + "원");

                $('#productInfo').text('지정석 ' + $(this)[0].id + '개월');
                $('#productPrice').text(price.toLocaleString() + "원");

                $('#coupon_selector').val(0);
                $('#mileage').val(0);
                $('#usedMil').text("0p");
                $('#getMil').text((Math.floor(price / 100)).toLocaleString() + "p")
            }
        });
    })
</script>