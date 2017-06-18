@editor ||= {}
class editor.ImageToolbar
  constructor: (@extraContentToolbar) ->
    @uploader = $('[data-behavior="image-uploader"]')
    @uploaderComponent = @uploader.find('[data-component="GalleryUploader"]')
    @uploaderComponent.on 'upload:start', @add
    @button = $('<li></li>')
    @button.append(@uploader)

    @previews = []

  toolbarButton: =>
    @button

  add: (event, preview) =>
    $(@).trigger('update:embed')
    $(preview).on 'upload:done', @done
    @previews[preview.id()] = preview

    loadImage preview.file, ((img) =>
        return if $(img).data('upload-id')

        $img = $(img).attr('data-upload-id', preview.id())
        $img.fadeTo(0, 0.5)

        @extraContentToolbar.hoverSensor().before($img)
      ), {
      canvas: false
    }

  done: (event, url) =>
    @img = $("img[data-upload-id='#{event.target.id()}']")
    @img.attr('src', url)
    @img.removeAttr('height')
    @img.removeAttr('width')
    @img.fadeTo(0, 1, @cleanUp)

    $(@).trigger('update:embed')

  cleanUp: =>
    @img.removeAttr('style')
