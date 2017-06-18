window.redirect = (url) ->
  window.location.href = url

class @SelectNavigation
  constructor: (@container) ->
    @container.find('select').change(@redirect)

  redirect: (event) =>
    window.redirect($(event.target).val())

