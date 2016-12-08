$(document).ready(function() {
  $('img.avatar').each(function(i, img) {
    var $img = $(img)
    if ($img.prop('naturalWidth') == 0) {
      var data = (new Identicon($img.data('hash'), 80)).toString()
      $img.attr('src', 'data:image/png;base64,' + data)
    }
  })
})
