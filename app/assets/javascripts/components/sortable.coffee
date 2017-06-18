class @Sortable
  constructor: (@container) ->
    @container.disableSelection()
    @container.sortable({stop: @update})

  update: =>
    $.ajax
      type: 'PUT'
      url: @url()
      data: @data()

    @triggerEventsForItems()

  url: =>
    @container.data('sortable-route')

  data: =>
    positions: $.map(@items(), @positionMap)

  triggerEventsForItems: =>
    @items().each (index, element) ->
      $(element).trigger('sortable:update', index + 1)

  items: =>
    @container.find('[data-sortable-container="item"]')

  positionMap: (element, index) ->
    id: $(element).data('id')
    position: index + 1
    resource_name: $(element).data('resource-name')
