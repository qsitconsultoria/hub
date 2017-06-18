$(document).ready ->

  $(".js-accordion-trigger").each (index, element) ->
    target = $(this).data("target")

    # Init
    if $(target).is(":visible")
      $(this).text($(this).attr("data-text-close"))
      $(this).addClass "is-open"
    else
      $(this).text($(this).attr("data-text-open"))

    $(this).bind "click focus", ->
      target = $(this).data("target")
      $(target).slideToggle "fast"
      $(target).toggleClass "is-open"
      $(this).toggleClass "is-open"

      if $(target).hasClass("is-open")
        $(this).text($(this).attr("data-text-open"))
      else
        $(this).text($(this).attr("data-text-close"))

      event.preventDefault()
