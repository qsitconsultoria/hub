#= require helpers/spec_helper
#= require components/select_navigation

describe 'SelectNavigation', ->
  beforeEach ->
    loadFixtures('select_navigation.html')

  it 'opens link when selected', ->
    spyOn(window, 'redirect')

    element = $('[data-component="SelectNavigation"]')
    selectNavigation = new SelectNavigation(element)

    # simulates user selecting option and triggers change event
    element.find('option:last').prop('selected', true).change()

    expect(window.redirect).toHaveBeenCalledWith(element.find('option:last').val())
