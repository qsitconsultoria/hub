$ ->
  $('#library_file_search').on 'keyup', ->
    if $(this).val() == ""
      $('.file-suggestion-footer').remove()


  $('#library_file_search').typeahead
    name: "library_file"
    valueKey: "title"
    limit: 4
    remote:
      url: "/biblioteca/autocomplete?query=%QUERY"
      filter: (parsedResponse) ->
        footer = $('.file-suggestion-footer')

        if (parsedResponse.length == 0) # no results footer
          footer.remove()

          $('.tt-dropdown-menu').addClass('visible')
          $('.tt-dataset-library_file').addClass('visible')

          $( "<div class='file-suggestion-footer'>
                <p class='empty-results'>Nenhum arquivo encontrado.</p>
              </div>" ).appendTo('.tt-dataset-library_file')
        else
          if (parsedResponse.length > 4) # results > 4 - (See results_number) footer
            footer.remove()

            $( "<div class='file-suggestion-footer'>
                  <button type='submit'>
                    Ver todos resultados (" + (parsedResponse.length) + ")
                  </button>
                </div>" ).insertAfter('.tt-suggestions')
          else # results < 4 - no footer
            footer.remove()

        parsedResponse
    template: [
              "<a href='{{url}}'>
                <div class='file-suggestion'>
                  <div class='filetype'>
                    <img alt='Ico imagem small' height='36' src='{{filetype_icon}}' width='30'>
                  </div>
                  <div class='file--details'>
                    <h2 class='file-title'>{{title}}</h2>
                    <p class='file-extra-info'>{{filetype}}, atualizado {{created_at}} atrás</p>
                  </div>
                </div>
              </a>
              "
              ].join('')
    engine: Hogan
