class @DateTimePicker
  constructor: (@container) ->
    @cleanUpTexts()
    @initializeInputs()

  cleanUpTexts: =>
    @container.contents().filter(@textType).remove()

  initializeInputs: =>
    @dateInput = $('<input>')
    @dateInput.addClass('string required form__input')

    @container.append(@dateInput)
    today = new Date()
    @dateInput.pickadate
      selectYears: false
      selectMonths: false
      format: 'dd/mm/yyyy'
      min: new Date()
      max: new Date(today.getFullYear() + 5, today.getMonth(), today.getDate())
      onSet: @setDate
      onOpen: @setDatePosition

    @datePicker = @dateInput.pickadate('picker')
    @datePicker.set('select', @currentDate())

    # @timeInput = $('<input>')
    # @timeInput.addClass('time__input btn btn-default')
    # @container.append(@timeInput)
    # @timeInput.pickatime
    #   clear: 'Excluir'
    #   onSet: @setTime
    #   onOpen: @setTimePosition

    # @timePicker = @timeInput.pickatime('picker')
    # @timePicker.set('select', @currentTime())

  currentDate: =>
    new Date(@yearSelect().val(), @monthSelect().val() - 1, @daySelect().val())

  yearSelect: => @container.find('select[id$="1i"]')
  monthSelect: => @container.find('select[id$="2i"]')
  daySelect: => @container.find('select[id$="3i"]')

  currentTime: =>
    hour = @container.find('select[id$="4i"]').val()
    min = @container.find('select[id$="5i"]').val()

    [hour, min]

  setDate: =>
    date = @dateInput.val()

    day = date.split('/')[0]
    month = date.split('/')[1] - 1
    year = date.split('/')[2]

    date = new Date(year, month, day)
    @yearSelect().val(date.getFullYear())
    @monthSelect().val(date.getMonth() + 1)
    @daySelect().val(date.getDate())

  setDatePosition: () =>
    @dateInput.next().css('left', @dateInput.position().left)

  setTime: (event) =>
    @container.find('select[id$="4i"]').val(@pad(@timePicker.get('select').hour))
    @container.find('select[id$="5i"]').val(@pad(@timePicker.get('select').mins))

  setTimePosition: () =>
    @timeInput.next().css('left', @timeInput.position().left)

  pad: (number) =>
    if number > 9
      number
    else
      '0'+number

  textType: ->
    @nodeType == 3
