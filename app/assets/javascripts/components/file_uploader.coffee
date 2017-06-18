$('.btn-upload-file').on 'click', ->
  $('#library_file_original_file').click()
  $('#library_file_original_file').on 'change', ->
    filename = $('#library_file_original_file').val().split('\\').slice(-1)
    $('.form__input--file p').text(filename)

$('.remove--file--icon').on 'click', ->
  $('.js-has-file').remove()
  $('.js-has-no-file').show()
  $(".btn[value='Salvar']").attr 'disabled', true

$ ->
  submitButton = $(".btn[value='Salvar']")

  $(document).on 'upload:start', 'form', (e) ->
    submitButton.attr 'disabled', true
    submitButton.css 'background-color', '#9cd9e6'
    submitButton.val 'Processando...'
    $(".no-file-alert").remove()

  $(document).on 'upload:progress', 'form', (e) ->
    detail = e.originalEvent.detail
    percentComplete = Math.round(detail.loaded / detail.total * 100)

    $('.upload--progress').show()
    $('.upload--progress').css('width', "#{percentComplete}%")
    $('.form__input--file p').addClass('file--name')
    $('.btn-upload-file').hide()

  $(document).on 'upload:complete', 'form', (e) ->
    if !$(this).find('input.uploading').length
      submitButton.removeAttr 'disabled'
      submitButton.css 'background-color', '#37c544'
      submitButton.val 'Salvar'

  $(document).on 'upload:success', 'form', (e) ->
    $('.form__input--file').addClass('upload--success')
