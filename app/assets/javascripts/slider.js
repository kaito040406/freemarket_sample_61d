$(document).on('turbolinks:load', function(){
  $('.slick').slick({
    autoplay:true,  
    dots:true,    
  });
});
$(function(){
  $("#slider").slick({
    prevArrow: '<img src=""  class="slide-arrow prev-arrow">',
    nextArrow: '<img src="" class="slide-arrow next-arrow">'
  });
});