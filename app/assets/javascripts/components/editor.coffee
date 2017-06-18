#= require components/editor/extra_content_toolbar
#= require components/editor/video
#= require components/editor/image

class @Editor
  constructor: (@container) ->
    @ensureFocusOnFirstInput()
    @initPreview()
    @initExtraContentToolbar()
    @initMediumEditor()

  ensureFocusOnFirstInput: =>
    input = @container.find('[data-container="first-focus"]')
    input.focus()

    # trick for deselecting
    input.get(0).setSelectionRange(0,0)

  initPreview: =>
    @preview = @container.find('[data-container="preview"]')
    @preview.wrap($('<div class="preview-container"/>'))

    @preview.on 'input', @updateTextArea

  initExtraContentToolbar: =>
    @extraContentToolbar = new editor.ExtraContentToolbar(@preview)
    $(@extraContentToolbar).on 'update', @updateTextArea

  initMediumEditor: =>
    @editor = new MediumEditor @preview, {
      placeholder: 'Escreva aqui seu conteúdo...',
      allowMultiParagraphSelection: false,
      diffTop: -12,
      buttons: ['bold', 'italic', 'underline', 'anchor', 'header1', 'header2', 'quote', 'unorderedlist', 'orderedlist']
      firstHeader: 'h2',
      secondHeader: 'h3',
      delay: 0
    }

  updateTextArea: (event) =>
    @container.find('[data-container="content"] textarea').val(@preview.html())


