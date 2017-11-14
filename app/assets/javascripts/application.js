//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery.inputmask.bundle.js
//= require_tree .

$(function() {
    applyInputMask();
})

function applyInputMask() {
    $(".mask-phone").inputmask("(999) 999-9999", {
        'place_holder': "(___) ___-____",
        removeMaskOnSubmit: true

    })
    $(".mask-price").inputmask("$", {
        'place_holder': "$",
        removeMaskOnSubmit: true
    })
}



$(".alert").fadeOut(3000);
$(".alert-success").fadeOut(3000);
$(".alert-danger").fadeOut(3000);