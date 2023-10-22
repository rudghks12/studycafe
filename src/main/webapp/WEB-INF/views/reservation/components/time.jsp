<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<table style="height: 200px; width: 100%;">
  <tr>
    <th style="color: #756A6A; position: relative; width: 20%; font-size: 24px;
                        position: relative" rowspan="5"
    >
      <div style="position: absolute; top: 10px; left: 0px;">이용 시간</div>
    </th>
  </tr>
  <tr>
    <td style="width: 3%;">
      <input type="checkbox" id="1" checked>
    </td>
    <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold;">
      <label for="1">1시간 이용권</label>
    </td>
    <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold; color: #888">
      <label for="1" id="1_price">3,000원</label>
    </td>
    <td style="text-align: right; width: 3%;">
      <input type="checkbox" id="20">
    </td>
    <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold;">
      <label for="20">20시간 이용권</label>
    </td>
    <td style="text-align: right; width: 12%; font-size: 20px; font-weight: bold; color: #888">
      <label for="20" id="20_price">22,000원</label>
    </td>
  </tr>
  <tr>
    <td>
      <input type="checkbox" id="3">
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold;">
      <label for="3">3시간 이용권</label>
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
      <label for="3" id="3_price">6,000원</label>
    </td>
    <td style="text-align: right;">
      <input type="checkbox" id="40">
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold;">
      <label for="40">40시간 이용권</label>
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
      <label for="40" id="40_price">41,000원</label>
    </td>
  </tr>
  <tr>
    <td>
      <input type="checkbox" id="6">
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold;">
      <label for="6">6시간 이용권</label>
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
      <label for="6" id="6_price">10,000원</label>
    </td>
    <td style="text-align: right;">
      <input type="checkbox" id="60">
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold;">
      <label for="60">60시간 이용권</label>
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
      <label for="60" id="60_price">58,000원</label>
    </td>
  </tr>
  <tr>
    <td>
      <input type="checkbox" id="12">
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold;">
      <label for="12">12시간 이용권</label>
    </td>
    <td style="text-align: right;font-size: 20px; font-weight: bold; color: #888">
      <label for="12" id="12_price">15,000원</label>
    </td>
    <td style="text-align: right;">
      <input type="checkbox" id="80">
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold;">
      <label for="80">80시간 이용권</label>
    </td>
    <td style="text-align: right; font-size: 20px; font-weight: bold; color: #888">
      <label for="80" id="80_price">74,000원</label>
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

        $('#productInfo').text($(this)[0].id + '시간 이용권');
        $('#productPrice').text(price.toLocaleString() + "원");

        $('#coupon_selector').val(0);
        $('#mileage').val(0);
        $('#usedMil').text("0p");
        $('#getMil').text((Math.floor(price / 100)).toLocaleString() + "p")
      }
    });
  })
</script>