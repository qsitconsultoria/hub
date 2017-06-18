class @WorkPlaceChooser
  constructor: (@container) ->
    @container.show()
    @radioContainer = @container.find('[data-item="radio"]')

    @radioTrue = @radioContainer.find('[value="true"]')
    @radioFalse = @radioContainer.find('[value="false"]')

    @radioTrue.on 'change', => @enableSelectsBasedOnStatus()
    @radioFalse.on 'change', => @enableSelectsBasedOnStatus()

    @selectTrue = @container.find('[data-item="select-true"]')
    @selectTrue.data('name', @selectTrue.attr('name'))
    @selectFalse = @container.find('[data-item="select-false"]')
    @selectFalse.data('name', @selectFalse.attr('name'))

    @enableSelectsBasedOnStatus()

  enableSelectsBasedOnStatus: ->
    if @radioTrue.is(":checked")
      @enableSelect(@selectTrue)
      @disableSelect(@selectFalse)
    else if @radioFalse.is(":checked")
      @enableSelect(@selectFalse)
      @disableSelect(@selectTrue)
    else
      @disableSelect(@selectTrue)
      @disableSelect(@selectFalse)

  enableSelect: (select) ->
    select.show()
    select.attr('name', select.data('name'))
    select.addClass('required');

  disableSelect: (select) ->
    select.hide()
    select.attr('name', '')
    select.removeClass('required');
