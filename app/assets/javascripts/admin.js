$('#all-orders-button').click(function(){
  $(this).addClass('btn-primary');
  $(this).removeClass('btn-secondary');
  $('#uf-orders-button').addClass('btn-secondary');
  $('#pf-orders-button').addClass('btn-secondary');
  $('#uf-orders-button').removeClass('btn-primary');
  $('#pf-orders-button').removeClass('btn-primary');
  $('#to-fulfill').addClass('hidden');
  $('#pf-orders').addClass('hidden');
  $('#all-orders').removeClass('hidden');
});

$('#uf-orders-button').click(function(){
  $(this).addClass('btn-primary');
  $(this).removeClass('btn-secondary');
  $('#all-orders-button').addClass('btn-secondary');
  $('#pf-orders-button').addClass('btn-secondary');
  $('#all-orders-button').removeClass('btn-primary');
  $('#pf-orders-button').removeClass('btn-primary');
  $('#to-fulfill').removeClass('hidden');
  $('#pf-orders').addClass('hidden');
  $('#all-orders').addClass('hidden');
});

$('#pf-orders-button').click(function(){
  $(this).addClass('btn-primary');
  $(this).removeClass('btn-secondary');
  $('#all-orders-button').addClass('btn-secondary');
  $('#uf-orders-button').addClass('btn-secondary');
  $('#all-orders-button').removeClass('btn-primary');
  $('#uf-orders-button').removeClass('btn-primary');
  $('#to-fulfill').addClass('hidden');
  $('#all-orders').addClass('hidden');
  $('#pf-orders').removeClass('hidden');
});

$(document).ready(function(){
  var status_dropdowns = $( 'select[name^=order_lines]' );
  var fulfilled_input = $( 'input[name^=order_lines]' );
    $(status_dropdowns).each(function(index, element){
      var value = $(element).val();
      if(value ==2 ){
        var field = $((fulfilled_input)[index]).get(0);
        console.log("Hello");
        console.log(field);
        field.disabled=false;
}
  });
});

$( 'select[name^=order_lines]' ).change(function(){
  var changed = $(this).get(0);
  var row = $(this).closest('tr').get(0);
  var numberInput = row.getElementsByTagName('input')[0];
  if($(changed).val() == 2){
  numberInput.disabled = false;
  }
  else {
    numberInput.disabled = true;
  }

});
