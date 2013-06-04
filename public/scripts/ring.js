$(document).ready(function() {

  var ring = function() {
    $.ajax({
      type: "POST",
      url: "/api/ring",
      success: function(data) {
        $('#ring_value').text("rang " + data.rang.toString() + " time(s), click here to ring again");
      }
    });
  };

  ring();

  $('#ring_value').click(ring);
});
