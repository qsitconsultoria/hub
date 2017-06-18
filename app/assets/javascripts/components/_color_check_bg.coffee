$ ->
  $(".form__input--radio--color-check label").each ->
    color_name = "theme--" + $(this).find('input').val()
    $(this).addClass color_name

  $(".form__input--radio--color-check input").click ->
    $(".form__input--radio--color-check label").removeClass("is-active")
    $(this).parent("label").addClass("is-active")

  $(".form__input--radio--color-check input:checked").parent("label").addClass("is-active")




