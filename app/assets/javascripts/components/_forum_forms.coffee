$(document).ready ->

  $(".js-reply-form-trigger").bind "click focus", ->
    target = $(this).closest(".forum-answers-list").find(".forum-answers-list__reply-form")
    $(target).fadeIn "fast"
    $(target).find(".form__input").focus()
    return false

  $('[js-data-toggle="autosize"]').on "focus", ->
    $(this).autosize()
    return
