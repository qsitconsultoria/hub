$ ->
  $('#year-slider').slider
    range: true,
    min: 1950,
    max: 2015,

    create: (event, ui) ->
      startValue = $('.year-start').text()
      endValue = $('.year-end').text()

      $('#year-slider').slider('values', 0, startValue)
      $('#year-slider').slider('values', 1, endValue)

    slide: (event, ui) ->
      startValue = ui.values[0]
      endValue = ui.values[1]

      $('.year-start').html startValue
      $('.year-end').html endValue

    stop: (event, ui) ->
      startValue = ui.values[0]
      endValue = ui.values[1]

      $('#query_year_gteq').val(startValue)
      $('#query_year_lteq').val(endValue)

