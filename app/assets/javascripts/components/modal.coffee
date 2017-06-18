$ ->
  $('.open-modal').on 'click', ->
    $('.overlay').show()
    $('.metadata--modal').removeClass('open')

    $($(this).attr('href')).addClass('open')

  $('.close-modal').on 'click', ->
    $('.overlay').hide()
    $('.metadata--modal').removeClass('open')

  $('.overlay').on 'click', ->
    $(this).hide()
    $('.metadata--modal').removeClass('open')

  $(document).keyup (e) ->
    if e.keyCode == 27
      $('.overlay').hide()
      $('.metadata--modal').removeClass('open')
