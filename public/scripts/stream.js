$(document).ready(function() {

  var stream = function() {
    var client = new XMLHttpRequest();
    client.open('get', '/api/stream');
    client.send();
    client.onprogress = function() {
      $('#stream_value').html($('#stream_value').html() + "<br>" + this.responseText);
    }
  };

  stream();
});
