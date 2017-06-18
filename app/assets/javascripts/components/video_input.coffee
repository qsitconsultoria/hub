class @VideoInput
  constructor: (@container) ->
    # console.log 'VideoInput'
    @sourceTextarea = @container.find('textarea')
    @urlInput = $('<input class="form__input" placeholder="Cole aqui o endereço do vídeo do Youtube ou Vimeo">')
    @removeButton = $('<a data-behavior="remove" href="#">&times;</a>')
    @urlInput.on 'keyup', @renderVideo

    @sourceTextarea.before(@urlInput)
    @sourceTextarea.before(@removeButton)

    if @sourceTextarea.val()
      @setVideoRenderedAs(true)
      @iframe = $(@sourceTextarea.val())
      @urlInput.before(@iframe)
    else
      @setVideoRenderedAs(false)
      @urlInput.show()

    $(window).resize(@resize).resize()

    @removeButton.click @remove


  renderVideo: (event) =>
    return if @isVideoRendered()
    return unless @videoURL()
    @embed()
    @sourceTextarea.val(@iframe.prop('outerHTML'))
    @urlInput.before(@iframe)
    @setVideoRenderedAs(true)
    $(window).resize()

  videoURL: =>
    url = @urlInput.val()
    return @parseYouTube(url) if @parseYouTube(url)
    return @parseVimeo(url) if @parseVimeo(url)


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

  embed: =>
    url = @urlInput.val()
    if id = @parseYouTube(url)
      @iframe = $("<iframe data-behavior='elastic-video' width='560' height='315'  src='//www.youtube.com/embed/#{id}?rel=0' frameborder='0' allowfullscreen></iframe>")
      @setRatio()

    if id = @parseVimeo(url)
      @iframe = $("<iframe data-behavior='elastic-video' src='//player.vimeo.com/video/#{id}?title=0&amp;byline=0&amp;portrait=0&amp;color=e79f2e' width='644' height='403' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>")
      @setRatio()

  isVideoRendered: =>
    @_isVideoRendered

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
      newWidth = @container.width()
      $(element).attr('width', newWidth)
      $(element).attr('height', newWidth * $(element).data('aspect-ratio'))

  remove: (event) =>
    event.preventDefault()
    @sourceTextarea.val('')
    @urlInput.val('')
    @iframe.detach()
    @setVideoRenderedAs(false)

  setVideoRenderedAs: (value) =>
    @_isVideoRendered = value
    @container.attr('data-video-rendered', value)

