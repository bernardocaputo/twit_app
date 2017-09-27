$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.remove_twit', (e) ->
    $.ajax '/twits/'+ e.target.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Twit removido', 4000, 'green')
          console.log(e.target.id)
          $('#card_' + e.target.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na remoção do Twit', 4000, 'red')
    return false
