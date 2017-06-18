@editor ||= {}
class editor.ExtraContentToolbar
  constructor: (@preview) ->
    @extensions = []
    @initPlusButton()
    @initHoverSensor()
    @initVideoToolbar()
    @initImageToolbar()
    @initToolbar()

    @_isToolbarOpen = false
    $('html').click @closeToolbarsIfClickedOutside

  initToolbar: =>
    @_toolbar = $('<div data-behavior="extra-content-toolbar"><ul></ul></div>').hide()
    $(@extensions).each (index, extension) =>
      @_toolbar.find('ul').append(extension.toolbarButton())
    @_toolbar.css({position:'absolute'})
    @_toolbar.on 'click', 'a', @toolbarButtonClicked
    @preview.parent().append(@_toolbar)

  initVideoToolbar: =>
    @videoToolbar = new editor.VideoToolbar(@)
    @extensions.push(@videoToolbar)
    @preview.parent().append(@videoToolbar.html())

  initImageToolbar: =>
    @imageToolbar = new editor.ImageToolbar(@)
    $(@imageToolbar).on 'update:add', @closeToolbars
    $(@imageToolbar).on 'update:embed', @triggerUpdate
    @extensions.push(@imageToolbar)

  initPlusButton: =>
    @_plusButton = $('<div data-behavior="add-button"><a href="#">+</a></div>').hide()
    @_plusButton.on 'click', @openToolbar
    @preview.parent().append(@_plusButton)
    @preview.on 'mouseover', '*', @updatePlusButton

  initHoverSensor: =>
    @_hoverSensor = $('<div class="hover-sensor"/>')
    @preview.parent().append(@_hoverSensor)

  hoverSensor: =>
    @_hoverSensor

  toolbar: =>
    @_toolbar

  plusButton: =>
    @_plusButton

  openToolbar: (event) =>
    event.preventDefault()
    targetTop = @_plusButton.position().top + 'px'
    @_toolbar.css({top: targetTop}).fadeIn('fast')
    @_isToolbarOpen = true

  isToolbarOpen: =>
    @_isToolbarOpen or @videoToolbar.isToolbarOpen()

  closeToolbars: =>
    @toolbar().hide()
    @_isToolbarOpen = false
    @videoToolbar.close()

  closeToolbarsIfClickedOutside: (event) =>
    elements = [@plusButton(), @toolbar(), @videoToolbar.toolbar(), @imageToolbar.toolbarButton()]
    return true if @hasClickedInside(elements, event.target)
    @closeToolbars()
    true

  hasClickedInside: (elements, target) =>
    result = false
    $.each elements, (index, element) ->
      result = $.contains(element[0], target)
      return false if result
    result

  toolbarButtonClicked: (event) =>
    event.preventDefault()
    if $(event.target).data('type') == 'Video'
      @closeToolbars()
      @videoToolbar.open()
      $(@videoToolbar).on 'update:embed', @triggerUpdate


  triggerUpdate: =>
    $(@).trigger('update')
    @closeToolbars()

  updatePlusButton: (event) =>
    $(@_hoverSensor).trigger('update')
    $(event.target).before(@_hoverSensor)
    unless @currentElement == $(event.target)[0]
      if !@isToolbarOpen()
        @currentElement = $(event.target)[0]
        @_plusButton.hide().fadeIn()
        @_plusButton.css({top: @_hoverSensor.position().top + 'px'})


