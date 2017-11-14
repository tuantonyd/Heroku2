$('.img-thumbnail').click(function(){
  console.log($(this).attr('src'));
  $("#enlarged").attr('src', $(this).attr('src'));
})


console.log($('#addToCart'));
