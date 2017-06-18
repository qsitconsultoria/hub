@editor ||= {}
class editor.VideoToolbar
  constructor: (@extraContentToolbar) ->

    @_toolbar = $('<div data-behavior="video"><input placeholder="Insira a URL do vídeo (Youtube, Vimeo)"/></div>').hide()

    $(window).resize(@resize).resize()

    @_toolbar.on 'keydown', 'input', @embedIfEnterKeyPressed
    $('html').click @clickOutside
    @_isToolbarOpen = false

  embedIfEnterKeyPressed: (event) =>
    if @enterKeyPressed(event)
      event.preventDefault()
      @embed()

  enterKeyPressed: (event) ->
    event.keyCode == 13

  updatePosition: =>
    targetTop = @extraContentToolbar.plusButton().position().top + 'px'
    @toolbar().css({top: targetTop})

  isToolbarOpen: =>
    @_isToolbarOpen

  open: =>
    @updatePosition()
    @_isToolbarOpen = true
    @toolbar().hide().fadeIn('fast')
    @ensureFocus()

  close: =>
    @_isToolbarOpen = false
    @input().val('')
    @_toolbar.hide()

  html: =>
    @_toolbar

  toolbar: =>
    @_toolbar

  input: =>
    @_toolbar.find('input')

  contains: (target) =>
    $(target).closest('[data-behavior="video"]').is(@toolbar())

  embed: =>
    url = @input().val()

    if id = @parseYouTube(url)
      @iframe = $("<iframe data-behavior='elastic-video' width='560' height='315'  src='//www.youtube.com/embed/#{id}?rel=0' frameborder='0' allowfullscreen></iframe>")
      @extraContentToolbar.hoverSensor().before(@iframe)
      @setRatio()
      $(window).resize()

    if id = @parseVimeo(url)
      @iframe = $("<iframe data-behavior='elastic-video' src='//player.vimeo.com/video/#{id}?title=0&amp;byline=0&amp;portrait=0&amp;color=e79f2e' width='644' height='403' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>")
      @extraContentToolbar.hoverSensor().before(@iframe)
      @setRatio()
      $(window).resize()

    $(@).trigger('update:embed')

  parseYouTube: (str) ->
    # link : //youtube.com/watch?v=Bo_deCOd1HU
    # share : //youtu.be/Bo_deCOd1HU
    # embed : //youtube.com/embed/Bo_deCOd1HU

    re = /\/\/(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=|embed\/)?([a-z0-9_\-]+)/i
    matches = re.exec(str)
    matches[1] if (matches)

  parseVimeo: (str) ->
    # embed & link: http://vimeo.com/86164897

    re = /\/\/(?:www\.)?vimeo.com\/([0-9a-z\-_]+)/i
    matches = re.exec(str)
    matches[1] if (matches)

  setRatio: =>
    @ratio(@iframe.get(0).height / @iframe.get(0).width)
    @iframe.removeAttr('height')
    @iframe.removeAttr('width')

  ratio: (ratio) =>
    if ratio
      @iframe.attr('data-aspect-ratio', ratio)
    else
      @iframe.data('data-aspect-ratio')

  resize: =>

    $('[data-behavior="elastic-video"]').each (index, element) =>
      newWidth = $(element).parent().width()
      $(element).attr('width', newWidth)
      $(element).attr('height', newWidth * $(element).data('aspect-ratio'))

  ensureFocus: =>
    @toolbar().find('input').focus()

  toolbarButton: =>
    $('<li><a href="#" data-type="Video">Video</a></li>')
