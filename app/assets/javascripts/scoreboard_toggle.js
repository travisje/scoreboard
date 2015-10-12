$(function() {
  $('.display_stats').click(function() {
    $(this).parent().next().toggle();
    if ($(this).text()===("-"))
      $(this).text("+");
    else
      $(this).text("-");
    $(this).parent().toggleClass("grey");
  });
});
