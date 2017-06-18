$ ->
  $('[data-container="managers-select"]').on "change", ->
    if $(this).val()
      $(".create-new-manager__container").hide()
      $('#manager_name').val('')
      $('#manager_email').val('')
    else
      $(".create-new-manager__container").show()
    return
