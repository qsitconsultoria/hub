$ ->
  showSimpleSearch = ->
    $('.simple--search--panel').addClass('visible')
    $('.simple-search--tab').addClass('active')
    $('.advanced--search--panel').removeClass('visible')
    $('.advanced-search--tab').removeClass('active')

  showAdvancedSearch = ->
    $('.advanced--search--panel').addClass('visible')
    $('.advanced-search--tab').addClass('active')
    $('.simple--search--panel').removeClass('visible')
    $('.simple-search--tab').removeClass('active')

  if (window.location.href).split('#')[1] == 'busca-avancada'
    showAdvancedSearch()

  $('.simple-search--tab').on 'click', ->
    showSimpleSearch()

  $('.advanced-search--tab').on 'click', ->
    showAdvancedSearch()
