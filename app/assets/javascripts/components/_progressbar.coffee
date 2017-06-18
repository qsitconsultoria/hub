ready = ->
  moveProgressBar = ->
    $(".progressbar").each (i, el) ->
      getPercent = $(this).data("progress-percent")
      $(this).find(".progressbar__fill").css
        width: getPercent + "%"
      return
  moveProgressBar()

$(document).ready(ready)
$(document).on('page:load', ready)
