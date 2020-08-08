$(document).on('turbolinks:load', function (){
  let $inputPrice
  if ( document.getElementById('item_price') != null ) {
    $inputPrice = $('#item_price');
  } else if ( document.getElementById('price') != null ) {
    $inputPrice = $('#price');
  }
  const $textFee = $('#add-tax-price');
  const $textProfit = $('#profit');
  const errorMessage = '半角数字のみ入力可能'
  if ( $inputPrice.val() != '' ) {
    textUpdate($inputPrice.val());
  }
  $inputPrice.on('input', function(event){
    textUpdate($inputPrice.val());
  });
  function textUpdate (input) {
    if ($.isNumeric(input)) {
      const fee = Math.floor(input * 0.1);
      $textFee.text(fee);
      $textProfit.text(input - fee);
    } else {
      $textFee.text(errorMessage);
      $textProfit.text(errorMessage);
    }
  }

});