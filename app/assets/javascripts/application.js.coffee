# *************************************
#
#   Application
#   -> HUB
#
# *************************************

# -------------------------------------
#   vendor
# -------------------------------------
#= require medium-editor
#= require pickadate/lib/picker
#= require pickadate/lib/picker.date
#= require pickadate/lib/translations/pt_BR
#= require jqueryui/ui/core
#= require jqueryui/ui/widget
#= require jqueryui/ui/mouse
#= require jqueryui/ui/sortable
#= require jqueryui/ui/slider
#= require typeahead.min
#= require hogan

# -------------------------------------
#   components
# -------------------------------------
#= require components/_progressbar
#= require components/_accordion
#= require components/behavior
#= require components/_slidebar_options
#= require components/_forum_forms
#= require components/work_place_chooser
#= require components/_search_tabs
#= require components/search_autocomplete
#= require components/modal
#= require components/year_slider

# -------------------------------------
#   inbox
# -------------------------------------
ready = ->
  # autosize textareas
  $.behavior('autosize').autosize()

  # Fastclick
  FastClick.attach document.body

  # Responsive nav
  $navIdentifier = $('.js-navbar')
  $navToggle = $('.js-navbar-toggle')
  $navToggle.click ->
    $navToggle.toggleClass 'is-active'
    $navIdentifier.toggleClass 'is-active'
    false

  $(window).resize(resize).resize()
$(document).ready(ready)
$(document).on('page:load', ready)

resize = ->
  $('[data-behavior="elastic-video"]').each (index, element) =>
    newWidth = $(element).parent().width()
    $(element).attr('width', newWidth)
    $(element).attr('height', newWidth * $(element).data('aspect-ratio'))

$ ->
  $('.comment form textarea').on 'keyup', ->
    textarea = $('.comment form textarea')
    if textarea.val() == ''
      $('.btn--comment').hide()
      $('.comment form textarea').attr('width', '50px')
    else
      $('.btn--comment').show()
