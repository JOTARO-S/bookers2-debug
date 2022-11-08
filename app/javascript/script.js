/*  global $*/
$(document).on("turbolinks:load" , function() {
　$('#tab-contents .tab[id != "tab1"]').hide();
});

$(document).on("turbolinks:load" , function() {
  $('#tab-menu a').click(function() {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
});