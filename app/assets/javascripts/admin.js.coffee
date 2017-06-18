# *************************************
#
#   Application
#   -> HUB GIZ
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
#= require refile
#= require select2/select2
#= require select2/select2_locale_pt-BR

# -------------------------------------
#   components
# -------------------------------------
#= require components/select_navigation
#= require components/editor
#= require components/behavior
#= require components/date_time_picker
#= require components/video_input
#= require components/_slug
#= require components/sortable
#= require components/_color_check_bg
#= require components/_slidebar_options
#= require components/file_uploader

# -------------------------------------
#   custom files
# -------------------------------------
#= require admin/new_manager_form



# -------------------------------------
#   Components Setup
# -------------------------------------
$ ->
  # $('[data-component="SelectNavigation"]').each (index, element) ->
  #   new SelectNavigation($(element))

  # $('[data-component="Editor"]').each (index, element) ->
  #   new Editor($(element))

  # $('[data-component="DateTimePicker"]').each (index, element) ->
  #   new DateTimePicker($(element))


  $('[data-sortable-container="item"]').on 'sortable:update', (event, index) ->
    index = '0' + index if index < 9
    $(event.target).find('.panel-title').text(index)

# -------------------------------------
#   Inbox
# -------------------------------------
$ ->
  $.behavior('autosize').autosize()

  # Fastclick
  FastClick.attach document.body

$ ->
  $(".js-multiple-select").removeClass('form__input')
  $(".js-multiple-select").select2()

  $("#s2id_autogen1").attr('placeholder', 'Adicione um Tema...')

  $('#s2id_autogen2').attr('placeholder', 'Adicione um Curso...')
