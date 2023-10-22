<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<table style="height: 200px; width: 100%;">
    <tr>
        <th style="color: #756A6A; position: relative; width: 15%; font-size: 24px;
                        position: relative" rowspan="5"
        >
            <div style="position: absolute; top: 10px; left: 0px;">이용 시간</div>
        </th>
    </tr>
    <tr>
        <td style="width: 3%;">
            <input type="checkbox" id="1" checked>
        </td>
        <td style="text-align: right; width: 15%; font-size: 20px; font-weight: bold;">
            <label for="1">사물함 1주 이용권</label>
        </td>
        <td style="text-align: right; width: 10%; font-size: 20px; font-weight: bold; color: #888">
            <label for="1" id="1_price">5,000원</label>
        </td>
        <td style="text-align: right; width: 3%;">
            <input type="checkbox" id="6">
        </td>
        <td style="text-align: right; width: 15%; font-size: 20px; font-weight: bold;">
            <label for="6">사물함 6주 이용권</label>
        </td>
        <td style="text-align: right; width: 10%; font-size: 20px; font-weight: bold; color: #888">
            <label for="6" id="6_price">30,000원</label>
        </td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" id="2">
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold;">
            <label for="2">사물함 2주 이용권</label>
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
            <label for="2" id="2_price">10,000원</label>
        </td>
        <td style="text-align: right;">
            <input type="checkbox" id="8">
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold;">
            <label for="8">사물함 8주 이용권</label>
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
            <label for="8" id="8_price">40,000원</label>
        </td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" id="3">
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold;">
            <label for="3">사물함 3주 이용권</label>
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
            <label for="3" id="3_price">15,000원</label>
        </td>
        <td style="text-align: right;">
            <input type="checkbox" id="10">
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold;">
            <label for="10">사물함 10주 이용권</label>
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
            <label for="10" id="10_price">60,000원</label>
        </td>
    </tr>
    <tr>
        <td>
            <input type="checkbox" id="4">
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold;">
            <label for="4">사물함 4주 이용권</label>
        </td>
        <td style="text-align: right;font-size: 20px; font-weight: bold; color: #888">
            <label for="4" id="4_price">20,000원</label>
        </td>
        <td style="text-align: right;">
            <input type="checkbox" id="12">
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold;">
            <label for="12">사물함 12주 이용권</label>
        </td>
        <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
            <label for="12" id="12_price">80,000원</label>
        </td>
    </tr>
</table>

<script>
    $(document).ready(function() {
        $('input[type="checkbox"]').click(function () {
            if ($(this).prop('checked')) {
                $('input[type="checkbox"]').prop('checked', false);
                $(this).prop('checked', true);

                let price = parseInt($('#' + $(this)[0].id + '_price').text().replace(",", ""));

                $('#total_cash').text(price.toLocaleString() + "원");

                $('#productInfo').text('사물함 ' + $(this)[0].id + '주 이용권');
                $('#productPrice').text(price.toLocaleString() + "원");

                $('#coupon_selector').val(0);
                $('#mileage').val(0);
                $('#usedMil').text("0p");
                $('#getMil').text((Math.floor(price / 100)).toLocaleString() + "p")
            }
        });
    })
</script>