/*  global $*/
$(document).on("turbolinks:load", function() {
  $(function() {
    $(".tab").click(function(){
      $(".tab-active").removeClass("tab-active");
      $(this).addClass("tab-active");
      $(".box-show").removeClass("box-show");
      const index = $(this).index();
      $(".tabbox").eq(index).addClass("box-show");
    });
  }); 
});

$('#tab-contents .tab[id != "tab1"]').hide();

$('#tab-menu a').on('click', function(event) {
  $("#tab-contents .tab").hide();
  $("#tab-menu .active").removeClass("active");
  $(this).addClass("active");
  $($(this).attr("href")).show();
  event.preventDefault();
});